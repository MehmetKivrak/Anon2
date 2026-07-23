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
