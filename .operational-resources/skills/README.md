# Skills library (playbooks)

## TL;DR (VI)

- **`skills/`** = playbook **lặp lại** cho AI: Goal → bước → output — không thay `docs/` (chuẩn) hay `rules/` (luật).
- Tạo skill mới: copy **`SKILL-TEMPLATE.md`** → `skills/<nhóm>/<tên>/SKILL.md`, rồi **thêm một dòng** vào bảng mục lục dưới đây.
- Nội dung `SKILL.md` nên **English**; mục TL;DR trong từng file có thể là VI.

**Location:** `.operational-resources/skills/`  
**Read before skills:** `.operational-resources/rules/`, then `.operational-resources/docs/project-overview.md` and `docs/README.md`.

## File layout

| File | Purpose |
|------|---------|
| **`SKILL-TEMPLATE.md`** | Copy this when creating a new skill (required structure). |
| **`<category>/<name>/SKILL.md`** | Required per skill: playbook body. |
| **`checklist.md`** | Optional: PR / verification checklist for high-risk or frequent tasks. |
| **`examples.md`** | Optional: snippets and commands **without secrets**. |
| **`HOW-TO-ADD-TOPIC.md`** | Where code lives vs docs; how to add a skill. |

## Language

- Prefer **English** in `SKILL.md` for stable AI parsing.
- You may keep **Vietnamese** in step examples if tickets are VI-only — stay consistent within one file.

## Catalog

### Backend

**Hub JPA (entity + repo + migration):** [backend/create-jpa-entity/README.md](backend/create-jpa-entity/)  
**Hub REST (controller + DTO + test + docs API):** [backend/create-rest-api/README.md](backend/create-rest-api/)  
**Hub Service (use case + transaction + ports):** [backend/create-service-layer/README.md](backend/create-service-layer/)  
**Hub file upload:** [backend/implement-file-upload/README.md](backend/implement-file-upload/)  
**Hub pagination & search:** [backend/implement-pagination-search/README.md](backend/implement-pagination-search/)

| Skill | Short description |
|-------|-------------------|
| [backend/create-rest-api](backend/create-rest-api/) | REST controller, DTOs, validation, docs API; see folder `README.md` |
| [backend/create-service-layer](backend/create-service-layer/) | Service/use-case, transactions, ports/clients; see folder `README.md` |
| [backend/create-jpa-entity](backend/create-jpa-entity/) | JPA entity, mapping, repository, migration slice; see folder `README.md` |
| [backend/implement-file-upload](backend/implement-file-upload/) | Multipart, storage, validation, security; see folder `README.md` |
| [backend/implement-pagination-search](backend/implement-pagination-search/) | Pageable, Specification, meta; see folder `README.md` |

### Debugging

**Hub stacktrace:** [debugging/analyze-stacktrace/README.md](debugging/analyze-stacktrace/)  
**Hub debug local:** [debugging/debug-backend-error/README.md](debugging/debug-backend-error/)  
**Hub production incident:** [debugging/debug-production-issue/README.md](debugging/debug-production-issue/)

| Skill | Short description |
|-------|-------------------|
| [debugging/analyze-stacktrace](debugging/analyze-stacktrace/) | Read stack traces, Caused by, app frames; see folder `README.md` |
| [debugging/debug-backend-error](debugging/debug-backend-error/) | Reproduce, isolate, fix, regression test (local); see folder `README.md` |
| [debugging/debug-production-issue](debugging/debug-production-issue/) | Prod triage, observability, mitigation, post-incident; see folder `README.md` |

### Architecture

**Hub:** [architecture/README.md](architecture/README.md) — when to use design vs review; links to `docs/architecture/`.

| Skill | Short description |
|-------|-------------------|
| [architecture/design-feature-architecture](architecture/design-feature-architecture/) | Design a module/feature (layers, API, data, ADR) |
| [architecture/review-project-architecture](architecture/review-project-architecture/) | Review repository structure (P0/P1/P2 actions) |

### Code quality

**Hub code review:** [code-quality/review-code/README.md](code-quality/review-code/)  
**Hub detect smells:** [code-quality/detect-code-smells/README.md](code-quality/detect-code-smells/)  
**Hub safe refactor:** [code-quality/refactor-clean-code/README.md](code-quality/refactor-clean-code/)

