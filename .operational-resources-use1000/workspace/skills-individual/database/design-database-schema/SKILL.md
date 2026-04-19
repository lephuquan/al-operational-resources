# Skill: Design Database Schema

## TL;DR (VI)

- Thiết kế **schema** trước khi viết migration: bảng, **khóa**, **FK**, **index**, **constraint**, quy ước đặt tên.
- Cân bằng **normalization** vs hiệu năng đọc; ghi **trade-off** lớn vào ADR khi cần.
- Đầu ra neo **`docs/architecture/05-database-design.md`** và handoff sang **`create-migration`**.

## Goal

Có bản thiết kế schema đủ để implement migration + JPA nhất quán: quan hệ rõ, ràng buộc toàn vẹn dữ liệu, index phục vụ query hot path, và kế hoạch thay đổi an toàn (expand-contract, soft delete, v.v.).

## Preconditions

- Có spec/task mô tả entity nghiệp vụ, cardinality, và ràng buộc (unique, lifecycle).
- Biết RDBMS mục tiêu (PostgreSQL, MySQL, …) và convention naming của team.

## Steps

1. **Thu thập mô hình**
   - Liệt kê entity, thuộc tính, quan hệ 1-1 / 1-N / N-N từ spec hoặc domain event.
   - Ghi rõ **natural key** vs **surrogate key** (Long, UUID) theo convention.

2. **Bảng và cột**
   - Kiểu dữ liệu phù hợp (money, timestamp TZ, text length).
   - `NOT NULL` + default chỉ khi nghiệp vụ chắc chắn; tránh khóa cứng quá sớm khi cần backfill.

3. **Khóa ngoại và toàn vẹn**
   - FK với `ON DELETE` / `ON UPDATE` phù hợp (RESTRICT vs CASCADE có chủ đích).
   - Tránh orphan: quyết định soft delete vs hard delete thống nhất.

4. **Unique & business rules**
   - Unique constraint cho business key (email, mã đơn, …).
   - **Partial unique index** khi soft delete (ví dụ unique active rows only) nếu DB hỗ trợ.

5. **Index**
   - Index cho `WHERE`, `JOIN`, `ORDER BY` của API/report chính.
   - Tránh quá nhiều index trên bảng ghi nặng; đo hoặc ghi lý do.

6. **Soft delete & audit**
   - Cột `deleted_at` / `is_deleted` và ảnh hưởng query + unique.
   - `created_at` / `updated_at` / actor nếu audit cần thiết.

7. **Ghi nhận và handoff**
   - Cập nhật `docs/architecture/05-database-design.md` (hoặc tài liệu schema team).
   - Tạo ADR trong `docs/decisions/` khi trade-off kiến trúc đáng kể (denormalize, JSON column, sharding…).
   - Chuyển sang `skills/database/create-migration/SKILL.md` cho script versioned.

## Output

- Mô tả schema (doc + có thể diagram/textual ERD) + danh sách migration dự kiến (có thể tách nhiều bước).

## References

- `docs/architecture/05-database-design.md`
- `docs/decisions/README.md`, `docs/decisions/TEMPLATE.md`
- `skills/database/create-migration/SKILL.md`
- `skills/backend/create-jpa-entity/SKILL.md`
- `skills/database/optimize-query/SKILL.md`

**Last updated:** 2026-04-09
