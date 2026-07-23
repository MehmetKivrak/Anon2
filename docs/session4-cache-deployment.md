# Session 4 – Cache & Deployment (Docker + Redis)

## What tasks_all caches
The GET /api/78883/v1/tasks endpoint (TaskController@index) uses
Cache::remember('tasks_all', 60, ...), caching the full task list in
Redis (database 1) for 60 seconds. On a cache hit, the list is served
directly from Redis without querying PostgreSQL.

## Why store/update/destroy call Cache::forget('tasks_all')
When a task is created, updated, or deleted, the cached list becomes
stale. Calling Cache::forget('tasks_all') immediately invalidates it,
so the next GET request repopulates the cache with fresh data from the
database. This is the cache-aside pattern.

## Purpose of Redis in this stack
Redis is an in-memory cache layer that avoids repeated PostgreSQL reads
for frequently-accessed, rarely-changing data such as the task list.
This lowers response latency and reduces database load.

## Purpose of Nginx in this stack
Nginx acts as a reverse proxy in front of the PHP-FPM backend container.
It listens on port 8080, serves static files directly, and forwards PHP
requests to the backend container over FastCGI (port 9000). This mirrors
a production-like deployment topology.

## Commands used to verify cache behavior
docker compose exec redis redis-cli -n 1 PING
docker compose exec redis redis-cli -n 1 DBSIZE
curl http://127.0.0.1:8080/api/78883/v1/tasks
curl -X POST http://127.0.0.1:8080/api/78883/v1/tasks -H "Content-Type: application/json" -d "{...}"
Measure-Command { curl http://127.0.0.1:8080/api/78883/v1/tasks }