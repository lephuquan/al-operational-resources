# Integrate Payment Gateway (index)

## TL;DR (VI)

- Playbook **PSP**: port + adapter **HTTP**, **ghi DB** trạng thái, **webhook** có chữ ký + idempotency, **đối soát** API; **không** tin client-only success.
- **PCI** tối thiểu: token/hosted checkout; map lỗi qua **`map-exceptions-to-http`** và **`05-error-handling.md`**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình intent, idempotency, webhook, reconcile, PCI, test |
| `examples.md` | Bảng trạng thái, idempotency key, webhook flow |
| `checklist.md` | Gate trước merge |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Điền mục **Payment service provider** trong `docs/architecture/07-integrations.md`.
2. Chốt **error.code** / HTTP cho decline và lỗi provider.
3. Làm outbound adapter (`call-external-api`) + webhook (`implement-webhook-handler`) theo `SKILL.md`.
4. Chạy `checklist.md`.

## Liên kết nhanh

- `skills/integration/call-external-api/README.md`
- `skills/integration/implement-webhook-handler/README.md`
- `skills/backend/create-service-layer/README.md`
- `skills/devops/configure-environment/README.md`
- `skills/error-handling/map-exceptions-to-http/README.md`
- `skills/security/security-review/SKILL.md`
- `docs/architecture/07-integrations.md`, `docs/architecture/08-transactions-and-consistency.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
