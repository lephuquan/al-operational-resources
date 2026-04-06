# Standard API Response Format

## 1. Success response

```json
{
  "success": true,
  "data": {},
  "meta": {
    "page": 1,
    "limit": 20,
    "total": 245,
    "hasNext": true,
    "cursor": "eyJ..."
  }
}
```

## 2. Error response

```json
{
  "success": false,
  "error": {
    "code": "ORDER_001",
    "message": "Sản phẩm hết hàng tạm thời",
    "details": {}
  }
}
```

(`details` optional — chỉ dùng khi cần debug an toàn phía client.)

## 3. Empty data response

```json
{
  "success": true,
  "data": null,
  "meta": {}
}
```

**Lý do chọn format này:** Frontend/client dễ xử lý, envelope consistent.

**Spring Boot:** map qua DTO + `@ControllerAdvice` để chuẩn hóa body lỗi/thành công.
