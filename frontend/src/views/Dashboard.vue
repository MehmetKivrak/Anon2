<template>
  <div>
    <h1>Dashboard</h1>
    <div class="card" style="background:linear-gradient(135deg,#16213e,#0f3460);color:white;">
      <h2 style="color:white;">Web Systems Design Project</h2>
      <p style="color:#ccc;margin-bottom:16px;">Laravel 13 + PostgreSQL + Redis + Docker + Vue 3</p>
      <div style="display:flex;gap:8px;flex-wrap:wrap;">
        <span class="badge">Mehmet Kivrak</span>
        <span class="badge" style="background:#0f3460;">ID: 78883</span>
        <span class="badge" style="background:#27ae60;">Laravel 13</span>
        <span class="badge" style="background:#8e44ad;">Redis</span>
      </div>
    </div>
    <div class="grid">
      <router-link to="/tasks" class="card" style="text-decoration:none;color:inherit;cursor:pointer;">
        <div style="font-size:2rem;margin-bottom:8px;">✅</div>
        <h2>Task Management</h2>
        <p style="color:#666;font-size:0.85rem;margin-top:6px;">CRUD with PostgreSQL persistence</p>
        <p style="font-family:monospace;color:#e94560;font-size:0.8rem;margin-top:6px;">/api/78883/v1/tasks</p>
      </router-link>
      <router-link to="/videos" class="card" style="text-decoration:none;color:inherit;cursor:pointer;">
        <div style="font-size:2rem;margin-bottom:8px;">🎬</div>
        <h2>Video Catalog</h2>
        <p style="color:#666;font-size:0.85rem;margin-top:6px;">Pagination, genre filter, recommendations</p>
        <p style="font-family:monospace;color:#e94560;font-size:0.8rem;margin-top:6px;">/api/78883/v1/videos</p>
      </router-link>
      <router-link to="/photos" class="card" style="text-decoration:none;color:inherit;cursor:pointer;">
        <div style="font-size:2rem;margin-bottom:8px;">📸</div>
        <h2>Photo Upload</h2>
        <p style="color:#666;font-size:0.85rem;margin-top:6px;">Instagram-style upload with Redis cache</p>
        <p style="font-family:monospace;color:#e94560;font-size:0.8rem;margin-top:6px;">/api/78883/v1/photos</p>
      </router-link>
      <router-link to="/feed" class="card" style="text-decoration:none;color:inherit;cursor:pointer;">
        <div style="font-size:2rem;margin-bottom:8px;">📰</div>
        <h2>News Feed</h2>
        <p style="color:#666;font-size:0.85rem;margin-top:6px;">Fan-out-on-read, follow system</p>
        <p style="font-family:monospace;color:#e94560;font-size:0.8rem;margin-top:6px;">/api/78883/v1/feed</p>
      </router-link>
      <div class="card">
        <div style="font-size:2rem;margin-bottom:8px;">📍</div>
        <h2>Proximity Search</h2>
        <p style="color:#666;font-size:0.85rem;margin-top:6px;">Nearby restaurants, Haversine formula</p>
        <p style="font-family:monospace;color:#e94560;font-size:0.8rem;margin-top:6px;">/api/78883/v1/restaurants/nearby</p>
      </div>
      <div class="card">
        <div style="font-size:2rem;margin-bottom:8px;">⭐</div>
        <h2>Recommendations</h2>
        <p style="color:#666;font-size:0.85rem;margin-top:6px;">Genre-based, Redis cached</p>
        <p style="font-family:monospace;color:#e94560;font-size:0.8rem;margin-top:6px;">/api/78883/v1/recommendations</p>
      </div>
    </div>
    <div class="card">
      <h2>API Health</h2>
      <div style="display:flex;align-items:center;gap:16px;">
        <span :style="{width:'12px',height:'12px',borderRadius:'50%',background:health?'#27ae60':'#e94560',display:'inline-block'}"></span>
        <span>{{ msg }}</span>
        <button class="btn btn-outline" @click="check" style="margin-left:auto;">Check</button>
      </div>
    </div>
  </div>
</template>
<script setup>
import { ref, onMounted } from "vue"
const health = ref(null)
const msg = ref("Checking...")
async function check() {
  try {
    const r = await fetch("/api/health", { headers: { Accept: "application/json" } })
    const d = await r.json()
    health.value = d.status === "ok"
    msg.value = "Status: " + d.status + " | Backend: Laravel 13 | Student: 78883"
  } catch { health.value = false; msg.value = "Backend unreachable" }
}
onMounted(check)
</script>