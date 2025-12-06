-- Additional seed data for service categories and items

-- Background Removal category and services
with background_removal_category as (
	insert into service_categories (label, description, icon, order_index)
	select 'Background Removal', 'Professional clipping paths, multi-path services, and shadow effects.', 'i-lucide-wand', 5
	where not exists (
		select 1 from service_categories where label = 'Background Removal'
	)
	returning id
), background_removal_final as (
	select id from background_removal_category
	union all
	select id from service_categories where label = 'Background Removal'
	limit 1
)
insert into service_items (category_id, label, description, icon, href, order_index)
select background_removal_final.id, source.label, source.description, source.icon, source.href, source.order_index
from background_removal_final
cross join (
	values
		('Clipping Path', 'Simple, medium, complex, and super complex clipping path services.', 'i-lucide-scissors', '/services#clipping-path', 1),
		('Multi Path', 'Multiple clipping paths in a single image.', 'i-lucide-layers', '/services#multi-path', 2),
		('Image Cut Out', 'Precise image cut out services for various needs.', 'i-lucide-wand', '/services#image-cut-out', 3),
		('Ghost Mannequin', '3D mannequin effect and ghost mannequin services.', 'i-lucide-user', '/services#ghost-mannequin', 4),
		('Shadow Services', 'Natural shadows, reflections, and drop shadow effects.', 'i-lucide-layers', '/services#shadow-services', 5)
) as source(label, description, icon, href, order_index)
where not exists (
	select 1
	from service_items
	where category_id = background_removal_final.id
		and label = source.label
);

-- Photo Retouching category and services
with photo_retouching_category as (
	insert into service_categories (label, description, icon, order_index)
	select 'Photo Retouching', 'Retouching, color correction, and exposure enhancement services.', 'i-lucide-sparkles', 6
	where not exists (
		select 1 from service_categories where label = 'Photo Retouching'
	)
	returning id
), photo_retouching_final as (
	select id from photo_retouching_category
	union all
	select id from service_categories where label = 'Photo Retouching'
	limit 1
)
insert into service_items (category_id, label, description, icon, href, order_index)
select photo_retouching_final.id, source.label, source.description, source.icon, source.href, source.order_index
from photo_retouching_final
cross join (
	values
		('Portrait Retouching', 'Professional retouching for portraits and headshots.', 'i-lucide-sparkles', '/services#portrait-retouching', 1),
		('Headshot Retouching', 'Enhance headshots with expert retouching.', 'material-symbols:person-pin', '/services#headshot-retouching', 2),
		('Fashion Photo Retouch', 'Professional retouching for fashion photography.', 'i-lucide-sparkles', '/services#fashion-photo-retouch', 3),
		('Newborn Photo Retouch', 'Specialized retouching for newborn photography.', 'i-lucide-baby', '/services#newborn-photo-retouch', 4),
		('Ecommerce Product Photo Retouch', 'Enhance product images for e-commerce and catalogs.', 'i-lucide-palette', '/services#ecommerce-product-photo-retouch', 5),
		('Jewelry Retouching', 'Specialized jewelry photo enhancement.', 'i-lucide-diamond', '/services#jewelry-retouch', 6),
		('Weeding Photo Retouch', 'Professional retouching for wedding photographs.', 'i-lucide-sun', '/services#weeding-photo-retouch', 7),
		('High End Retouch', 'Advanced retouching techniques for high-end photography.', 'i-lucide-star', '/services#high-end-retouch', 8)
) as source(label, description, icon, href, order_index)
where not exists (
	select 1
	from service_items
	where category_id = photo_retouching_final.id
		and label = source.label
);

-- Image Enhancement category and services
with image_enhancement_category as (
	insert into service_categories (label, description, icon, order_index)
	select 'Image Enhancement', 'Retouching, color correction, and exposure enhancement services.', 'i-lucide-sparkles', 7
	where not exists (
		select 1 from service_categories where label = 'Image Enhancement'
	)
	returning id
), image_enhancement_final as (
	select id from image_enhancement_category
	union all
	select id from service_categories where label = 'Image Enhancement'
	limit 1
)
insert into service_items (category_id, label, description, icon, href, order_index)
select image_enhancement_final.id, source.label, source.description, source.icon, source.href, source.order_index
from image_enhancement_final
cross join (
	values
		('Lightroom Image Editing', 'Professional retouching for all photo types.', 'i-lucide-sparkles', '/services#lightroom-image-editing', 1),
		('Color Correction', 'Professional color grading and correction.', 'i-lucide-palette', '/services#color-correction', 2),
		('Exposure Correction', 'Fix over/under-exposed images.', 'i-lucide-sun', '/services#exposure-correction', 3),
		('Real Estate Photo Enhancement', 'Enhance real estate photos for better appeal.', 'i-lucide-home', '/services#real-estate-photo-enhancement', 4)
) as source(label, description, icon, href, order_index)
where not exists (
	select 1
	from service_items
	where category_id = image_enhancement_final.id
		and label = source.label
);

