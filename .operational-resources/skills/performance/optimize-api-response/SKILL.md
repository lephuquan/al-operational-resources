# Skill: Optimize API Response

## TL;DR (VI)

- Giảm **payload** và chi phí **serialize**: **DTO/record** hoặc **projection** — **không** trả **JPA entity** graph (tránh lazy/`@JsonIgnore` che tạm).
- **Pagination / giới hạn field** cho list; **đo** bằng timer/latency (`add-metrics`) trước và sau thay đổi.
- **Cache** chỉ sau khi đã tối ưu shape/pagination hợp lý — **`caching-strategy`**.

## Goal

Make HTTP responses **smaller and faster to produce** without breaking the public contract, using DTOs, pagination, and measured iteration.

## Preconditions

- Contract or OpenAPI slice in **`docs/api/`**; list rules in **`docs/api/07-pagination-filtering.md`** when paginating.
- Baseline: p95 latency or payload size **before** change (even rough).

## Steps

1. **Stop leaking persistence into JSON**
   - Return **DTOs** built in the service or mapped at the boundary — not entities with lazy collections that trigger N+1 or accidental huge graphs.
   - If a field must be omitted, **do not** rely only on `@JsonIgnore` on entities long-term; shape belongs on the DTO.

2. **Trim the JSON shape**
   - Use **`@JsonInclude(JsonInclude.Include.NON_NULL)`** (class or global config) where null fields add noise.
   - Prefer **specific DTOs per endpoint** over one mega-DTO with half the fields null.

3. **Pagination and limits**
   - List endpoints: **`Page`**, **cursor**, or **limit+offset** per team standard — see **`skills/backend/implement-pagination-search/README.md`** and **`docs/api/07-pagination-filtering.md`**.
   - Never unbounded `findAll()` for client-facing APIs.

4. **Reduce over-fetching at source**
   - Prefer **query projections** (JPQL DTO constructor, Spring Data interface projection) when the DB row is wide but the response is narrow.
   - Align with **`skills/database/optimize-query/README.md`** when DB work dominates.

5. **Batch or compound responses (optional)**
   - For “many small calls” anti-patterns, consider **batch endpoints** or **field expansion** only if **`docs/api/`** and versioning allow — avoid ad-hoc fat payloads.

6. **Field selection / GraphQL**
   - **`fields` query param** or **GraphQL** only when the team **owns** the complexity (caching, N+1 on the server, security of introspection).

7. **Serialization tuning**
   - Reuse **`ObjectMapper`** beans; avoid creating mappers per request.
   - Large responses: **gzip** often belongs at **reverse proxy**; if enabled in app, document CPU trade-off.

8. **Measure**
   - **`Timer`** or HTTP server metrics around hot endpoints (`skills/observability/add-metrics/README.md`).
   - Compare **serialized size** (dev/staging) when payload shrink is the goal.

9. **Caching (last resort for wrong shape)**
   - Apply **`skills/performance/caching-strategy/README.md`** only after response shape and DB access are reasonable — cache masks smells.

10. **Contract and docs**
   - Update **`docs/api/`** when response shape, pagination, or optional fields change.

## Output

- DTO/projection changes + controller mapping + tests; optional metric/dashboard note.

## References

- `skills/backend/create-rest-api/README.md`
- `skills/backend/create-jpa-entity/README.md`
- `skills/backend/implement-pagination-search/README.md`
- `skills/database/optimize-query/README.md`
- `skills/performance/caching-strategy/README.md`
- `skills/observability/add-metrics/README.md`
- `docs/api/03-response-format.md`, `docs/api/07-pagination-filtering.md`

**Last updated:** 2026-04-11
