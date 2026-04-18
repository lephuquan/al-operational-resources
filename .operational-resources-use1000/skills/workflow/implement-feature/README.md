# Implement Feature (index)

## TL;DR (VI)

- Đây là playbook **triển khai feature end-to-end có kiểm soát** sau khi đã có task trong `current-task/`.
- Đọc `SKILL.md` để biết thứ tự; dùng `examples.md` cho prompt mẫu; `checklist.md` để soát trước MR.
- Luồng tổng **ticket → Done:** `task-lifecycle/README.md` → `FROM-TICKET-TO-DONE.md`.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Playbook chính: slice, layer, test, docs, handoff |
| `examples.md` | Mẫu prompt AL + progress log + chia slice |
| `checklist.md` | Quality gate trước khi coi xong / trước MR |
| `README.md` | File này — thứ tự dùng và liên kết |

## Thứ tự khuyến nghị

1. Đảm bảo task đạt DoR (xem `task-lifecycle/FROM-TICKET-TO-DONE.md` §4).
2. Nếu cần thiết kế sâu trước code: `skills/architecture/design-feature-architecture/`.
3. Đọc `SKILL.md` và chốt first slice.
4. Làm từng cụm với AL theo `examples.md`.
5. Chạy `checklist.md` trước khi MR; MR chi tiết dùng `skills/workflow/prepare-pull-request/README.md`.

## Liên kết nhanh

- `task-lifecycle/README.md`
- `task-lifecycle/FROM-TICKET-TO-DONE.md`
- `current-task/TEMPLATE.md`
- `skills/backend/create-rest-api/README.md`
- `skills/backend/create-service-layer/README.md`
- `skills/backend/create-jpa-entity/README.md`
- `skills/security/validate-input/README.md`
- `skills/testing/create-test-data/README.md`
- `skills/testing/write-unit-test/README.md`
- `skills/testing/write-integration-test/README.md`
- `skills/workflow/investigate-bug/README.md` (khi task là bugfix)
- `skills/workflow/prepare-pull-request/README.md`

**Last updated:** 2026-04-11
