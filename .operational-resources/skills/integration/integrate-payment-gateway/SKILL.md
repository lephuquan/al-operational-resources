# Skill: Integrate Payment Gateway

## Goal

Tích hợp cổng thanh toán: idempotency, webhook signature, đối soát trạng thái.

## Steps

1. Lưu `payment_intent_id` / id giao dịch provider; không trùng lặp.
2. Webhook: verify signature; xử lý out-of-order events.
3. Luồng happy path + fallback; không coi “client báo success” là đã thanh toán.
4. PCI: không log full card; dùng tokenization của provider.
5. Test: sandbox provider + replay webhook.

## References

- `skills/integration/implement-webhook-handler/README.md` (endpoint webhook, chữ ký, idempotency)
- `skills/integration/call-external-api/README.md` (gọi API provider / đối soát)
- `rules/06-security.md`

**Last updated:** 2026-04-11
