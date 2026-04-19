# Skill: Reduce Memory Usage

## TL;DR (VI)

- Tránh **materialize** danh sách/file lớn trong heap: **pagination**, **batch/stream** (JDBC/JPA **`Stream`** / **`Query.scroll`**), **chunk processing**.
- File và HTTP body: **`InputStream`** / **chunked**; không đọc **toàn bộ `byte[]`** khi kích thước không giới hạn.
- **Container/JVM**: giới hạn heap hợp lý (`MaxRAMPercentage`), quan sát **heap/GC** (`add-metrics`); heap dump **prod** chỉ khi incident có quy trình.

## Goal

Lower **heap footprint** and **allocation churn** so services stay stable under load without hiding correctness bugs behind bigger machines.

## Preconditions

- Evidence of pressure: **OOMKilled**, high **GC time**, **heap** dashboards, or profiler (async-profiler, JFR) in staging.
- Known **worst-case input size** (rows, file MB, message batch).

## Steps

1. **Find the allocator**
   - Identify paths that build **`List` of millions**, **giant `String`**, or **whole-file `byte[]`**.
   - Use heap histogram / allocation profiling in **staging** before guessing.

2. **Data access: never unbounded `findAll()`**
   - Use **`Page`**, **keyset**, or **`Stream<T>`** with **`@Transactional(readOnly=true)`** and explicit **`close()`** / try-with-resources for JPA streams.
   - Prefer **batch size** (`fetchSize` for JDBC) for bulk export jobs.

3. **Process in chunks**
   - For ETL/reporting: read **N rows**, process, **clear** references, repeat — avoid one flat `ArrayList` of all IDs.

4. **Files and uploads**
   - Stream to storage or disk; cap size at API boundary — **`skills/backend/implement-file-upload/README.md`**.
   - When transforming, use **bounded buffers** or piped streams.

5. **HTTP clients and responses**
   - Do not buffer unbounded response bodies in memory; use **streaming** APIs on `WebClient`/`RestTemplate` when the provider allows.
   - Large JSON out: **pagination** / smaller DTOs — **`skills/performance/optimize-api-response/README.md`**.

6. **Strings and serialization**
   - Avoid repeated **`String` concat** in hot loops; use **`StringBuilder`** or templates.
   - Beware **logging huge payloads** at INFO (memory + I/O).

7. **Caches**
   - Unbounded local caches **grow heap**; use **size-bound** eviction (Caffeine `maximumWeight`) and TTL — **`skills/performance/caching-strategy/README.md`**.

8. **Object churn**
   - Reduce short-lived allocations in hot paths (reuse buffers where safe, avoid autoboxing in tight loops) after profiling proves it matters.

9. **JVM and container**
   - Set **heap** and **direct memory** consciously; **`JAVA_OPTS`** / **`MaxRAMPercentage`** documented in **`skills/devops/dockerize-service/README.md`** and `docs/setup/`.
   - Align **pod memory limit** > heap + metaspace + native + headroom.

10. **Observe**
   - Expose **JVM memory** and GC metrics (`skills/observability/add-metrics/README.md`); alert on **sustained** high old-gen after full GC.

11. **Heap dumps (production)**
   - Only with **approval** and **PII policy**; transfer securely; analyze with **Eclipse MAT** / similar offline.

12. **Verify**
   - Load test or replay with **worst-case** volume; compare **heap max**, **GC pause**, and **throughput** before/after.

## Output

- Code changes (streaming/batch/pagination) + config notes; optional runbook snippet for dumps and limits.

## References

- `skills/performance/optimize-api-response/README.md`
- `skills/backend/implement-pagination-search/README.md`
- `skills/database/optimize-query/README.md`
- `skills/backend/implement-file-upload/README.md`
- `skills/performance/caching-strategy/README.md`
- `skills/devops/dockerize-service/README.md`
- `skills/devops/configure-environment/README.md`
- `skills/observability/add-metrics/README.md`
- `docs/architecture/08-transactions-and-consistency.md` (tránh transaction ôm toàn bộ batch không cần thiết)

**Last updated:** 2026-04-11
