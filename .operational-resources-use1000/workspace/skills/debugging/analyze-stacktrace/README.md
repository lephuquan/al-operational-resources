# Analyze Stacktrace (index)

## TL;DR (VI)

- Playbook **đọc stack trace** Java/Spring: tìm **`Caused by`** gốc, lọc **noise**, nhảy vào **frame package app**.
- Kết quả là **1–3 cây** root cause + chỗ mở code + bước verify — handoff sang **`debug-backend-error`** / **`debug-production-issue`** khi cần.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình đọc và phân loại exception |
| `examples.md` | Ví dụ duplicate key + khung ghi chú |
| `checklist.md` | Gate khi phân tích |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Dán full stack vào task hoặc file note (redact secret).
2. Chạy theo `SKILL.md` hoặc đánh dấu `checklist.md`.
3. Điền khung trong `examples.md` để lưu kết quả.
4. Nếu cần quy trình debug đầy đủ: `debug-backend-error/README.md` (local) hoặc `debug-production-issue/README.md` (prod).

## Liên kết nhanh

- `skills/workflow/investigate-bug/README.md` (quy trình bugfix end-to-end)
- `skills/debugging/debug-backend-error/README.md`
- `skills/debugging/debug-production-issue/README.md`

**Last updated:** 2026-04-11
