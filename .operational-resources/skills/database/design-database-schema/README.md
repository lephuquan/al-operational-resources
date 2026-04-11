# Design Database Schema (index)

## TL;DR (VI)

- Playbook **thiết kế schema** trước migration: bảng, khóa, FK, index, constraint, soft delete.
- Neo **`docs/architecture/05-database-design.md`**; trade-off lớn → **ADR**; triển khai script → **`create-migration`**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình đầy đủ từ domain → doc → handoff migration |
| `examples.md` | Ghi chú quan hệ, bảng sketch, partial unique, kế hoạch migration |
| `checklist.md` | Gate trước khi chốt thiết kế |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Đọc/chỉnh `docs/architecture/05-database-design.md`.
2. Làm theo `SKILL.md` và điền mẫu trong `examples.md`.
3. Chạy `checklist.md`.
4. Chuyển sang `skills/database/create-migration/README.md`.

## Liên kết nhanh

- `docs/architecture/05-database-design.md`
- `docs/decisions/README.md`
- `skills/database/create-migration/README.md`
- `skills/backend/create-jpa-entity/README.md`
- `skills/database/optimize-query/SKILL.md`

**Last updated:** 2026-04-09
