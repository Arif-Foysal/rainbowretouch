<script setup lang="ts">
definePageMeta({
  middleware: "admin",
  layout: "admin",
});

const supabase = useSupabaseClient();
const serviceImageBucket = "service-item-images";
const { profile, fetchProfile } = useUserProfile();
const toast = useToast();

const formatNumber = (value: number) => value.toLocaleString();
const formatCurrency = (value: number) =>
  new Intl.NumberFormat("en-US", {
    style: "currency",
    currency: "USD",
    maximumFractionDigits: 0,
  }).format(value);

type AdminProfile = {
  id: string;
  email: string;
  full_name?: string | null;
  avatar_url?: string | null;
  role?: "user" | "admin" | null;
  created_at?: string;
};

type ContactAttachment = {
  url?: string | null;
  name?: string | null;
};

type ContactRequest = {
  id: string;
  first_name: string;
  last_name: string;
  email: string;
  phone?: string | null;
  subject: string;
  budget?: string | null;
  deadline?: string | null;
  message: string;
  attachments: ContactAttachment[];
  created_at?: string | null;
};

type ServiceItemRecord = {
  id: string;
  label: string;
  description: string | null;
  icon: string | null;
  href: string | null;
  order_index: number;
  service_item_features?: FeatureRecord[];
  service_item_images?: ImageRecord[];
};

type FeatureRecord = {
  id: string;
  label: string;
  icon: string | null;
  description: string | null;
  service_item_id?: string;
  created_at?: string;
};

type ImageRecord = {
  id: string;
  image_url: string;
  storage_path?: string | null;
  alt: string | null;
  order_index: number;
  service_item_id?: string;
  created_at?: string;
};

type ServiceCategoryRecord = {
  id: string;
  label: string;
  description: string | null;
  icon: string | null;
  order_index: number;
  service_items: ServiceItemRecord[];
};

// Fetch profile on mount
onMounted(async () => {
  await fetchProfile();
});

// Fetch all users (admin only)
const users = ref<AdminProfile[]>([]);
const loading = ref(true);
const contactLoading = ref(true);
const contactRequests = ref<ContactRequest[]>([]);
const totalUsers = ref(0);
const activeProjects = ref(0);
const totalRevenue = ref(0);
const pendingOrders = ref(0);
const stats = computed(() => [
  {
    label: "Total Users",
    value: formatNumber(totalUsers.value),
    icon: "i-lucide-users",
  },
  {
    label: "Active Projects",
    value: formatNumber(activeProjects.value),
    icon: "i-lucide-folder",
  },
  {
    label: "Total Revenue",
    value: formatCurrency(totalRevenue.value),
    icon: "i-lucide-dollar-sign",
  },
  {
    label: "Pending Orders",
    value: formatNumber(pendingOrders.value),
    icon: "i-lucide-clock",
  },
]);
const serviceCategoryOptions = computed(() =>
  serviceCategories.value.map((category) => ({
    id: category.id,
    label: category.label,
  }))
);
const serviceOptions = computed(() =>
  serviceCategories.value.flatMap((category) =>
    (category.service_items ?? []).map((service) => ({
      id: service.id,
      label: `${category.label} • ${service.label}`,
    }))
  )
);
const isAttachmentModalOpen = ref(false);
const selectedAttachment = ref<{
  url?: string | null;
  name?: string | null;
  requestId?: string;
  contactName?: string;
} | null>(null);

type SectionKey = "overview" | "users" | "services" | "contacts";
type ServicesTab = "services" | "categories" | "features" | "photos";

const navItems: Array<{
  key: SectionKey;
  label: string;
  icon: string;
  description: string;
}> = [
  {
    key: "overview",
    label: "Overview",
    icon: "i-lucide-layout-dashboard",
    description: "Key metrics at a glance"
  },
  {
    key: "users",
    label: "Users",
    icon: "i-lucide-users",
    description: "Manage members and roles"
  },
  {
    key: "services",
    label: "Services",
    icon: "i-lucide-layers",
    description: "Categories, services, features, photos"
  },
  {
    key: "contacts",
    label: "Contact Requests",
    icon: "i-lucide-inbox",
    description: "Inbound inquiries"
  }
];

const activeSection = ref<SectionKey>("overview");
const servicesTab = ref<ServicesTab>("services");
const mobileNavOpen = ref(false);
const userSearch = ref("");
const categorySearch = ref("");
const serviceSearch = ref("");
const serviceCategoryFilter = ref<string>("");
const featureSearch = ref("");
const featureServiceFilter = ref<string>("");
const photoSearch = ref("");
const photoServiceFilter = ref<string>("");
const expandedPhotoServices = ref<Set<string>>(new Set());

const togglePhotoService = (serviceId: string) => {
  const next = new Set(expandedPhotoServices.value);
  if (next.has(serviceId)) {
    next.delete(serviceId);
  } else {
    next.add(serviceId);
  }
  expandedPhotoServices.value = next;
};

const servicesSearch = ref("");

const expandedServices = ref<Set<string>>(new Set());

const toggleService = (serviceId: string) => {
  const next = new Set(expandedServices.value);
  if (next.has(serviceId)) {
    next.delete(serviceId);
  } else {
    next.add(serviceId);
  }
  expandedServices.value = next;
};

const filteredServiceHierarchy = computed(() => {
  const q = servicesSearch.value.trim().toLowerCase();
  return serviceCategories.value
    .map((category) => ({
      ...category,
      service_items: (category.service_items ?? []).filter((service) => {
        if (!q) return true;
        return (
          service.label.toLowerCase().includes(q) ||
          (service.description ?? "").toLowerCase().includes(q) ||
          category.label.toLowerCase().includes(q) ||
          (service.service_item_features ?? []).some((f) =>
            f.label.toLowerCase().includes(q)
          )
        );
      })
    }))
    .filter((category) => !q || category.service_items.length > 0);
});

const photoCategoryGroups = computed(() =>
  serviceCategories.value
    .map((category) => ({
      ...category,
      service_items: (category.service_items ?? []).filter((service) => {
        if (!photoSearch.value.trim()) return true;
        const q = photoSearch.value.trim().toLowerCase();
        return (
          service.label.toLowerCase().includes(q) ||
          category.label.toLowerCase().includes(q)
        );
      })
    }))
    .filter((category) => category.service_items.length > 0)
);
const contactSearch = ref("");

const setSection = (key: SectionKey) => {
  activeSection.value = key;
  mobileNavOpen.value = false;
};

const currentSection = computed(
  () => navItems.find((item) => item.key === activeSection.value) ?? navItems[0]!
);

const serviceCategories = ref<ServiceCategoryRecord[]>([]);
const servicesNavigationLoading = ref(true);

type FlatService = ServiceItemRecord & {
  categoryId: string;
  categoryLabel: string;
};
type FlatFeature = FeatureRecord & {
  serviceLabel: string;
  categoryLabel: string;
};
type FlatPhoto = ImageRecord & {
  serviceLabel: string;
  categoryLabel: string;
};

const flatServices = computed<FlatService[]>(() =>
  serviceCategories.value.flatMap((category) =>
    (category.service_items ?? []).map((service) => ({
      ...service,
      categoryId: category.id,
      categoryLabel: category.label
    }))
  )
);

const flatFeatures = computed<FlatFeature[]>(() =>
  serviceCategories.value.flatMap((category) =>
    (category.service_items ?? []).flatMap((service) =>
      (service.service_item_features ?? []).map((feature) => ({
        ...feature,
        serviceLabel: service.label,
        categoryLabel: category.label
      }))
    )
  )
);

const flatPhotos = computed<FlatPhoto[]>(() =>
  serviceCategories.value.flatMap((category) =>
    (category.service_items ?? []).flatMap((service) =>
      (service.service_item_images ?? []).map((image) => ({
        ...image,
        serviceLabel: service.label,
        categoryLabel: category.label
      }))
    )
  )
);

const filteredUsers = computed(() => {
  const q = userSearch.value.trim().toLowerCase();
  if (!q) return users.value;
  return users.value.filter((user) =>
    [user.full_name, user.email, user.role]
      .filter(Boolean)
      .some((field) => (field as string).toLowerCase().includes(q))
  );
});

const filteredCategories = computed(() => {
  const q = categorySearch.value.trim().toLowerCase();
  if (!q) return serviceCategories.value;
  return serviceCategories.value.filter((category) =>
    [category.label, category.description]
      .filter(Boolean)
      .some((field) => (field as string).toLowerCase().includes(q))
  );
});

const filteredFlatServices = computed(() => {
  let list = flatServices.value;
  if (serviceCategoryFilter.value) {
    list = list.filter((s) => s.categoryId === serviceCategoryFilter.value);
  }
  const q = serviceSearch.value.trim().toLowerCase();
  if (q) {
    list = list.filter((service) =>
      [service.label, service.description, service.href]
        .filter(Boolean)
        .some((field) => (field as string).toLowerCase().includes(q))
    );
  }
  return list;
});

