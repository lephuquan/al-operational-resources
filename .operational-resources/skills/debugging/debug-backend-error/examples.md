# Examples: Debug local

Mẫu ghi chú và reproduce. Thay URL/path; redact token.

## Ghi chú bug (markdown)

```markdown
## Local bug: 500 on POST /api/v1/orders

**Branch:** feature/xyz @ abc1234  
**Profile:** local  
**Symptom:** 500, body `INTERNAL_ERROR`  
**Stack root:** `DataIntegrityViolationException` — duplicate `uq_orders_reference`

### Reproduce
```bash
curl -sS -X POST "http://localhost:8080/api/v1/orders" \
  -H "Content-Type: application/json" \
  -d '{"reference":"DUP-1","customerId":"c1","lines":[]}'
```
(Lần 2 với cùng `reference` → 500)

### Fix direction
- App-level idempotency or return 409 Conflict with stable error code
- Regression: integration test two creates same reference → expect 409
```

## Log DEBUG tạm (`application-local.yml` — không commit nếu team cấm)

```yaml
logging:
  level:
    com.example.order: DEBUG
    org.hibernate.SQL: DEBUG
    org.hibernate.orm.jdbc.bind: TRACE
```

**Last updated:** 2026-04-09
