# Analyze Application Logs (index)

## TL;DR (VI)

- Playbook **đọc log vận hành**: khung giờ → service → level → **correlation/trace** → gom pattern → đối chiếu deploy/metric.
- Neo **format log** (`configure-logging`, `add-logging`); incident sâu → **`debug-production-issue`**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình triage, grep, Loki/ELK ý niệm, bảo mật ticket |
| `examples.md` | Query/grep mẫu, redaction |
| `checklist.md` | Gate khi kết luận từ log |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Biết nơi log (file, Loki, ELK, cloud) và tên field trace.
2. Làm theo `SKILL.md`; tham chiếu `examples.md`.
3. Chạy `checklist.md` trước khi chốt root cause chỉ từ log.

## Liên kết nhanh

- `skills/observability/add-logging/README.md`
- `skills/observability/add-metrics/README.md`
- `skills/observability/implement-request-tracing/README.md`
- `skills/devops/configure-logging/README.md`
- `skills/debugging/debug-production-issue/README.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
