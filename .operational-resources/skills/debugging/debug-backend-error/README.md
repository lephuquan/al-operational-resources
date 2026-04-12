# Debug Backend Error — Local (index)

## TL;DR (VI)

- Playbook xử lý lỗi backend trên **máy dev**: thu thập → **analyze-stacktrace** → reproduce → khoanh vùng → fix nhỏ → test.
- Handoff từ đọc stack: **`analyze-stacktrace`**; khi lên môi trường thật: **`debug-production-issue`**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình đầy đủ từ gather → fix → chốt |
| `examples.md` | Mẫu ghi bug + curl + log DEBUG tạm |
| `checklist.md` | Gate trước khi đóng bug |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. `skills/debugging/analyze-stacktrace/README.md` (nếu chưa rõ root cause).
2. Làm theo `SKILL.md`; điền mẫu `examples.md`.
3. Chạy `checklist.md`.

## Liên kết nhanh

- `skills/debugging/analyze-stacktrace/README.md`
- `skills/debugging/debug-production-issue/README.md`
- `docs/setup/01-README.md`
- `notes/debugging/bug-history.md`
- `skills/testing/write-integration-test/README.md`

**Last updated:** 2026-04-09
