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

| Skill | Short description |
|-------|-------------------|
| [backend/create-rest-api](backend/create-rest-api/) | REST controller, DTOs, validation |
| [backend/create-service-layer](backend/create-service-layer/) | Service layer, transactions, ports |
| [backend/create-jpa-entity](backend/create-jpa-entity/) | Entity, mapping, repository |
| [backend/implement-file-upload](backend/implement-file-upload/) | Multipart, storage, validation |
| [backend/implement-pagination-search](backend/implement-pagination-search/) | Pageable, spec/filter |

### Debugging

| Skill | Short description |
|-------|-------------------|
| [debugging/analyze-stacktrace](debugging/analyze-stacktrace/) | Read Java/Spring stack traces |
| [debugging/debug-backend-error](debugging/debug-backend-error/) | Debug local backend errors |
| [debugging/debug-production-issue](debugging/debug-production-issue/) | Production incidents, logs, rollback |

### Architecture

**Hub:** [architecture/README.md](architecture/README.md) — when to use design vs review; links to `docs/architecture/`.

| Skill | Short description |
|-------|-------------------|
| [architecture/design-feature-architecture](architecture/design-feature-architecture/) | Design a module/feature (layers, API, data, ADR) |
| [architecture/review-project-architecture](architecture/review-project-architecture/) | Review repository structure (P0/P1/P2 actions) |

### Code quality

| Skill | Short description |
|-------|-------------------|
| [code-quality/review-code](code-quality/review-code/) | Code review checklist |
| [code-quality/detect-code-smells](code-quality/detect-code-smells/) | Detect code smells |
| [code-quality/refactor-clean-code](code-quality/refactor-clean-code/) | Safe refactoring |

### Testing

| Skill | Short description |
|-------|-------------------|
| [testing/write-unit-test](testing/write-unit-test/) | JUnit 5 + Mockito |
| [testing/write-integration-test](testing/write-integration-test/) | Spring Boot integration tests |
| [testing/create-test-data](testing/create-test-data/) | Fixtures, builders |

### Database

| Skill | Short description |
|-------|-------------------|
| [database/design-database-schema](database/design-database-schema/) | Schema design |
| [database/optimize-query](database/optimize-query/) | N+1, indexes |
| [database/create-migration](database/create-migration/) | Flyway / Liquibase |

### Security

| Skill | Short description |
|-------|-------------------|
| [security/secure-api-endpoint](security/secure-api-endpoint/) | Spring Security |
| [security/validate-input](security/validate-input/) | Bean Validation |
| [security/security-review](security/security-review/) | Security review |

### Integration

| Skill | Short description |
|-------|-------------------|
| [integration/call-external-api](integration/call-external-api/) | RestTemplate / WebClient |
| [integration/integrate-email-service](integration/integrate-email-service/) | Email |
| [integration/integrate-payment-gateway](integration/integrate-payment-gateway/) | Payment providers |
| [integration/implement-webhook-handler](integration/implement-webhook-handler/) | Webhooks |
| [integration/integrate-message-queue](integration/integrate-message-queue/) | Message queues |

### Performance

| Skill | Short description |
|-------|-------------------|
| [performance/optimize-api-response](performance/optimize-api-response/) | DTOs, batching |
| [performance/caching-strategy](performance/caching-strategy/) | Caching |
| [performance/analyze-query-performance](performance/analyze-query-performance/) | Explain plans, slow queries |
| [performance/reduce-memory-usage](performance/reduce-memory-usage/) | Streams, batching |

### Observability

| Skill | Short description |
|-------|-------------------|
| [observability/add-logging](observability/add-logging/) | SLF4J, structured logs |
| [observability/add-metrics](observability/add-metrics/) | Micrometer |
| [observability/implement-request-tracing](observability/implement-request-tracing/) | Trace / correlation IDs |
| [observability/analyze-application-logs](observability/analyze-application-logs/) | Log analysis |

### Error handling

| Skill | Short description |
|-------|-------------------|
| [error-handling/global-exception-handler](error-handling/global-exception-handler/) | `@ControllerAdvice` |
| [error-handling/api-error-response-format](error-handling/api-error-response-format/) | Error envelope |
| [error-handling/map-exceptions-to-http](error-handling/map-exceptions-to-http/) | Map exceptions to HTTP |

### DevOps

| Skill | Short description |
|-------|-------------------|
| [devops/dockerize-service](devops/dockerize-service/) | Dockerfile |
| [devops/configure-environment](devops/configure-environment/) | Profiles / env |
| [devops/configure-logging](devops/configure-logging/) | Logback |
| [devops/health-check-endpoint](devops/health-check-endpoint/) | Actuator health |

### Workflow

| Skill | Short description |
|-------|-------------------|
| [workflow/implement-feature](workflow/implement-feature/) | End-to-end feature delivery |
| [workflow/prepare-pull-request](workflow/prepare-pull-request/) | Prepare a pull request |
| [workflow/investigate-bug](workflow/investigate-bug/) | Systematic bug investigation |

## Maintenance

- When adding a skill, follow **`SKILL-TEMPLATE.md`** and register it in the table above.
- When **docs** paths change (`docs/api/NN-*.md`), update **References** inside affected skills.
- Existing skills may still be **short** or **Vietnamese**; migrate gradually toward the template.

**Last updated:** 2026-04-08
