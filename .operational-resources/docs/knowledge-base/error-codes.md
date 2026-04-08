# Error Codes (Reference)

Danh sách mã lỗi ổn định cho client. **Đồng bộ** với `docs/api/05-error-handling.md`.

| Code | HTTP | Ý nghĩa |
|------|------|---------|
| AUTH_001 | 401 | Invalid credentials |
| ORDER_001 | 400 | Business rule / validation (ví dụ hết hàng) |
| ORDER_403 | 403 | Forbidden / state không cho phép |
| PAYMENT_502 | 502 | Lỗi tích hợp cổng thanh toán |

Thêm mã mới khi có module mới; tránh đổi ý nghĩa mã đã public.
