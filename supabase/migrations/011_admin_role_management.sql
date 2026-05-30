-- Admin-callable role management. Both functions enforce that the *caller*
-- is an admin and refuse to demote the caller themselves (to avoid lockout).

create or replace function public.promote_to_admin(user_email text)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  target_id uuid;
begin
  if not public.is_admin() then
    raise exception 'forbidden: caller is not an admin';
  end if;

  select id into target_id from public.profiles where email = user_email;
  if target_id is null then
    raise exception 'no profile found for email: %', user_email;
  end if;

  update public.profiles
    set role = 'admin', updated_at = now()
    where id = target_id;
end;
$$;

create or replace function public.demote_admin(user_email text)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  target_id uuid;
  remaining_admins int;
begin
  if not public.is_admin() then
    raise exception 'forbidden: caller is not an admin';
  end if;

  select id into target_id from public.profiles where email = user_email;
  if target_id is null then
    raise exception 'no profile found for email: %', user_email;
  end if;

  if target_id = auth.uid() then
    raise exception 'cannot demote yourself';
  end if;

  select count(*) into remaining_admins
    from public.profiles
    where role = 'admin' and id <> target_id;
  if remaining_admins < 1 then
    raise exception 'refusing to remove the last admin';
  end if;

  update public.profiles
    set role = 'user', updated_at = now()
    where id = target_id;
end;
$$;

grant execute on function public.promote_to_admin(text) to authenticated;
grant execute on function public.demote_admin(text) to authenticated;
