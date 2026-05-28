import type { RealtimeChannel } from '@supabase/supabase-js'

export type ChatMessage = {
  id: string
  session_id: string
  sender_id: string
  sender_role: 'visitor' | 'admin'
  body: string | null
  image_url: string | null
  created_at: string
}

export type ChatSession = {
  id: string
  visitor_id: string
  visitor_name: string | null
  visitor_email: string | null
  last_message_at: string
  last_message_preview: string | null
  unread_for_admin: number
  unread_for_visitor: number
  closed_at: string | null
  created_at: string
}

const MAX_IMAGE_BYTES = 5 * 1024 * 1024
const ALLOWED_MIME = ['image/jpeg', 'image/png', 'image/webp', 'image/gif']

export const useChat = () => {
  const supabase = useSupabaseClient<any>()
  const user = useSupabaseUser()

  const session = useState<ChatSession | null>('chat:session', () => null)
  const messages = useState<ChatMessage[]>('chat:messages', () => [])
  const sessions = useState<ChatSession[]>('chat:sessions', () => [])
  const ready = useState<boolean>('chat:ready', () => false)

  let msgChannel: RealtimeChannel | null = null
  let inboxChannel: RealtimeChannel | null = null

  const currentUid = async (): Promise<string | null> => {
    if (user.value?.id) return user.value.id
    const { data } = await supabase.auth.getUser()
    return data?.user?.id ?? null
  }

  const ensureVisitor = async (): Promise<ChatSession | null> => {
    if (!user.value) {
      const { error } = await supabase.auth.signInAnonymously()
      if (error) {
        console.error('Anonymous sign-in failed:', error)
        return null
      }
    }
    const uid = (await supabase.auth.getUser()).data.user?.id
    if (!uid) return null

    const { data: existing } = await supabase
      .from('chat_sessions')
      .select('*')
      .eq('visitor_id', uid)
      .maybeSingle()

    if (existing) {
      session.value = existing as ChatSession
    } else {
      const { data, error } = await supabase
        .from('chat_sessions')
        .insert({ visitor_id: uid })
        .select()
        .single()
      if (error) {
        console.error('Create session failed:', error)
        return null
      }
      session.value = data as ChatSession
    }
    ready.value = true
    return session.value
  }

  const loadMessages = async (sessionId: string) => {
    const { data, error } = await supabase
      .from('chat_messages')
      .select('*')
      .eq('session_id', sessionId)
      .order('created_at', { ascending: true })
    if (error) {
      console.error('Load messages failed:', error)
      return
    }
    messages.value = (data || []) as ChatMessage[]
  }

  const subscribe = (sessionId: string) => {
    unsubscribe()
    msgChannel = supabase
      .channel(`chat:${sessionId}`)
      .on(
        'postgres_changes',
        { event: 'INSERT', schema: 'public', table: 'chat_messages', filter: `session_id=eq.${sessionId}` },
        (payload: { new: ChatMessage }) => {
          if (!messages.value.find(m => m.id === payload.new.id)) {
            messages.value = [...messages.value, payload.new]
          }
        }
      )
      .subscribe()
  }

  const unsubscribe = () => {
    if (msgChannel) {
      supabase.removeChannel(msgChannel)
      msgChannel = null
    }
  }

  const loadSessions = async () => {
    const { data, error } = await supabase
      .from('chat_sessions')
      .select('*')
      .order('last_message_at', { ascending: false })
    if (error) {
      console.error('Load sessions failed:', error)
      return
    }
    sessions.value = (data || []) as ChatSession[]
  }

  const subscribeInbox = () => {
    if (inboxChannel) return
    inboxChannel = supabase
      .channel('chat:inbox')
      .on(
        'postgres_changes',
        { event: '*', schema: 'public', table: 'chat_sessions' },
        () => { loadSessions() }
      )
      .subscribe()
  }

  const unsubscribeInbox = () => {
    if (inboxChannel) {
      supabase.removeChannel(inboxChannel)
      inboxChannel = null
    }
  }

  const sendText = async (sessionId: string, body: string) => {
    const trimmed = body.trim()
    if (!trimmed) return
    const uid = await currentUid()
    if (!uid) {
      console.error('sendText: no auth user')
      return
    }
    const role = await detectRole()
    const { data, error } = await supabase.from('chat_messages').insert({
      session_id: sessionId,
      sender_id: uid,
      sender_role: role,
      body: trimmed,
    }).select().single()
    if (error) {
      console.error('Send text failed:', error)
      return
    }
    if (data && !messages.value.find(m => m.id === (data as ChatMessage).id)) {
      messages.value = [...messages.value, data as ChatMessage]
    }
  }

  const sendImage = async (sessionId: string, file: File) => {
    if (!ALLOWED_MIME.includes(file.type)) {
      throw new Error('Unsupported image type')
    }
    if (file.size > MAX_IMAGE_BYTES) {
      throw new Error('Image exceeds 5MB')
    }
    const uid = await currentUid()
    if (!uid) {
      console.error('sendImage: no auth user')
      return
    }
    const ext = file.name.split('.').pop() || 'bin'
    const path = `${sessionId}/${crypto.randomUUID()}.${ext}`
    const { error: upErr } = await supabase.storage
      .from('chat-attachments')
      .upload(path, file, { contentType: file.type, upsert: false })
    if (upErr) {
      console.error('Upload failed:', upErr)
      throw upErr
    }
    const { data: pub } = supabase.storage.from('chat-attachments').getPublicUrl(path)
    const role = await detectRole()
    const { data, error } = await supabase.from('chat_messages').insert({
      session_id: sessionId,
      sender_id: uid,
      sender_role: role,
      image_url: pub.publicUrl,
    }).select().single()
    if (error) {
      console.error('Send image failed:', error)
      return
    }
    if (data && !messages.value.find(m => m.id === (data as ChatMessage).id)) {
      messages.value = [...messages.value, data as ChatMessage]
    }
  }

  const markRead = async (sessionId: string, role: 'visitor' | 'admin') => {
    const column = role === 'admin' ? 'unread_for_admin' : 'unread_for_visitor'
    const { error } = await supabase
      .from('chat_sessions')
      .update({ [column]: 0 })
      .eq('id', sessionId)
    if (error) console.error('markRead failed:', error)
  }

  const updateVisitorInfo = async (sessionId: string, info: { visitor_name?: string, visitor_email?: string }) => {
    await supabase.from('chat_sessions').update(info).eq('id', sessionId)
  }

  const detectRole = async (): Promise<'visitor' | 'admin'> => {
    const uid = await currentUid()
    if (!uid) return 'visitor'
    const { data } = await supabase.from('profiles').select('role').eq('id', uid).maybeSingle()
    return (data?.role === 'admin') ? 'admin' : 'visitor'
  }

  return {
    session,
    messages,
    sessions,
    ready,
    ensureVisitor,
    loadMessages,
    subscribe,
    unsubscribe,
    loadSessions,
    subscribeInbox,
    unsubscribeInbox,
    sendText,
    sendImage,
    markRead,
    updateVisitorInfo,
  }
}
