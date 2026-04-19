# Global Exception Handler (index)

## TL;DR (VI)

- Playbook **`@RestControllerAdvice`**: map exception → **HTTP** + envelope lỗi; **một** nơi xử lý, không nhân đôi logic ở controller.
- Neo vào **`api-error-response-format`** (shape JSON) và **`map-exceptions-to-http`** (bảng status ↔ nghiệp vụ).

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình handler, thứ tự catch, validation, Security, test |
| `examples.md` | Gợi ý `@ExceptionHandler`, validation `details`, `WebMvcTest` |
| `checklist.md` | Gate trước merge |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Đọc `skills/error-handling/api-error-response-format/README.md` và `docs/api/05-error-handling.md`.
2. Chuẩn hoá mapping với `skills/error-handling/map-exceptions-to-http/README.md`.
3. Làm theo `SKILL.md`; tham chiếu `examples.md` khi code.
4. Chạy `checklist.md`; bổ sung mã vào `error-codes.md` khi cần.

## Liên kết nhanh

- `skills/error-handling/api-error-response-format/README.md`
- `skills/error-handling/map-exceptions-to-http/README.md`
- `docs/api/03-response-format.md`, `docs/api/05-error-handling.md`
- `docs/knowledge-base/error-codes.md`
- `skills/security/secure-api-endpoint/README.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
