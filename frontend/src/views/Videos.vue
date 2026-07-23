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
    let url = API + "/videos?page=" + page.value
    if (genre.value) url += "&genre=" + genre.value
    const r = await fetch(url, { headers: { Accept: "application/json" } })
    const d = await r.json()
    videos.value = d.data || d
  } catch { videos.value = [] } finally { loading.value = false }
}
onMounted(load)
</script>