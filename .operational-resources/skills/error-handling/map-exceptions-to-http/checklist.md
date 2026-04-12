# Checklist: Map Exceptions to HTTP

Dùng khi thêm domain error mới hoặc đổi contract lỗi.

## Matrix & docs

- [ ] Mỗi case mới có **HTTP status** và **`error.code`** ghi trong **`error-codes.md`** (và/hoặc bảng trong **`05-error-handling.md`**).
- [ ] Không mâu thuẫn với bảng khuyến nghị trong **`05-error-handling.md`** trừ khi đã **ghi lý do** ngoại lệ.

## Semantics

- [ ] **404 vs 403** tuân policy bảo mật (không lộ tài nguyên ẩn nếu team cấm).
- [ ] **409 vs 422** phân biệt rõ (conflict state vs business rule).
- [ ] Không dùng **500** cho lỗi nghiệp vụ **dự kiến** (hết hàng, trùng email, …).

## Code

- [ ] Service không trả **`ResponseEntity`**; chỉ throw domain / exception đã thống nhất.
- [ ] **`@RestControllerAdvice`** map đúng matrix — không hai status khác nhau cho cùng một exception type.

## Verification

- [ ] Có test hoặc checklist thủ công cho path quan trọng (status + `error.code`).

**Last updated:** 2026-04-11
