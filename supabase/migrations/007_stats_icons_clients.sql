-- Add default icons to existing About stats (projects / clients / awards / experience)
do $$
declare
  v jsonb;
  arr jsonb;
  out_arr jsonb := '[]'::jsonb;
  i int := 0;
  item jsonb;
  guess text;
  lbl text;
begin
  select value into v from public.site_settings where key = 'about';
  if v is null then return; end if;
  arr := coalesce(v->'stats', '[]'::jsonb);
  for i in 0..(jsonb_array_length(arr) - 1) loop
    item := arr->i;
    if item ? 'icon' and (item->>'icon') is not null and (item->>'icon') <> '' then
      out_arr := out_arr || jsonb_build_array(item);
    else
      lbl := lower(coalesce(item->>'label', ''));
      guess := case
        when lbl like '%project%' then 'i-lucide-folder-check'
        when lbl like '%client%' or lbl like '%customer%' then 'i-lucide-users'
        when lbl like '%award%' then 'i-lucide-award'
        when lbl like '%year%' or lbl like '%experience%' then 'i-lucide-briefcase'
        else 'i-lucide-sparkles'
      end;
      out_arr := out_arr || jsonb_build_array(item || jsonb_build_object('icon', guess));
    end if;
  end loop;
  update public.site_settings
    set value = jsonb_set(v, '{stats}', out_arr, true)
    where key = 'about';
end$$;

-- Seed empty 'clients' setting (renowned clients with logos)
insert into public.site_settings (key, value)
values ('clients', jsonb_build_object(
  'headline', 'Trusted by',
  'title', 'Renowned clients we work with',
  'items', '[]'::jsonb
))
on conflict (key) do nothing;
