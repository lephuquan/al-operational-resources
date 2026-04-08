# Database design

## TL;DR (VI)

- Mô tả **engine**, **migration**, **bảng chính** và quy ước (soft delete, audit, index).
- Đây là **mẫu**; khi có schema thật, thay ví dụ `users`/`orders` bằng tên đúng.

**Last updated:** 2026-04-08

## 1. Overview

| Item | Choice (template) |
|------|-------------------|
| Engine | PostgreSQL (example) |
| Access | Spring Data JPA |
| Schema ownership | Application service account with least privilege |
| Migrations | Flyway or Liquibase (pick one) |
| Time zone | Store timestamps in UTC |

## 2. Naming conventions

- Tables: `snake_case`, plural for entity sets (`orders`, `order_items`).
- Primary keys: `id` (UUID or bigserial — team decision).
- Foreign keys: `<referenced_table>_id` unless composite keys are required.

## 3. Cross-cutting columns (typical)

| Column | Purpose |
|--------|---------|
| `created_at` | Audit: creation time |
| `updated_at` | Audit: last change |
| `deleted_at` | Soft delete (nullable); omit if hard delete only |
| `version` | Optimistic locking (optional) |

## 4. Example entities (illustrative — replace with real model)

| Table | Key fields | Notes |
|-------|------------|--------|
| `users` | `id`, `email`, `password_hash`, `role`, `status` | No plain-text passwords |
| `orders` | `id`, `user_id`, `status`, `total_amount`, `currency` | |
| `order_items` | `order_id`, `product_id`, `quantity`, `unit_price` | |
| `payments` | `order_id`, `status`, `provider_ref` | Integrate with PSP |
| `outbox_events` | `id`, `payload`, `published_at` | If using transactional outbox |

## 5. Relationships

- Prefer explicit FKs; define `ON DELETE` behavior per relationship (restrict vs cascade).
- Many-to-many: junction table with its own PK or composite unique constraint.

## 6. Indexing strategy (template)

- Index foreign keys used in joins and filters.
- Unique indexes on natural keys (`users.email`) when required.
- Partial indexes for hot filtered queries (document per feature).

## 7. Constraints

- `CHECK` constraints for enums stored as strings or smallints when helpful.
- **Row-level security** (PostgreSQL): only if product requires; document in ADR.

## 8. Migration workflow

1. Change Java entity or add SQL migration script.
2. Run migrations in CI and locally.
3. Update this document when adding tables or changing critical constraints.

## Related

- JPA entity skill: `skills/backend/create-jpa-entity/`
- API pagination does not replace DB indexes — align list endpoints with indexes (`docs/api/07-pagination-filtering.md`)
