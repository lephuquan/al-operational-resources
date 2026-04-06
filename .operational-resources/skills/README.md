# Personal Skills Library

Thư mục này chứa **skill** (quy trình có thể lặp lại) cho AI-assisted coding. Mỗi skill là một “playbook” ngắn: mục tiêu → bước → kiểm tra.

**Vị trí:** `.operational-resources/skills/`  
**Tham chiếu chung:** `.operational-resources/docs/`, `.operational-resources/rules/`

## Quy ước file

- `SKILL.md` — bắt buộc: mục tiêu, điều kiện, các bước, output mong đợi.
- `checklist.md` — tùy chọn: checklist thực thi / PR.
- `examples.md` — tùy chọn: ví dụ Spring Boot / snippet.

## Mục lục

### Backend

| Skill | Mô tả ngắn |
|-------|------------|
| [backend/create-rest-api](backend/create-rest-api/) | REST controller + DTO + validation |
| [backend/create-service-layer](backend/create-service-layer/) | Service, transaction, ports |
| [backend/create-jpa-entity](backend/create-jpa-entity/) | Entity, mapping, repository |
| [backend/implement-file-upload](backend/implement-file-upload/) | Multipart, storage, validation |
| [backend/implement-pagination-search](backend/implement-pagination-search/) | Pageable, spec/filter |

### Debugging

| Skill | Mô tả |
|-------|--------|
| [debugging/analyze-stacktrace](debugging/analyze-stacktrace/) | Đọc stack trace Java/Spring |
| [debugging/debug-backend-error](debugging/debug-backend-error/) | Debug lỗi local |
| [debugging/debug-production-issue](debugging/debug-production-issue/) | Incident prod, log, rollback |

### Architecture

| Skill | Mô tả |
|-------|--------|
| [architecture/design-feature-architecture](architecture/design-feature-architecture/) | Thiết kế module/feature |
| [architecture/review-project-architecture](architecture/review-project-architecture/) | Review cấu trúc dự án |

### Code quality

| Skill | Mô tả |
|-------|--------|
| [code-quality/review-code](code-quality/review-code/) | Review checklist |
| [code-quality/detect-code-smells](code-quality/detect-code-smells/) | Nhận diện smell |
| [code-quality/refactor-clean-code](code-quality/refactor-clean-code/) | Refactor an toàn |

### Testing

| Skill | Mô tả |
|-------|--------|
| [testing/write-unit-test](testing/write-unit-test/) | JUnit 5 + Mockito |
| [testing/write-integration-test](testing/write-integration-test/) | Spring Boot Test |
| [testing/create-test-data](testing/create-test-data/) | Fixtures, builders |

### Database

| Skill | Mô tả |
|-------|--------|
| [database/design-database-schema](database/design-database-schema/) | Thiết kế schema |
| [database/optimize-query](database/optimize-query/) | N+1, index |
| [database/create-migration](database/create-migration/) | Flyway/Liquibase |

### Security

| Skill | Mô tả |
|-------|--------|
| [security/secure-api-endpoint](security/secure-api-endpoint/) | Spring Security |
| [security/validate-input](security/validate-input/) | Bean Validation |
| [security/security-review](security/security-review/) | Review bảo mật |

### Integration

| Skill | Mô tả |
|-------|--------|
| [integration/call-external-api](integration/call-external-api/) | RestTemplate/WebClient |
| [integration/integrate-email-service](integration/integrate-email-service/) | Email |
| [integration/integrate-payment-gateway](integration/integrate-payment-gateway/) | Payment |
| [integration/implement-webhook-handler](integration/implement-webhook-handler/) | Webhook |
| [integration/integrate-message-queue](integration/integrate-message-queue/) | Queue |

### Performance

| Skill | Mô tả |
|-------|--------|
| [performance/optimize-api-response](performance/optimize-api-response/) | DTO, batch |
| [performance/caching-strategy](performance/caching-strategy/) | Cache |
| [performance/analyze-query-performance](performance/analyze-query-performance/) | Explain, slow query |
| [performance/reduce-memory-usage](performance/reduce-memory-usage/) | Stream, batch |

### Observability

| Skill | Mô tả |
|-------|--------|
| [observability/add-logging](observability/add-logging/) | SLF4J, structured |
| [observability/add-metrics](observability/add-metrics/) | Micrometer |
| [observability/implement-request-tracing](observability/implement-request-tracing/) | TraceId |
| [observability/analyze-application-logs](observability/analyze-application-logs/) | Đọc log |

### Error handling

| Skill | Mô tả |
|-------|--------|
| [error-handling/global-exception-handler](error-handling/global-exception-handler/) | @ControllerAdvice |
| [error-handling/api-error-response-format](error-handling/api-error-response-format/) | Envelope lỗi |
| [error-handling/map-exceptions-to-http](error-handling/map-exceptions-to-http/) | Mapping HTTP |

### DevOps

| Skill | Mô tả |
|-------|--------|
| [devops/dockerize-service](devops/dockerize-service/) | Dockerfile |
| [devops/configure-environment](devops/configure-environment/) | Profiles |
| [devops/configure-logging](devops/configure-logging/) | Logback |
| [devops/health-check-endpoint](devops/health-check-endpoint/) | Actuator |

### Workflow

| Skill | Mô tả |
|-------|--------|
| [workflow/implement-feature](workflow/implement-feature/) | End-to-end feature |
| [workflow/prepare-pull-request](workflow/prepare-pull-request/) | Chuẩn bị PR |
| [workflow/investigate-bug](workflow/investigate-bug/) | Điều tra bug có hệ thống |
