# Add Logging (index)

## TL;DR (VI)

- Playbook **log trong code**: **SLF4J**, level đúng, message **parameterized**, **không PII/secret**.
- **MDC / correlation** làm chung với **`implement-request-tracing`**; **appenders / level / JSON** thuộc **`configure-logging`**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình logger, level, MDC, exception, performance |
| `examples.md` | Snippet SLF4J, MDC `try/finally` |
| `checklist.md` | Gate trước merge |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Đồng bộ pattern với `skills/devops/configure-logging/README.md` (pattern có `%X{…}` nếu dùng MDC).
2. Bật/tracing: `skills/observability/implement-request-tracing/SKILL.md`.
3. Làm theo `SKILL.md`; tham chiếu `examples.md`.
4. Chạy `checklist.md`.

## Liên kết nhanh

- `skills/devops/configure-logging/README.md`
- `skills/observability/implement-request-tracing/SKILL.md`
- `skills/observability/analyze-application-logs/SKILL.md`
- `skills/backend/create-service-layer/README.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
