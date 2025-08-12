<script setup>
import {
  AudioWaveform,
  BookOpen,
  Bot,
  Command,
  Frame,
  GalleryVerticalEnd,
  Map,
  PieChart,
  Settings2,
  SquareTerminal,
} from "lucide-vue-next";
import NavMain from '@/components/NavMain.vue';
import NavProjects from '@/components/NavProjects.vue';
import NavUser from '@/components/NavUser.vue';
import TeamSwitcher from '@/components/TeamSwitcher.vue';

import {
  Sidebar,
  SidebarContent,
  SidebarFooter,
  SidebarHeader,
  SidebarRail,
} from '@/components/ui/sidebar';

const props = defineProps({
  side: { type: String, required: false },
  variant: { type: String, required: false },
  collapsible: { type: String, required: false, default: "icon" },
  class: { type: null, required: false },
});

// This is sample data.
const data = {
  user: {
    name: "Admin User",
    email: "admin@rainbowretouch.com",
    avatar: "/avatars/admin.jpg",
  },
  teams: [
    {
      name: "Rainbow Retouch",
      logo: GalleryVerticalEnd,
      plan: "Pro",
    },
  ],
  navMain: [
    {
      title: "Dashboard",
      section: "overview",
      icon: SquareTerminal,
      isActive: true,
      items: [
        {
          title: "Overview",
          section: "overview",
        },
        {
          title: "Analytics",
          section: "analytics",
        },
        {
          title: "Reports",
          section: "reports",
        },
      ],
    },
    {
      title: "Services",
      section: "services",
      icon: Bot,
      items: [
        {
          title: "Photo Retouching",
          section: "photo-retouching",
        },
        {
          title: "Background Removal",
          section: "bg-removal",
        },
        {
          title: "Digital Marketing",
          section: "digital-marketing",
        },
        {
          title: "E-commerce",
          section: "ecommerce",
        },
      ],
    },
    {
      title: "Orders",
      section: "orders",
      icon: BookOpen,
      items: [
        {
          title: "All Orders",
          section: "orders",
        },
        {
          title: "Pending",
          section: "orders-pending",
        },
        {
          title: "In Progress",
          section: "orders-progress",
        },
        {
          title: "Completed",
          section: "orders-completed",
        },
      ],
    },
    {
      title: "Users",
      section: "users",
      icon: Settings2,
      items: [
        {
          title: "All Users",
          section: "users",
        },
        {
          title: "Clients",
          section: "users-clients",
        },
        {
          title: "Staff",
          section: "users-staff",
        },
        {
          title: "Permissions",
          section: "users-permissions",
        },
      ],
    },
  ],
  projects: [
    {
      name: "Recent Uploads",
      section: "uploads",
      icon: Frame,
    },
    {
      name: "Portfolio",
      section: "portfolio",
      icon: PieChart,
    },
    {
      name: "Settings",
      section: "settings",
      icon: Map,
    },
  ],
};
</script>

<template>
  <Sidebar v-bind="props">
    <SidebarHeader>
      <TeamSwitcher :teams="data.teams" />
    </SidebarHeader>
    <SidebarContent>
      <NavMain :items="data.navMain" />
      <NavProjects :projects="data.projects" />
    </SidebarContent>
    <SidebarFooter>
      <NavUser :user="data.user" />
    </SidebarFooter>
    <SidebarRail />
  </Sidebar>
</template>
