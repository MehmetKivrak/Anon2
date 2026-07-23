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
