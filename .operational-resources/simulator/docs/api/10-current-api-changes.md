# Current API changes (changelog)

## TL;DR (VI)

- Ghi **mọi thay đổi contract hoặc hành vi** đang làm hoặc sắp release.
- Sau khi merge/release, có thể tóm tắt vào `docs/decisions/` hoặc release notes team — file này có thể **xóa trắng** mỗi cycle.

**Last updated:** 2026-04-08

## Active work / draft

**Task / ticket reference:** _(link or id)_

**Scope (one line):**

- …

## Changes (add newest first)

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
