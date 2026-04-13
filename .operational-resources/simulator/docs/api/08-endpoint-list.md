# Endpoint inventory

## TL;DR (VI)

- Bảng **tổng quan** mọi route: method, path, auth, response chính — cập nhật khi đổi contract.
- Dùng path `{id}` thống nhất; chi tiết request/response ghi trong `09-contract-template.md` hoặc OpenAPI.

**Last updated:** 2026-04-08

## How to use this file

- Keep one row per **route** (method + path). Sub-resources can be separate rows.
- The **Auth** column should be one of: `Public`, `Authenticated`, `Role:XXX`, or `Scope:xxx` — match your `04-authentication.md` model.
- Link DTO/type names to your codebase or OpenAPI schema names for traceability.

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
| GET | `/actuator/health` | Internal / infra | Spring example; disable or secure in prod |

## When to update

- Add/update rows whenever you add an endpoint or change auth, path, or response contract.
- For large APIs, you may split by module (`08a-orders.md`, …) — if so, list sub-files in `01-README.md`.
