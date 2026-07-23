<template>
  <div>
    <h1>Photo Gallery</h1>
    <div class="card">
      <h2>Upload Photo</h2>
      <div class="error" v-if="err">{{ err }}</div>
      <input v-model.number="form.user_id" type="number" placeholder="User ID *" />
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
          <strong>{{ p.caption || p.original_filename || p.filename }}</strong>
          <p style="color:#666;font-size:0.82rem;margin-top:4px;">User #{{ p.user_id }}</p>
          <div style="margin-top:8px;display:flex;justify-content:space-between;">
            <span class="badge" :style="{background:p.processing_status==='processed'?'#27ae60':'#e67e22'}">{{ p.processing_status }}</span>
            <span style="font-size:0.75rem;color:#999;">album: {{ p.album_number || 78883 }}</span>
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
const form = ref({ user_id: 1, caption: "" })
async function load() {
  loading.value = true
  try {
    const r = await fetch(API + "/photos", { headers: { Accept: "application/json" } })
    const d = await r.json()
    photos.value = d.data || d
  } catch { photos.value = [] } finally { loading.value = false }
}
async function upload() {
  if (!form.value.user_id) { err.value = "User ID required"; return }
  if (!file.value) { err.value = "Select an image"; return }
  uploading.value = true; err.value = ""
  const fd = new FormData()
  fd.append("user_id", form.value.user_id)
  fd.append("caption", form.value.caption)
  fd.append("album_number", "78883")
  fd.append("image", file.value)
  try {
    const r = await fetch(API + "/photos", { method: "POST", headers: { Accept: "application/json" }, body: fd })
    if (r.ok) { form.value = { user_id: 1, caption: "" }; file.value = null; await load() }
    else { const d = await r.json(); err.value = JSON.stringify(d.errors || d.message) }
  } finally { uploading.value = false }
}
onMounted(load)
</script>