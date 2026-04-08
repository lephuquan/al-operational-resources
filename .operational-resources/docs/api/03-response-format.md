# Standard API Response Format

## Success response

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

## Error response

```json
{
  "success": false,
  "error": {
    "code": "ORDER_001",
    "message": "San pham het hang tam thoi",
    "details": {}
  }
}
```

- `details` la optional; chi tra ve noi dung an toan cho client.
- Validation error nen co danh sach field loi (xem `05-error-handling.md`).

## Empty data response

```json
{
  "success": true,
  "data": null,
  "meta": {}
}
```

**Spring Boot:** map qua DTO + `@ControllerAdvice` de chuan hoa body loi/thanh cong.
