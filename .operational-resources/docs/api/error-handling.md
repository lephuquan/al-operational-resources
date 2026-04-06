# Error Handling & Error Codes

## Error code format

`MODULE_CODE` (ví dụ: `AUTH_001`, `ORDER_429`, `PAYMENT_003`)

## Common error codes (mẫu)

| Code | HTTP Status | Message | Ý nghĩa |
|------|-------------|---------|---------|
| AUTH_001 | 401 | Invalid credentials | Sai email/mật khẩu |
| AUTH_429 | 429 | Too many login attempts | Rate limit login |
| ORDER_001 | 400 | Product out of stock | Hết hàng |
| ORDER_403 | 403 | Cannot modify paid order | Không sửa đơn đã thanh toán |
| PAYMENT_502 | 502 | Payment gateway error | Lỗi cổng thanh toán |

## Error handling flow (Spring Boot)

Controller → Service → custom exception → `@ControllerAdvice` / `HandlerExceptionResolver` → JSON error envelope
