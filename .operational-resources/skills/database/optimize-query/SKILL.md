# Skill: Optimize Query

## TL;DR (VI)

- Giảm **N+1**, **slow query**, **full scan** không cần thiết trên stack JPA/Hibernate + RDBMS.
- Đo trước khi đoán: log SQL / datasource proxy / **`EXPLAIN (ANALYZE)`** — rồi mới thêm index hoặc fetch join.
- Pagination luôn có **limit**; cache chỉ khi có **invalidate** rõ.

## Goal

Cải thiện hiệu năng truy vấn có bằng chứng (số query, thời gian, plan): giữ đúng hành vi nghiệp vụ và tránh tối ưu sớm không cần thiết.

## Preconditions

- Đã xác định endpoint/use case chậm hoặc tải DB cao.
- Có môi trường dev/staging với dữ liệu đủ lớn **hoặc** cách tái hiện (seed).
- Quyền chạy `EXPLAIN` trên DB mục tiêu (hoặc nhờ DBA).

## Steps

1. **Đo và tái hiện**
   - Bật log SQL tạm (`show-sql`, `format_sql`) hoặc **datasource-proxy** / OpenTelemetry JDBC (chỉ dev/staging).
   - Đếm số query trên một request (ví dụ integration test assert query count).

2. **N+1 và fetch**
   - Xác định lazy load trong loop → thay bằng `JOIN FETCH`, `@EntityGraph`, **DTO projection**, hoặc **batch fetch** (`default_batch_fetch_size`).
   - Cảnh báo: `JOIN FETCH` + `Page` có thể duplicate/count sai — cần query tách hoặc chiến lược khác.

3. **Phân tích plan**
   - Chạy `EXPLAIN ANALYZE` (PostgreSQL) hoặc tương đương cho câu SQL nặng.
   - Tìm sequential scan, sort lớn, nested loop trên bảng lớn.

4. **Index & schema**
   - Thêm index phù hợp predicate/sort; tránh index thừa trên bảng ghi nặng.
   - Cập nhật qua migration (`create-migration`); ghi lý do trong MR.

5. **Pagination & stream**
   - Không `findAll()` rồi lọc trong memory; dùng `Page` / `LIMIT` / keyset pagination khi data lớn.

6. **Cache (tuỳ chọn)**
   - Chỉ khi có TTL/invalidate/event rõ; tránh stale data khó debug.

7. **Xác nhận**
   - So sánh before/after: latency, query count, plan.
   - Regression test cho hành vi (kết quả tập hợp giống logic cũ).

## Output

- Thay đổi code/query/index + ghi chú đo lường (số liệu hoặc hướng dẫn reproduce) trong task/MR.

## References

- `skills/performance/analyze-query-performance/README.md` (EXPLAIN, chứng minh slow query)
- `docs/architecture/05-database-design.md`
- `docs/knowledge-base/coding-patterns.md`
- `skills/database/create-migration/SKILL.md`
- `skills/backend/create-jpa-entity/SKILL.md`
- `skills/backend/implement-pagination-search/SKILL.md`

**Last updated:** 2026-04-11
