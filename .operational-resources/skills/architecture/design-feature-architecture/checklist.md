# Checklist: Design Feature Architecture

Use before implementation starts. Skip rows that do not apply.

## Exit criteria

- [ ] The design is understandable by another engineer without live explanation
- [ ] Open questions are explicitly listed (not hidden in assumptions)
- [ ] Ready-for-implementation status is stated: **Ready** / **Blocked**

## Inputs

- [ ] Spec or task file read; scope and non-goals are clear
- [ ] `docs/architecture/01-README.md` reading order understood
- [ ] Stakeholder/owner for unresolved trade-offs identified

## Structure

- [ ] Feature mapped to layers per `06-backend-layers-and-dependencies.md`
- [ ] Packages/paths align with `04-folder-structure.md`
- [ ] Async or external calls align with `07-integrations.md` (if any)

## Contract & behavior

- [ ] Main request/response and validation noted (link or sketch in task)
- [ ] Error semantics consistent with `docs/api/` and project error catalog (if any)
- [ ] Idempotency / transactions considered per `08-transactions-and-consistency.md` when needed
- [ ] Backward compatibility and versioning impact checked (if API is public/shared)

## Data

- [ ] Schema/migration impact listed (`05-database-design.md`)
- [ ] Indexes/constraints for hot paths considered
- [ ] Read/write amplification risk noted for expected traffic profile

## Cross-cutting

- [ ] Security touchpoints per `09-security-architecture-backend.md`
- [ ] Observability (logs/metrics/traces) for new flows
- [ ] Failure and retry strategy documented for external integrations (if any)

## Decisions

- [ ] ADR filed and index updated if the decision is significant (`docs/decisions/`)
- [ ] Top 3 risks + mitigations included in design note

## Handoff to implementation

- [ ] Coding sequence proposed (suggested first PR slice)
- [ ] Test strategy outlined (unit/integration boundaries)
- [ ] Out-of-scope items explicitly parked for later

**Last updated:** 2026-04-08
