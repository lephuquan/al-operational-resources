# Examples: Migration

Thay version, tên bảng, schema theo dự án. Không chứa secret.

## Flyway — file mới

**Tên file:** `V202604091200__add_orders_status_index.sql`

```sql
-- Add index for list-by-status queries (hot path)
CREATE INDEX idx_orders_status_created_at ON orders (status, created_at DESC);
```

**Expand-then-contract (gợi ý 2 bước)**

*Migration 1 — thêm cột nullable:*

```sql
ALTER TABLE orders ADD COLUMN fulfillment_code VARCHAR(64);
```

*Migration 2 — backfill + NOT NULL (sau khi app đã ghi dữ liệu):*

```sql
UPDATE orders SET fulfillment_code = 'LEGACY' WHERE fulfillment_code IS NULL;
ALTER TABLE orders ALTER COLUMN fulfillment_code SET NOT NULL;
```

## Liquibase — YAML fragment (gợi ý)

```yaml
databaseChangeLog:
  - changeSet:
      id: 20260409-add-orders-status-index
      author: team
      changes:
        - createIndex:
            indexName: idx_orders_status_created_at
            tableName: orders
            columns:
              - column:
                  name: status
              - column:
                  name: created_at
                  descending: true
```

## Ghi chú MR (mẫu)

```markdown
## Migration
- Flyway `V202604091200__add_orders_status_index.sql`
- **Rollback:** forward-only — drop index manual if needed: `DROP INDEX idx_orders_status_created_at;`
- **Tested:** local Postgres 15 + staging 2026-04-09
```

**Last updated:** 2026-04-09
