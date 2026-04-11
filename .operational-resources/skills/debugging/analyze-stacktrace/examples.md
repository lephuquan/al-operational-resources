# Examples: Đọc stack trace

Ví dụ minh họa cấu trúc; không phải lỗi thật của dự án.

## Stack trace giả lập (rút gọn)

```text
org.springframework.dao.DataIntegrityViolationException: could not execute statement
...
Caused by: org.postgresql.util.PSQLException: ERROR: duplicate key value violates unique constraint "uq_orders_reference"
```

**Đọc nhanh:** root cause = **duplicate key** trên constraint `uq_orders_reference` → mở chỗ insert/update `orders.reference` (service hoặc repository), kiểm tra race/idempotency.

## Khung ghi kết quả phân tích (dán vào task/notes)

```markdown
## Stack analysis
- **Top exception:** DataIntegrityViolationException
- **Deepest Caused by:** PSQLException duplicate key `uq_orders_reference`
- **First app frame:** `com.example.order.OrderServiceImpl.create` (line ~112)
- **Hypothesis:** Trùng `reference` khi retry hoặc thiếu unique business rule ở tầng app
- **Next:** Reproduce với cùng payload; check idempotency key / DB unique / transaction
```

## Noise thường gặp (bỏ qua khi tìm chỗ sửa)

- `...$$SpringCGLIB$$...`
- `sun.reflect`, `jdk.internal.reflect` (trừ khi đang debug reflection thật)
- Hàng chục frame `reactor.core` — tìm `Caused by:` gốc bên trong

**Last updated:** 2026-04-09