| Skill | Short description |
|-------|-------------------|
| [code-quality/review-code](code-quality/review-code/) | Structured PR/self-review; see folder `README.md` |
| [code-quality/detect-code-smells](code-quality/detect-code-smells/) | Detect smells with evidence + severity; see folder `README.md` |
| [code-quality/refactor-clean-code](code-quality/refactor-clean-code/) | Safe refactoring, small steps, tests; see folder `README.md` |

### Testing

| Skill | Short description |
|-------|-------------------|
| [testing/write-unit-test](testing/write-unit-test/) | JUnit 5 + Mockito |
| [testing/write-integration-test](testing/write-integration-test/) | Spring Boot integration tests |
| [testing/create-test-data](testing/create-test-data/) | Fixtures, builders |

### Database

**Hub schema design:** [database/design-database-schema/README.md](database/design-database-schema/)  
**Hub migration (Flyway / Liquibase):** [database/create-migration/README.md](database/create-migration/)  
**Hub query performance:** [database/optimize-query/README.md](database/optimize-query/)

| Skill | Short description |
|-------|-------------------|
| [database/design-database-schema](database/design-database-schema/) | Tables, keys, FK, indexes, soft delete; see folder `README.md` |
| [database/optimize-query](database/optimize-query/) | N+1, EXPLAIN, fetch, indexes; see folder `README.md` |
| [database/create-migration](database/create-migration/) | Versioned DDL, test, JPA sync; see folder `README.md` |

### Security

**Hub bảo vệ API:** [security/secure-api-endpoint/README.md](security/secure-api-endpoint/)

| Skill | Short description |
|-------|-------------------|
| [security/secure-api-endpoint](security/secure-api-endpoint/) | Filter chain, authn/authz, CSRF/CORS, testing; see folder `README.md` |
| [security/validate-input](security/validate-input/) | Bean Validation |
| [security/security-review](security/security-review/) | Security review |

### Integration

**Hub outbound HTTP (WebClient / config / resilience):** [integration/call-external-api/README.md](integration/call-external-api/)  
**Hub inbound webhooks (signature, idempotency):** [integration/implement-webhook-handler/README.md](integration/implement-webhook-handler/)  
**Hub email (SMTP / provider, templates):** [integration/integrate-email-service/README.md](integration/integrate-email-service/)  
**Hub message queue (broker, outbox, DLQ):** [integration/integrate-message-queue/README.md](integration/integrate-message-queue/)  
**Hub payment (PSP, webhook, reconcile):** [integration/integrate-payment-gateway/README.md](integration/integrate-payment-gateway/)

| Skill | Short description |
|-------|-------------------|
| [integration/call-external-api](integration/call-external-api/) | WebClient, timeouts, ports, WireMock; see folder `README.md` |
| [integration/integrate-email-service](integration/integrate-email-service/) | Port + SMTP or HTTP API, templates, async; see folder `README.md` |
| [integration/integrate-payment-gateway](integration/integrate-payment-gateway/) | Intent, idempotency, webhook, PCI-aware; see folder `README.md` |
| [integration/implement-webhook-handler](integration/implement-webhook-handler/) | POST callback, HMAC, idempotency, fast ACK; see folder `README.md` |
| [integration/integrate-message-queue](integration/integrate-message-queue/) | Producer/consumer, idempotency, DLQ, outbox; see folder `README.md` |

### Performance

**Hub phân tích slow query (EXPLAIN / evidence):** [performance/analyze-query-performance/README.md](performance/analyze-query-performance/)  
**Hub cache (TTL, evict, stampede):** [performance/caching-strategy/README.md](performance/caching-strategy/)  
**Hub API response (DTO, pagination, payload):** [performance/optimize-api-response/README.md](performance/optimize-api-response/)  
**Hub memory (stream, batch, heap):** [performance/reduce-memory-usage/README.md](performance/reduce-memory-usage/)

| Skill | Short description |
|-------|-------------------|
| [performance/optimize-api-response](performance/optimize-api-response/) | DTO, pagination, projection, measure; see folder `README.md` |
| [performance/caching-strategy](performance/caching-strategy/) | Cache-aside, keys, Redis/Caffeine, invalidation; see folder `README.md` |
| [performance/analyze-query-performance](performance/analyze-query-performance/) | EXPLAIN ANALYZE, plan, pg_stat_statements; see folder `README.md` |
| [performance/reduce-memory-usage](performance/reduce-memory-usage/) | Stream/batch, file streaming, JVM/container; see folder `README.md` |

