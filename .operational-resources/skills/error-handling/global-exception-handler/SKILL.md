# Skill: Global Exception Handler

## Goal

`@ControllerAdvice` thống nhất: map exception → HTTP + body lỗi theo envelope dự án.

## Steps

1. Tạo `@RestControllerAdvice` với `@ExceptionHandler` cho từng loại (validation, domain, generic).
2. `MethodArgumentNotValidException` → 400 + chi tiết field (cẩn thận message).
3. Domain exception có `errorCode` → map sang HTTP status phù hợp.
4. `Exception` fallback → 500 (không leak stack trace ra client).
5. Test: `@WebMvcTest` assert status + body.

## References

- `docs/api/error-handling.md`
