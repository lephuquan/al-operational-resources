# Skill: Optimize Query

## Goal

Giảm N+1, slow query, và full scan không cần thiết trên JPA.

## Steps

1. Bật log SQL tạm (`show-sql`, `format_sql`) hoặc datasource-proxy (dev).
2. Xác định N+1: `JOIN FETCH` / `@EntityGraph` / batch size.
3. `EXPLAIN ANALYZE` trên PostgreSQL cho query nặng.
4. Pagination: luôn limit; tránh `findAll` lớn.
5. Cache chỉ khi có cơ chế invalidate rõ.

## References

- `docs/knowledge-base/coding-patterns.md`