### Observability

**Hub logging trong code (SLF4J / levels / MDC):** [observability/add-logging/README.md](observability/add-logging/)  
**Hub metrics (Micrometer / Actuator):** [observability/add-metrics/README.md](observability/add-metrics/)  
**Hub đọc log (triage / Loki / ELK):** [observability/analyze-application-logs/README.md](observability/analyze-application-logs/)  
**Hub tracing (W3C / Micrometer / MDC):** [observability/implement-request-tracing/README.md](observability/implement-request-tracing/)

| Skill | Short description |
|-------|-------------------|
| [observability/add-logging](observability/add-logging/) | SLF4J, levels, parameterized messages, MDC; see folder `README.md` |
| [observability/add-metrics](observability/add-metrics/) | Counter, Timer, Gauge, low-cardinality tags; see folder `README.md` |
| [observability/implement-request-tracing](observability/implement-request-tracing/) | Trace context, propagate, async; see folder `README.md` |
| [observability/analyze-application-logs](observability/analyze-application-logs/) | Time range, correlation, grouping, redaction; see folder `README.md` |

### Error handling

**Hub error envelope (JSON):** [error-handling/api-error-response-format/README.md](error-handling/api-error-response-format/)  
**Hub global handler (`@ControllerAdvice`):** [error-handling/global-exception-handler/README.md](error-handling/global-exception-handler/)  
**Hub HTTP mapping (status + `error.code`):** [error-handling/map-exceptions-to-http/README.md](error-handling/map-exceptions-to-http/)

| Skill | Short description |
|-------|-------------------|
| [error-handling/global-exception-handler](error-handling/global-exception-handler/) | `@RestControllerAdvice`, map exception → HTTP + envelope; see folder `README.md` |
| [error-handling/api-error-response-format](error-handling/api-error-response-format/) | Envelope `success`/`error`, codes, details; see folder `README.md` |
| [error-handling/map-exceptions-to-http](error-handling/map-exceptions-to-http/) | Matrix domain → HTTP + stable codes; see folder `README.md` |

### DevOps

**Hub environment (profiles / env / secrets):** [devops/configure-environment/README.md](devops/configure-environment/)  
**Hub logging (Logback / profiles):** [devops/configure-logging/README.md](devops/configure-logging/)  
**Hub Docker (Spring Boot image):** [devops/dockerize-service/README.md](devops/dockerize-service/)  
**Hub health / probes (Actuator):** [devops/health-check-endpoint/README.md](devops/health-check-endpoint/)

| Skill | Short description |
|-------|-------------------|
| [devops/dockerize-service](devops/dockerize-service/) | Multi-stage Dockerfile, non-root, env; see folder `README.md` |
| [devops/configure-environment](devops/configure-environment/) | Spring profiles, env, ConfigurationProperties; see folder `README.md` |
| [devops/configure-logging](devops/configure-logging/) | Logback, levels, rotation, correlation id; see folder `README.md` |
| [devops/health-check-endpoint](devops/health-check-endpoint/) | Actuator health, liveness/readiness, Security; see folder `README.md` |

### Workflow

**Hub triển khai từ task:** [workflow/implement-feature/README.md](workflow/implement-feature/README.md) — slice, prompt AL, checklist, liên kết `PLAYBOOK.md`.

| Skill | Short description |
|-------|-------------------|
| [workflow/implement-feature](workflow/implement-feature/) | Triển khai feature có kiểm soát: task → slice → code → test → docs → MR |
| [workflow/prepare-pull-request](workflow/prepare-pull-request/) | Prepare a pull request |
| [workflow/investigate-bug](workflow/investigate-bug/) | Systematic bug investigation |

## Maintenance

- When adding a skill, follow **`SKILL-TEMPLATE.md`** and register it in the table above.
- When **docs** paths change (`docs/api/NN-*.md`), update **References** inside affected skills.
- Existing skills may still be **short** or **Vietnamese**; migrate gradually toward the template.

**Last updated:** 2026-04-11
