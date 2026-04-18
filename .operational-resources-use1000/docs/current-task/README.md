# Current Tasks (Single Source of Truth)

This folder is the canonical input/output area for task-driven AL execution.

## TL;DR

- Keep exactly one task file per task in this folder.
- Create task file from `TEMPLATE.md`.
- Validate strict input gate with `.operational-resources-use1000/scripts/start-task.ps1`.
- Validate AL-done output gate with `.operational-resources-use1000/scripts/close-task.ps1`.

## Folder contract

- Path: `.operational-resources-use1000/docs/current-task/` (this tree)
- **Flat mode (legacy):** one task = one file `YYYYMMDD-short-slug.md` at this level.
- **Folder mode (recommended for new work):** one folder `YYYYMMDD-short-slug/` with `TASK.md` (canonical) and optional `DISCOVERY.md`, optional `logs/`. See `FOLDER-CONVENTION.md`.
- No duplicate task copies in other folders.

## Required files

- `TEMPLATE.md`: main authoring template
- `DISCOVERY-TEMPLATE.md`: shared discovery template for raw/unclear tasks
- `SCHEMA.md`: contract for required sections and outputs
- `HUMAN-GATE-CHECKLIST.md`: final human validation gates
- `METRICS.md`: KPI tracking
- `logs/TEMPLATE.md`: execution log template
- `MIGRATION-TO-STRICT-CONTRACT.md`: upgrade guide for legacy task files

## Standard workflow

1. (Optional but recommended for unclear tasks) Run discovery with `DISCOVERY-TEMPLATE.md`, then validate with:
   - `powershell -File .operational-resources-use1000/scripts/preflight-discovery.ps1 -DiscoveryFile ".operational-resources-use1000/docs/current-task/<path-to-DISCOVERY.md or flat discovery>.md"`
   - Continue only when discovery preflight passes.
2. Create task file from `TEMPLATE.md`.
3. Fill scope, AC, AC->test mapping, context pack, DoD, and required `task_contract`.
4. Run:
   - `powershell -File .operational-resources-use1000/scripts/start-task.ps1 -TaskFile ".operational-resources-use1000/docs/current-task/..."` (flat file or `.../TASK.md` in folder mode; see `FOLDER-CONVENTION.md`).
5. **AL implements** the task using the §8 context pack (default owner of code and tests after input gate passes; see `SCHEMA.md` Role split). Human does not substitute for the primary coding path unless the task records an exception.
6. **AL** runs tests and records evidence (for example under the work-item `logs/` folder in folder mode).
7. Run:
   - `powershell -File .operational-resources-use1000/scripts/close-task.ps1 -TaskFile ".operational-resources-use1000/docs/current-task/..." -TestEvidence "<path-to-evidence>"`
8. **Human** (post-handoff): review code + testing evidence, create MR, merge/close outside AL, tick **§13.2**, own product/scope if the outcome diverges from the ticket.

## Role split

- **AL:** read task, **implement AC (mandatory primary coder after `start-task.ps1` passes and §8 is sufficient)**, update tests, run tests, update evidence in task/log, update contract docs when required, handoff ready through **AL done**.
- **Human:** authoring/approving the task and discovery when needed; after handoff—review code and evidence, create MR, decide merge, close task in external process, tick **§13.2**, product/scope decisions and early AC steering when required. See `SCHEMA.md` for exceptions.

## Dashboard (active tasks)

| ID | Task name | Priority | Status | File |
|:---|:---|:---:|:---:|:---|
| 20260414 | ShelfLog infra baseline (SIM-DEMO-1) | High | Done | `20260414-shelflog-infra.md` |
| 20260411 | ShelfLog shelf items API (SIM-DEMO-2) | Medium | Review (AL done) | `20260411-shelf-items-api.md` |

## References

- `../../task-lifecycle/README.md`
- `../../task-lifecycle/FROM-TICKET-TO-DONE.md`
- `../../skills/workflow/implement-feature/README.md`
- `../../rules/`

**Last updated:** 2026-04-17 (AL default implementation owner; human post-handoff gates)
