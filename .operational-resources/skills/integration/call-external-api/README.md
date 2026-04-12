# Call External API (index)

## TL;DR (VI)

- Playbook **gọi HTTP ra ngoài**: **`WebClient`** (ưu tiên), config qua **`@ConfigurationProperties`**, **timeout** + **giới hạn body**, map lỗi → domain / **502–503**.
- Neo **`docs/architecture/07-integrations.md`**; client nằm **infrastructure**, service chỉ thấy **port**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình client, auth, resilience, test, docs |
| `examples.md` | YAML/bean `WebClient`, WireMock, timeout |
| `checklist.md` | Gate trước merge |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Ghi (hoặc cập nhật) một dòng integration trong `docs/architecture/07-integrations.md`.
2. Định nghĩa **port** trong application layer; implement adapter theo `SKILL.md`.
3. Chốt mapping lỗi với `skills/error-handling/map-exceptions-to-http/README.md`.
4. Chạy `checklist.md`.

## Liên kết nhanh

- `skills/integration/integrate-payment-gateway/README.md` (PSP outbound + reconcile)
- `skills/integration/implement-webhook-handler/README.md` (callback ngược từ provider)
- `skills/backend/create-service-layer/README.md`
- `skills/devops/configure-environment/README.md`
- `skills/error-handling/map-exceptions-to-http/README.md`
- `skills/observability/implement-request-tracing/SKILL.md`
- `docs/architecture/07-integrations.md`, `docs/architecture/08-transactions-and-consistency.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
