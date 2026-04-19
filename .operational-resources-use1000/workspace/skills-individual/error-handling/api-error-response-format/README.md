# API Error Response Format (index)

## TL;DR (VI)

- Playbook **envelope lỗi JSON**: `success: false`, `error.code`, `error.message`, `error.details` (tuỳ trường hợp) — bám **`docs/api/03-response-format.md`** và **`05-error-handling.md`**.
- Dùng **một bộ type/builder** dùng chung; exception handler chỉ **điền** đúng shape.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình schema, code, message, details, HTTP |
| `examples.md` | JSON mẫu, gợi ý DTO Java |
| `checklist.md` | Gate trước merge |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Đọc `docs/api/03-response-format.md` → `05-error-handling.md`.
2. Làm theo `SKILL.md`; copy chỉnh từ `examples.md`.
3. Nối với `skills/error-handling/map-exceptions-to-http/README.md` (bảng HTTP ↔ ý nghĩa) và `global-exception-handler/README.md` (thực thi body).
4. Chạy `checklist.md`; cập nhật `error-codes.md` khi thêm mã mới.

## Liên kết nhanh

- `docs/api/03-response-format.md`, `docs/api/05-error-handling.md`
- `docs/knowledge-base/error-codes.md`
- `skills/error-handling/global-exception-handler/README.md`
- `skills/error-handling/map-exceptions-to-http/README.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
