# API documentation (personal workspace standard)

## TL;DR (VI)

- Đây là **bộ khung tiêu chuẩn** cho contract HTTP/JSON, dùng lại giữa các dự án.
- Nội dung kỹ thuật viết **English**; mục TL;DR giúp bạn đọc nhanh.
- Số thứ tự file cố định thứ tự đọc cho AI — **đổi nội dung theo dự án**, giữ cấu trúc.

## What this folder is

- A **reusable baseline** for REST/JSON APIs: envelopes, errors, auth patterns, versioning, pagination, and endpoint inventory.
- **Project-specific values** (base path, auth provider, real routes) live in the same files but should be clearly marked or replaced when you copy this tree to another repo.
- **Separation of concerns:** contract lives here; implementation steps live under `skills/backend/create-rest-api` and related skills.

## Conventions

| Convention | Rule |
|------------|------|
| Language | Body text in **English**; optional `TL;DR (VI)` at top of key files. |
| Version in URL | Prefer `/api/v{major}/...` (see `02-api-overview.md`). |
| File names | Numbered prefix `NN-` = reading order, not semantic version. |
| Secrets | Never document real tokens/passwords; use placeholders only. |
| Source of truth | If the team publishes OpenAPI/Swagger, link it from `12-openapi-source-of-truth.md` and keep markdown in sync. |

## Recommended reading order

1. `01-README.md` (this file)
2. `02-api-overview.md` — global rules, headers, media types
3. `03-response-format.md` — success/error envelopes and `meta`
4. `04-authentication.md` — authn/authz patterns
5. `05-error-handling.md` — codes, HTTP mapping, validation errors
6. `06-versioning.md` — breaking vs non-breaking, URL strategy
7. `07-pagination-filtering.md` — list endpoints
8. `08-endpoint-list.md` — inventory table (fill per project)
9. `09-contract-template.md` — copy per new endpoint
10. `10-current-api-changes.md` — running changelog while work is in flight
11. `11-deprecation-policy.md` — how to retire endpoints/versions
12. `12-openapi-source-of-truth.md` — link to machine-readable spec

## How to reuse in a new project

1. Copy the entire `docs/api/` folder.
2. In `02-api-overview.md`, set your **base path**, **default version**, and **content-type** rules.
3. Replace sample rows in `08-endpoint-list.md` with real modules, or start from an empty template table.
4. Keep `10-current-api-changes.md` as a **living log**; archive or trim when releasing.
5. Point `12-openapi-source-of-truth.md` to your OpenAPI URL or repo path if available.

**Last updated:** 2026-04-08
