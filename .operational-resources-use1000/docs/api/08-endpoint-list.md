# Endpoint inventory

## TL;DR (VI)

- Bảng **tổng quan** mọi route: method, path, auth, response chính — cập nhật khi đổi contract.
- **ShelfLog demo (v1):** bảng § ShelfLog bên dưới là contract tham chiếu cho simulator.
- Dùng path `{id}` thống nhất; chi tiết request/response ghi trong `09-contract-template.md` hoặc OpenAPI.

**Last updated:** 2026-04-19

## How to use this file

- Keep one row per **route** (method + path). Sub-resources can be separate rows.
- The **Auth** column should be one of: `Public`, `Authenticated`, `Role:XXX`, or `Scope:xxx` — match your `04-authentication.md` model.
- Link DTO/type names to your codebase or OpenAPI schema names for traceability.

## Demo users — `users` (local chore / DEMO-USER-1)

| Module | Method | Path | Auth | Response type / notes |
|--------|--------|------|------|------------------------|
| Demo | POST | `/api/v1/users` | Public (demo) | **201** + `{ id, email, name? }`; duplicate email (case-insensitive) **409** + `USER_409_DUPLICATE_EMAIL`; validation **400** + `COMMON_400_VALIDATION` |

## ShelfLog demo — `shelf-items` (v1)

| Module | Method | Path | Auth | Response type / notes |
|--------|--------|------|------|------------------------|
| ShelfLog | POST | `/api/v1/shelf-items` | Public (demo) | **201** + created `ShelfItem` JSON |
| ShelfLog | GET | `/api/v1/shelf-items` | Public (demo) | **200** + paginated JSON (`content`, `page`, `size`, `totalElements`); query: `page`, `size`, optional `category` |
| ShelfLog | GET | `/api/v1/shelf-items/export` | Public (demo) | **200** + `text/csv;charset=UTF-8` attachment (`Content-Disposition: attachment; filename="shelf-items-UTCDate.csv"`); same query params as list; **413** JSON `SHELF_413_EXPORT` if matching rows **> 5000** (no partial CSV); cells starting with `= + - @` prefixed for spreadsheet safety |
| ShelfLog | GET | `/api/v1/shelf-items/{id}` | Public (demo) | **200** / **404** |
| ShelfLog | PUT | `/api/v1/shelf-items/{id}` | Public (demo) | **200** / **404** |
| ShelfLog | DELETE | `/api/v1/shelf-items/{id}` | Public (demo) | **204** / **404** |

Business spec: `../specs/feature-shelflog-items.md`.

## Inventory table (template)

| Module | Method | Path | Auth | Response type / notes |
|--------|--------|------|------|------------------------|
| _Example_ | GET | `/api/v2/health` | Public | Plain text or JSON per gateway |
| | | | | |
| | | | | |

## Path conventions

- Use **`{id}`** path variables (OpenAPI style), not `:id`, unless your ecosystem standard differs — then document the exception here.
- Collection resources use **plural** nouns: `/orders`, `/orders/{orderId}/items`.

## Operational endpoints (optional)

If applicable, list non-business routes (metrics, health) with their auth model:

| Method | Path | Auth | Notes |
|--------|------|------|-------|
| GET | `/actuator/health` | Public (ShelfLog demo) / Internal in prod | Enable for local demo; lock down in real deployments |

## When to update

- Add/update rows whenever you add an endpoint or change auth, path, or response contract.
- For large APIs, you may split by module (`08a-orders.md`, …) — if so, list sub-files in `01-README.md`.
