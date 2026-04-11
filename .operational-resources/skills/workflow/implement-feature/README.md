# Implement Feature (index)

## TL;DR (VI)

- Đây là playbook **triển khai feature end-to-end có kiểm soát** sau khi đã có task trong `docs/current-task/`.
- Đọc `SKILL.md` để biết thứ tự; dùng `examples.md` cho prompt mẫu; `checklist.md` để soát trước MR.
- Điểm vào tổng thể workspace: `PLAYBOOK.md`; flow chi tiết song song: `WORKFLOW.md`.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Playbook chính: slice, layer, test, docs, handoff |
| `examples.md` | Mẫu prompt AL + progress log + chia slice |
| `checklist.md` | Quality gate trước khi coi xong / trước MR |
| `README.md` | File này — thứ tự dùng và liên kết |

## Thứ tự khuyến nghị

1. Đảm bảo task đạt DoR (xem `PLAYBOOK.md`).
2. Nếu cần thiết kế sâu trước code: `skills/architecture/design-feature-architecture/`.
3. Đọc `SKILL.md` và chốt first slice.
4. Làm từng cụm với AL theo `examples.md`.
5. Chạy `checklist.md` trước khi MR; MR chi tiết dùng `skills/workflow/prepare-pull-request/`.

## Liên kết nhanh

- `PLAYBOOK.md`
- `WORKFLOW.md`
- `docs/current-task/TEMPLATE.md`
- `skills/backend/create-rest-api/`, `create-service-layer/`, `create-jpa-entity/`
- `skills/workflow/prepare-pull-request/`

**Last updated:** 2026-04-09
