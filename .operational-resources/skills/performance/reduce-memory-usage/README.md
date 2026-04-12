# Reduce Memory Usage (index)

## TL;DR (VI)

- Playbook **giảm heap / allocation**: không **load all**, **stream/batch**, file **streaming**, cache có **giới hạn**, JVM/container **có chừng**.
- Neo **`optimize-api-response`** (payload), **`optimize-query`** (query), **`dockerize-service`** (heap).

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình tìm allocator, stream, file, cache, JVM, verify |
| `examples.md` | Gợi ý batch, stream, `InputStream` |
| `checklist.md` | Gate trước merge |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Xác nhận triệu chứng (OOM, GC, metric) trên staging hoặc prod có kiểm soát.
2. Làm theo `SKILL.md`; đo lại sau thay đổi.
3. Chạy `checklist.md`.

## Liên kết nhanh

- `skills/performance/optimize-api-response/README.md`
- `skills/backend/implement-pagination-search/README.md`
- `skills/database/optimize-query/README.md`
- `skills/backend/implement-file-upload/README.md`
- `skills/performance/caching-strategy/README.md`
- `skills/devops/dockerize-service/README.md`
- `skills/observability/add-metrics/README.md`

**Last updated:** 2026-04-11
