# Create Migration (index)

## TL;DR (VI)

- Playbook thêm **Flyway / Liquibase** migration: version đúng, DDL an toàn, test trên DB thật, đồng bộ **JPA**.
- Đọc `SKILL.md` cho quy trình; `examples.md` cho mẫu SQL/YAML; `checklist.md` trước merge.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình: naming, DDL, backfill, lock, test, entity, rollback |
| `examples.md` | Flyway file, expand-contract, Liquibase YAML, ghi chú MR |
| `checklist.md` | Quality gate |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Chốt thiết kế schema (`design-database-schema` / task).
2. Viết migration + chạy trên dev/staging.
3. Cập nhật entity JPA nếu cần.
4. Chạy `checklist.md` và ghi rollback/forward-fix trong MR.

## Liên kết nhanh

- `docs/architecture/05-database-design.md`
- `skills/database/design-database-schema/SKILL.md`
- `skills/backend/create-jpa-entity/SKILL.md`
- `skills/database/optimize-query/SKILL.md`

**Last updated:** 2026-04-09