const filteredFlatFeatures = computed(() => {
  let list = flatFeatures.value;
  if (featureServiceFilter.value) {
    list = list.filter((f) => f.service_item_id === featureServiceFilter.value);
  }
  const q = featureSearch.value.trim().toLowerCase();
  if (q) {
    list = list.filter((feature) =>
      [feature.label, feature.description, feature.serviceLabel]
        .filter(Boolean)
        .some((field) => (field as string).toLowerCase().includes(q))
    );
  }
  return list;
});

const filteredFlatPhotos = computed(() => {
  let list = flatPhotos.value;
  if (photoServiceFilter.value) {
    list = list.filter((p) => p.service_item_id === photoServiceFilter.value);
  }
  const q = photoSearch.value.trim().toLowerCase();
  if (q) {
    list = list.filter((photo) =>
      [photo.alt, photo.serviceLabel, photo.categoryLabel]
        .filter(Boolean)
        .some((field) => (field as string).toLowerCase().includes(q))
    );
  }
  return list;
});

const filteredContactRequests = computed(() => {
  const q = contactSearch.value.trim().toLowerCase();
  if (!q) return contactRequests.value;
  return contactRequests.value.filter((request) =>
    [
      request.first_name,
      request.last_name,
      request.email,
      request.phone,
      request.subject,
      request.message
    ]
      .filter(Boolean)
      .some((field) => (field as string).toLowerCase().includes(q))
  );
});

const findServiceById = (id: string): ServiceItemRecord | undefined => {
  for (const category of serviceCategories.value) {
    const match = category.service_items?.find((s) => s.id === id);
    if (match) return match;
  }
  return undefined;
};

const findCategoryIdForService = (serviceId: string): string => {
  for (const category of serviceCategories.value) {
    if (category.service_items?.some((s) => s.id === serviceId)) {
      return category.id;
    }
  }
  return "";
};

const isCategoryModalOpen = ref(false);
const categoryModalMode = ref<"create" | "edit">("create");
const categoryForm = reactive({
  id: "",
  label: "",
  description: "",
  icon: "",
  order_index: 1,
});
const isSavingCategory = ref(false);

const isServiceModalOpen = ref(false);
const serviceModalMode = ref<"create" | "edit">("create");
const serviceForm = reactive({
  id: "",
  categoryId: "",
  label: "",
  description: "",
  icon: "",
  href: "",
  order_index: 1,
});
const isSavingService = ref(false);

const isFeatureModalOpen = ref(false);
const featureModalMode = ref<"create" | "edit">("create");
const featureForm = reactive({
  id: "",
  serviceId: "",
  label: "",
  icon: "",
  description: "",
});
const isSavingFeature = ref(false);

const isImageModalOpen = ref(false);
const imageModalMode = ref<"create" | "edit">("create");
const imageForm = reactive({
  id: "",
  serviceId: "",
  image_url: "",
  storage_path: "",
  alt: "",
  order_index: 1,
});
const imageUploadFiles = ref<File[]>([]);
const isSavingImage = ref(false);
const selectedUploadFile = computed(() => imageUploadFiles.value?.[0] || null);

const fetchUsers = async () => {
  loading.value = true;
  const { data, error } = await supabase
    .from("profiles")
    .select("*")
    .order("created_at", { ascending: false });

  if (error) {
    toast.add({
      title: "Error",
      description: "Failed to fetch users",
      color: "error",
    });
  } else {
    users.value = (data ?? []) as AdminProfile[];
    totalUsers.value = users.value.length;
  }
  loading.value = false;
};

onMounted(() => {
  fetchUsers();
  fetchContactRequests();
  fetchServicesNavigation();
});

const logout = async () => {
  await supabase.auth.signOut();
  navigateTo("/login");
};

const openAttachmentModal = (
  attachment: ContactAttachment,
  request: ContactRequest
) => {
  selectedAttachment.value = {
    ...attachment,
    requestId: request.id,
    contactName: `${request.first_name} ${request.last_name}`.trim(),
  };
  isAttachmentModalOpen.value = true;
};

const closeAttachmentModal = () => {
  isAttachmentModalOpen.value = false;
  selectedAttachment.value = null;
};

const downloadSelectedAttachment = () => {
  const attachment = selectedAttachment.value;
  if (!attachment?.url) return;

  const link = document.createElement("a");
  link.href = attachment.url;
  link.setAttribute("download", attachment.name || "attachment");
  link.setAttribute("target", "_blank");
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);
};

const deriveStoragePathFromUrl = (url: string) => {
  try {
    const parsed = new URL(url);
    const marker = "/storage/v1/object/public/";
    const idx = parsed.pathname.indexOf(marker);
    if (idx === -1) return "";
    return parsed.pathname.slice(idx + marker.length);
  } catch (err) {
    return "";
  }
};

const resetCategoryForm = () => {
  categoryForm.id = "";
  categoryForm.label = "";
  categoryForm.description = "";
  categoryForm.icon = "";
  categoryForm.order_index = 1;
};

const resetServiceForm = () => {
  serviceForm.id = "";
  serviceForm.categoryId = "";
  serviceForm.label = "";
  serviceForm.description = "";
  serviceForm.icon = "";
  serviceForm.href = "";
  serviceForm.order_index = 1;
};

const openCreateCategoryModal = () => {
  resetCategoryForm();
  categoryModalMode.value = "create";
  categoryForm.order_index = serviceCategories.value.length + 1;
  isCategoryModalOpen.value = true;
};

const openEditCategoryModal = (category: ServiceCategoryRecord) => {
  categoryModalMode.value = "edit";
  categoryForm.id = category.id;
  categoryForm.label = category.label;
  categoryForm.description = category.description || "";
  categoryForm.icon = category.icon || "";
  categoryForm.order_index = category.order_index;
  isCategoryModalOpen.value = true;
};

const saveCategory = async () => {
  if (!categoryForm.label.trim()) {
    toast.add({
      title: "Validation error",
      description: "Category name is required.",
      color: "error",
    });
    return;
  }

  isSavingCategory.value = true;

  const payload = {
    label: categoryForm.label.trim(),
    description: categoryForm.description.trim()
      ? categoryForm.description.trim()
      : null,
    icon: categoryForm.icon.trim() ? categoryForm.icon.trim() : null,
    order_index: Number.isFinite(categoryForm.order_index)
      ? categoryForm.order_index
      : 1,
  };

  let error;

  if (categoryModalMode.value === "create") {
    ({ error } = await (supabase as any)
      .from("service_categories")
      .insert(payload));
  } else {
    ({ error } = await (supabase as any)
      .from("service_categories")
      .update(payload)
      .eq("id", categoryForm.id));
  }

  if (error) {
    toast.add({
      title: "Error",
      description: "Failed to save category.",
      color: "error",
    });
  } else {
    toast.add({
      title:
        categoryModalMode.value === "create"
          ? "Category created"
          : "Category updated",
      description: "The services navigation has been updated.",
      color: "success",
    });
    isCategoryModalOpen.value = false;
    await fetchServicesNavigation();
  }

  isSavingCategory.value = false;
};

const deleteCategory = async (category: ServiceCategoryRecord) => {
  if (
    !confirm(
      `Delete category "${category.label}"? All nested services will be removed.`
    )
  ) {
    return;
  }

  const { error } = await supabase
    .from("service_categories")
    .delete()
    .eq("id", category.id);

  if (error) {
    toast.add({
      title: "Error",
      description: "Failed to delete category.",
      color: "error",
    });
  } else {
    toast.add({
      title: "Category deleted",
      description: "The services navigation has been updated.",
      color: "success",
    });
    await fetchServicesNavigation();
  }
};

const openCreateServiceModal = (category?: ServiceCategoryRecord) => {
  resetServiceForm();
  serviceModalMode.value = "create";
  if (category) {
    serviceForm.categoryId = category.id;
    serviceForm.order_index = (category.service_items?.length || 0) + 1;
  } else if (serviceCategoryFilter.value) {
    serviceForm.categoryId = serviceCategoryFilter.value;
  }
  isServiceModalOpen.value = true;
};

const openEditServiceModal = (
  service: ServiceItemRecord,
  categoryId: string
) => {
  serviceModalMode.value = "edit";
  serviceForm.id = service.id;
  serviceForm.categoryId = categoryId;
  serviceForm.label = service.label;
  serviceForm.description = service.description || "";
  serviceForm.icon = service.icon || "";
  serviceForm.href = service.href || "";
  serviceForm.order_index = service.order_index;
  isServiceModalOpen.value = true;
};

const resetFeatureForm = () => {
  featureForm.id = "";
  featureForm.serviceId = "";
  featureForm.label = "";
  featureForm.icon = "";
  featureForm.description = "";
};

const resetImageForm = () => {
  imageForm.id = "";
  imageForm.serviceId = "";
  imageForm.image_url = "";
  imageForm.storage_path = "";
  imageForm.alt = "";
  imageForm.order_index = 1;
  imageUploadFiles.value = [];
};

