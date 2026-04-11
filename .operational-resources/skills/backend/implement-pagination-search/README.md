# Implement Pagination & Search (index)

## TL;DR (VI)

- Playbook API **danh sách** có **page/size/sort** an toàn, **filter/search** qua repository (`Page`, `Specification`, …).
- Bám **`docs/api/07-pagination-filtering.md`** và **`03-response-format.md`**.
- Tránh **N+1** và **sort/filter** không kiểm soát từ query string.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình đầy đủ: Pageable, sort whitelist, query, N+1, response meta, test |
| `examples.md` | Controller, clamp size, Specification, repository |
| `checklist.md` | Quality gate |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Đọc `docs/api/07-pagination-filtering.md` + envelope meta.
2. Làm theo `SKILL.md`; chỉnh index DB nếu search nặng (`optimize-query`).
3. Chạy `checklist.md`.

## Liên kết nhanh

- `docs/api/07-pagination-filtering.md`
- `docs/api/03-response-format.md`
- `skills/backend/create-rest-api/SKILL.md`
- `skills/backend/create-service-layer/SKILL.md`
- `skills/database/optimize-query/SKILL.md`
- `skills/workflow/implement-feature/README.md`

**Last updated:** 2026-04-09
