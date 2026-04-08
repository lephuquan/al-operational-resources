# Checklist: Design Feature Architecture

Use before implementation starts. Skip rows that do not apply.

## Inputs

- [ ] Spec or task file read; scope and non-goals are clear
- [ ] `docs/architecture/01-README.md` reading order understood

## Structure

- [ ] Feature mapped to layers per `06-backend-layers-and-dependencies.md`
- [ ] Packages/paths align with `04-folder-structure.md`
- [ ] Async or external calls align with `07-integrations.md` (if any)

## Contract & behavior

- [ ] Main request/response and validation noted (link or sketch in task)
- [ ] Error semantics consistent with `docs/api/` and project error catalog (if any)
- [ ] Idempotency / transactions considered per `08-transactions-and-consistency.md` when needed

## Data

- [ ] Schema/migration impact listed (`05-database-design.md`)
- [ ] Indexes/constraints for hot paths considered

## Cross-cutting

- [ ] Security touchpoints per `09-security-architecture-backend.md`
- [ ] Observability (logs/metrics/traces) for new flows

## Decisions

- [ ] ADR filed and index updated if the decision is significant (`docs/decisions/`)

**Last updated:** 2026-04-08
