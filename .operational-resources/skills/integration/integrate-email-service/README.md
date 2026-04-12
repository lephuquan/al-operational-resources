# Integrate Email Service (index)

## TL;DR (VI)

- Playbook **gửi email**: **port** ở application, adapter **SMTP** hoặc **HTTP API**; **template** + **escape**; **async/queue** khi cần; **không log PII**.
- **Bounce/complaint** → webhook (`implement-webhook-handler`); neo **`docs/architecture/07-integrations.md`**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình port, SMTP/API, template, async, test |
| `examples.md` | `spring.mail`, `JavaMailSender`, gợi ý port |
| `checklist.md` | Gate trước merge |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Điền mục Notification (email) trong `docs/architecture/07-integrations.md`.
2. Chốt SMTP vs HTTP API; cấu hình secret qua `configure-environment`.
3. Làm theo `SKILL.md`; tham chiếu `examples.md`.
4. Chạy `checklist.md`.

## Liên kết nhanh

- `skills/backend/create-service-layer/README.md`
- `skills/devops/configure-environment/README.md`
- `skills/integration/call-external-api/README.md`
- `skills/integration/implement-webhook-handler/README.md`
- `skills/integration/integrate-message-queue/README.md`
- `skills/security/validate-input/README.md`
- `docs/architecture/07-integrations.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
