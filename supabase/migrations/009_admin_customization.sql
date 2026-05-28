-- Make remaining hardcoded UI sections editable via site_settings.
-- Seeds defaults from the current hardcoded content.

-- 1) Home: process steps
insert into public.site_settings (key, value)
values ('process_steps', jsonb_build_object(
  'headline', 'How it works',
  'title', 'From upload to delivery in 24 hours',
  'description', '',
  'items', jsonb_build_array(
    jsonb_build_object('icon', 'i-lucide-upload-cloud', 'title', 'Upload',
      'description', 'Send us your images via the form or your preferred cloud link.'),
    jsonb_build_object('icon', 'i-lucide-message-square', 'title', 'Brief',
      'description', 'Tell us the look — references welcome. We confirm scope in 1 hour.'),
    jsonb_build_object('icon', 'i-lucide-sparkles', 'title', 'We Retouch',
      'description', 'A dedicated editor delivers pixel-perfect results within 24 hours.'),
    jsonb_build_object('icon', 'i-lucide-check-circle-2', 'title', 'Approve & Deliver',
      'description', 'Free unlimited revisions until you love it. Source files included.')
  )
))
on conflict (key) do nothing;

-- 2) Footer navigation columns
insert into public.site_settings (key, value)
values ('footer_navigation', jsonb_build_object(
  'columns', jsonb_build_array(
    jsonb_build_object('label', 'Services', 'children', jsonb_build_array(
      jsonb_build_object('label', 'Background Removal', 'to', '/services#background-removal'),
      jsonb_build_object('label', 'Photo Retouching', 'to', '/services#retouching'),
      jsonb_build_object('label', 'Image Enhancement', 'to', '/services#enhancement'),
      jsonb_build_object('label', 'Image Masking', 'to', '/services#masking')
    )),
    jsonb_build_object('label', 'Company', 'children', jsonb_build_array(
      jsonb_build_object('label', 'About Us', 'to', '/about'),
      jsonb_build_object('label', 'Portfolio', 'to', '/portfolio'),
      jsonb_build_object('label', 'Pricing', 'to', '/pricing'),
      jsonb_build_object('label', 'Contact', 'to', '/contact')
    )),
    jsonb_build_object('label', 'Resources', 'children', jsonb_build_array(
      jsonb_build_object('label', 'Blog', 'to', '/blog'),
      jsonb_build_object('label', 'FAQs', 'to', '/pricing#faq')
    ))
  )
))
on conflict (key) do nothing;

-- 3) Top promo banner
insert into public.site_settings (key, value)
values ('topbar_promo', jsonb_build_object(
  'enabled', true,
  'text_html', 'Get a <span class="font-semibold">free photo retouch</span> — just upload your image!',
  'button_label', 'Upload Now',
  'button_link', '/contact'
))
on conflict (key) do nothing;

-- 4) Home: service highlights (the Features.vue card grid)
insert into public.site_settings (key, value)
values ('service_highlights', jsonb_build_object(
  'title', 'Professional Photo Editing Services',
  'description', 'Enhance your images with our expert editing solutions',
  'hero_image_url', 'https://images.unsplash.com/photo-1542038784456-1ea8e935640e?w=1200&q=80',
  'hero_image_badge', 'Stunning Quality',
  'hero_image_title', 'Professional Photo Editing Services',
  'hero_image_subtitle', 'Transform your product images with our expert editing team',
  'items', jsonb_build_array(
    jsonb_build_object('icon', 'i-lucide-truck', 'title', 'Fast Delivery', 'description', 'Quick turnaround on all editing projects', 'color', 'blue'),
    jsonb_build_object('icon', 'i-lucide-file-text', 'title', 'Custom Quotation', 'description', 'Tailored pricing for your specific needs', 'color', 'purple'),
    jsonb_build_object('icon', 'i-lucide-headphones', 'title', '24/7 Support', 'description', 'Always available to assist you', 'color', 'green'),
    jsonb_build_object('icon', 'i-lucide-shield-check', 'title', 'Non-Disclosure', 'description', 'Your images remain confidential', 'color', 'red'),
    jsonb_build_object('icon', 'i-lucide-tag', 'title', 'Bulk Discounts', 'description', 'Special rates for large orders', 'color', 'orange'),
    jsonb_build_object('icon', 'i-lucide-layers', 'title', 'High Volume Editing', 'description', 'Capable of handling large batches', 'color', 'indigo'),
    jsonb_build_object('icon', 'i-lucide-dollar-sign', 'title', 'Cost Effective', 'description', 'Competitive rates without compromising quality', 'color', 'emerald'),
    jsonb_build_object('icon', 'i-lucide-users', 'title', 'Dedicated Editors', 'description', 'Expert professionals for your projects', 'color', 'pink'),
    jsonb_build_object('icon', 'i-lucide-message-circle', 'title', 'Live Chat', 'description', 'Instant communication for your queries', 'color', 'cyan'),
    jsonb_build_object('icon', 'i-lucide-lock', 'title', 'Secured Payment', 'description', 'Safe and protected transactions', 'color', 'violet')
  )
))
on conflict (key) do nothing;

-- 5) About: extend with values array (merge into existing about row, don't overwrite)
do $$
declare
  cur jsonb;
  patch jsonb := jsonb_build_object(
    'values_headline', 'Our Values',
    'values_title', 'Design That Speaks',
    'values_description', 'We believe in creating designs that not only look beautiful but tell a compelling story.',
    'values', jsonb_build_array(
      jsonb_build_object('icon', 'i-lucide-sparkles', 'title', 'Creative Excellence',
        'description', 'Pushing boundaries and exploring new design horizons with every project.'),
      jsonb_build_object('icon', 'i-lucide-heart', 'title', 'Client-Focused',
        'description', 'Your vision is our mission. We listen, collaborate, and deliver beyond expectations.'),
      jsonb_build_object('icon', 'i-lucide-rocket', 'title', 'Innovation First',
        'description', 'Staying ahead of trends while creating timeless designs that stand the test of time.')
    )
  );
begin
  select value into cur from public.site_settings where key = 'about';
  if cur is null then
    insert into public.site_settings (key, value) values ('about', patch);
  else
    -- merge: existing wins for duplicate keys (patch || cur => right side wins)
    update public.site_settings set value = patch || cur where key = 'about';
  end if;
end$$;
