# Caching Strategy (index)

## TL;DR (VI)

- Playbook **cache**: khi nào cache, **cache-aside**, **key/TTL/evict**, **stampede**, **multi-instance**, bảo mật phạm vi dữ liệu.
- Neo **metrics** và **env config**; tránh dùng cache che **slow query** khi chưa phân tích (`analyze-query-performance` / `optimize-query`).

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình placement, key, Spring Cache, security, test |
| `examples.md` | Key mẫu, `@Cacheable` / evict sketch |
| `checklist.md` | Gate trước merge |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Đo baseline; chốt mức chấp nhận stale.
2. Làm theo `SKILL.md`; security review nếu multi-tenant.
3. Chạy `checklist.md`; ghi ADR khi đổi hành vi người dùng.

## Liên kết nhanh

- `skills/performance/optimize-api-response/README.md`
- `skills/performance/analyze-query-performance/README.md`
- `skills/database/optimize-query/README.md`
- `skills/devops/configure-environment/README.md`
- `skills/observability/add-metrics/README.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