-- Image Masking category and services
with image_masking_category as (
	insert into service_categories (label, description, icon, order_index)
	select 'Image Masking', 'Masking, photo restoration, and image manipulation services.', 'i-lucide-layers', 8
	where not exists (
		select 1 from service_categories where label = 'Image Masking'
	)
	returning id
), image_masking_final as (
	select id from image_masking_category
	union all
	select id from service_categories where label = 'Image Masking'
	limit 1
)
insert into service_items (category_id, label, description, icon, href, order_index)
select image_masking_final.id, source.label, source.description, source.icon, source.href, source.order_index
from image_masking_final
cross join (
	values
		('Layer Masking', 'Professional masking services for all needs.', 'i-lucide-layers', '/services#layer-masking', 1),
		('Multi Masking', 'Advanced multi-layer masking techniques.', 'i-lucide-refresh-ccw', '/services#multi-masking', 2),
		('Alpha Channel Masking', 'Precise alpha channel masking for complex images.', 'i-lucide-pen-tool', '/services#alpha-channel-masking', 3),
		('Hair Masking', 'Expert hair masking for detailed cutouts.', 'i-lucide-wand-2', '/services#hair-masking', 4),
		('Product Masking', 'Specialized masking for product images.', 'i-lucide-box', '/services#product-masking', 5)
) as source(label, description, icon, href, order_index)
where not exists (
	select 1
	from service_items
	where category_id = image_masking_final.id
		and label = source.label
);

-- Advanced Design category and services
with advanced_design_category as (
	insert into service_categories (label, description, icon, order_index)
	select 'Advanced Design', 'Advanced design services including masking, photo restoration, and image manipulation.', 'i-lucide-layers', 9
	where not exists (
		select 1 from service_categories where label = 'Advanced Design'
	)
	returning id
), advanced_design_final as (
	select id from advanced_design_category
	union all
	select id from service_categories where label = 'Advanced Design'
	limit 1
)
insert into service_items (category_id, label, description, icon, href, order_index)
select advanced_design_final.id, source.label, source.description, source.icon, source.href, source.order_index
from advanced_design_final
cross join (
	values
		('Image Manupulation', 'Creative image manipulation and compositing services.', 'i-lucide-layers', '/services#image-manipulation', 1),
		('AI Image Generation & Editing', 'Leverage AI to create and edit stunning images.', 'simple-icons:codemagic', '/services#ai-image-generation-editing', 2),
		('Object Removal', 'Seamless removal of unwanted objects from images.', 'streamline-ultimate:scissors-2-bold', '/services#object-removal', 3),
		('Virtual Staging', 'Enhance property images with virtual furniture and decor.', 'i-lucide-wand-2', '/services#virtual-staging', 4),
		('Photo Restoration', 'Restore old and damaged photos to their former glory.', 'i-lucide-image', '/services#photo-restoration', 5)
) as source(label, description, icon, href, order_index)
where not exists (
	select 1
	from service_items
	where category_id = advanced_design_final.id
		and label = source.label
);

-- Web Application Development category and services
with web_app_dev_category as (
	insert into service_categories (label, description, icon, order_index)
	select 'Web Application Development', 'Building responsive and dynamic web applications with modern web technologies.', 'material-symbols:web-traffic', 10
	where not exists (
		select 1 from service_categories where label = 'Web Application Development'
	)
	returning id
), web_app_dev_final as (
	select id from web_app_dev_category
	union all
	select id from service_categories where label = 'Web Application Development'
	limit 1
)
insert into service_items (category_id, label, description, icon, href, order_index)
select web_app_dev_final.id, source.label, source.description, source.icon, source.href, source.order_index
from web_app_dev_final
cross join (
	values
		('Front End Development', 'Creating visually appealing and user-friendly interfaces.', 'i-lucide-pen-tool', '/services#front-end-development', 1),
		('API Development', 'Building robust and scalable APIs for seamless integration.', 'i-lucide-film', '/services#api-development', 2),
		('Full Stack Development', 'Comprehensive web solutions from front end to back end.', 'i-lucide-code', '/services#full-stack-development', 3)
) as source(label, description, icon, href, order_index)
where not exists (
	select 1
	from service_items
	where category_id = web_app_dev_final.id
		and label = source.label
);
