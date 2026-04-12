# Health Check Endpoint (index)

## TL;DR (VI)

- **Actuator `health`**: cấu hình **exposure**, **`show-details`** an toàn, bật **liveness/readiness** cho K8s khi cần.
- **Spring Security**: mở **`/actuator/health/**`** cho probe (đúng phạm vi) để tránh **401** → container restart loop.
- **`HealthIndicator`** tùy chỉnh: nhanh, không lộ secret/PII.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình Actuator, probe, security, custom health |
| `examples.md` | YAML management, Security permit, probe K8s, indicator mẫu |
| `checklist.md` | Gate trước merge |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Đọc `SKILL.md` và chỉnh `application-*.yml` theo `examples.md`.
2. Nếu có Spring Security: kiểm tra **anonymous** gọi được probe path.
3. Nếu deploy container: đồng bộ path với `skills/devops/dockerize-service/`.
4. Chạy `checklist.md`; ghi probe path + port trong `docs/setup/` hoặc runbook.

## Liên kết nhanh

- `skills/devops/dockerize-service/README.md`
- `skills/devops/configure-environment/README.md`
- `skills/observability/add-metrics/SKILL.md`
- `skills/security/secure-api-endpoint/SKILL.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
