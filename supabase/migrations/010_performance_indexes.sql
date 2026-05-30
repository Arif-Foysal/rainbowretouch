-- Indexes matching the filter+order patterns used by composables in app/composables/useCms.ts
-- All idempotent (create index if not exists), safe to re-run.

create index if not exists blog_posts_published_idx
  on public.blog_posts (is_published, published_at desc);

create index if not exists pricing_plans_active_order_idx
  on public.pricing_plans (is_active, order_index);

create index if not exists testimonials_active_order_idx
  on public.testimonials (is_active, order_index);

create index if not exists portfolio_active_order_idx
  on public.portfolio_items (is_active, order_index);

create index if not exists faqs_active_order_idx
  on public.faqs (is_active, order_index);

create index if not exists team_active_order_idx
  on public.team_members (is_active, order_index);

create index if not exists service_item_images_item_order_idx
  on public.service_item_images (service_item_id, order_index);

create index if not exists site_settings_key_idx
  on public.site_settings (key);
