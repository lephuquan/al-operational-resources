# AGENTS.md - Personal AI Workspace

Last updated: 2026-04-17
Owner: Phu Quan Le (personal only)

## 1) Workspace intent
- This workspace is personal and optimized for fast, high-quality delivery with AI.
- It must not change team-shared conventions without explicit confirmation.
- Team standards remain default; personal rules can override for local workflow decisions.

## 2) Project context
- Project: `al-operational-resources`
- Stack: Spring Boot 3.x, Java 17, Maven
- Architecture target: Layered + clean boundaries (controller/service/repository/domain)
- Main goal: deliver features safely with strong tests and maintainable code

## 3) Core principles
- Readability and maintainability over clever shortcuts.
- Security-first: validate all input, never hardcode secrets.
- Performance-aware: avoid unnecessary DB calls, design for pagination.
- Testability-first: code should be easy to unit/integration test.

## 4) Working protocol with AI
1. Plan briefly before non-trivial implementation.
2. Read `.operational-resources-use1000/rules/` first, then `.operational-resources-use1000/docs/` (and task file in `current-task/`).
3. If unclear, ask instead of guessing.
4. Do not auto-commit or push.
5. After each task: summarize changes and suggest next checks.
6. **Task-driven runs:** after `start-task.ps1` passes and §8 context is sufficient, **AL implements code and tests** through **AL done**; the human owns **post-handoff** review, evidence check, MR, merge, **§13.2**, and product/scope. Canonical policy: `.operational-resources-use1000/current-task/SCHEMA.md` (Role split).

## 5) Forbidden actions
- No deleting major files/folders without confirmation.
- No adding dependencies without explicit reason.
- No architecture-level changes without plan and approval.
- No secret exposure in code, logs, or docs.

## 6) Priority order
1. `.operational-resources-use1000/rules/00-personal-priority.md`
2. This `AGENTS.md`
3. Other `.operational-resources-use1000/rules/*.md`
4. `.operational-resources-use1000/docs/**`
5. Team docs/rules for cross-check and alignment

## 7) References
- **Một task ticket → Done (nguồn chính):** `.operational-resources-use1000/task-lifecycle/README.md` → `FROM-TICKET-TO-DONE.md`
- **Triển khai / duy trì docs+skills+rules:** `.operational-resources-use1000/guides/README.md`
- Directory map (cấu trúc thư mục): `.operational-resources-use1000/MAP.md`
- Rules: `.operational-resources-use1000/rules/`
- Personal docs: `.operational-resources-use1000/docs/`
- Backend architecture (numbered): `.operational-resources-use1000/docs/architecture/01-README.md`
- Architecture playbooks (design vs review): `.operational-resources-use1000/skills/architecture/README.md`
- ADRs (index + template): `.operational-resources-use1000/docs/decisions/README.md`
- Feature specs (index): `.operational-resources-use1000/docs/specs/README.md`
- Local run & setup (no secrets): `.operational-resources-use1000/docs/setup/01-README.md`
- Skills index: `.operational-resources-use1000/skills/README.md`
- Adding a skill / topic: `.operational-resources-use1000/skills/HOW-TO-ADD-TOPIC.md` (copy `SKILL-TEMPLATE.md` → `skills/<group>/<topic>/SKILL.md`)
- Notes: `.operational-resources-use1000/notes/`
