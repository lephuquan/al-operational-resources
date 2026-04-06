# Database Design

**Last updated**: 06/04/2026

## Database overview

- Engine: [PostgreSQL — hoặc DB team chọn]
- Access: **Spring Data JPA** (hoặc JDBC/MyBatis nếu team quy định)
- Schema management: **Flyway / Liquibase** [chọn khi áp dụng]

## Key tables & relationships (mẫu — điền theo schema thực tế)

- **users** (id, email, role, status, …)
- **orders** (id, user_id, status, total_amount, …)
- **order_items** (order_id, product_id, quantity, price)
- **payments** (…)
- **notifications** (…)

## Important design decisions

- Soft delete (`deleted_at`) cho entity cần audit [nếu team chọn]
- Timestamp: `created_at`, `updated_at` (JPA `@CreationTimestamp` / `@UpdateTimestamp` hoặc Auditing)
- Indexing strategy: [liệt kê index quan trọng]
- Partitioning: [nếu bảng rất lớn]

## Constraints & business rules tại DB level

- Foreign key + `ON DELETE` phù hợp (cẩn thận cascade)
- Check constraints cho field quan trọng
- RLS (PostgreSQL): [nếu áp dụng]
