# Map Exceptions to HTTP (index)

## TL;DR (VI)

- Playbook **thiết kế bảng mapping**: nghiệp vụ / exception → **HTTP status** + **`error.code`** — nền cho service layer và **`global-exception-handler`**.
- Chuẩn mặc định nằm trong **`docs/api/05-error-handling.md`**; chi tiết mã trong **`error-codes.md`**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình inventory, phân loại HTTP, mã lỗi, tài liệu, triển khai |
| `examples.md` | Bảng mẫu, gợi ý exception + mapping trong code |
| `checklist.md` | Gate trước merge |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Đọc `docs/api/05-error-handling.md` và `docs/knowledge-base/error-codes.md`.
2. Làm theo `SKILL.md` để lập matrix; ghi vào docs + code.
3. Triển khai handler theo `skills/error-handling/global-exception-handler/README.md`.
4. Chạy `checklist.md`.

## Liên kết nhanh

- `skills/error-handling/api-error-response-format/README.md`
- `skills/error-handling/global-exception-handler/README.md`
- `docs/api/03-response-format.md`, `docs/api/05-error-handling.md`
- `docs/knowledge-base/error-codes.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