const openCreateFeatureModal = (service?: ServiceItemRecord) => {
  resetFeatureForm();
  featureModalMode.value = "create";
  if (service) {
    featureForm.serviceId = service.id;
  } else if (featureServiceFilter.value) {
    featureForm.serviceId = featureServiceFilter.value;
  }
  isFeatureModalOpen.value = true;
};

const openCreateImageModal = (service?: ServiceItemRecord) => {
  resetImageForm();
  imageModalMode.value = "create";
  if (service) {
    imageForm.serviceId = service.id;
    imageForm.order_index = (service.service_item_images?.length || 0) + 1;
  } else if (photoServiceFilter.value) {
    imageForm.serviceId = photoServiceFilter.value;
    const target = findServiceById(photoServiceFilter.value);
    imageForm.order_index = (target?.service_item_images?.length || 0) + 1;
  }
  isImageModalOpen.value = true;
};

const openEditFeatureModal = (feature: FeatureRecord) => {
  featureModalMode.value = "edit";
  featureForm.id = feature.id;
  featureForm.serviceId = feature.service_item_id || "";
  featureForm.label = feature.label;
  featureForm.icon = feature.icon || "";
  featureForm.description = feature.description || "";
  isFeatureModalOpen.value = true;
};

const openEditImageModal = (image: ImageRecord) => {
  imageModalMode.value = "edit";
  imageForm.id = image.id;
  imageForm.serviceId = image.service_item_id || "";
  imageForm.image_url = image.image_url;
  imageForm.storage_path = image.storage_path || "";
  imageForm.alt = image.alt || "";
  imageForm.order_index = image.order_index || 1;
  imageUploadFiles.value = [];
  isImageModalOpen.value = true;
};

const saveService = async () => {
  if (!serviceForm.label.trim()) {
    toast.add({
      title: "Validation error",
      description: "Service name is required.",
      color: "error",
    });
    return;
  }

  if (!serviceForm.categoryId) {
    toast.add({
      title: "Validation error",
      description: "A category is required for the service.",
      color: "error",
    });
    return;
  }

  isSavingService.value = true;

  const payload = {
    category_id: serviceForm.categoryId,
    label: serviceForm.label.trim(),
    description: serviceForm.description.trim()
      ? serviceForm.description.trim()
      : null,
    icon: serviceForm.icon.trim() ? serviceForm.icon.trim() : null,
    href: serviceForm.href.trim() ? serviceForm.href.trim() : null,
    order_index: Number.isFinite(serviceForm.order_index)
      ? serviceForm.order_index
      : 1,
  };

  let error;

  if (serviceModalMode.value === "create") {
    ({ error } = await (supabase as any).from("service_items").insert(payload));
  } else {
    ({ error } = await (supabase as any)
      .from("service_items")
      .update(payload)
      .eq("id", serviceForm.id));
  }

  if (error) {
    toast.add({
      title: "Error",
      description: "Failed to save service.",
      color: "error",
    });
  } else {
    toast.add({
      title:
        serviceModalMode.value === "create"
          ? "Service created"
          : "Service updated",
      description: "The services navigation has been updated.",
      color: "success",
    });
    isServiceModalOpen.value = false;
    await fetchServicesNavigation();
  }

  isSavingService.value = false;
};

const deleteService = async (service: ServiceItemRecord) => {
  if (!confirm(`Delete service "${service.label}"?`)) {
    return;
  }

  const { error } = await supabase
    .from("service_items")
    .delete()
    .eq("id", service.id);

  if (error) {
    toast.add({
      title: "Error",
      description: "Failed to delete service.",
      color: "error",
    });
  } else {
    toast.add({
      title: "Service deleted",
      description: "The services navigation has been updated.",
      color: "success",
    });
    await fetchServicesNavigation();
  }
};

const saveFeature = async () => {
  if (!featureForm.label.trim()) {
    toast.add({
      title: "Validation error",
      description: "Feature label is required.",
      color: "error",
    });
    return;
  }
  if (!featureForm.serviceId) {
    toast.add({
      title: "Validation error",
      description: "Missing service reference.",
      color: "error",
    });
    return;
  }

  isSavingFeature.value = true;

  const payload = {
    service_item_id: featureForm.serviceId,
    label: featureForm.label.trim(),
    icon: featureForm.icon.trim() ? featureForm.icon.trim() : null,
    description: featureForm.description.trim()
      ? featureForm.description.trim()
      : null,
  };

  let error;
  if (featureModalMode.value === "create") {
    ({ error } = await (supabase as any)
      .from("service_item_features")
      .insert(payload));
  } else {
    ({ error } = await (supabase as any)
      .from("service_item_features")
      .update(payload)
      .eq("id", featureForm.id));
  }

  if (error) {
    toast.add({
      title: "Error",
      description: "Failed to save feature.",
      color: "error",
    });
  } else {
    toast.add({
      title:
        featureModalMode.value === "create"
          ? "Feature created"
          : "Feature updated",
      description: "Service features updated.",
      color: "success",
    });
    isFeatureModalOpen.value = false;
    await fetchServicesNavigation();
  }

  isSavingFeature.value = false;
};

const deleteFeature = async (feature: FeatureRecord) => {
  if (!confirm(`Delete feature "${feature.label}"?`)) return;

  const { error } = await supabase
    .from("service_item_features")
    .delete()
    .eq("id", feature.id);

  if (error) {
    toast.add({
      title: "Error",
      description: "Failed to delete feature.",
      color: "error",
    });
  } else {
    toast.add({
      title: "Feature deleted",
      description: "Service features updated.",
      color: "success",
    });
    await fetchServicesNavigation();
  }
};

const saveImage = async () => {
  if (!imageForm.serviceId) {
    toast.add({
      title: "Validation error",
      description: "Missing service reference.",
      color: "error",
    });
    return;
  }

  if (imageModalMode.value === "create" && !imageUploadFiles.value.length) {
    toast.add({
      title: "Validation error",
      description: "Please select an image file.",
      color: "error",
    });
    return;
  }

  isSavingImage.value = true;

  try {
    let publicUrl = imageForm.image_url;
    let storagePath = imageForm.storage_path;

    if (imageUploadFiles.value.length) {
      const file = imageUploadFiles.value[0] as File;
      const path = `${imageForm.serviceId}/${Date.now()}-${file.name}`;
      const { error: uploadError } = await supabase.storage
        .from(serviceImageBucket)
        .upload(path, file, {
          cacheControl: "3600",
          upsert: false,
        });

      if (uploadError) throw uploadError;

      const { data: publicData } = supabase.storage
        .from(serviceImageBucket)
        .getPublicUrl(path);
      publicUrl = publicData?.publicUrl || "";
      storagePath = path;
    }

    if (!publicUrl) {
      throw new Error("Missing image URL after upload.");
    }

    const payload = {
      service_item_id: imageForm.serviceId,
      image_url: publicUrl,
      storage_path: storagePath || deriveStoragePathFromUrl(publicUrl),
      alt: imageForm.alt.trim() ? imageForm.alt.trim() : null,
      order_index: Number.isFinite(imageForm.order_index)
        ? imageForm.order_index
        : 1,
    };

    let error;
    if (imageModalMode.value === "create") {
      ({ error } = await (supabase as any)
        .from("service_item_images")
        .insert(payload));
    } else {
      ({ error } = await (supabase as any)
        .from("service_item_images")
        .update(payload)
        .eq("id", imageForm.id));
    }

    if (error) throw error;

    // Clear cached data for the services page
    await clearNuxtData("services-page");

    toast.add({
      title:
        imageModalMode.value === "create" ? "Image uploaded" : "Image updated",
      description: "Service images updated.",
      color: "success",
    });
    isImageModalOpen.value = false;
    await fetchServicesNavigation();
  } catch (err: any) {
    console.error("Error saving image:", err);
    toast.add({
      title: "Error",
      description: err.message || "Failed to save image.",
      color: "error",
    });
  } finally {
    isSavingImage.value = false;
  }
};

const deleteImage = async (image: ImageRecord) => {
  if (!confirm("Delete this image?")) return;

  const path = image.storage_path || deriveStoragePathFromUrl(image.image_url);
  if (path) {
    await supabase.storage.from(serviceImageBucket).remove([path]);
  }

  const { error } = await supabase
    .from("service_item_images")
    .delete()
    .eq("id", image.id);

  if (error) {
    toast.add({
      title: "Error",
      description: "Failed to delete image.",
      color: "error",
    });
  } else {
    toast.add({
      title: "Image deleted",
      description: "Service images updated.",
      color: "success",
    });
    await fetchServicesNavigation();
  }
};

watch(isCategoryModalOpen, (open) => {
  if (!open) {
    resetCategoryForm();
    categoryModalMode.value = "create";
  }
});

watch(isServiceModalOpen, (open) => {
  if (!open) {
    resetServiceForm();
    serviceModalMode.value = "create";
  }
});

