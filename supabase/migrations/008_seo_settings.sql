-- Expanded SEO settings stored under the single `seo` key

insert into public.site_settings (key, value)
values ('seo', jsonb_build_object(
  'meta', jsonb_build_object(
    'default_title', 'Rainbow Retouch',
    'title_template', '%s — Rainbow Retouch',
    'default_description', 'Professional photo retouching, background removal, and image enhancement services.',
    'keywords', 'photo retouching, background removal, image enhancement, photo editing',
    'author', 'Rainbow Retouch',
    'canonical_base', ''
  ),
  'og', jsonb_build_object(
    'site_name', 'Rainbow Retouch',
    'type', 'website',
    'locale', 'en_US',
    'default_image', ''
  ),
  'twitter', jsonb_build_object(
    'card', 'summary_large_image',
    'site', '',
    'creator', '',
    'default_image', ''
  ),
  'robots', jsonb_build_object(
    'index', true,
    'follow', true,
    'extra', ''
  ),
  'icons', jsonb_build_object(
    'favicon', '/favicon.ico',
    'apple_touch_icon', '',
    'theme_color', '#ffffff'
  ),
  'verification', jsonb_build_object(
    'google', '',
    'bing', '',
    'pinterest', '',
    'facebook', '',
    'yandex', ''
  ),
  'analytics', jsonb_build_object(
    'ga4_id', '',
    'gtm_id', '',
    'plausible_domain', '',
    'plausible_src', 'https://plausible.io/js/script.js'
  ),
  'schema', jsonb_build_object(
    'enabled', true,
    'type', 'Organization',
    'name', 'Rainbow Retouch',
    'logo_url', '',
    'url', '',
    'phone', '',
    'email', '',
    'street', '',
    'city', '',
    'region', '',
    'postal_code', '',
    'country', '',
    'sameAs', '[]'::jsonb
  )
))
on conflict (key) do update
  set value = excluded.value || public.site_settings.value;
