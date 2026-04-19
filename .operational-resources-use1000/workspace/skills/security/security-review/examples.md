# Examples: Security Review

Không dán **secret thật** vào PR hay chat; ví dụ chỉ mang tính minh họa.

## Gợi ý tìm pattern nguy hiểm (grep / IDE search)

Tên biến / chuỗi thường cần xem kỹ (điều chỉnh theo codebase):

- `password`, `secret`, `apiKey`, `api_key`, `privateKey`, `BEGIN RSA`, `client_secret`
- `executeQuery(` + nối chuỗi từ tham số
- `ObjectInputStream`, `Runtime.getRuntime().exec`

Luôn **xác nhận false positive** (test fixture, placeholder có kiểm soát).

## Dependency check (Maven)

```bash
mvn -q dependency:check
```

Hoặc dùng công cụ team chuẩn (Dependabot, Snyk, OWASP DC trong CI).

## Kịch bản IDOR (thủ công hoặc test)

1. User **A** tạo resource → lấy `id`.
2. Đăng nhập user **B** (cùng role nếu cần).
3. Gọi **GET/PUT/DELETE** với `id` của A → kỳ vọng **403** hoặc **404** (theo policy team), không được thấy/sửa dữ liệu A.

## Gợi ý ghi chú PR (mẫu)

- **Must-fix:** `OrderController#get` — thiếu kiểm tra `order.tenantId == currentUser.tenantId` (IDOR).
- **Follow-up:** Thêm test negative cho user B trên order của A.

**Last updated:** 2026-04-11
