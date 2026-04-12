# Analyze Query Performance (index)

## TL;DR (VI)

- Playbook **phân tích** slow query: thu thập câu lệnh → **`EXPLAIN ANALYZE`** (Postgres) → đọc plan → tài liệu hoá bằng chứng.
- **Sửa** schema/JPA/pagination sau khi chẩn đoán — xem **`database/optimize-query`** và **`create-migration`**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình capture, EXPLAIN, red flags, stats, handoff |
| `examples.md` | Lệnh EXPLAIN mẫu, gợi ý đọc plan |
| `checklist.md` | Gate trước khi kết luận |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Chốt ngưỡng “chậm” và môi trường reproduce.
2. Làm theo `SKILL.md`; lưu plan đã redact.
3. Chuyển sang `optimize-query` hoặc migration khi đã có giả thuyết có bằng chứng.
4. Chạy `checklist.md`.

## Liên kết nhanh

- `skills/database/optimize-query/README.md`
- `skills/database/create-migration/README.md`
- `skills/backend/implement-pagination-search/README.md`
- `skills/observability/add-metrics/README.md`
- `docs/architecture/05-database-design.md`

**Last updated:** 2026-04-11
