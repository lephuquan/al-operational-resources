# Implement Request Tracing (index)

## TL;DR (VI)

- Playbook **distributed tracing**: **W3C / B3**, **Micrometer Tracing**, **MDC → Logback**, propagate **WebClient** và **message headers**.
- Neo **`configure-logging`** (pattern `%X{traceId}`); đọc log theo trace → **`analyze-application-logs`**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình inbound, MDC, outbound, async, messaging, verify |
| `examples.md` | YAML gợi ý, WebClient + observation |
| `checklist.md` | Gate trước merge |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Chốt header với team platform (gateway / mesh).
2. Bật Micrometer Tracing + chỉnh Logback theo `configure-logging`.
3. Làm theo `SKILL.md`; kiểm tra propagate với `examples.md`.
4. Chạy `checklist.md`.

## Liên kết nhanh

- `skills/devops/configure-logging/README.md`
- `skills/observability/add-logging/README.md`
- `skills/observability/add-metrics/README.md`
- `skills/observability/analyze-application-logs/README.md`
- `skills/integration/call-external-api/README.md`
- `skills/integration/integrate-message-queue/README.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
