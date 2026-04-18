# Investigate Bug (index)

## TL;DR (VI)

- Playbook **điều tra bug có phương pháp**: thu thập **bằng chứng** → **tái hiện** → giả thuyết có kiểm chứng → **fix tối thiểu** → **regression test** → ghi nhận nếu lỗi hay gặp.
- Khi có **exception**: **`analyze-stacktrace`** trước; **local** dùng **`debug-backend-error`**; **production** dùng **`debug-production-issue`** (policy + redact).
- Gói việc trong **`current-task/`** (task type **bugfix**, khối B trong `TEMPLATE.md`).

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình đầy đủ: evidence, reproduce, narrow, fix, verify |
| `checklist.md` | Gate trước khi coi root cause chắc / trước MR |
| `examples.md` | Mẫu giả thuyết–bằng chứng, progress log |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Tạo/cập nhật file task (`TEMPLATE.md` §6B — bugfix).
2. Làm theo `SKILL.md`; điền `examples.md` khi cần.
3. Chạy `checklist.md` trước MR; MR theo `skills/workflow/prepare-pull-request/README.md`.

## Liên kết nhanh

- `current-task/TEMPLATE.md`
- `skills/debugging/analyze-stacktrace/README.md`
- `skills/debugging/debug-backend-error/README.md`
- `skills/debugging/debug-production-issue/README.md`
- `skills/testing/write-unit-test/README.md`
- `skills/testing/write-integration-test/README.md`
- `skills/workflow/prepare-pull-request/README.md`
- `notes/debugging/bug-history.md`

**Last updated:** 2026-04-11
