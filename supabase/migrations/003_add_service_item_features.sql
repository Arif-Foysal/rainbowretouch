-- Add features per service item
-- Each feature can include a label, icon, and description.

-- Enable extension for UUID generation if not already enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE IF NOT EXISTS public.service_item_features (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  service_item_id UUID NOT NULL REFERENCES public.service_items(id) ON DELETE CASCADE,
  label TEXT NOT NULL,
  icon TEXT,
  description TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT TIMEZONE('utc', NOW())
);

-- Basic index for lookup by service item
CREATE INDEX IF NOT EXISTS service_item_features_service_item_id_idx
  ON public.service_item_features(service_item_id);

-- RLS
ALTER TABLE public.service_item_features ENABLE ROW LEVEL SECURITY;

-- Allow authenticated users to read
CREATE POLICY "Authenticated users can read service item features"
  ON public.service_item_features
  FOR SELECT
  TO authenticated
  USING (true);

-- Allow service role full access (typical Supabase setup)
GRANT ALL ON public.service_item_features TO service_role;

-- Optional: allow authenticated to insert/update/delete if needed (commented out by default)
-- CREATE POLICY "Authenticated users can insert service item features"
--   ON public.service_item_features
--   FOR INSERT
--   TO authenticated
--   WITH CHECK (true);
--
-- CREATE POLICY "Authenticated users can update service item features"
--   ON public.service_item_features
--   FOR UPDATE
--   TO authenticated
--   USING (true)
--   WITH CHECK (true);
--
-- CREATE POLICY "Authenticated users can delete service item features"
--   ON public.service_item_features
--   FOR DELETE
--   TO authenticated
--   USING (true);
