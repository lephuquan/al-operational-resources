# Checklist: Review Project Architecture

Quick pass before writing the narrative (strengths / risks / P0–P2 actions).

## Review setup

- [ ] Review scope defined (whole repo / module / changed area)
- [ ] Timebox defined (quick scan vs deep review)

## Baseline read

- [ ] `docs/architecture/02-system-overview.md`
- [ ] `docs/architecture/04-folder-structure.md`
- [ ] `docs/architecture/06-backend-layers-and-dependencies.md`

## Layering & coupling

- [ ] Controllers: HTTP mapping and validation only; no business rules
- [ ] Services: orchestration and domain rules; clear boundaries
- [ ] Persistence: repositories/entities behind documented rules; no layer violations spotted

## Cross-cutting

- [ ] Security model consistent with `09-security-architecture-backend.md`
- [ ] Global error handling and API error shape reviewed (`docs/api/` as needed)
- [ ] Logging/observability adequate for debugging production issues
- [ ] Integration failure behavior checked (timeout/retry/circuit breaker patterns where relevant)

## Tests

- [ ] Critical paths have automated coverage (unit and/or integration)
- [ ] Slow/flaky tests identified if any
- [ ] Negative/error-path test coverage assessed for key use cases

## Risk framing

- [ ] Each risk includes impact + likelihood
- [ ] Each action has owner suggestion and smallest first step
- [ ] No proposed action violates existing architecture rules without explicit ADR/approval

## Output shape

- [ ] Review scope stated at top of report
- [ ] Three strengths listed
- [ ] Three risks listed
- [ ] Three actions with **P0 / P1 / P2** labels
- [ ] Recommended first implementation slice included

**Last updated:** 2026-04-08
