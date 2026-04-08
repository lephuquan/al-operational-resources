# External integrations (template)

## TL;DR (VI)

- Liệt kê **hệ thống ngoài** (thanh toán, email, queue): protocol, hướng gọi, **không** ghi secret.
- Mỗi dòng có thể mở rộng thành ADR nếu quyết định lớn.

**Last updated:** 2026-04-08

## How to use

Add one subsection per integration. Replace placeholders with project-specific names. Store credentials in env/vault — never in this file.

---

## Integration: Payment service provider

| Field | Value |
|-------|--------|
| Direction | Outbound REST + inbound webhooks |
| Protocol | HTTPS |
| Auth | API key in header (name: `X-Api-Key`) — value from env |
| Idempotency | Required for charge requests — key header `Idempotency-Key` |
| Failure modes | Timeouts, 429, provider maintenance — map to `docs/api/05-error-handling.md` |
| Resilience | Retries only on idempotent reads; circuit breaker for calls |

---

## Integration: Notification (email)

| Field | Value |
|-------|--------|
| Direction | Outbound (SMTP or provider HTTP API) |
| Protocol | SMTP / HTTPS |
| Templates | Stored in repo or provider — document location |

---

## Integration: Message broker (optional)

| Field | Value |
|-------|--------|
| Product | RabbitMQ / Kafka / … |
| Usage | Domain events, async notifications |
| Naming | Exchange/topic naming convention: `domain.event.v1` (example) |

---

## Integration: Object storage (optional)

| Field | Value |
|-------|--------|
| Product | S3-compatible |
| Usage | User uploads, reports |
| Access | Pre-signed URLs or server-side streaming — document threat model |

## Related

- HTTP contract exposed to clients: `docs/api/`
- Transactions and outbox: `08-transactions-and-consistency.md`
