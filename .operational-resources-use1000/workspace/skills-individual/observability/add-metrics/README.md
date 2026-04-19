# Add Metrics (index)

## TL;DR (VI)

- Playbook **Micrometer**: **Counter / Timer / Gauge**, tag **ít cardinality**, Actuator **Prometheus** (khi dùng).
- Neo **bảo mật `/actuator`** với `health-check-endpoint`; kết hợp **log + trace** khi hạ tầng cho phép.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình registry, loại meter, cardinality, test |
| `examples.md` | Counter, Timer, YAML exposure |
| `checklist.md` | Gate trước merge |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Chốt backend (Prometheus, …) và naming convention.
2. Bật Actuator/registry theo `SKILL.md`; kiểm tra security endpoint.
3. Thêm meter tùy chỉnh; chạy `checklist.md`.

## Liên kết nhanh

- `skills/devops/health-check-endpoint/README.md`
- `skills/observability/add-logging/README.md`
- `skills/observability/analyze-application-logs/README.md`
- `skills/observability/implement-request-tracing/README.md`
- `skills/devops/configure-environment/README.md`

**Last updated:** 2026-04-11
