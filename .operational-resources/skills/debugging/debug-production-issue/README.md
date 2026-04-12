# Debug Production Issue (index)

## TL;DR (VI)

- Playbook **sự cố production**: triage → deploy context → health → log/trace → metrics → **mitigation** → post-incident.
- Luôn ưu tiên **giảm thiệt hại** và tuân **policy** (approval, secret, PII).
- Đọc stack mẫu: **`analyze-stacktrace`**; tái hiện an toàn trên local: **`debug-backend-error`** (sau khi redact).

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình incident đầy đủ |
| `examples.md` | Timeline, prompt redacted, mitigation options |
| `checklist.md` | Gate trong và sau incident |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Triage impact/scope; lấy trace/version.
2. Làm theo `SKILL.md` và tick `checklist.md`.
3. Ghi timeline theo `examples.md` vào `notes/` hoặc hệ incident của team.

## Liên kết nhanh

- `skills/debugging/analyze-stacktrace/README.md`
- `skills/debugging/debug-backend-error/README.md`
- `rules/06-security.md`
- `skills/devops/health-check-endpoint/README.md`
- `skills/observability/analyze-application-logs/README.md`
- `skills/observability/implement-request-tracing/SKILL.md`

**Last updated:** 2026-04-09
