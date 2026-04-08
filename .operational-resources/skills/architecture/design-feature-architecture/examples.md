# Examples: Feature design notes

Non-secret sketches. Replace names and IDs with project-specific values.

## Example A — Order checkout (markdown snippet)

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

**Last updated:** 2026-04-08
