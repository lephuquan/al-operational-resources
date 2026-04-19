# Skill: Analyze Query Performance

## TL;DR (VI)

- **Chẩn đoán** trước khi sửa: lấy **slow query** từ **APM**, **DB stats** (`pg_stat_statements`, …), hoặc **log** có bind value an toàn — rồi **EXPLAIN (ANALYZE)** (PostgreSQL) hoặc tương đương.
- Đọc plan: **Seq Scan** nặng, **Nested Loop** trên volume lớn, **sort/hash** spill, **ước lượng sai** (rows estimate), **lock wait**.
- Kết quả là **bằng chứng** (latency, plan, rows); triển khai sửa (index, rewrite, N+1) theo **`skills/database/optimize-query/README.md`**.

## Goal

Identify and **prove** why specific database queries are slow, using reproducible evidence suitable for review with DBAs and for before/after comparison.

## Preconditions

- **Target DB** and permission to run **`EXPLAIN`** (read-only is enough for analysis on a copy).
- **Representative data volume** (staging, anonymized dump, or synthetic seed) so plans match production shape.
- Optional: **APM** or **`pg_stat_statements`** enabled in a safe environment.

## Steps

1. **Define “slow”**
   - Agree threshold (p95/p99 latency, CPU on DB, rows scanned) and **which endpoint/job** is in scope.

2. **Capture the statement**
   - From **APM** (slow query trace), **ORM** SQL log (staging only), **`pg_stat_statements`** (normalized SQL), or **manual** reproduction.
   - Replace **literals** with placeholders when sharing externally; never paste production **PII** in tickets.

3. **Reproduce in a controlled session**
   - Run the same **parameters** as the slow case (cardinality matters).
   - Disable aggressive **caching** that hides the problem during the first run.

4. **PostgreSQL: `EXPLAIN (ANALYZE, BUFFERS)`**
   - Use **`ANALYZE`** for real timings; **`BUFFERS`** for cache vs read I/O (when I/O is suspected).
   - Record: **planning time**, **execution time**, **actual rows** vs **estimated rows** (bad estimates → stale stats or skew).

5. **Interpret common red flags**

   | Signal | Often implies |
   |--------|----------------|
   | Sequential Scan on large table + filter | Missing/partial index; predicate not sargable |
   | Nested Loop with huge inner rows | Join order / missing index on inner key |
   | Sort / HashAggregate spilling to disk | Work_mem; reduce data earlier; index for ORDER BY |
   | Bitmap Heap Scan + high heap fetches | Index not very selective; consider different index or rewrite |
   | High **rows removed by filter** after index scan | Index column order vs predicate mismatch |

6. **Statistics and maintenance**
   - If estimates are wildly off: **`ANALYZE`** relevant tables; check **autovacuum** health; document if **extended statistics** or **histogram** updates are needed (DBA).

7. **Concurrency**
   - If symptom is **timeout** under load: check **lock waits**, **blocking**, hot **index** contention — may need session-level trace or `pg_locks` (team runbook).

8. **Other engines (brief)**
   - **MySQL:** `EXPLAIN ANALYZE` (8.0.18+); **SQL Server:** actual execution plan; adapt concepts (scans, seeks, cardinality).

9. **Document the finding**
   - One-page note: **query fingerprint**, **parameters**, **plan snippet**, **hypothesis**, **risk** of proposed change (write amplification).

10. **Handoff to fix**
   - Schema/index changes → **`skills/database/create-migration/README.md`**.
   - ORM/N+1/pagination → **`skills/database/optimize-query/README.md`**.

11. **Verify after change**
   - Re-run **`EXPLAIN (ANALYZE)`** and compare **execution time** and **buffer** metrics; align with **`add-metrics`** DB pool / latency if available.

## Output

- Written analysis: slow query identification, EXPLAIN output (sanitized), root-cause hypothesis, recommended next skill (optimize-query vs migration vs DBA).

## References

- `skills/database/optimize-query/README.md`
- `skills/database/create-migration/README.md`
- `skills/backend/implement-pagination-search/README.md`
- `skills/observability/add-metrics/README.md`
- `docs/architecture/05-database-design.md`

**Last updated:** 2026-04-11
