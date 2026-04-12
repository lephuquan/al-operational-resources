# Implement Webhook Handler (index)

## TL;DR (VI)

- Playbook **HTTP inbound** từ bên thứ ba: **verify chữ ký** trên **raw body**, **idempotency** theo event id, **2xx** nhanh, xử lý nặng **async/queue**.
- Neo **`docs/architecture/07-integrations.md`**; bảo mật path webhook trong **Spring Security**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình route, verify, idempotency, response, test |
| `examples.md` | Controller raw body, HMAC verify sketch, idempotency insert |
| `checklist.md` | Gate trước merge |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Đọc tài liệu provider + cập nhật `docs/architecture/07-integrations.md`.
2. Chốt **secret** và tên header qua `configure-environment`; không commit secret.
3. Làm theo `SKILL.md`; tham chiếu `examples.md`.
4. Chạy `checklist.md`.

## Liên kết nhanh

- `skills/integration/integrate-payment-gateway/README.md` (thanh toán: intent + đối soát)
- `skills/integration/integrate-email-service/README.md` (bounce/complaint → cập nhật suppression)
- `skills/integration/integrate-message-queue/README.md` (đẩy event sau ACK nhanh)
- `skills/integration/call-external-api/README.md`
- `skills/observability/implement-request-tracing/README.md`
- `skills/backend/create-rest-api/README.md`
- `skills/devops/configure-environment/README.md`
- `skills/security/secure-api-endpoint/README.md`
- `skills/error-handling/map-exceptions-to-http/README.md`
- `docs/architecture/07-integrations.md`, `docs/architecture/08-transactions-and-consistency.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
