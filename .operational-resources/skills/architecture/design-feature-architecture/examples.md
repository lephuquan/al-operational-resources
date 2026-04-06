# Examples: Feature Design Notes

```markdown
## Feature: Order checkout

- API: POST /api/v2/orders (idempotent-Key header?)
- Flow: validate cart → reserve stock → create order → emit OrderCreated
- Failure: insufficient stock → ORDER_001; payment fail → rollback + PAYMENT_*
- DB: orders + order_lines; transaction on service.create
```
