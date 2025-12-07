-- Add images per service item
-- Each service item can have multiple images stored as URLs with optional alt text and ordering.

CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS public.service_item_images (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  service_item_id UUID NOT NULL REFERENCES public.service_items(id) ON DELETE CASCADE,
  image_url TEXT NOT NULL,
  alt TEXT,
  order_index INT NOT NULL DEFAULT 1,
  created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

CREATE INDEX IF NOT EXISTS service_item_images_service_item_id_idx
  ON public.service_item_images(service_item_id);

ALTER TABLE public.service_item_images ENABLE ROW LEVEL SECURITY;

CREATE POLICY "Public read access to service_item_images"
  ON public.service_item_images
  FOR SELECT
  USING (true);

GRANT ALL ON public.service_item_images TO service_role;
