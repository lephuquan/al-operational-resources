# Skill: Review Project Architecture

## TL;DR (VI)

- Rà soát repo **nhanh**: layer, coupling, security, testability — không refactor lớn trừ khi có plan riêng.
- Kết luận: **3 điểm mạnh + 3 rủi ro + hành động P0/P1/P2**.

## Goal

Deliver a **concise architecture review** of the repository: layering, coupling, cross-cutting concerns, and test posture—with prioritized, actionable follow-ups (no large refactors without an explicit plan).

## Preconditions

- **None** — applies to any Spring Boot–style backend documented in this workspace.

## Steps

1. **Read the baseline** — `docs/architecture/02-system-overview.md`, `docs/architecture/04-folder-structure.md`, and `docs/architecture/06-backend-layers-and-dependencies.md`.
2. **Scan packages** — Controllers stay thin; services own orchestration; repositories/data access stay behind documented boundaries (no business rules leaking into web layer, no ad-hoc DB access in wrong layers).
3. **Cross-cutting** — Security (`docs/architecture/09-security-architecture-backend.md`), global error handling (see `docs/api/05-error-handling.md` if present), logging and observability.
4. **Assess tests** — Unit vs integration balance; critical paths covered; flakiness and data setup (`skills/testing/*` as implementation reference).
5. **Summarize** — Three strengths, three risks, three actions labeled **P0 / P1 / P2**.

## Output

- A short bullet report (strengths, risks, actions)—**no** large-scale refactor unless the user explicitly requests a plan.

## References

- Rules: `rules/` (project-wide constraints)
- Docs: `docs/architecture/01-README.md`, `02-system-overview.md`, `04-folder-structure.md`, `06-backend-layers-and-dependencies.md`, `09-security-architecture-backend.md`
- API / errors: `docs/api/01-README.md`, `docs/api/05-error-handling.md` (if present)
- Related skills: `skills/architecture/design-feature-architecture/SKILL.md`, `skills/code-quality/review-code/SKILL.md`

**Last updated:** 2026-04-08
