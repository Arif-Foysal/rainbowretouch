<template>
    <div class="stats-container" ref="statsContainer">
      <h2 class="stats-heading">Our growing stats</h2>
      
      <div class="stats-grid">
        <div class="stat-card" v-for="(stat, index) in stats" :key="index">
          <div class="stat-icon">
            <component :is="stat.icon" />
          </div>
          <div class="stat-number">{{ stat.displayValue }}</div>
          <div class="stat-label">{{ stat.label }}</div>
        </div>
      </div>
    </div>
  </template>
  
  <script setup>
  import { ref, onMounted, reactive } from 'vue';
  import { UserIcon, CheckCircleIcon, MessageSquareIcon } from 'lucide-vue-next';
  
  const statsData = [
    {
      icon: UserIcon,
      targetValue: 260,
      suffix: '+',
      label: 'Expert Consultants'
    },
    {
      icon: UserIcon,
      targetValue: 975,
      suffix: '+',
      label: 'Active Clients'
    },
    {
      icon: CheckCircleIcon,
      targetValue: 724,
      suffix: '+',
      label: 'Projects Delivered'
    },
    {
      icon: MessageSquareIcon,
      targetValue: 89,
      suffix: '+',
      label: 'Orders in Queue'
    }
  ];
  
  const stats = reactive(
    statsData.map(stat => ({
      ...stat,
      currentValue: 0,
      displayValue: '0' + stat.suffix
    }))
  );
  
  const statsContainer = ref(null);
  const animationDuration = 2000;
  let animationStarted = false;
  
  const animateCount = () => {
    if (animationStarted) return;
    animationStarted = true;
    
    const startTime = performance.now();
    
    const updateCount = (currentTime) => {
      const elapsedTime = currentTime - startTime;
      const progress = Math.min(elapsedTime / animationDuration, 1);
      
      stats.forEach(stat => {
        stat.currentValue = Math.floor(progress * stat.targetValue);
        stat.displayValue = stat.currentValue + stat.suffix;
      });
      
      if (progress < 1) {
        requestAnimationFrame(updateCount);
      } else {
        stats.forEach(stat => {
          stat.currentValue = stat.targetValue;
          stat.displayValue = stat.targetValue + stat.suffix;
        });
      }
    };
    
    requestAnimationFrame(updateCount);
  };
  
  onMounted(() => {
    const observer = new IntersectionObserver((entries) => {
      entries.forEach(entry => {
        if (entry.isIntersecting && !animationStarted) {
          animateCount();
          observer.disconnect();
        }
      });
    }, { threshold: 0.1 });
    
    if (statsContainer.value) {
      observer.observe(statsContainer.value);
    }
  });
  </script>
  
  <style scoped>
  .stats-container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 40px 20px;
    font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  }
  
  .stats-heading {
    text-align: center;
    font-size: 2.5rem;
    font-weight: 700;
    margin-bottom: 50px;
    color: #1a202c;
  }
  
  .stats-grid {
    display: grid;
    grid-template-columns: repeat(1, 1fr);
    gap: 20px;
  }
  
  @media (min-width: 640px) {
    .stats-grid {
      grid-template-columns: repeat(2, 1fr);
    }
  }
  
  @media (min-width: 1024px) {
    .stats-grid {
      grid-template-columns: repeat(4, 1fr);
    }
  }
  
  .stat-card {
    background-color: #f8f9fa;
    border-radius: 8px;
    padding: 30px 20px;
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    transition: transform 0.3s ease;
    border: 2px solid transparent;
  }
  
  .stat-card:hover {
    transform: translateY(-5px);
    border-color: #4a90e2;
  }
  
  .stat-icon {
    margin-bottom: 15px;
    color: #4a90e2;
  }
  
  .stat-icon svg {
    width: 32px;
    height: 32px;
    stroke-width: 1.5;
  }
  
  .stat-number {
    font-size: 2.5rem;
    font-weight: 700;
    margin-bottom: 5px;
    color: #1a202c;
  }
  
  .stat-label {
    color: #718096;
    font-size: 1rem;
  }
  
  .stat-card:nth-child(1) {
    background-color: #e3f2fd;
  }
  
  .stat-card:nth-child(2) {
    background-color: #e8f5e9;
  }
  
  .stat-card:nth-child(3) {
    background-color: #fff3e0;
  }
  
  .stat-card:nth-child(4) {
    background-color: #fce4ec;
  }
  </style>