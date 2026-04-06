# Skill: Analyze Query Performance

## Goal

Tìm slow query và chứng minh bằng EXPLAIN/APM.

## Steps

1. Thu thập query từ log hoặc APM (p95, p99).
2. `EXPLAIN (ANALYZE, BUFFERS)` trên PostgreSQL.
3. Kiểm tra index missing, seq scan, wrong cardinality.
4. Cập nhật migration thêm index; re-test.
5. Tránh “fix” bằng cache nếu root cause là index.
