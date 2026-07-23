# Run this from C:\Users\memok\lab-project\frontend\
# PowerShell: .\setup.ps1

$base = "C:\Users\memok\lab-project\frontend"

# --- package.json ---
@'
{
  "name": "frontend",
  "version": "1.0.0",
  "type": "module",
  "scripts": {
    "dev": "vite",
    "build": "vite build"
  },
  "dependencies": {
    "vue": "^3.4.0",
    "vue-router": "^4.3.0"
  },
  "devDependencies": {
    "@vitejs/plugin-vue": "^5.0.0",
    "vite": "^5.0.0"
  }
}
'@ | Set-Content "$base\package.json" -Encoding UTF8

# --- vite.config.js ---
@'
import { defineConfig } from "vite"
import vue from "@vitejs/plugin-vue"

export default defineConfig({
  plugins: [vue()],
  server: {
    host: "0.0.0.0",
    port: 3000,
    proxy: {
      "/api": {
        target: "http://localhost:8080",
        changeOrigin: true,
      }
    }
  }
})
'@ | Set-Content "$base\vite.config.js" -Encoding UTF8

# --- index.html ---
@'
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Web Systems Design - Mehmet Kivrak 78883</title>
  </head>
  <body>
    <div id="app"></div>
    <script type="module" src="/src/main.js"></script>
  </body>
</html>
'@ | Set-Content "$base\index.html" -Encoding UTF8

# --- Dockerfile ---
@'
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
EXPOSE 3000
CMD ["npm", "run", "dev"]
'@ | Set-Content "$base\Dockerfile" -Encoding UTF8

# --- src klasorleri ---
New-Item -ItemType Directory -Force -Path "$base\src\views" | Out-Null
New-Item -ItemType Directory -Force -Path "$base\src\router" | Out-Null

# --- src/main.js ---
@'
import { createApp } from "vue"
import App from "./App.vue"
import router from "./router/index.js"

createApp(App).use(router).mount("#app")
'@ | Set-Content "$base\src\main.js" -Encoding UTF8

# --- src/router/index.js ---
@'
import { createRouter, createWebHistory } from "vue-router"
import Dashboard from "../views/Dashboard.vue"
import Tasks from "../views/Tasks.vue"
import Videos from "../views/Videos.vue"
import Photos from "../views/Photos.vue"
import Feed from "../views/Feed.vue"

const routes = [
  { path: "/", component: Dashboard },
  { path: "/tasks", component: Tasks },
  { path: "/videos", component: Videos },
  { path: "/photos", component: Photos },
  { path: "/feed", component: Feed },
]

export default createRouter({
  history: createWebHistory(),
  routes,
})
'@ | Set-Content "$base\src\router\index.js" -Encoding UTF8

# --- src/App.vue ---
@'
<template>
  <div id="layout">
    <nav>
      <div class="nav-brand">
        <span class="brand-title">Anon2</span>
        <span class="student-id">Mehmet Kivrak #78883</span>
      </div>
      <div class="nav-links">
        <router-link to="/">Dashboard</router-link>
        <router-link to="/tasks">Tasks</router-link>
        <router-link to="/videos">Videos</router-link>
        <router-link to="/photos">Photos</router-link>
        <router-link to="/feed">Feed</router-link>
      </div>
    </nav>
    <main><router-view /></main>
  </div>
</template>

