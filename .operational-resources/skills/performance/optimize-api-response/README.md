# Optimize API Response (index)

## TL;DR (VI)

- Playbook **nhẹ và gọn response HTTP**: DTO, **pagination**, giảm serialize; **đo** trước/sau.
- Neo **`docs/api/`** và **`create-rest-api`**; DB nặng → **`optimize-query`**; cache → **`caching-strategy`**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình DTO, pagination, projection, đo lường |
| `examples.md` | DTO, `@JsonInclude`, gợi ý projection |
| `checklist.md` | Gate trước merge |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Đo baseline (latency / kích thước) trên endpoint đích.
2. Làm theo `SKILL.md`; cập nhật contract `docs/api/` khi đổi shape.
3. Chạy `checklist.md`.

## Liên kết nhanh

- `skills/performance/reduce-memory-usage/README.md` (payload / list lớn trong heap)
- `skills/backend/create-rest-api/README.md`
- `skills/backend/implement-pagination-search/README.md`
- `skills/database/optimize-query/README.md`
- `skills/performance/caching-strategy/README.md`
- `skills/observability/add-metrics/README.md`
- `docs/api/03-response-format.md`, `docs/api/07-pagination-filtering.md`

**Last updated:** 2026-04-11
