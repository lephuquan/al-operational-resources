# Skill: Map Exceptions to HTTP

## Goal

Bảng mapping rõ ràng: domain error → status code (400/404/409/422/429/502…).

## Steps

1. Liệt kê business cases: not found, conflict, forbidden, dependency fail.
2. Map trong `ControllerAdvice` hoặc exception factory.
3. Giữ `error.code` ổn định cho client (xem `knowledge-base/error-codes.md`).
4. Document trong `docs/api/error-handling.md`.
