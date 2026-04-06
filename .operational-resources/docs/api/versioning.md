# API Versioning Strategy

- **Current version**: v2 (đang phát triển)
- **Legacy version**: v1 (chỉ hỗ trợ, không thêm feature mới)
- **Deprecation plan**: v1 tắt sau 6 tháng kể từ khi v2 ổn định [điều chỉnh theo team]

## Quy tắc versioning

- Breaking change → tăng version
- Non-breaking (thêm field optional) → có thể giữ version cũ
- URL versioning: `/api/v2/orders`
