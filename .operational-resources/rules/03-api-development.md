# 03 - API Development Guidelines

## Endpoint design

- **Versioning**: `/api/v2/...` (hoặc version team đang dùng — đồng bộ với `docs/api/`)
- **Resource naming**: kebab-case cho path segment (`/user-profiles`, `/order-items`)
- **HTTP methods**: tuân thủ RESTful (GET an toàn/idempotent khi đúng ngữ nghĩa; POST tạo; PUT/PATCH cập nhật; DELETE xóa)

## Response format (envelope JSON)

Hình thức chuẩn (điều chỉnh theo contract team nếu khác):

```json
{
  "success": true,
  "data": {},
  "error": null,
  "meta": {
    "page": 1,
    "limit": 20,
    "total": 100
  }
}
```

Khi lỗi:

```json
{
  "success": false,
  "data": null,
  "error": {
    "code": "ORDER_001",
    "message": "Human readable message"
  },
  "meta": {}
}
```

## Error handling

- Dùng **exception domain/hoặc custom** + **global exception handler** (`@ControllerAdvice`) để map sang HTTP + `error.code`.
- **Error code format**: `MODULE_CODE` (ví dụ: `ORDER_001`, `AUTH_429`).
- **Validate input** ở boundary: DTO + **Jakarta Bean Validation** (`@Valid`, `@NotNull`, …) — tương đương vai trò “schema validation” (không dùng Zod trong Java).

## Current API tasks

- [ ] Cập nhật endpoint / thay đổi contract đang làm tại đây (ví dụ: Order API v2)
