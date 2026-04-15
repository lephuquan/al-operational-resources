# Current Tasks (Single Source of Truth)

This folder is the canonical input/output area for task-driven AL execution.

## TL;DR

- Keep exactly one task file per task in this folder.
- Create task file from `TEMPLATE.md`.
- Validate strict input gate with `.operational-resources/scripts/start-task.ps1`.
- Validate AL-done output gate with `.operational-resources/scripts/close-task.ps1`.

## Folder contract

- Path: `.operational-resources/docs/current-task/`
- One task = one file: `YYYYMMDD-short-slug.md`
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
   - `powershell -File .operational-resources/scripts/preflight-discovery.ps1 -DiscoveryFile ".operational-resources/docs/current-task/<discovery-file>.md"`
   - Continue only when discovery preflight passes.
2. Create task file from `TEMPLATE.md`.
3. Fill scope, AC, AC->test mapping, context pack, DoD, and required `task_contract`.
4. Run:
   - `powershell -File .operational-resources/scripts/start-task.ps1 -TaskFile ".operational-resources/docs/current-task/YYYYMMDD-slug.md"`
5. Implement task using the listed context pack.
6. Execute tests and record evidence.
7. Run:
   - `powershell -File .operational-resources/scripts/close-task.ps1 -TaskFile ".operational-resources/docs/current-task/YYYYMMDD-slug.md" -TestEvidence "<path>"`
8. Handoff to human gate: human reviews code + testing evidence, creates MR, and decides merge/close outside AL.

## Role split

- **AL:** read task, implement AC, update tests, run tests, update evidence in task/log, handoff ready.
- **Human:** review code, review testing evidence, create MR, decide merge, close task in external process.

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

**Last updated:** 2026-04-14 (4-phase workflow baseline)
