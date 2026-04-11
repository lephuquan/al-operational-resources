# Optimize Query (index)

## TL;DR (VI)

- Playbook **tối ưu truy vấn**: đo → N+1/fetch → EXPLAIN → index/migration → xác nhận số liệu.
- Không tối ưu mù; ưu tiên **bằng chứng** (query count, plan, latency).
- Liên quan chặt **`create-jpa-entity`**, **`implement-pagination-search`**, **`create-migration`**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình đo, N+1, plan, index, pagination, cache, xác nhận |
| `examples.md` | JOIN FETCH, EntityGraph, batch size, projection, EXPLAIN |
| `checklist.md` | Gate trước merge tối ưu |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Tái hiện slow path và đo baseline.
2. Làm theo `SKILL.md`; thử fetch/projection trước khi thêm index.
3. Index → migration qua `create-migration` khi cần.
4. Chạy `checklist.md` và ghi số liệu before/after trong MR.

## Liên kết nhanh

- `docs/architecture/05-database-design.md`
- `skills/database/create-migration/README.md`
- `skills/backend/create-jpa-entity/README.md`
- `skills/backend/implement-pagination-search/README.md`

**Last updated:** 2026-04-09
