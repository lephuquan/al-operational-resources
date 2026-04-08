# Error handling and error codes

## TL;DR (VI)

- Mỗi lỗi có **mã ổn định** (`MODULE_NNN`) + HTTP status đúng nghĩa.
- Lỗi validation: dùng `details` dạng mảng field; lỗi domain: message an toàn, không lộ stack/SQL.

**Last updated:** 2026-04-08

## Principles

- **HTTP status** tells the client *category* (auth, not found, conflict, rate limit).
- **`error.code`** tells the client *which* business rule failed (stable for i18n and monitoring).
- **Messages** are safe for end users; logs contain technical detail server-side only.

## Error code format

- Pattern: **`MODULE_CODE`** where:
  - `MODULE` is a short uppercase domain prefix (`AUTH`, `ORDER`, `COMMON`, …).
  - `CODE` is typically numeric (`001`, `429`) or semantic suffix agreed by the team.
- Codes must remain **stable** across releases when the meaning is unchanged.

## JSON error envelope

See `03-response-format.md`. Typical failure body:

```json
{
  "success": false,
  "error": {
    "code": "ORDER_001",
    "message": "Requested operation cannot be completed",
    "details": null
  }
}
```

## HTTP status mapping (recommended defaults)

| Scenario | HTTP | Example `error.code` |
|----------|------|------------------------|
| Validation / bad input | 400 | `COMMON_400_VALIDATION` |
| Missing or invalid auth | 401 | `AUTH_001` |
| Authenticated but not allowed | 403 | `AUTH_003` |
| Resource not found | 404 | `ORDER_404` |
| Conflict (duplicate, wrong state) | 409 | `ORDER_409` |
| Unprocessable business rule | 422 | `PAYMENT_422` |
| Rate limited | 429 | `AUTH_429` |
| Upstream / dependency failure | 502/503 | `PAYMENT_502` |
| Unexpected server error | 500 | `COMMON_500` |

Project-specific codes belong in `docs/knowledge-base/error-codes.md` (or team equivalent); keep this file as the **contract** for shape and rules.

## Validation errors (`details` as array)

```json
{
  "success": false,
  "error": {
    "code": "COMMON_400_VALIDATION",
    "message": "Validation failed",
    "details": [
      { "field": "email", "reason": "must be a valid email address" },
      { "field": "quantity", "reason": "must be greater than 0" }
    ]
  }
}
```

- **`field`:** logical JSON path (`items[0].price` if needed).
- **`reason`:** safe text; avoid echoing raw user input unescaped in HTML clients.

## Domain / business errors

- Use specific `error.code` per case (stock out, order already paid, insufficient balance).
- Prefer **409** when the conflict is due to current resource state.

## Security

- **Never** return stack traces, SQL fragments, file paths, or secret values in `message` or `details`.
- Log full exception server-side with correlation id.

## Processing flow (conceptual)

`Controller` → `Service` (throws domain exception with code) → global handler → JSON envelope.

Framework-specific wiring (e.g. Spring `@ControllerAdvice`) lives in skills under `skills/error-handling/`.

## Sample code table (illustrative)

Replace with your real catalog:

| Code | HTTP | Meaning (example) |
|------|------|---------------------|
| AUTH_001 | 401 | Invalid credentials |
| AUTH_429 | 429 | Too many login attempts |
| ORDER_001 | 400 | Business rule: cannot fulfill order |
| ORDER_403 | 403 | Action not allowed for current user/state |
| PAYMENT_502 | 502 | Upstream payment provider error |
