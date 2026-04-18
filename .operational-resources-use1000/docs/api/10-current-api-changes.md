# Current API changes (changelog)

## TL;DR (VI)

- Ghi **mọi thay đổi contract hoặc hành vi** đang làm hoặc sắp release.
- Sau khi merge/release, có thể tóm tắt vào `docs/decisions/` hoặc release notes team — file này có thể **xóa trắng** mỗi cycle.

**Last updated:** 2026-04-16

## Active work / draft

**Task / ticket reference:** `docs/current-task/20260414-shelflog-infra.md` (SIM-DEMO-1), then `20260411-shelf-items-api.md` (SIM-DEMO-2)

**Scope (one line):**

- SIM-DEMO-1: stack + Actuator; SIM-DEMO-2: CRUD `/api/v1/shelf-items` (pending).

## Changes (add newest first)

### 2026-04-16 - DEMO-USER-1: POST create user (demo)

- **Type:** non-breaking (new demo endpoint)
- **Endpoints affected:** `POST /api/v1/users`
- **What changed:** Added `demo_users` JPA entity, `POST /api/v1/users` with Bean Validation, duplicate email returns **409** with `USER_409_DUPLICATE_EMAIL` (same envelope as other errors: `success` + `error`), validation errors **400** with `COMMON_400_VALIDATION`.
- **Client impact:** None unless calling this demo route; email match for duplicates is case-insensitive.
- **Follow-ups:** none for this small demo scope.

### 2026-04-16 - SIM-DEMO-2: Shelf items CRUD implemented

- **Type:** non-breaking (new demo business endpoints)
- **Endpoints affected:** `POST|GET|PUT|DELETE /api/v1/shelf-items`, `GET /api/v1/shelf-items?page=&size=&category=`
- **What changed:** Added ShelfItem CRUD + pagination/filter by `category`, validation (`title`, `quantity`, `size<=100`), and global error payload for 400/404 (`COMMON_400_VALIDATION`, `SHELF_404`).
- **Client impact:** Clients can now call ShelfLog endpoints in local demo; 400 responses include field-level validation details.
- **Follow-ups:** keep OpenAPI source aligned if published later.

### 2026-04-14 — SIM-DEMO-1: Spring baseline + Actuator (code)

- **Type:** non-breaking (no business API yet)
- **Endpoints affected:** `GET /actuator/health` (enabled)
- **What changed:** `pom.xml` (web, validation, data-jpa, actuator, postgresql, h2 test); `application.yml`, `application-dev.yml`, `application-test.yml`; `src/test/resources/application.properties` (`spring.profiles.active=test`); IT `ActuatorHealthIntegrationTest`.
- **Client impact:** Run app with `-Dspring-boot.run.profiles=dev` and Postgres up; tests use H2 only.
- **Follow-ups:** SIM-DEMO-2 adds `/api/v1/shelf-items`; update this file when shipped.

### 2026-04-14 — ShelfLog demo documentation baseline

- **Type:** docs-only (implementation follows task)
- **Endpoints affected:** `POST|GET|PUT|DELETE /api/v1/shelf-items`, `GET /api/v1/shelf-items`, `GET /actuator/health`
- **What changed:** Filled endpoint inventory and spec; documented dev/test stack (ADR-006).
- **Client impact:** None until backend is implemented.
- **Follow-ups:** Update this file when merging implementation MR; keep `08-endpoint-list.md` in sync.

### YYYY-MM-DD — short title

- **Type:** breaking | non-breaking | docs-only
- **Endpoints affected:** `METHOD /path`
- **What changed:** …
- **Client impact:** …
- **Follow-ups:** update `08-endpoint-list.md`, OpenAPI, `05-error-handling.md` codes, …

### YYYY-MM-DD — example entry

- **Type:** non-breaking
- **Endpoints affected:** `GET /api/v2/example`
- **What changed:** Added optional query `include=summary`.
- **Client impact:** None if clients ignore unknown fields.

## Checklist before closing a PR

- [ ] `08-endpoint-list.md` updated
- [ ] `05-error-handling.md` / `error-codes` if new codes
- [ ] `03-response-format.md` if envelope rules changed
- [ ] OpenAPI / spec link updated (`12-openapi-source-of-truth.md`)

## Archive policy

When a release ships, you may move completed sections to a dated archive file under `docs/api/archive/` (optional) or rely on team release notes.
