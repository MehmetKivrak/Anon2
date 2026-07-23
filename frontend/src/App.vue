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
