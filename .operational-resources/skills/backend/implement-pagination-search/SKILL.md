# Skill: Implement Pagination & Search

## Goal

API list có phân trang và lọc/tìm kiếm ổn định; tránh load full bảng.

## Steps

1. Controller nhận `Pageable` (Spring Data) hoặc tham số `page`, `size`, `sort` có validate.
2. Repository: `Page<Entity>` + `Specification` / query DSL / `@Query` với dynamic filters.
3. Tránh N+1: dùng `JOIN FETCH` hoặc `@EntityGraph` khi list kèm quan hệ.
4. Response `meta`: total, page, size, hasNext (theo `docs/api/response-format.md`).
5. Search: chuẩn hóa keyword (trim, escape) và index DB phù hợp.

## References

- `docs/api/api-overview.md` (pagination strategy)