watch(isFeatureModalOpen, (open) => {
  if (!open) {
    resetFeatureForm();
    featureModalMode.value = "create";
  }
});

watch(isImageModalOpen, (open) => {
  if (!open) {
    resetImageForm();
    imageModalMode.value = "create";
  }
});

const fetchServicesNavigation = async () => {
  servicesNavigationLoading.value = true;

  const { data, error } = await supabase
    .from("service_categories")
    .select(
      "id, label, description, icon, order_index, service_items(id, label, description, icon, href, order_index, service_item_features(id, label, icon, description, created_at), service_item_images(id, image_url, storage_path, alt, order_index, created_at))"
    )
    .order("order_index", { ascending: true })
    .order("order_index", { foreignTable: "service_items", ascending: true });

  if (error) {
    toast.add({
      title: "Error",
      description: "Failed to load services navigation.",
      color: "error",
    });
    serviceCategories.value = [];
  } else {
    const typedData = (data ?? []) as any[];
    serviceCategories.value = typedData.map((category: any) => ({
      id: category.id,
      label: category.label,
      description: category.description,
      icon: category.icon,
      order_index: category.order_index,
      service_items: (category.service_items ?? []).map((item: any) => ({
        id: item.id,
        label: item.label,
        description: item.description,
        icon: item.icon,
        href: item.href,
        order_index: item.order_index,
        service_item_images: (item.service_item_images ?? []).map(
          (image: any) => ({
            id: image.id,
            image_url: image.image_url,
            storage_path: image.storage_path,
            alt: image.alt,
            order_index: image.order_index,
            created_at: image.created_at,
            service_item_id: item.id,
          })
        ),
        service_item_features: (item.service_item_features ?? []).map(
          (feature: any) => ({
            id: feature.id,
            label: feature.label,
            icon: feature.icon,
            description: feature.description,
            created_at: feature.created_at,
            service_item_id: item.id,
          })
        ),
      })),
    }));
  }

  servicesNavigationLoading.value = false;
};

const extractBudgetValue = (budget?: string | null) => {
  if (!budget) return 0;
  const matches = budget.match(/[\d,.]+/g);
  if (!matches?.length) return 0;
  const numbers = matches
    .map((num) => Number(num.replace(/,/g, "")))
    .filter((value) => !Number.isNaN(value));

  if (!numbers.length) return 0;
  const [first = 0, second = first] = numbers;
  if (numbers.length >= 2) {
    return (first + second) / 2;
  }
  return first;
};

const fetchContactRequests = async () => {
  contactLoading.value = true;
  const { data, error } = await supabase
    .from("contact_requests")
    .select("*")
    .order("created_at", { ascending: false });

  if (error) {
    toast.add({
      title: "Error",
      description: "Failed to fetch contact requests",
      color: "error",
    });
    contactRequests.value = [];
  } else {
    const mappedRequests = (data ?? []).map((request: any) => {
      const attachmentsArray = Array.isArray(request.attachments)
        ? request.attachments
        : request.attachments
          ? [request.attachments]
          : [];

      const attachments = attachmentsArray.map(
        (attachment: any, index: number) => {
          if (typeof attachment === "string") {
            return { url: attachment, name: `Attachment ${index + 1}` };
          }
          return {
            url: attachment?.url || attachment?.path || null,
            name:
              attachment?.name ||
              attachment?.filename ||
              `Attachment ${index + 1}`,
          };
        }
      );

      return {
        ...request,
        attachments,
      } as ContactRequest;
    });

    contactRequests.value = mappedRequests;

    const now = new Date();
    activeProjects.value = mappedRequests.filter((request) => {
      if (!request.deadline) return true;
      const deadlineDate = new Date(request.deadline);
      return deadlineDate >= now;
    }).length;

    pendingOrders.value = mappedRequests.filter(
      (request) => !request.deadline
    ).length;

    totalRevenue.value = mappedRequests.reduce((sum, request) => {
      return sum + extractBudgetValue(request.budget);
    }, 0);
  }

  contactLoading.value = false;
};
</script>

