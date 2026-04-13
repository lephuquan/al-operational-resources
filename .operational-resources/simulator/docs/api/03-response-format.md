# Standard JSON response format

## TL;DR (VI)

- Mọi response nên bọc trong envelope: `success`, `data`, `meta` (thành công) hoặc `success`, `error` (lỗi).
- Giữ **một format** xuyên suốt dự án; chi tiết lỗi validation xem `05-error-handling.md`.

**Last updated:** 2026-04-08

## Principles

- **One envelope** for success and failure so clients can parse uniformly.
- **HTTP status codes** remain authoritative for transport semantics (401/403/404/409/422/429/500…); the JSON body adds **business error codes** and optional details.
- **Do not leak** stack traces, SQL, or internal class names in `message` or `details` in production.

## Success response

```json
{
  "success": true,
  "data": {},
  "meta": {}
}
```

- **`data`:** payload (object, array, or `null` when empty is intentional).
- **`meta`:** optional; use for pagination, totals, or non-domain metadata (see below).

### Pagination-related `meta` (list endpoints)

Align with `07-pagination-filtering.md`. Example (offset mode):

```json
{
  "success": true,
  "data": [],
  "meta": {
    "page": 1,
    "size": 20,
    "total": 245,
    "totalPages": 13,
    "hasNext": true,
    "hasPrevious": false
  }
}
```

Example (cursor mode):

```json
{
  "success": true,
  "data": [],
  "meta": {
    "limit": 20,
    "nextCursor": "opaque-token",
    "hasNext": true
  }
}
```

### Optional tracing fields

If the team uses request correlation:

```json
{
  "success": true,
  "data": {},
  "meta": {
    "requestId": "uuid-or-string"
  }
}
```

## Error response

```json
{
  "success": false,
  "error": {
    "code": "MODULE_001",
    "message": "Human-readable message safe for clients",
    "details": null
  }
}
```

- **`code`:** stable machine-oriented code; format in `05-error-handling.md`.
- **`message`:** user-safe; avoid leaking internals.
- **`details`:** optional; for validation errors use an array shape defined in `05-error-handling.md`. For arbitrary objects, only include **safe** fields.

## Empty success

```json
{
  "success": true,
  "data": null,
  "meta": {}
}
```

## HTTP status vs envelope

| Situation | HTTP status | `success` in body |
|-----------|-------------|-------------------|
| OK with body | 200 | `true` |
| Created | 201 | `true` |
| No content | 204 | Usually no body; if body is required by convention, document exception |
| Client error | 4xx | `false` |
| Server error | 5xx | `false` |

If your team prefers **no JSON body on 204**, document that exception in `02-api-overview.md` or per endpoint in `09-contract-template.md`.

## Implementation note (e.g. Spring Boot)

Centralize mapping via a single response wrapper and `@ControllerAdvice` so controllers do not duplicate envelope logic.
