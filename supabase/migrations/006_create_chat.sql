-- Live chat: sessions + messages + storage bucket

-- Helper: is current user an admin?
create or replace function public.is_admin()
returns boolean
language sql
security definer
stable
as $$
  select exists(
    select 1 from public.profiles
    where id = auth.uid() and role = 'admin'
  );
$$;

grant execute on function public.is_admin() to authenticated;

-- Sessions: one row per visitor (visitor_id = auth.users.id, may be anonymous)
create table if not exists public.chat_sessions (
  id uuid primary key default gen_random_uuid(),
  visitor_id uuid not null references auth.users(id) on delete cascade,
  visitor_name text,
  visitor_email text,
  last_message_at timestamptz not null default now(),
  last_message_preview text,
  unread_for_admin int not null default 0,
  unread_for_visitor int not null default 0,
  closed_at timestamptz,
  created_at timestamptz not null default now(),
  unique(visitor_id)
);

create index if not exists chat_sessions_last_message_at_idx
  on public.chat_sessions(last_message_at desc);

-- Messages
create table if not exists public.chat_messages (
  id uuid primary key default gen_random_uuid(),
  session_id uuid not null references public.chat_sessions(id) on delete cascade,
  sender_id uuid not null references auth.users(id),
  sender_role text not null check (sender_role in ('visitor','admin')),
  body text,
  image_url text,
  created_at timestamptz not null default now(),
  check (body is not null or image_url is not null)
);

create index if not exists chat_messages_session_created_idx
  on public.chat_messages(session_id, created_at);

alter table public.chat_sessions enable row level security;
alter table public.chat_messages enable row level security;

-- chat_sessions policies
drop policy if exists "Visitor reads own session" on public.chat_sessions;
create policy "Visitor reads own session"
  on public.chat_sessions for select
  to authenticated
  using (visitor_id = auth.uid() or public.is_admin());

drop policy if exists "Visitor inserts own session" on public.chat_sessions;
create policy "Visitor inserts own session"
  on public.chat_sessions for insert
  to authenticated
  with check (visitor_id = auth.uid());

drop policy if exists "Visitor or admin updates session" on public.chat_sessions;
create policy "Visitor or admin updates session"
  on public.chat_sessions for update
  to authenticated
  using (visitor_id = auth.uid() or public.is_admin())
  with check (visitor_id = auth.uid() or public.is_admin());

-- chat_messages policies
drop policy if exists "Read messages in own session or admin" on public.chat_messages;
create policy "Read messages in own session or admin"
  on public.chat_messages for select
  to authenticated
  using (
    public.is_admin()
    or exists (
      select 1 from public.chat_sessions s
      where s.id = chat_messages.session_id and s.visitor_id = auth.uid()
    )
  );

drop policy if exists "Insert messages as self" on public.chat_messages;
create policy "Insert messages as self"
  on public.chat_messages for insert
  to authenticated
  with check (
    sender_id = auth.uid()
    and (
      (sender_role = 'admin' and public.is_admin())
      or (
        sender_role = 'visitor'
        and exists (
          select 1 from public.chat_sessions s
          where s.id = session_id and s.visitor_id = auth.uid()
        )
      )
    )
  );

-- Trigger: keep session last_message_at / preview / unread counters in sync
create or replace function public.handle_new_chat_message()
returns trigger
language plpgsql
security definer
as $$
begin
  update public.chat_sessions
  set
    last_message_at = new.created_at,
    last_message_preview = coalesce(left(new.body, 120), '[image]'),
    unread_for_admin = case when new.sender_role = 'visitor'
      then unread_for_admin + 1 else unread_for_admin end,
    unread_for_visitor = case when new.sender_role = 'admin'
      then unread_for_visitor + 1 else unread_for_visitor end
  where id = new.session_id;
  return new;
end;
$$;

drop trigger if exists on_chat_message_insert on public.chat_messages;
create trigger on_chat_message_insert
  after insert on public.chat_messages
  for each row execute function public.handle_new_chat_message();

-- Realtime
do $$
begin
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'chat_sessions'
  ) then
    alter publication supabase_realtime add table public.chat_sessions;
  end if;
  if not exists (
    select 1 from pg_publication_tables
    where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = 'chat_messages'
  ) then
    alter publication supabase_realtime add table public.chat_messages;
  end if;
end$$;

-- Storage bucket for chat attachments
insert into storage.buckets (id, name, public)
values ('chat-attachments', 'chat-attachments', true)
on conflict (id) do nothing;

drop policy if exists "Public read chat-attachments" on storage.objects;
create policy "Public read chat-attachments"
  on storage.objects for select
  using (bucket_id = 'chat-attachments');

drop policy if exists "Authenticated upload chat-attachments" on storage.objects;
create policy "Authenticated upload chat-attachments"
  on storage.objects for insert
  to authenticated
  with check (bucket_id = 'chat-attachments');

drop policy if exists "Authenticated update chat-attachments" on storage.objects;
create policy "Authenticated update chat-attachments"
  on storage.objects for update
  to authenticated
  using (bucket_id = 'chat-attachments')
  with check (bucket_id = 'chat-attachments');

grant all on public.chat_sessions to service_role;
grant all on public.chat_messages to service_role;
grant select, insert, update on public.chat_sessions to authenticated;
grant select, insert on public.chat_messages to authenticated;
