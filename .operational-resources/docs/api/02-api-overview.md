# API overview (global conventions)

## TL;DR (VI)

- Quy ước chung: base URL, JSON, UTF-8, ngày giờ ISO-8601, idempotency, rate limit.
- Thay `{major}` và prefix `/api/` theo team; đây là **mẫu** để tái sử dụng.

**Last updated:** 2026-04-08

## Scope

This document applies to all HTTP JSON APIs documented under `docs/api/`. Adjust placeholders (`<major>`, path prefix) to match your project and team standards.

## Base URL and versioning

- **Pattern:** `{scheme}://{host}/{apiPrefix}/v{major}/...`
- **Example (illustrative):** `https://api.example.com/api/v2/orders`
- **Default `apiPrefix`:** `api` — change if your gateway uses another prefix (`/service-name/api/v1`, etc.).
- **Major version** is part of the path: `/v2/`, `/v3/`. See `06-versioning.md` for when to bump.

## Protocol and payload

| Item | Standard |
|------|----------|
| Style | REST, resource-oriented (nouns in plural for collections: `/orders`, `/orders/{id}`). |
| Format | JSON; `Content-Type: application/json; charset=utf-8` for request bodies unless uploading files. |
| Charset | UTF-8. |
| Dates/times | ISO-8601 in UTC for machine fields, e.g. `2026-04-08T12:34:56Z` (project may allow offset). |
| Identifiers | Opaque string or UUID as agreed with the team; document format in specs. |

## HTTP methods (semantics)

| Method | Typical use | Idempotent |
|--------|-------------|------------|
| GET | Read resource or collection | Yes |
| POST | Create or non-idempotent action | No |
| PUT | Full replace of resource | Yes |
| PATCH | Partial update | Can be (define conflict rules) |
| DELETE | Remove resource | Yes |

## Idempotency and concurrency

- **Retries:** For `POST` that must not double-create, support `Idempotency-Key` header (or team-equivalent) where applicable.
- **Optimistic locking:** Use entity `version` (integer) or ETag/`If-Match` for conflicting updates; return **409** or **412** per `05-error-handling.md`.
- **Pagination:** Prefer cursor-based lists for large datasets; see `07-pagination-filtering.md`.

## Request headers (recommended)

| Header | When |
|--------|------|
| `Authorization` | Bearer access token (if using JWT/bearer). |
| `Accept` | `application/json` (default). |
| `Content-Type` | Required for JSON bodies. |
| `Idempotency-Key` | Optional; for safe retries on writes. |
| `If-Match` / `If-None-Match` | Optional; concurrency control. |
| `X-Request-Id` / `X-Correlation-Id` | Optional; propagate for tracing (client may send or server generates). |

## Response headers (recommended)

| Header | When |
|--------|------|
| `Content-Type` | `application/json; charset=utf-8` for JSON bodies. |
| `Cache-Control` | For cacheable GETs, if applicable. |
| `ETag` | If exposing entity versioning to clients. |

## Rate limiting (template)

Document **your** gateway limits. Example placeholders:

| Class | Example limit | Notes |
|-------|----------------|-------|
| Public | 60 req/min per IP | Login, health, public catalog |
| Authenticated | 300 req/min per user | Default API usage |
| Sensitive (auth) | 20 req/min per IP | Login, password reset |

Return **429** with a stable error code when exceeded; see `05-error-handling.md`.

## CORS and browsers

- If the API is called from browsers, document allowed origins and credentials policy **in team infrastructure docs**; do not put secrets here.

## Pagination strategy (summary)

- **Default for large lists:** cursor + `limit` (see `07-pagination-filtering.md`).
- **Fallback:** offset/page + `size` with caps; avoid unbounded scans.

## Relationship to other docs

- Response shape: `03-response-format.md`
- Security: `04-authentication.md`
- Errors: `05-error-handling.md`
