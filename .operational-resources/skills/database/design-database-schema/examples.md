# Examples: Thiết kế schema

Mẫu ghi chú và ERD dạng text. Không chứa dữ liệu thật.

## Ghi chú quan hệ (markdown)

```markdown
## Orders domain

- **orders** 1 — N **order_lines**
- **orders** N — 1 **customers** (FK `customer_id`)
- Business rule: `orders.reference` unique per tenant (composite unique `(tenant_id, reference)`)
```

## Bảng tóm tắt (sketch)

| Table | PK | Important columns | Indexes | Notes |
|-------|----|-------------------|---------|-------|
| orders | `id` BIGSERIAL | `tenant_id`, `reference`, `status`, `created_at` | `(tenant_id, status, created_at DESC)` | soft delete `deleted_at` |
| order_lines | `id` BIGSERIAL | `order_id`, `product_id`, `qty` | `(order_id)` | FK CASCADE delete lines with order |

## Partial unique (PostgreSQL — ý tưởng)

```sql
-- Chỉ unique reference khi chưa xóa mềm
CREATE UNIQUE INDEX uq_orders_tenant_reference_active
  ON orders (tenant_id, reference)
  WHERE deleted_at IS NULL;
```

## Ghi chú handoff migration (mẫu)

```markdown
## Planned migrations
1. `V...__create_orders_and_lines.sql` — tables + FK
2. `V...__add_orders_status_index.sql` — index hot path (có thể CONCURRENTLY trên prod)
```

**Last updated:** 2026-04-09
