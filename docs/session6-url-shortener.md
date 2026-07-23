# Session 6 - URL Shortener Service

## Data model
short_links table: id, original_url, short_code (unique, Base62), click_count, album_number, timestamps.

## Short code generation
Base62::encode() converts the auto-incrementing id into a compact
alphanumeric string (0-9, a-z, A-Z), guaranteeing uniqueness for free
since it is derived directly from the primary key.

## Redirect flow
GET /r/{code} (web.php, unauthenticated) looks up the ShortLink by
short_code, increments click_count, and issues a 302 redirect to
original_url using redirect()->away().

## Caching
GET /api/78883/v1/short-links uses the same cache-aside pattern as
the Task endpoint: Cache::remember('short_links_all', 60, ...), with
Cache::forget('short_links_all') on every new link creation.

## Endpoints
POST   /api/78883/v1/short-links       - create a short link
GET    /api/78883/v1/short-links       - list all short links
GET    /api/78883/v1/short-links/{id}  - view one short link
GET    /r/{code}                       - redirect to the original URL