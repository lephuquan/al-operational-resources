# Transactions and consistency

## TL;DR (VI)

- Mặc định: **`@Transactional` trên application service** cho một use case ghi DB.
- Tích hợp async: cân nhắc **outbox** hoặc message sau khi commit; tránh gọi HTTP trong transaction dài.

**Last updated:** 2026-04-08

## 1. Transaction boundaries

| Rule | Guidance |
|------|------------|
| Default | One transaction per application use case that mutates state |
| Read-only | Mark read-only transactions where possible (`@Transactional(readOnly = true)`) |
| Propagation | Use `REQUIRES_NEW` sparingly for isolated side effects; document why |
| Rollback | Unchecked exceptions roll back by default; be explicit for checked exceptions if needed |

## 2. Cross-aggregate consistency

- **Single database:** prefer single transaction when changes must commit together.
- **Multiple systems:** prefer **eventual consistency**: local commit + reliable message (outbox) or idempotent consumers.

## 3. Idempotency (service layer)

- Align with HTTP idempotency keys in `docs/api/02-api-overview.md` when exposing APIs.
- For background jobs, use deduplication keys or natural unique constraints.

## 4. Optimistic locking

- Use `version` column or ETag flow documented in API when concurrent updates are possible.
- On conflict, return **409** with stable error code (`docs/api/05-error-handling.md`).

## 5. Anti-patterns

- Long transactions including calls to slow external APIs.
- Silent partial failure across services without compensating action or clear error surface.

## Related

- Database: `05-database-design.md`
- Integrations: `07-integrations.md`
