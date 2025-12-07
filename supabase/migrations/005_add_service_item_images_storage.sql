-- Bucket and policy for service item images, and add storage_path for easier deletes

-- Ensure bucket exists
insert into storage.buckets (id, name, public)
values ('service-item-images', 'service-item-images', true)
on conflict (id) do nothing;

-- Policies on storage.objects for this bucket
create policy if not exists "Public read access to service-item-images"
  on storage.objects for select
  using (bucket_id = 'service-item-images');

create policy if not exists "Authenticated manage service-item-images"
  on storage.objects for all
  to authenticated
  using (bucket_id = 'service-item-images')
  with check (bucket_id = 'service-item-images');

-- Keep service role full access
grant all on storage.objects to service_role;

-- Track storage path alongside public URL for clean deletes
alter table if exists public.service_item_images
  add column if not exists storage_path text;
