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