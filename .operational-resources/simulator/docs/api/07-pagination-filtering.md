# Pagination, filtering, and sorting

## TL;DR (VI)

- List: ưu tiên **cursor** + `limit`; fallback **page** + `size` có trần.
- Sort/filter: tên tham số **cố định**, field sort **whitelist**; `meta` khớp `03-response-format.md`.

**Last updated:** 2026-04-08

## Goals

- Predictable list behavior for large datasets.
- Avoid SQL injection via sort/filter parameters.
- Consistent `meta` block in list responses (`03-response-format.md`).

## Pagination modes

### Cursor-based (preferred for large or frequently changing lists)

**Query parameters:**

| Param | Required | Description |
|-------|----------|---------------|
| `cursor` | No | Opaque token from previous response; omit for first page. |
| `limit` | No | Page size; enforce a **maximum** (e.g. 100). |

**Response `meta`:**

- `nextCursor` (or `cursor` for next page), `hasNext`, optional `prevCursor` if bidirectional.
- Omit `total` if counting is expensive; document that behavior.

### Offset-based (simpler; use when datasets are small or counts are cheap)

**Query parameters:**

| Param | Required | Description |
|-------|----------|-------------|
| `page` | No | 1-based page index (document if 0-based instead). |
| `size` | No | Page size; enforce maximum. |

**Response `meta`:**

- `page`, `size`, `total`, `totalPages`, `hasNext`, `hasPrevious` as applicable.

### Rules

- If both `cursor` and `page` are sent, **prefer cursor** and ignore `page`, or return **400** — pick one rule and document it.
- Always cap `limit` / `size`.

## Filtering

- Use **explicit** query keys: `status=PAID`, `customerId=123`, `from=2026-01-01T00:00:00Z`.
- For full-text search, use a single key such as `q` unless the domain needs multiple (`q`, `sku`, …).
- Document which filters are supported **per endpoint** in `08-endpoint-list.md` or per-contract `09-contract-template.md`.

## Sorting

- Preferred pattern: `sort=fieldName,direction` with `direction` in `asc|desc`.
- Multiple sorts: repeat param or comma-separated — **choose one** and stick to it project-wide.
- **Whitelist** allowed `fieldName` values server-side; reject unknown fields with **400**.

## Empty list

- HTTP **200** with `success: true`, `data: []`, and appropriate `meta` (e.g. `hasNext: false`).

## Related

- Response envelope: `03-response-format.md`
- Overview: `02-api-overview.md`
