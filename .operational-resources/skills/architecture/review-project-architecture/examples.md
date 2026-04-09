# Examples: Architecture review outputs

Use these templates to produce concise, actionable review reports.

## Example A — Feature module review

```markdown
## Architecture review: Order module

### Scope
- Packages reviewed: `order.api`, `order.application`, `order.domain`, `order.infra`

### Strengths
1. Controller layer is thin and delegates orchestration to service.
2. Domain errors are centralized and mapped consistently in global handler.
3. Integration boundary with payment provider is isolated behind port interface.

### Risks
1. Service method has mixed transaction + remote call sequence (timeout can hold DB tx too long).
2. Read endpoint performs repeated repository calls (N+1 pattern risk).
3. Missing negative-path tests for stock reservation failures.

### Actions
- **P0:** Split transaction boundary from remote payment call; apply outbox/retry-safe pattern.
- **P1:** Refactor query path to use projection/fetch join and add query-count test.
- **P2:** Add integration tests for reserve-stock failure and payment-timeout mapping.
```

## Example B — Repository-wide quick health report

```markdown
## Architecture review: Repo quick scan

### Scope
- Timebox: 90 minutes
- Areas: auth, order, payment, shared error handling

### Strengths
1. Standardized request/response envelope across API.
2. Security filters and endpoint authorization are mostly centralized.
3. Naming and package conventions are consistent in new modules.

### Risks
1. Legacy controller contains business logic branches.
2. Retry policy differs across two HTTP clients (inconsistent failure behavior).
3. Test pyramid skewed toward integration tests, limited service unit coverage.

### Actions
- **P0:** Move business branches from legacy controller to service and add WebMvc regression test.
- **P1:** Standardize retry/timeouts in shared client config.
- **P2:** Add targeted unit tests for service decision logic.
```

## Reusable report skeleton

```markdown
## Architecture review: <area>

### Scope
- Modules:
- Timebox:
- Constraints:

### Strengths
1.
2.
3.

### Risks
1.
2.
3.

### Actions
- **P0:**
- **P1:**
- **P2:**
```

**Last updated:** 2026-04-08
