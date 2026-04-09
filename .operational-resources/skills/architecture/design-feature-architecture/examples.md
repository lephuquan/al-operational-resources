# Examples: Feature design notes

Các mẫu phác thảo không chứa secret. Hãy thay tên/ID theo dự án thực tế.

## Example A — Order checkout (mẫu markdown)

```markdown
## Feature: Order checkout

- API: `POST /api/v2/orders` (optional `Idempotency-Key` header)
- Flow: validate cart → reserve stock → create order → emit `OrderCreated`
- Failure: insufficient stock → `ORDER_001`; payment failure → rollback + `PAYMENT_*`
- DB: `orders` + `order_lines`; transaction boundary on `OrderService.create`
```

## Example B — Read-only dashboard aggregate

```markdown
## Feature: Dashboard summary

- API: `GET /api/v1/dashboard/summary` — no writes
- Flow: parallel reads from cached projections; fallback to DB if cache miss
- Failure: upstream timeout → `503` + retry hint; stale cache flagged in response meta
- DB: no new tables; optional materialized view later if NFR requires
```

## Example C — Webhook ingestion (idempotent)

```markdown
## Feature: Payment webhook ingestion

- API: `POST /api/v1/webhooks/payment` with signature header
- Flow: verify signature → deduplicate by eventId → persist event log → update payment state
- Failure:
  - invalid signature → `401`
  - duplicate eventId → `200` (idempotent no-op)
  - transient DB error → retry by provider + internal alert
- DB:
  - `payment_webhook_events(event_id unique, payload_hash, received_at)`
  - index on `(provider, received_at)` for troubleshooting
- Transaction:
  - event log insert + state transition in one boundary when possible
```

## Mẫu output tái sử dụng (dán vào task file)

```markdown
## Design note

### Scope
- In scope:
- Out of scope:

### Boundaries
- Controller:
- Service/Application:
- Domain/Repository:

### API sketch
- Endpoint(s):
- Request validation:
- Response shape:
- Error semantics:

### Data impact
- Schema/migration:
- Index/constraint:

### Cross-cutting
- Security:
- Observability:
- Performance:
- Integrations:

### Risks and mitigations
1. Risk:
   Mitigation:
2. Risk:
   Mitigation:
3. Risk:
   Mitigation:
```

Gợi ý dùng nhanh:
- Với feature đơn giản: dùng Example A/B rồi rút gọn.
- Với flow tích hợp ngoài hệ thống: dùng Example C để tránh quên idempotency/retry.
- Luôn giữ output ngắn gọn nhưng đủ quyết định để chuyển qua implement.

**Last updated:** 2026-04-08
