# Checklist: Global Exception Handler

Dùng trước khi merge advice / handler mới.

## Structure

- [ ] Có **một** nơi chính (hoặc ranh giới đã **ghi rõ**) cho REST error mapping — không trùng `@ExceptionHandler` cùng exception ở nhiều class không kiểm soát.
- [ ] Handler **cụ thể** đăng ký trước fallback **`Exception`**.

## Contract

- [ ] Mọi response lỗi khớp **`docs/api/03-response-format.md`** (qua type/builder từ `api-error-response-format`).
- [ ] Validation trả **`details`** đúng dạng mảng trong **`05-error-handling.md`** khi áp dụng.

## Security & safety

- [ ] Fallback 500 không đưa **stack trace** / SQL / path / secret vào body.
- [ ] **401/403** nhất quán với cấu hình Spring Security (không 500 thay cho 403 vì thiếu handler).

## Observability

- [ ] Lỗi được **log** server-side với mức phù hợp; có **request/correlation id** khi stack hỗ trợ.

## Tests

- [ ] Có test cơ bản cho **validation 400** + `$.error.code`.
- [ ] Có test cho ít nhất **một** domain exception và **fallback 500** (hoặc mock).

## Docs

- [ ] Mã lỗi mới đã vào **`error-codes.md`** (nếu team dùng).

**Last updated:** 2026-04-11
