# Skill: Create Migration

## TL;DR (VI)

- Thêm **migration** (Flyway / Liquibase) có **version rõ**, **review được**, **test trên DB giống prod**.
- Tránh lock lâu trên bảng lớn; tách **backfill** phức tạp sang migration/step riêng khi cần.
- Sau DDL: đồng bộ **entity JPA** và ghi chú **rollback / expand-contract** trong task hoặc ADR.

## Goal

Thay đổi schema (hoặc seed/bảng trợ giúp) một cách có kiểm soát: lịch sử thay đổi rõ, chạy được trên môi trường team, không phá dữ liệu hiện có thiếu kế hoạch.

## Preconditions

- Biết tool migration của dự án (Flyway, Liquibase, …) và thư mục script chuẩn.
- Đã có thiết kế bảng/cột/index (task, `design-database-schema`, hoặc `docs/architecture/05-database-design.md`).
- Có DB dev/staging hoặc container để chạy thử migration.

## Steps

1. **Đặt version và tên file**
   - Flyway: `V{version}__snake_description.sql` (version tăng dần, không trùng).
   - Liquibase: changelog master + file changeset với **id** duy nhất + author.
   - Mô tả ngắn gắn với nghiệp vụ (ví dụ `add_order_status_index`).

2. **Viết DDL an toàn**
   - `CREATE TABLE` kèm `IF NOT EXISTS` chỉ khi tool/DB hỗ trợ và team cho phép — tránh che lỗi thật.
   - `ALTER`: ưu tiên **expand** trước (thêm cột nullable / default an toàn) rồi mới **contract** (NOT NULL, drop) ở migration sau nếu cần zero-downtime.
   - Index: đặt tên có ý nghĩa; cân nhắc `CONCURRENTLY` trên PostgreSQL cho bảng lớn (ghi rõ trong script/ADR).

3. **Dữ liệu và backfill**
   - Cập nhật hàng loạt: tách migration riêng hoặc batch nếu volume lớn.
   - Không để migration “half state” không recover được — ghi rõ thứ tự deploy.

4. **Khóa và hiệu năng**
   - Tránh `ALTER` lock toàn bảng trong giờ cao điểm nếu có chiến lược online (team quyết định).
   - Tránh transaction DDL dài trên engine không hỗ trợ tốt.

5. **Kiểm thử**
   - Chạy migration trên DB sạch + DB có dữ liệu mẫu (nếu có).
   - Xác nhận app start + smoke query sau migrate.

6. **Đồng bộ code**
   - Cập nhật entity/mapping JPA khớp schema (`skills/backend/create-jpa-entity/SKILL.md`).
   - Cập nhật docs/schema nếu team duy trì.

7. **Rollback / forward-fix**
   - Flyway: thường **không** có auto rollback — cần migration forward-fix (`Vxxx__fix_...`) hoặc quy trình restore backup.
   - Ghi trong MR/task: “no rollback” hoặc bước khắc phục.

## Output

- File migration mới + (nếu cần) entity/test cập nhật + ghi chú deploy trong MR.

## References

- `docs/architecture/05-database-design.md`
- `skills/database/design-database-schema/SKILL.md`
- `skills/backend/create-jpa-entity/SKILL.md`
- `skills/database/optimize-query/SKILL.md` (index, hot path)

**Last updated:** 2026-04-09
