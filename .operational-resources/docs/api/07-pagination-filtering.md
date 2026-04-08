# Pagination, Filtering, Sorting

## Query parameter convention

- Pagination cursor-first: `?cursor=<token>&limit=20`
- Offset fallback: `?page=1&size=20`
- Sorting: `?sort=createdAt,desc`
- Filtering: `?status=PAID&customerId=123`
- Search keyword: `?q=abc`

## Rules

- `limit` toi da do team quy dinh (vi du 100).
- Neu co `cursor` thi uu tien cursor mode; bo qua `page`.
- Sort field phai whitelist de tranh SQL injection theo ten cot.
- Filter key dat ten theo field nghiep vu, khong dat ten mo ho.

## Response meta

Tra ve trong `meta`: `total` (neu co), `page`/`size` hoac `cursor`, `hasNext`.
