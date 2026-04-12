# Skill: Caching Strategy

## TL;DR (VI)

- Chỉ cache khi có **bằng chứng** (read-heavy, chi phí tính toán/DB cao) và chấp nhận **eventual consistency** hoặc có **invalidation** rõ.
- Ưu tiên **cache-aside** (ứng dụng đọc/ghi cache) trừ khi team chọn read/write-through; **key** có **namespace + version**; **TTL** + **evict** khi dữ liệu gốc đổi.
- Tránh **thundering herd** (singleflight / lock / TTL jitter); **không** cache dữ liệu nhạy cảm sai **phạm vi** (thiếu tenant/user trong key khi cần).

## Goal

Introduce **safe, observable** caching (in-process or distributed) with clear invalidation rules and documented consistency trade-offs.

## Preconditions

- Baseline metrics or profiling showing **hot path** worth caching.
- Decision record (task/ADR) if behavior visible to users changes (`skills/architecture/design-feature-architecture/README.md`).

## Steps

1. **Classify the data**
   - **Read-heavy** vs write-heavy; **staleness** tolerance (seconds vs minutes vs “must be fresh”).
   - **Scope:** global, per-tenant, per-user — must be reflected in **cache key** and **security** review.

2. **Choose placement**

   | Layer | Typical use |
   |-------|-------------|
   | **In-process** (Caffeine, etc.) | Local repeat reads, low latency; invalidation harder across instances |
   | **Distributed** (Redis) | Shared across pods; network latency; good for sessions/catalogs |
   | **HTTP** (`Cache-Control`) | CDN/browser; separate from server-side cache — document in API docs |

3. **Key design**
   - Pattern: `app:{domain}:{version}:{tenantId}:{entityId}` (example) — **version** bumps when serialization shape changes.
   - Avoid unbounded key cardinality (e.g. raw search query strings) unless hashed and bounded.

4. **Pattern: cache-aside**
   - Read: miss → load from source → set with TTL.
   - Write: update source → **evict** or **update** cache explicitly; prefer **evict** when in doubt.

5. **TTL and invalidation**
   - **TTL** as safety net; **explicit `@CacheEvict` / delete** on mutations that must hide stale data quickly.
   - On multi-instance: use **shared** store or **pub/sub** eviction (Redis channels) if local caches must stay coherent.

6. **Thundering herd**
   - For hot keys: **single-flight** (one loader per key), **probabilistic early refresh**, or **stale-while-revalidate** pattern where supported.

7. **Spring Cache (typical)**
   - `@Cacheable`, `@CachePut`, `@CacheEvict` on **service** layer; configure **`CacheManager`** + Redis/Caffeine via properties.
   - **SpEL** keys: keep simple and testable; avoid heavy logic in annotations.

8. **Security**
   - Do not cache **cross-tenant** data under a key missing tenant id.
   - Do not log **cache values** containing PII in prod (`rules/06-security.md`).

9. **Observability**
   - Expose **hit/miss** or timer around load path (`skills/observability/add-metrics/README.md`); alert on **miss storms** after deploy.

10. **Configuration**
   - Redis URL, TTL defaults via **`skills/devops/configure-environment/README.md`**; no secrets in repo.

11. **Testing**
   - Tests for **cache hit** after second call; **eviction** after update; **concurrent** miss behavior if critical.

12. **Documentation**
   - ADR or `docs/` note: what is cached, TTL, invalidation triggers, and known **staleness** window.

## Output

- Cache configuration + annotated methods or explicit cache service + tests.
   - Short design note / ADR when behavior changes.

## References

- `skills/performance/optimize-api-response/README.md`
- `skills/database/optimize-query/README.md`
- `skills/devops/configure-environment/README.md`
- `skills/observability/add-metrics/README.md`
- `skills/integration/integrate-message-queue/README.md` (optional event-driven invalidation)
- `skills/architecture/design-feature-architecture/README.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
