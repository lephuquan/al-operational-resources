# Checklist: Review Project Architecture

Quick pass before writing the narrative (strengths / risks / P0–P2 actions).

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

## Tests

- [ ] Critical paths have automated coverage (unit and/or integration)
- [ ] Slow/flaky tests identified if any

## Output shape

- [ ] Three strengths listed
- [ ] Three risks listed
- [ ] Three actions with **P0 / P1 / P2** labels

**Last updated:** 2026-04-08
