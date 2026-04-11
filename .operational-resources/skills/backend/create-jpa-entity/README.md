# Create JPA Entity (index)

## TL;DR (VI)

- Playbook tạo **entity JPA + repository** (+ migration khi đổi schema), bám `docs/architecture/05-database-design.md`.
- Đọc `SKILL.md` → làm theo bước → soát `checklist.md` → copy/adapt từ `examples.md`.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình đầy đủ: mapping, ID, quan hệ, audit, repo, migration, test |
| `examples.md` | Code mẫu entity, quan hệ, repository, SQL migration |
| `checklist.md` | Quality gate trước khi merge |
| `README.md` | File này — thứ tự dùng và liên kết |

## Thứ tự khuyến nghị

1. Chốt schema/aggregate trong task hoặc `design-feature-architecture` nếu thay đổi lớn.
2. Làm theo `SKILL.md` từng bước (đừng nhét business vào repository).
3. Thêm migration qua `skills/database/create-migration/SKILL.md` khi cần.
4. Chạy `checklist.md`.
5. Handoff sang service/API: `create-service-layer`, `create-rest-api`.

## Liên kết nhanh

- `docs/architecture/05-database-design.md`
- `skills/database/create-migration/SKILL.md`
- `skills/backend/create-service-layer/SKILL.md`
- `skills/workflow/implement-feature/README.md`

**Last updated:** 2026-04-09
