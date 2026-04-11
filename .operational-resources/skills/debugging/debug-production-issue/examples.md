# Examples: Production incident

Mẫu ghi chú nội bộ. Thay thời gian, version, id; **không** dán token hay dữ liệu user thật.

## Timeline ngắn (markdown)

```markdown
## Incident 2026-04-09 — elevated 5xx on `POST /api/v1/orders`

| Time (UTC) | Event |
|------------|--------|
| 14:02 | Error rate 2% → 18% on `order-api` |
| 14:05 | Confirmed deploy `v2.3.4` at 13:55 |
| 14:12 | Rollback to `v2.3.3` — error rate normal |
| 14:30 | Sample trace id `abc...` → `DataIntegrityViolation` duplicate key |

**Mitigation:** rollback  
**Hypothesis:** missing idempotency on retry after timeout  
**Follow-up:** ticket ORD-999 + add integration test + alert on duplicate rate
```

## Mẫu hỏi khi nhờ người/AI (đã redact)

```text
Between 14:00–14:15 UTC, error rate spiked on service order-api v2.3.4.
Sample trace id: <redacted-uuid-shape>.
Symptom: HTTP 500 on POST /api/v1/orders, no request body shared.
Question: what logs/metrics should we check next given Spring Boot + Postgres?
```

## Mitigation options (gợi ý chọn một — theo runbook team)

- Rollback deployment
- Disable feature flag `new-checkout`
- Scale replicas (nếu saturation)
- Open circuit / shed load to dependency X

**Last updated:** 2026-04-09
