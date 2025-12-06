-- Create tables to store the services navigation hierarchy
create extension if not exists "pgcrypto";

create table if not exists service_categories (
  id uuid primary key default gen_random_uuid(),
  label text not null,
  description text,
  icon text,
  order_index int not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists service_items (
  id uuid primary key default gen_random_uuid(),
  category_id uuid not null references service_categories(id) on delete cascade,
  label text not null,
  description text,
  icon text,
  href text,
  order_index int not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index if not exists service_items_category_idx on service_items(category_id);

alter table service_categories enable row level security;
alter table service_items enable row level security;

create policy if not exists "Allow public read access to service_categories"
  on service_categories
  for select
  using (true);

create policy if not exists "Allow public read access to service_items"
  on service_items
  for select
  using (true);

-- Seed service categories
insert into service_categories (id, label, description, icon, order_index)
values
  ('3aa3bb0c-63cd-4a7c-8dc3-f1f7977e6f0a', 'Image Retouching', 'Magazine-grade cleanup for editorials, lookbooks, and high-volume campaigns.', 'i-lucide-wand', 1),
  ('f3d33b41-e64c-4f5f-826e-07d4476237b2', 'Ecommerce Photo Editing', 'Optimized images for product listings, ads, and catalogs.', 'i-lucide-package-check', 2),
  ('43bbac21-02f7-46cb-b0f8-bb751f0766f9', 'Image Restoration & Enhancement', 'Revive old or damaged photos with expert restoration and enhancement techniques.', 'i-lucide-refresh-ccw', 3),
  ('884bd56d-309b-4897-8dc4-b5b9b918602f', 'Creative Composition & Ads', 'High-end photo manipulation and compositing for advertising, key art, and marketing visuals.', 'i-lucide-lightbulb', 4)
  on conflict (id) do nothing;

-- Seed services for Image Retouching
insert into service_items (category_id, label, description, icon, href, order_index)
values
  ('3aa3bb0c-63cd-4a7c-8dc3-f1f7977e6f0a', 'Color Grading', 'Professional color grading to balance exposure, refine skin tones, and create a polished, high-end look.', 'i-lucide-palette', '/services#grading', 1),
  ('3aa3bb0c-63cd-4a7c-8dc3-f1f7977e6f0a', 'Beauty & Skin Polish', 'Advanced dodge and burn plus texture recovery for close-ups.', 'i-lucide-sparkles', '/services#beauty-polish', 2),
  ('3aa3bb0c-63cd-4a7c-8dc3-f1f7977e6f0a', 'Garment Detailing', 'Wrinkle removal, edge cleanup, and fabric reshaping.', 'i-lucide-scissors', '/services#garment-detail', 3),
  ('3aa3bb0c-63cd-4a7c-8dc3-f1f7977e6f0a', 'Environmental Cleanup', 'Remove props, distractions, and uneven lighting on set.', 'i-lucide-brush', '/services#environment-cleanup', 4)
  on conflict do nothing;

-- Seed services for Ecommerce Photo Editing
insert into service_items (category_id, label, description, icon, href, order_index)
values
  ('f3d33b41-e64c-4f5f-826e-07d4476237b2', 'Background Removal', 'Precise cutouts with edge refinement and alpha-channel exports for all product types.', 'i-lucide-crop', '/services#background-removal', 1),
  ('f3d33b41-e64c-4f5f-826e-07d4476237b2', 'Ghost Mannequin & Apparel', 'Create invisible-mannequin shots and stitch interiors for clean product presentation.', 'i-lucide-user', '/services#ghost-mannequin', 2),
  ('f3d33b41-e64c-4f5f-826e-07d4476237b2', 'Color Correction & White Balance', 'Batch color correction, white-balance, and consistent look across SKUs.', 'i-lucide-sliders', '/services#color-correction', 3),
  ('f3d33b41-e64c-4f5f-826e-07d4476237b2', 'Retouching & Spot Removal', 'Remove dust, lint, and blemishes while preserving natural texture.', 'i-lucide-sparkles', '/services#retouching', 4),
  ('f3d33b41-e64c-4f5f-826e-07d4476237b2', 'Shadows & Reflections', 'Natural drop shadows and soft reflections to enhance product depth.', 'i-lucide-layers', '/services#shadows-reflections', 5),
  ('f3d33b41-e64c-4f5f-826e-07d4476237b2', 'Resize, Export & SEO', 'Resize, crop, and export multi-resolution assets optimized for performance and SEO.', 'i-lucide-search', '/services#resize-export', 6)
  on conflict do nothing;

-- Seed services for Image Restoration & Enhancement
insert into service_items (category_id, label, description, icon, href, order_index)
values
  ('43bbac21-02f7-46cb-b0f8-bb751f0766f9', 'Damage Repair & Stitching', 'Reconstruct tears, scratches, and missing sections using content-aware healing and manual retouching.', 'i-lucide-wrench', '/services#damage-repair', 1),
  ('43bbac21-02f7-46cb-b0f8-bb751f0766f9', 'Color & Tone Restoration', 'Recover faded colors, correct discoloration, and rebalance tones for archival prints and scans.', 'i-lucide-sliders', '/services#color-restoration', 2),
  ('43bbac21-02f7-46cb-b0f8-bb751f0766f9', 'Dust, Scratch & Spot Removal', 'Automated and manual cleanup to remove dust, scratches, and surface blemishes while preserving detail.', 'i-lucide-sparkles', '/services#dust-scratch-removal', 3),
  ('43bbac21-02f7-46cb-b0f8-bb751f0766f9', 'Tonal Recovery & Contrast', 'Restore dynamic range and local contrast for depth and clarity in over/under-exposed captures.', 'i-lucide-contrast', '/services#tonal-recovery', 4),
  ('43bbac21-02f7-46cb-b0f8-bb751f0766f9', 'Noise Reduction & Sharpening', 'Advanced denoising paired with detail-preserving sharpening for scanned or low-light images.', 'i-lucide-aperture', '/services#noise-reduction', 5),
  ('43bbac21-02f7-46cb-b0f8-bb751f0766f9', 'Photo Reconstruction & Composite Repair', 'Rebuild heavily damaged images, composite multi-source elements, and recreate missing context.', 'i-lucide-image', '/services#photo-reconstruction', 6)
  on conflict do nothing;

-- Seed services for Creative Composition & Ads
insert into service_items (category_id, label, description, icon, href, order_index)
values
  ('884bd56d-309b-4897-8dc4-b5b9b918602f', 'Photo Manipulation', 'Seamlessly combine multiple images to create surreal, conceptual, or marketing visuals.', 'i-lucide-layers', '/services#manipulation', 1),
  ('884bd56d-309b-4897-8dc4-b5b9b918602f', 'Automotive Retouching', 'Specialized reflection management, cleaning, and background replacement for vehicle photography.', 'i-lucide-car', '/services#automotive', 2),
  ('884bd56d-309b-4897-8dc4-b5b9b918602f', 'Jewelry Retouching', 'Focus stacking, metal polishing, and gemstone sharpening for macro jewelry photography.', 'i-lucide-diamond', '/services#jewelry', 3)
  on conflict do nothing;