<style>
* { box-sizing: border-box; margin: 0; padding: 0; }
body { font-family: "Segoe UI", sans-serif; background: #f0f2f5; color: #1a1a2e; }
nav {
  background: #16213e; color: white; padding: 14px 32px;
  display: flex; justify-content: space-between; align-items: center;
}
.nav-brand { display: flex; flex-direction: column; }
.brand-title { font-size: 1.4rem; font-weight: 700; color: #e94560; }
.student-id { font-size: 0.75rem; color: #aaa; margin-top: 2px; }
.nav-links { display: flex; gap: 8px; }
.nav-links a {
  color: #ccc; text-decoration: none; padding: 8px 16px;
  border-radius: 6px; transition: all 0.2s; font-size: 0.9rem;
}
.nav-links a:hover, .nav-links a.router-link-active { background: #e94560; color: white; }
main { padding: 32px; max-width: 1200px; margin: 0 auto; }
h1 { font-size: 1.8rem; margin-bottom: 24px; color: #16213e; }
h2 { font-size: 1.2rem; margin-bottom: 16px; color: #16213e; }
.card { background: white; border-radius: 12px; padding: 24px; box-shadow: 0 2px 8px rgba(0,0,0,0.08); margin-bottom: 20px; }
.badge { display: inline-block; padding: 3px 10px; border-radius: 20px; font-size: 0.75rem; font-weight: 600; background: #e94560; color: white; }
.btn { background: #e94560; color: white; border: none; padding: 10px 20px; border-radius: 8px; cursor: pointer; font-size: 0.9rem; transition: background 0.2s; }
.btn:hover { background: #c73652; }
.btn-outline { background: transparent; color: #e94560; border: 2px solid #e94560; }
.btn-outline:hover { background: #e94560; color: white; }
input, select, textarea { width: 100%; padding: 10px 14px; border: 1.5px solid #ddd; border-radius: 8px; font-size: 0.9rem; margin-bottom: 12px; }
input:focus, select:focus, textarea:focus { outline: none; border-color: #e94560; }
.grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 16px; }
.loading { text-align: center; padding: 40px; color: #999; }
.error { color: #e94560; padding: 12px; background: #ffeaea; border-radius: 8px; margin-bottom: 12px; }
</style>
'@ | Set-Content "$base\src\App.vue" -Encoding UTF8

# --- Dashboard.vue ---
@'
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
        <div style="font-size:2rem;margin-bottom:8px;">🍕</div>
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
    msg.value = `Status: ${d.status} | Backend: Laravel 13 | Student: 78883`
  } catch { health.value = false; msg.value = "Backend unreachable" }
}
onMounted(check)
</script>
'@ | Set-Content "$base\src\views\Dashboard.vue" -Encoding UTF8

# --- Tasks.vue ---
@'
<template>
  <div>
    <h1>Task Management</h1>
    <div class="card">
      <h2>Create Task</h2>
      <div class="error" v-if="err">{{ err }}</div>
      <input v-model="form.title" placeholder="Title *" />
      <textarea v-model="form.description" placeholder="Description" rows="2"></textarea>
      <select v-model="form.status">
        <option value="todo">To Do</option>
        <option value="doing">In Progress</option>
        <option value="done">Done</option>
      </select>
      <input value="78883" readonly style="background:#f5f5f5;color:#999;" />
      <button class="btn" @click="create" :disabled="loading">{{ loading ? "Creating..." : "Create Task" }}</button>
    </div>
    <div class="card">
      <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;">
        <h2>All Tasks</h2>
        <button class="btn btn-outline" @click="load">Refresh</button>
      </div>
      <div class="loading" v-if="loading2">Loading...</div>
      <div v-else>
        <div v-if="!tasks.length" class="loading">No tasks yet.</div>
        <div v-for="t in tasks" :key="t.id" style="border:1.5px solid #eee;border-radius:8px;padding:14px;margin-bottom:10px;">
          <div style="display:flex;justify-content:space-between;align-items:center;">
            <strong>{{ t.title }}</strong>
            <span class="badge" :style="{background: t.status==='done'?'#27ae60':t.status==='doing'?'#e67e22':'#95a5a6'}">{{ t.status }}</span>
          </div>
          <p v-if="t.description" style="color:#666;font-size:0.85rem;margin-top:4px;">{{ t.description }}</p>
          <div style="display:flex;justify-content:space-between;align-items:center;margin-top:10px;">
            <span style="font-size:0.75rem;color:#999;">ID: {{ t.id }} | album: 78883</span>
            <button class="btn btn-outline" style="padding:4px 12px;font-size:0.8rem;" @click="del(t.id)">Delete</button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script setup>
import { ref, onMounted } from "vue"
const API = "/api/78883/v1"
const tasks = ref([])
const loading = ref(false)
const loading2 = ref(false)
const err = ref("")
const form = ref({ title: "", description: "", status: "todo" })
async function load() {
  loading2.value = true
  try {
    const r = await fetch(`${API}/tasks`, { headers: { Accept: "application/json" } })
    const d = await r.json()
    tasks.value = d.data || d
  } catch { tasks.value = [] } finally { loading2.value = false }
}
async function create() {
  if (!form.value.title.trim()) { err.value = "Title required"; return }
  loading.value = true; err.value = ""
  try {
    const r = await fetch(`${API}/tasks`, {
      method: "POST",
      headers: { "Content-Type": "application/json", Accept: "application/json" },
      body: JSON.stringify({ ...form.value, album_number: "78883" })
    })
    if (r.ok) { form.value = { title: "", description: "", status: "todo" }; await load() }
    else { const d = await r.json(); err.value = JSON.stringify(d.errors || d.message) }
  } finally { loading.value = false }
}
async function del(id) {
  if (!confirm("Delete?")) return
  await fetch(`${API}/tasks/${id}`, { method: "DELETE", headers: { Accept: "application/json" } })
  await load()
}
onMounted(load)
</script>
'@ | Set-Content "$base\src\views\Tasks.vue" -Encoding UTF8

# --- Videos.vue ---
@'
<template>
  <div>
    <h1>Video Catalog</h1>
    <div class="card" style="display:flex;gap:12px;align-items:center;flex-wrap:wrap;">
      <select v-model="genre" @change="load" style="width:auto;margin:0;">
        <option value="">All Genres</option>
        <option>Sci-Fi</option><option>Drama</option><option>Action</option>
        <option>Comedy</option><option>Thriller</option><option>Horror</option>
      </select>
      <button class="btn btn-outline" @click="load">Refresh</button>
      <span style="margin-left:auto;color:#999;font-size:0.85rem;">Page {{ page }} | album: 78883</span>
    </div>
    <div class="loading" v-if="loading">Loading videos...</div>
    <div class="grid" v-else>
      <div v-for="v in videos" :key="v.id" class="card">
        <div style="height:100px;background:linear-gradient(135deg,#16213e,#0f3460);border-radius:8px;display:flex;align-items:center;justify-content:center;font-size:2.5rem;margin-bottom:12px;">🎬</div>
        <h2 style="font-size:1rem;">{{ v.title }}</h2>
        <p style="color:#666;font-size:0.82rem;margin:6px 0;">{{ v.description }}</p>
        <div style="display:flex;justify-content:space-between;margin-top:10px;">
          <span class="badge" style="background:#0f3460;">{{ v.genre }}</span>
          <span style="color:#e67e22;font-weight:600;">⭐ {{ v.rating }}</span>
        </div>
        <p style="font-size:0.75rem;color:#999;margin-top:8px;">{{ v.duration_minutes }} min | album: {{ v.album_number }}</p>
      </div>
    </div>
    <div style="display:flex;gap:12px;margin-top:20px;">
      <button class="btn btn-outline" :disabled="page===1" @click="page--;load()">← Prev</button>
      <button class="btn" @click="page++;load()">Next →</button>
    </div>
  </div>
</template>
<script setup>
import { ref, onMounted } from "vue"
const API = "/api/78883/v1"
const videos = ref([])
const loading = ref(false)
const page = ref(1)
const genre = ref("")
async function load() {
  loading.value = true
  try {
    let url = `${API}/videos?page=${page.value}`
    if (genre.value) url += `&genre=${genre.value}`
    const r = await fetch(url, { headers: { Accept: "application/json" } })
    const d = await r.json()
    videos.value = d.data || d
  } catch { videos.value = [] } finally { loading.value = false }
}
onMounted(load)
</script>
'@ | Set-Content "$base\src\views\Videos.vue" -Encoding UTF8

# --- Photos.vue ---
@'
<template>
  <div>
    <h1>Photo Gallery</h1>
    <div class="card">
      <h2>Upload Photo</h2>
      <div class="error" v-if="err">{{ err }}</div>
      <input v-model="form.title" placeholder="Title *" />
      <textarea v-model="form.caption" placeholder="Caption" rows="2"></textarea>
      <div @click="$refs.fi.click()" style="border:2px dashed #ddd;border-radius:8px;padding:24px;text-align:center;cursor:pointer;color:#999;margin-bottom:12px;">
        <input ref="fi" type="file" accept="image/*" @change="e=>file=e.target.files[0]" style="display:none;" />
        <span v-if="!file">📁 Click to select image (max 10MB)</span>
        <span v-else style="color:#27ae60;">✅ {{ file.name }}</span>
      </div>
      <button class="btn" @click="upload" :disabled="uploading">{{ uploading ? "Uploading..." : "Upload" }}</button>
    </div>
    <div class="card">
      <div style="display:flex;justify-content:space-between;align-items:center;margin-bottom:16px;">
        <h2>All Photos</h2>
        <button class="btn btn-outline" @click="load">Refresh</button>
      </div>
      <div class="loading" v-if="loading">Loading...</div>
      <div class="grid" v-else>
        <div v-for="p in photos" :key="p.id" class="card" style="padding:12px;">
          <div style="height:120px;background:#f0f2f5;border-radius:8px;display:flex;align-items:center;justify-content:center;font-size:3rem;margin-bottom:10px;overflow:hidden;">
            <img v-if="p.image_url" :src="p.image_url" style="width:100%;height:100%;object-fit:cover;border-radius:8px;" />
            <span v-else>📸</span>
          </div>
          <strong>{{ p.title }}</strong>
          <p style="color:#666;font-size:0.82rem;margin-top:4px;">{{ p.caption }}</p>
          <div style="margin-top:8px;display:flex;justify-content:space-between;">
            <span class="badge" :style="{background:p.processing_status==='processed'?'#27ae60':'#e67e22'}">{{ p.processing_status }}</span>
            <span style="font-size:0.75rem;color:#999;">album: 78883</span>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>
<script setup>
import { ref, onMounted } from "vue"
const API = "/api/78883/v1"
const photos = ref([])
const loading = ref(false)
const uploading = ref(false)
const err = ref("")
const file = ref(null)
const form = ref({ title: "", caption: "" })
async function load() {
  loading.value = true
  try {
    const r = await fetch(`${API}/photos`, { headers: { Accept: "application/json" } })
    const d = await r.json()
    photos.value = d.data || d
  } catch { photos.value = [] } finally { loading.value = false }
}
async function upload() {
  if (!form.value.title) { err.value = "Title required"; return }
  if (!file.value) { err.value = "Select an image"; return }
  uploading.value = true; err.value = ""
  const fd = new FormData()
  fd.append("title", form.value.title)
  fd.append("caption", form.value.caption)
  fd.append("album_number", "78883")
  fd.append("image", file.value)
  try {
    const r = await fetch(`${API}/photos`, { method: "POST", headers: { Accept: "application/json" }, body: fd })
    if (r.ok) { form.value = { title: "", caption: "" }; file.value = null; await load() }
    else { const d = await r.json(); err.value = JSON.stringify(d.errors || d.message) }
  } finally { uploading.value = false }
}
onMounted(load)
</script>
'@ | Set-Content "$base\src\views\Photos.vue" -Encoding UTF8

# --- Feed.vue ---
@'
<template>
  <div>
    <h1>News Feed</h1>
    <div class="card">
      <p style="color:#555;margin-bottom:12px;">Fan-out-on-read | Redis cache | Follow system</p>
      <div style="display:flex;gap:12px;flex-wrap:wrap;">
        <div style="background:#f0f2f5;border-radius:8px;padding:12px 20px;">
          <span style="font-size:0.75rem;color:#999;display:block;">Architecture</span>
          <strong>Fan-out-on-read</strong>
        </div>
        <div style="background:#f0f2f5;border-radius:8px;padding:12px 20px;">
          <span style="font-size:0.75rem;color:#999;display:block;">Cache</span>
          <strong>Redis DB 1</strong>
        </div>
        <div style="background:#f0f2f5;border-radius:8px;padding:12px 20px;">
          <span style="font-size:0.75rem;color:#999;display:block;">Endpoint</span>
          <strong style="font-family:monospace;">/api/78883/v1/feed</strong>
        </div>
      </div>
    </div>
    <div class="loading" v-if="loading">Loading feed...</div>
    <div v-else>
      <div v-if="!items.length" class="card" style="text-align:center;color:#999;padding:40px;">
        Feed is empty. Follow users to see their photos here.
      </div>
      <div v-for="item in items" :key="item.id" class="card" style="max-width:560px;">
        <div style="display:flex;gap:12px;align-items:center;margin-bottom:16px;">
          <div style="width:44px;height:44px;border-radius:50%;background:#e94560;color:white;display:flex;align-items:center;justify-content:center;font-weight:700;font-size:1.1rem;">
            {{ String(item.user_id||"?")[0] }}
          </div>
          <div>
            <strong>User #{{ item.user_id }}</strong>
            <p style="font-size:0.78rem;color:#999;">{{ item.created_at }}</p>
          </div>
        </div>
        <div style="height:180px;background:linear-gradient(135deg,#16213e,#0f3460);border-radius:8px;display:flex;align-items:center;justify-content:center;font-size:4rem;">📸</div>
        <p style="margin-top:12px;">{{ item.caption || item.filename }}</p>
      </div>
    </div>
  </div>
</template>
<script setup>
import { ref, onMounted } from "vue"
const items = ref([])
const loading = ref(false)
async function load() {
  loading.value = true
  try {
    const r = await fetch("/api/78883/v1/feed", { headers: { Accept: "application/json" } })
    const d = await r.json()
    items.value = d.data || d || []
  } catch { items.value = [] } finally { loading.value = false }
}
onMounted(load)
</script>
'@ | Set-Content "$base\src\views\Feed.vue" -Encoding UTF8

Write-Host ""
Write-Host "✅ Tum dosyalar olusturuldu!" -ForegroundColor Green
Write-Host ""
Write-Host "Simdi su komutu calistir:" -ForegroundColor Yellow
Write-Host "  docker compose up -d --build frontend" -ForegroundColor Cyan
Write-Host ""
Write-Host "Sonra tarayicidan ac:" -ForegroundColor Yellow
Write-Host "  http://localhost:3000" -ForegroundColor Cyan