# Examples: Analyze Query Performance

Tập trung **PostgreSQL**; engine khác dùng cùng tư duy đọc plan.

## `EXPLAIN (ANALYZE, BUFFERS)` — mẫu

```sql
EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT)
SELECT o.id, o.status, c.name
FROM orders o
JOIN customers c ON c.id = o.customer_id
WHERE o.status = 'PENDING'
  AND o.created_at > NOW() - INTERVAL '7 days'
ORDER BY o.created_at DESC
LIMIT 50;
```

- **`ANALYZE`**: chạy thật, có thời gian thực tế.
- **`BUFFERS`**: hit/read buffer (cần quyền phù hợp; có thể tắt nếu policy cấm).

## Đọc nhanh output

- Dòng **`Seq Scan`** trên bảng lớn + `Filter:` → xem predicate có dùng được index không.
- **`Planning Time`** vs **`Execution Time`** — planning cao bất thường có thể do nhiều join hoặc stats phức tạp.
- **`Rows Removed by Filter`** lớn sau index scan → lệch kỳ vọng về thứ tự cột index hoặc điều kiện không nằm trên prefix index.

## `pg_stat_statements` (gợi ý)

```sql
SELECT query, calls, mean_exec_time, total_exec_time
FROM pg_stat_statements
ORDER BY mean_exec_time DESC
LIMIT 20;
```

Chỉ dùng trên môi trường cho phép; reset/extension cần quyền admin.

**Last updated:** 2026-04-11