<template>
  <div class="min-h-dvh bg-muted/20">
    <a
      href="#admin-main"
      class="sr-only focus:not-sr-only focus:fixed focus:top-2 focus:left-2 focus:z-50 focus:rounded-md focus:bg-primary focus:px-3 focus:py-2 focus:text-white"
    >Skip to admin content</a>

    <div class="flex">
      <!-- Sidebar (desktop) -->
      <aside
        class="sticky top-0 hidden h-dvh w-72 shrink-0 flex-col border-r border-default bg-background lg:flex"
        aria-label="Admin navigation"
      >
        <div class="flex items-center gap-3 border-b border-default px-6 py-5">
          <span
            class="flex h-9 w-9 items-center justify-center rounded-xl bg-primary/10 text-primary"
            aria-hidden="true"
          >
            <UIcon name="i-lucide-rainbow" class="h-5 w-5" />
          </span>
          <div class="leading-tight">
            <p class="text-sm font-semibold text-highlighted">
              Rainbow Retouch
            </p>
            <p class="text-xs text-muted">Admin console</p>
          </div>
        </div>

        <nav class="flex-1 overflow-y-auto px-3 py-4" aria-label="Sections">
          <ul class="space-y-1">
            <li v-for="item in navItems" :key="item.key">
              <button
                type="button"
                class="group flex w-full items-center gap-3 rounded-lg px-3 py-2 text-left text-sm transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary"
                :class="
                  activeSection === item.key
                    ? 'bg-primary/10 text-primary'
                    : 'text-muted hover:bg-muted/40 hover:text-highlighted'
                "
                :aria-current="activeSection === item.key ? 'page' : undefined"
                @click="setSection(item.key)"
              >
                <UIcon :name="item.icon" class="h-4 w-4" aria-hidden="true" />
                <span class="flex-1">{{ item.label }}</span>
                <UIcon
                  v-if="activeSection === item.key"
                  name="i-lucide-chevron-right"
                  class="h-3.5 w-3.5"
                  aria-hidden="true"
                />
              </button>
            </li>
          </ul>
        </nav>

        <div class="border-t border-default p-4">
          <div class="flex items-center gap-3">
            <UAvatar
              :alt="profile?.full_name || profile?.email || 'Admin avatar'"
              :src="profile?.avatar_url || undefined"
              size="sm"
            />
            <div class="min-w-0 flex-1">
              <p class="truncate text-sm font-medium text-highlighted">
                {{ profile?.full_name || "Admin" }}
              </p>
              <p class="truncate text-xs text-muted">
                {{ profile?.email }}
              </p>
            </div>
            <UButton
              icon="i-lucide-log-out"
              color="neutral"
              variant="ghost"
              size="sm"
              aria-label="Sign out"
              @click="logout"
            />
          </div>
        </div>
      </aside>

      <!-- Main column -->
      <div class="flex min-w-0 flex-1 flex-col">
        <!-- Topbar -->
        <header
          class="sticky top-0 z-20 flex flex-wrap items-center gap-3 border-b border-default bg-background/85 px-4 py-3 backdrop-blur supports-[backdrop-filter]:bg-background/70 sm:px-6 lg:px-8"
        >
          <UButton
            class="lg:hidden"
            icon="i-lucide-menu"
            color="neutral"
            variant="ghost"
            aria-label="Open navigation"
            @click="mobileNavOpen = true"
          />
          <div class="min-w-0">
            <p class="text-xs font-medium uppercase tracking-wide text-muted">
              {{ currentSection.description }}
            </p>
            <h1 class="text-xl font-semibold text-highlighted sm:text-2xl">
              {{ currentSection.label }}
            </h1>
          </div>
          <div class="ml-auto flex items-center gap-2">
            <UButton
              v-if="activeSection === 'overview'"
              label="Refresh"
              icon="i-lucide-refresh-cw"
              color="neutral"
              variant="outline"
              size="sm"
              @click="
                fetchUsers();
                fetchContactRequests();
                fetchServicesNavigation();
              "
            />
            <UButton
              v-if="activeSection === 'services'"
              label="Add category"
              icon="i-lucide-plus"
              color="primary"
              size="sm"
              @click="openCreateCategoryModal"
            />
          </div>
        </header>

        <main
          id="admin-main"
          tabindex="-1"
          class="flex-1 px-4 py-6 sm:px-6 lg:px-8"
        >
          <!-- OVERVIEW -->
          <section
            v-if="activeSection === 'overview'"
            aria-labelledby="overview-heading"
            class="space-y-6"
          >
            <h2 id="overview-heading" class="sr-only">Overview</h2>
            <UPageGrid class="gap-4">
              <UCard
                v-for="stat in stats"
                :key="stat.label"
                class="transition hover:border-primary/40"
              >
                <div class="flex items-center justify-between gap-4 p-6">
                  <div>
                    <p class="text-sm font-medium text-muted">{{ stat.label }}</p>
                    <p class="mt-2 text-3xl font-bold text-highlighted">
                      {{ stat.value }}
                    </p>
                  </div>
                  <span
                    class="flex h-12 w-12 items-center justify-center rounded-xl bg-primary/10 text-primary"
                    aria-hidden="true"
                  >
                    <UIcon :name="stat.icon" class="h-6 w-6" />
                  </span>
                </div>
              </UCard>
            </UPageGrid>

            <div class="grid gap-6 lg:grid-cols-2">
              <UCard>
                <template #header>
                  <div class="flex items-center justify-between gap-3">
                    <div>
                      <h3 class="text-base font-semibold text-highlighted">
                        Recent contact requests
                      </h3>
                      <p class="text-xs text-muted">
                        Latest 5 inquiries
                      </p>
                    </div>
                    <UButton
                      label="View all"
                      icon="i-lucide-arrow-right"
                      trailing
                      color="neutral"
                      variant="ghost"
                      size="xs"
                      @click="setSection('contacts')"
                    />
                  </div>
                </template>
                <ul
                  v-if="contactRequests.length"
                  class="divide-y divide-default"
                >
                  <li
                    v-for="request in contactRequests.slice(0, 5)"
                    :key="request.id"
                    class="flex items-center justify-between gap-3 py-3"
                  >
                    <div class="min-w-0">
                      <p class="truncate text-sm font-medium text-highlighted">
                        {{ request.first_name }} {{ request.last_name }}
                      </p>
                      <p class="truncate text-xs text-muted">
                        {{ request.subject }}
                      </p>
                    </div>
                    <time
                      v-if="request.created_at"
                      :datetime="request.created_at"
                      class="shrink-0 text-xs text-muted"
                    >{{
                      new Date(request.created_at).toLocaleDateString()
                    }}</time>
                  </li>
                </ul>
                <UEmpty
                  v-else
                  icon="i-lucide-inbox"
                  title="No contact requests"
                  description="New inquiries will appear here."
                />
              </UCard>

              <UCard>
                <template #header>
                  <div class="flex items-center justify-between gap-3">
                    <div>
                      <h3 class="text-base font-semibold text-highlighted">
                        New users
                      </h3>
                      <p class="text-xs text-muted">
                        Most recent signups
                      </p>
                    </div>
                    <UButton
                      label="View all"
                      icon="i-lucide-arrow-right"
                      trailing
                      color="neutral"
                      variant="ghost"
                      size="xs"
                      @click="setSection('users')"
                    />
                  </div>
                </template>
                <ul
                  v-if="users.length"
                  class="divide-y divide-default"
                >
                  <li
                    v-for="userItem in users.slice(0, 5)"
                    :key="userItem.id"
                    class="flex items-center gap-3 py-3"
                  >
                    <UAvatar
                      :src="userItem.avatar_url || undefined"
                      :alt="userItem.full_name || userItem.email || 'User'"
                      size="sm"
                    />
                    <div class="min-w-0 flex-1">
                      <p class="truncate text-sm font-medium text-highlighted">
                        {{ userItem.full_name || "No name" }}
                      </p>
                      <p class="truncate text-xs text-muted">
                        {{ userItem.email }}
                      </p>
                    </div>
                    <UBadge
                      :label="userItem.role || 'user'"
                      :color="userItem.role === 'admin' ? 'primary' : 'neutral'"
                      size="xs"
                    />
                  </li>
                </ul>
                <UEmpty
                  v-else
                  icon="i-lucide-users"
                  title="No users yet"
                  description="Signed-up users will appear here."
                />
              </UCard>
            </div>
          </section>

          <!-- USERS -->
          <section
            v-else-if="activeSection === 'users'"
            aria-labelledby="users-heading"
            class="space-y-4"
          >
            <h2 id="users-heading" class="sr-only">Users</h2>
            <UCard>
              <template #header>
                <div class="flex flex-wrap items-center justify-between gap-3">
                  <div class="flex items-center gap-3">
                    <h3 class="text-base font-semibold text-highlighted">
                      All users
                    </h3>
                    <UBadge
                      :label="`${users.length}`"
                      color="primary"
                      variant="subtle"
                    />
                  </div>
                  <UInput
                    v-model="userSearch"
                    icon="i-lucide-search"
                    placeholder="Search users…"
                    class="w-full sm:w-64"
                    aria-label="Search users"
                  />
                </div>
              </template>

              <div
                v-if="loading"
                role="status"
                class="flex items-center justify-center py-12"
              >
                <UIcon
                  name="i-lucide-loader-2"
                  class="h-8 w-8 animate-spin text-primary"
                  aria-hidden="true"
                />
                <span class="sr-only">Loading users…</span>
              </div>
              <UEmpty
                v-else-if="!filteredUsers.length"
                icon="i-lucide-users"
                title="No users match"
                description="Try a different search term."
              />
              <ul v-else class="divide-y divide-default">
                <li
                  v-for="userItem in filteredUsers"
                  :key="userItem.id"
                  class="flex flex-wrap items-center justify-between gap-3 py-4"
                >
                  <div class="flex items-center gap-3">
                    <UAvatar
                      :src="userItem.avatar_url || undefined"
                      :alt="userItem.full_name || userItem.email || 'User avatar'"
                      size="md"
                    />
                    <div>
                      <p class="font-medium text-highlighted">
                        {{ userItem.full_name || "No name" }}
                      </p>
                      <p class="text-sm text-muted">
                        {{ userItem.email || "No email" }}
                      </p>
                    </div>
                  </div>
                  <div class="flex items-center gap-3">
                    <UBadge
                      :label="userItem.role || 'user'"
                      :color="userItem.role === 'admin' ? 'primary' : 'neutral'"
                      variant="subtle"
                    />
                    <p class="text-xs text-muted">
                      Joined
                      <time
                        v-if="userItem.created_at"
                        :datetime="userItem.created_at"
                      >{{
                        new Date(userItem.created_at).toLocaleDateString()
                      }}</time>
                      <span v-else>N/A</span>
                    </p>
                  </div>
                </li>
              </ul>
            </UCard>
          </section>

          <!-- SERVICES -->
          <section
            v-else-if="activeSection === 'services'"
            aria-labelledby="services-heading"
            class="space-y-4"
          >
            <h2 id="services-heading" class="sr-only">Services management</h2>

            <!-- Loading -->
            <div
              v-if="servicesNavigationLoading"
              role="status"
              class="flex items-center justify-center py-16"
            >
              <UIcon
                name="i-lucide-loader-2"
                class="h-8 w-8 animate-spin text-primary"
                aria-hidden="true"
              />
              <span class="sr-only">Loading services…</span>
            </div>

            <!-- Unified hierarchy -->
            <template v-else>
              <!-- Toolbar -->
              <div class="flex items-center gap-3">
                <UInput
                  v-model="servicesSearch"
                  icon="i-lucide-search"
                  placeholder="Search categories, services, features…"
                  class="w-full sm:w-96"
                  aria-label="Search services"
                />
                <p class="shrink-0 text-sm text-muted">
                  {{ serviceCategories.length }} {{ serviceCategories.length === 1 ? 'category' : 'categories' }},
                  {{ flatServices.length }} {{ flatServices.length === 1 ? 'service' : 'services' }}
                </p>
              </div>

              <UEmpty
                v-if="!serviceCategories.length"
                icon="i-lucide-layers"
                title="No categories yet"
                description="Click 'Add category' to get started."
              />
              <UEmpty
                v-else-if="!filteredServiceHierarchy.length"
                icon="i-lucide-search-x"
                title="Nothing matches"
                description="Try a different search term."
              />

              <!-- Category list -->
              <div v-else class="space-y-6">
                <section
                  v-for="category in filteredServiceHierarchy"
                  :key="category.id"
                  :aria-labelledby="`cat-heading-${category.id}`"
                  class="rounded-2xl border border-default bg-background"
                >
                  <!-- Category header -->
                  <header class="flex flex-wrap items-center gap-3 px-5 py-4 border-b border-default">
                    <span
                      class="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-primary/10 text-primary"
                      aria-hidden="true"
                    >
                      <UIcon :name="category.icon || 'i-lucide-folder'" class="h-5 w-5" />
                    </span>
                    <div class="min-w-0 flex-1">
                      <h3
                        :id="`cat-heading-${category.id}`"
                        class="font-semibold text-highlighted"
                      >
                        {{ category.label }}
                      </h3>
                      <p v-if="category.description" class="text-sm text-muted line-clamp-1">
                        {{ category.description }}
                      </p>
                    </div>
                    <UBadge
                      :label="`${category.service_items?.length || 0} service${(category.service_items?.length || 0) === 1 ? '' : 's'}`"
                      color="neutral"
                      variant="subtle"
                      size="xs"
                    />
                    <div class="flex items-center gap-1">
                      <UButton
                        size="xs"
                        label="Add service"
                        icon="i-lucide-plus"
                        color="primary"
                        variant="soft"
                        :aria-label="`Add a service to ${category.label}`"
                        @click="openCreateServiceModal(category)"
                      />
                      <UButton
                        size="xs"
                        icon="i-lucide-pencil"
                        variant="ghost"
                        color="neutral"
                        :aria-label="`Edit category ${category.label}`"
                        @click="openEditCategoryModal(category)"
                      />
                      <UButton
                        size="xs"
                        icon="i-lucide-trash"
                        variant="ghost"
                        color="error"
                        :aria-label="`Delete category ${category.label}`"
                        @click="deleteCategory(category)"
                      />
                    </div>
                  </header>

                  <!-- Services list -->
                  <UEmpty
                    v-if="!category.service_items?.length"
                    icon="i-lucide-sparkles"
                    title="No services yet"
                    :description="`Add the first service to ${category.label}.`"
                    class="py-8"
                  />
                  <ul v-else class="divide-y divide-default">
                    <li
                      v-for="service in category.service_items"
                      :key="service.id"
                    >
                      <!-- Service row -->
                      <div class="flex items-center gap-3 px-5 py-3.5">
                        <button
                          type="button"
                          class="flex flex-1 items-center gap-3 text-left focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary rounded-lg min-w-0"
                          :aria-expanded="expandedServices.has(service.id)"
                          :aria-controls="`service-panel-${service.id}`"
                          @click="toggleService(service.id)"
                        >
                          <span
                            class="flex h-9 w-9 shrink-0 items-center justify-center rounded-lg bg-muted/50 text-muted"
                            aria-hidden="true"
                          >
                            <UIcon :name="service.icon || 'i-lucide-sparkles'" class="h-4 w-4" />
                          </span>
                          <div class="min-w-0 flex-1">
                            <p class="font-medium text-highlighted">{{ service.label }}</p>
                            <p v-if="service.description" class="truncate text-xs text-muted">
                              {{ service.description }}
                            </p>
                          </div>
                          <div class="flex shrink-0 items-center gap-2">
                            <UBadge
                              :label="`${service.service_item_features?.length || 0} feat`"
                              color="neutral"
                              variant="subtle"
                              size="xs"
                            />
                            <UBadge
                              :label="`${service.service_item_images?.length || 0} photo${(service.service_item_images?.length || 0) === 1 ? '' : 's'}`"
                              color="neutral"
                              variant="subtle"
                              size="xs"
                            />
                            <UIcon
                              name="i-lucide-chevron-down"
                              class="h-4 w-4 text-muted transition-transform duration-200"
                              :class="expandedServices.has(service.id) ? 'rotate-180' : ''"
                              aria-hidden="true"
                            />
                          </div>
                        </button>
                        <div class="flex shrink-0 items-center gap-1">
                          <UButton
                            size="xs"
                            icon="i-lucide-pencil"
                            variant="ghost"
                            color="neutral"
                            :aria-label="`Edit service ${service.label}`"
                            @click="openEditServiceModal(service, category.id)"
                          />
                          <UButton
                            size="xs"
                            icon="i-lucide-trash"
                            variant="ghost"
                            color="error"
                            :aria-label="`Delete service ${service.label}`"
                            @click="deleteService(service)"
                          />
                        </div>
                      </div>

                      <!-- Expanded panel: Features + Photos -->
                      <div
                        v-show="expandedServices.has(service.id)"
                        :id="`service-panel-${service.id}`"
                        class="border-t border-default/60 bg-muted/20"
                      >
                        <div class="grid gap-0 md:grid-cols-2 md:divide-x md:divide-default">
                          <!-- Features column -->
                          <div class="p-4">
                            <div class="mb-3 flex items-center justify-between gap-2">
                              <div class="flex items-center gap-2">
                                <UIcon name="i-lucide-star" class="h-4 w-4 text-muted" aria-hidden="true" />
                                <h4 class="text-sm font-semibold text-highlighted">Features</h4>
                                <UBadge
                                  v-if="service.service_item_features?.length"
                                  :label="`${service.service_item_features.length}`"
                                  color="neutral"
                                  variant="subtle"
                                  size="xs"
                                />
                              </div>
                              <UButton
                                size="xs"
                                label="Add"
                                icon="i-lucide-plus"
                                color="primary"
                                variant="ghost"
                                :aria-label="`Add a feature to ${service.label}`"
                                @click="openCreateFeatureModal(service)"
                              />
                            </div>
                            <UEmpty
                              v-if="!service.service_item_features?.length"
                              icon="i-lucide-star"
                              title="No features"
                              description="Add features to highlight this service."
                              class="rounded-xl border border-dashed border-default py-5 text-sm"
                            />
                            <ul v-else class="space-y-1">
                              <li
                                v-for="feature in service.service_item_features"
                                :key="feature.id"
                                class="group flex items-center gap-2 rounded-lg px-2 py-2 transition hover:bg-background"
                              >
                                <span
                                  class="flex h-7 w-7 shrink-0 items-center justify-center rounded-md bg-primary/10 text-primary"
                                  aria-hidden="true"
                                >
                                  <UIcon :name="feature.icon || 'i-lucide-check'" class="h-3.5 w-3.5" />
                                </span>
                                <div class="min-w-0 flex-1">
                                  <p class="text-sm font-medium text-highlighted">{{ feature.label }}</p>
                                  <p v-if="feature.description" class="truncate text-xs text-muted">
                                    {{ feature.description }}
                                  </p>
                                </div>
                                <div class="flex items-center gap-0.5 opacity-0 transition group-hover:opacity-100 group-focus-within:opacity-100">
                                  <UButton
                                    size="xs"
                                    icon="i-lucide-pencil"
                                    variant="ghost"
                                    color="neutral"
                                    :aria-label="`Edit feature ${feature.label}`"
                                    @click="openEditFeatureModal(feature)"
                                  />
                                  <UButton
                                    size="xs"
                                    icon="i-lucide-trash"
                                    variant="ghost"
                                    color="error"
                                    :aria-label="`Delete feature ${feature.label}`"
                                    @click="deleteFeature(feature)"
                                  />
                                </div>
                              </li>
                            </ul>
                          </div>

                          <!-- Photos column -->
                          <div class="border-t border-default/60 p-4 md:border-t-0">
                            <div class="mb-3 flex items-center justify-between gap-2">
                              <div class="flex items-center gap-2">
                                <UIcon name="i-lucide-image" class="h-4 w-4 text-muted" aria-hidden="true" />
                                <h4 class="text-sm font-semibold text-highlighted">Photos</h4>
                                <UBadge
                                  v-if="service.service_item_images?.length"
                                  :label="`${service.service_item_images.length}`"
                                  color="neutral"
                                  variant="subtle"
                                  size="xs"
                                />
                              </div>
                              <UButton
                                size="xs"
                                label="Upload"
                                icon="i-lucide-image-plus"
                                color="primary"
                                variant="ghost"
                                :aria-label="`Upload a photo for ${service.label}`"
                                @click="openCreateImageModal(service)"
                              />
                            </div>
                            <UEmpty
                              v-if="!service.service_item_images?.length"
                              icon="i-lucide-image-off"
                              title="No photos"
                              :description="`Upload photos for ${service.label}.`"
                              class="rounded-xl border border-dashed border-default py-5 text-sm"
                            />
                            <ul
                              v-else
                              class="grid grid-cols-2 gap-2 sm:grid-cols-3"
                            >
                              <li
                                v-for="photo in service.service_item_images"
                                :key="photo.id"
                                class="group relative overflow-hidden rounded-xl border border-default bg-background transition hover:border-primary/40 focus-within:border-primary/60"
                              >
                                <img
                                  :src="photo.image_url"
                                  :alt="photo.alt || `${service.label} photo`"
                                  class="h-24 w-full object-cover"
                                />
                                <p class="truncate px-1.5 py-1 text-xs text-muted">
                                  {{ photo.alt || "No alt" }}
                                </p>
                                <div
                                  class="absolute right-1 top-1 flex gap-0.5 opacity-0 transition group-hover:opacity-100 group-focus-within:opacity-100"
                                >
                                  <UButton
                                    size="xs"
                                    icon="i-lucide-pencil"
                                    variant="solid"
                                    color="neutral"
                                    :aria-label="`Edit photo ${photo.alt || ''}`"
                                    @click="openEditImageModal(photo)"
                                  />
                                  <UButton
                                    size="xs"
                                    icon="i-lucide-trash"
                                    variant="solid"
                                    color="error"
                                    :aria-label="`Delete photo ${photo.alt || ''}`"
                                    @click="deleteImage(photo)"
                                  />
                                </div>
                              </li>
                            </ul>
                          </div>
                        </div>
                      </div>
                    </li>
                  </ul>
                </section>
              </div>
            </template>
          </section>

          <!-- CONTACTS -->
          <section
            v-else-if="activeSection === 'contacts'"
            aria-labelledby="contacts-heading"
            class="space-y-4"
          >
            <h2 id="contacts-heading" class="sr-only">Contact requests</h2>
            <UCard>
              <template #header>
                <div class="flex flex-wrap items-center justify-between gap-3">
                  <div class="flex items-center gap-3">
                    <h3 class="text-base font-semibold text-highlighted">
                      Contact requests
                    </h3>
                    <UBadge
                      :label="`${contactRequests.length}`"
                      color="primary"
                      variant="subtle"
                    />
                  </div>
                  <UInput
                    v-model="contactSearch"
                    icon="i-lucide-search"
                    placeholder="Search by name, subject, message…"
                    class="w-full sm:w-72"
                    aria-label="Search contact requests"
                  />
                </div>
              </template>

              <div
                v-if="contactLoading"
                role="status"
                class="flex items-center justify-center py-12"
              >
                <UIcon
                  name="i-lucide-loader-2"
                  class="h-8 w-8 animate-spin text-primary"
                  aria-hidden="true"
                />
                <span class="sr-only">Loading contact requests…</span>
              </div>
              <UEmpty
                v-else-if="!contactRequests.length"
                icon="i-lucide-inbox"
                title="No contact requests yet"
                description="New requests will appear here as soon as clients reach out."
              />
              <UEmpty
                v-else-if="!filteredContactRequests.length"
                icon="i-lucide-search-x"
                title="Nothing matches"
                description="Try a different search term."
              />
              <ul v-else class="space-y-4">
                <li
                  v-for="request in filteredContactRequests"
                  :key="request.id"
                  class="rounded-2xl border border-default p-5 transition-colors hover:border-primary/40 focus-within:border-primary/60"
                >
                  <article :aria-labelledby="`request-${request.id}-name`">
                    <header class="flex flex-wrap items-start justify-between gap-4">
                      <div>
                        <h4
                          :id="`request-${request.id}-name`"
                          class="text-lg font-semibold text-highlighted"
                        >
                          {{ request.first_name }} {{ request.last_name }}
                        </h4>
                        <div class="mt-2 flex flex-wrap gap-3 text-sm text-muted">
                          <a
                            :href="`mailto:${request.email}`"
                            class="inline-flex items-center gap-2 hover:text-highlighted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary rounded-sm"
                            :aria-label="`Email ${request.first_name} ${request.last_name}`"
                          >
                            <UIcon name="i-lucide-mail" class="h-4 w-4" aria-hidden="true" />
                            {{ request.email }}
                          </a>
                          <a
                            v-if="request.phone"
                            :href="`tel:${request.phone}`"
                            class="inline-flex items-center gap-2 hover:text-highlighted focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary rounded-sm"
                            :aria-label="`Call ${request.first_name} ${request.last_name}`"
                          >
                            <UIcon name="i-lucide-phone" class="h-4 w-4" aria-hidden="true" />
                            {{ request.phone }}
                          </a>
                        </div>
                      </div>
                      <div class="text-right">
                        <p class="text-xs font-medium uppercase tracking-wide text-muted">
                          Received
                        </p>
                        <p class="text-sm font-semibold text-highlighted">
                          <time
                            v-if="request.created_at"
                            :datetime="request.created_at"
                          >{{
                            new Date(request.created_at).toLocaleDateString()
                          }}</time>
                          <span v-else>—</span>
                        </p>
                      </div>
                    </header>

                    <dl class="mt-4 grid gap-4 sm:grid-cols-3">
                      <div>
                        <dt class="text-xs font-medium uppercase tracking-wide text-muted">
                          Subject
                        </dt>
                        <dd class="font-medium text-highlighted">
                          {{ request.subject }}
                        </dd>
                      </div>
                      <div>
                        <dt class="text-xs font-medium uppercase tracking-wide text-muted">
                          Budget
                        </dt>
                        <dd class="font-medium text-highlighted">
                          {{ request.budget || "Not specified" }}
                        </dd>
                      </div>
                      <div>
                        <dt class="text-xs font-medium uppercase tracking-wide text-muted">
                          Deadline
                        </dt>
                        <dd class="font-medium text-highlighted">
                          <time
                            v-if="request.deadline"
                            :datetime="request.deadline"
                          >{{
                            new Date(request.deadline).toLocaleDateString()
                          }}</time>
                          <span v-else>Flexible</span>
                        </dd>
                      </div>
                    </dl>

                    <div class="mt-4">
                      <p class="mb-2 text-xs font-medium uppercase tracking-wide text-muted">
                        Message
                      </p>
                      <p class="whitespace-pre-line text-sm leading-relaxed text-default">
                        {{ request.message }}
                      </p>
                    </div>

                    <div v-if="request.attachments.length" class="mt-4">
                      <p
                        :id="`request-${request.id}-attachments`"
                        class="mb-2 text-xs font-medium uppercase tracking-wide text-muted"
                      >
                        Attachments
                      </p>
                      <ul
                        class="flex flex-wrap gap-3"
                        :aria-labelledby="`request-${request.id}-attachments`"
                      >
                        <li
                          v-for="(attachment, index) in request.attachments"
                          :key="`${request.id}-attachment-${index}`"
                        >
                          <button
                            type="button"
                            class="flex h-44 w-44 flex-col overflow-hidden rounded-xl border border-default bg-muted/30 transition hover:shadow-lg focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary"
                            :aria-label="`Preview attachment ${attachment.name || index + 1}`"
                            @click="openAttachmentModal(attachment, request)"
                          >
                            <img
                              v-if="attachment.url"
                              :src="attachment.url"
                              :alt="attachment.name || `Attachment ${index + 1}`"
                              class="h-full w-full object-cover"
                            />
                            <div
                              v-else
                              class="flex flex-1 items-center justify-center px-2 text-center text-xs text-muted"
                            >
                              No preview
                            </div>
                            <div
                              class="truncate bg-background/80 p-1 text-center text-xs text-muted"
                            >
                              {{ attachment.name || `Attachment ${index + 1}` }}
                            </div>
                          </button>
                        </li>
                      </ul>
                    </div>
                  </article>
                </li>
              </ul>
            </UCard>
          </section>
        </main>
      </div>
    </div>

    <!-- Mobile sidebar drawer -->
    <USlideover
      v-model:open="mobileNavOpen"
      side="left"
      :ui="{ content: 'max-w-xs' }"
    >
      <template #content>
        <div class="flex h-full flex-col bg-background">
          <div class="flex items-center justify-between border-b border-default px-4 py-4">
            <div class="flex items-center gap-2">
              <span
                class="flex h-8 w-8 items-center justify-center rounded-lg bg-primary/10 text-primary"
                aria-hidden="true"
              >
                <UIcon name="i-lucide-rainbow" class="h-4 w-4" />
              </span>
              <span class="text-sm font-semibold text-highlighted">
                Admin
              </span>
            </div>
            <UButton
              icon="i-lucide-x"
              color="neutral"
              variant="ghost"
              size="sm"
              aria-label="Close navigation"
              @click="mobileNavOpen = false"
            />
          </div>
          <nav class="flex-1 overflow-y-auto px-3 py-4" aria-label="Sections">
            <ul class="space-y-1">
              <li v-for="item in navItems" :key="item.key">
                <button
                  type="button"
                  class="flex w-full items-center gap-3 rounded-lg px-3 py-2 text-left text-sm transition-colors focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-primary"
                  :class="
                    activeSection === item.key
                      ? 'bg-primary/10 text-primary'
                      : 'text-muted hover:bg-muted/40 hover:text-highlighted'
                  "
                  :aria-current="activeSection === item.key ? 'page' : undefined"
                  @click="setSection(item.key)"
                >
                  <UIcon :name="item.icon" class="h-4 w-4" aria-hidden="true" />
                  {{ item.label }}
                </button>
              </li>
            </ul>
          </nav>
          <div class="border-t border-default p-4">
            <UButton
              label="Sign out"
              icon="i-lucide-log-out"
              color="neutral"
              variant="outline"
              block
              @click="logout"
            />
          </div>
        </div>
      </template>
    </USlideover>
    <UModal v-model:open="isCategoryModalOpen" :ui="{ content: 'max-w-xl' }">
      <template #header>
        <div>
          <p class="text-sm text-muted">
            {{
              categoryModalMode === "create"
                ? "Create category"
                : "Edit category"
            }}
          </p>
          <h2 class="text-lg font-semibold text-highlighted">
            {{
              categoryModalMode === "create"
                ? "New Services Category"
                : "Update Services Category"
            }}
          </h2>
        </div>
      </template>

      <template #body>
        <div class="space-y-4">
          <UFormGroup label="Label" required>
            <UInput
              v-model="categoryForm.label"
              placeholder="Brand Strategy"
              :disabled="isSavingCategory"
            />
          </UFormGroup>
          <UFormGroup label="Description">
            <UTextarea
              v-model="categoryForm.description"
              placeholder="Short teaser that appears in the menu"
              :rows="3"
              :disabled="isSavingCategory"
            />
          </UFormGroup>
          <UFormGroup label="Icon">
            <UInput
              v-model="categoryForm.icon"
              placeholder="i-lucide-sparkles"
              :disabled="isSavingCategory"
              model-value="i-lucide-sparkles"
            />
          </UFormGroup>
          <UFormGroup label="Order">
            <UInput
              v-model.number="categoryForm.order_index"
              type="number"
              min="1"
              :disabled="isSavingCategory"
            />
          </UFormGroup>
        </div>
      </template>

      <template #footer>
        <div class="flex justify-end gap-3">
          <UButton
            label="Cancel"
            color="neutral"
            variant="ghost"
            :disabled="isSavingCategory"
            @click="isCategoryModalOpen = false"
          />
          <UButton
            :label="
              categoryModalMode === 'create'
                ? 'Create category'
                : 'Save changes'
            "
            color="primary"
            :loading="isSavingCategory"
            @click="saveCategory"
          />
        </div>
      </template>
    </UModal>

    <UModal v-model:open="isServiceModalOpen" :ui="{ content: 'max-w-xl' }">
      <template #header>
        <div>
          <p class="text-sm text-muted">
            {{
              serviceModalMode === "create" ? "Create service" : "Edit service"
            }}
          </p>
          <h2 class="text-lg font-semibold text-highlighted">
            {{
              serviceModalMode === "create"
                ? "New Service Item"
                : "Update Service Item"
            }}
          </h2>
        </div>
      </template>

      <template #body>
        <div class="space-y-4">
          <UFormGroup label="Category" required>
            <USelectMenu
              v-model="serviceForm.categoryId"
              :options="serviceCategoryOptions"
              option-attribute="label"
              value-attribute="id"
              placeholder="Select category"
              :disabled="isSavingService"
            />
          </UFormGroup>
          <UFormGroup label="Label" required>
            <UInput
              v-model="serviceForm.label"
              placeholder="Website Audit"
              :disabled="isSavingService"
            />
          </UFormGroup>
          <UFormGroup label="Description">
            <UTextarea
              v-model="serviceForm.description"
              placeholder="Short teaser that appears in the menu"
              :rows="3"
              :disabled="isSavingService"
            />
          </UFormGroup>
          <div class="grid gap-4 md:grid-cols-2">
            <UFormGroup label="Icon">
              <UInput
                v-model="serviceForm.icon"
                placeholder="i-lucide-sparkles"
                :disabled="isSavingService"
                model-value="i-lucide-sparkles"
              />
            </UFormGroup>
            <UFormGroup label="URL">
              <UInput
                v-model="serviceForm.href"
                placeholder="/services/website-audit"
                :disabled="isSavingService"
              />
            </UFormGroup>
          </div>
          <UFormGroup label="Order">
            <UInput
              v-model.number="serviceForm.order_index"
              type="number"
              min="1"
              :disabled="isSavingService"
            />
          </UFormGroup>
        </div>
      </template>

      <template #footer>
        <div class="flex justify-end gap-3">
          <UButton
            label="Cancel"
            color="neutral"
            variant="ghost"
            :disabled="isSavingService"
            @click="isServiceModalOpen = false"
          />
          <UButton
            :label="
              serviceModalMode === 'create' ? 'Create service' : 'Save changes'
            "
            color="primary"
            :loading="isSavingService"
            @click="saveService"
          />
        </div>
      </template>
    </UModal>

    <UModal v-model:open="isFeatureModalOpen" :ui="{ content: 'max-w-xl' }">
      <template #header>
        <div>
          <p class="text-sm text-muted">
            {{
              featureModalMode === "create" ? "Create feature" : "Edit feature"
            }}
          </p>
          <h2 class="text-lg font-semibold text-highlighted">
            {{
              featureModalMode === "create"
                ? "New Service Feature"
                : "Update Service Feature"
            }}
          </h2>
        </div>
      </template>

      <template #body>
        <div class="space-y-4">
          <UFormGroup label="Service" required>
            <USelectMenu
              v-model="featureForm.serviceId"
              :options="serviceOptions"
              option-attribute="label"
              value-attribute="id"
              placeholder="Select service"
              :disabled="isSavingFeature"
            />
          </UFormGroup>
          <UFormGroup label="Label" required>
            <UInput
              v-model="featureForm.label"
              placeholder="Fast delivery"
              :disabled="isSavingFeature"
            />
          </UFormGroup>
          <UFormGroup label="Icon">
            <UInput
              v-model="featureForm.icon"
              placeholder="i-lucide-star"
              :disabled="isSavingFeature"
            />
          </UFormGroup>
          <UFormGroup label="Description">
            <UTextarea
              v-model="featureForm.description"
              placeholder="Short copy that describes the feature"
              :rows="3"
              :disabled="isSavingFeature"
            />
          </UFormGroup>
        </div>
      </template>

      <template #footer>
        <div class="flex justify-end gap-3">
          <UButton
            label="Cancel"
            color="neutral"
            variant="ghost"
            :disabled="isSavingFeature"
            @click="isFeatureModalOpen = false"
          />
          <UButton
            :label="
              featureModalMode === 'create' ? 'Create feature' : 'Save changes'
            "
            color="primary"
            :loading="isSavingFeature"
            @click="saveFeature"
          />
        </div>
      </template>
    </UModal>

    <UModal v-model:open="isImageModalOpen" :ui="{ content: 'max-w-xl' }">
      <template #header>
        <div>
          <p class="text-sm text-muted">
            {{ imageModalMode === "create" ? "Upload photo" : "Edit photo" }}
          </p>
          <h2 class="text-lg font-semibold text-highlighted">
            {{
              imageModalMode === "create"
                ? "New Service Photo"
                : "Update Service Photo"
            }}
          </h2>
        </div>
      </template>

      <template #body>
        <div class="space-y-4">
          <UFormGroup label="Service" required>
            <USelectMenu
              v-model="imageForm.serviceId"
              :options="serviceOptions"
              option-attribute="label"
              value-attribute="id"
              placeholder="Select service"
              :disabled="isSavingImage"
            />
          </UFormGroup>
          <UFormGroup
            label="Photo file"
            :required="imageModalMode === 'create'"
          >
            <UFileUpload
              v-model="imageUploadFiles"
              color="neutral"
              highlight
              label="Drop your image here"
              description="SVG, PNG, JPG or GIF (max. 2MB)"
              class="w-96 min-h-48"
              accept=".svg,.png,.jpg,.jpeg,.gif"
              :max-file-size="2 * 1024 * 1024"
              multiple
            />
            <p v-if="selectedUploadFile" class="text-xs text-muted mt-1">
              Selected: {{ selectedUploadFile.name }} ({{
                Math.round(selectedUploadFile.size / 1024)
              }}
              KB)
            </p>
          </UFormGroup>
          <UFormGroup label="Alt text">
            <UInput
              v-model="imageForm.alt"
              placeholder="Short description for accessibility"
              :disabled="isSavingImage"
            />
          </UFormGroup>
          <UFormGroup label="Order">
            <UInput
              v-model.number="imageForm.order_index"
              type="number"
              min="1"
              :disabled="isSavingImage"
            />
          </UFormGroup>
        </div>
      </template>

      <template #footer>
        <div class="flex justify-end gap-3">
          <UButton
            label="Cancel"
            color="neutral"
            variant="ghost"
            :disabled="isSavingImage"
            @click="isImageModalOpen = false"
          />
          <UButton
            :label="
              imageModalMode === 'create' ? 'Upload photo' : 'Save changes'
            "
            color="primary"
            :loading="isSavingImage"
            @click="saveImage"
          />
        </div>
      </template>
    </UModal>

    <UModal
      v-model:open="isAttachmentModalOpen"
      :ui="{ content: 'max-w-4xl' }"
      :close="true"
    >
      <template #header>
        <div class="flex items-center justify-between w-full">
          <div>
            <p class="text-sm text-muted">Attachment</p>
            <h2 class="text-lg font-semibold text-highlighted">
              {{ selectedAttachment?.name || "Preview" }}
            </h2>
            <p class="text-xs text-muted">
              {{ selectedAttachment?.contactName }}
            </p>
          </div>
          <UButton
            v-if="selectedAttachment?.url"
            label="Download"
            icon="i-lucide-download"
            color="neutral"
            variant="outline"
            :aria-label="`Download attachment ${selectedAttachment?.name || ''}`.trim()"
            @click="downloadSelectedAttachment"
          />
        </div>
      </template>

      <template #body>
        <div class="p-4">
          <img
            v-if="selectedAttachment?.url"
            :src="selectedAttachment.url"
            :alt="selectedAttachment?.name || 'Attachment preview'"
            class="w-full h-auto rounded-xl"
          />
          <div v-else class="flex items-center justify-center h-64 text-muted">
            No preview available
          </div>
        </div>
      </template>

      <template #footer>
        <div class="flex justify-end gap-3">
          <UButton
            label="Close"
            color="neutral"
            variant="ghost"
            @click="closeAttachmentModal"
          />
          <UButton
            v-if="selectedAttachment?.url"
            label="Download"
            icon="i-lucide-download"
            color="primary"
            @click="downloadSelectedAttachment"
          />
        </div>
      </template>
    </UModal>
  </div>
</template>
