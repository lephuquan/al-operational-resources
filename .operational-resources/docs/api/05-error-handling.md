# Error Handling and Error Codes

## Error code format

`MODULE_CODE` (vi du: `AUTH_001`, `ORDER_429`, `PAYMENT_003`)

## Common error codes (mau)

| Code | HTTP Status | Message | Y nghia |
|------|-------------|---------|---------|
| AUTH_001 | 401 | Invalid credentials | Sai email/mat khau |
| AUTH_429 | 429 | Too many login attempts | Rate limit login |
| ORDER_001 | 400 | Product out of stock | Het hang |
| ORDER_403 | 403 | Cannot modify paid order | Khong sua don da thanh toan |
| PAYMENT_502 | 502 | Payment gateway error | Loi cong thanh toan |

## Validation error shape

```json
{
  "success": false,
  "error": {
    "code": "COMMON_400_VALIDATION",
    "message": "Validation failed",
    "details": [
      { "field": "email", "reason": "must be a well-formed email address" }
    ]
  }
}
```

## Error handling flow (Spring Boot)

Controller -> Service -> custom exception -> `@ControllerAdvice` -> JSON error envelope
