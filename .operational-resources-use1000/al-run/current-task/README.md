# Current Tasks (Single Source of Truth)

This folder is the canonical input/output area for task-driven AL execution.

## Mục lục nhanh

| Khu vực | Nội dung | Ghi chú |
|---------|----------|---------|
| **Contract & template (gốc `current-task/`)** | `SCHEMA.md`, `TEMPLATE.md`, `DISCOVERY-TEMPLATE.md`, file `README.md` này | **Giữ path ổ định** — `start-task.ps1` và rule Cursor dựa trên các file này ở thư mục cha. |
| **Tài liệu tham chiếu** | [`reference/README.md`](reference/README.md) | Quy ước thư mục, workflow 4 phase, migration, metrics, human gate. |
| **Work items** | Thư mục `YYYYMMDD-short-slug/` (folder mode) hoặc file `YYYYMMDD-slug.md` (flat) | Mỗi ticket một nơi; xem `reference/FOLDER-CONVENTION.md`. |
| **Logs chung (flat)** | `logs/` | Evidence / template log cho task phẳng hoặc dùng chung. |

## TL;DR

- Keep exactly one task file per task (flat file **or** one `TASK.md` per folder).
- Create task file from `TEMPLATE.md`.
- Validate strict input gate with `.operational-resources-use1000/al-run/scripts/start-task.ps1`.
- Validate AL-done output gate with `.operational-resources-use1000/al-run/scripts/close-task.ps1`.

## Folder contract

- Path: `.operational-resources-use1000/al-run/current-task/` (this tree)
- **Flat mode (legacy):** one task = one file `YYYYMMDD-short-slug.md` at this level.
- **Folder mode (recommended for new work):** one folder `YYYYMMDD-short-slug/` with `TASK.md` (canonical) and optional `DISCOVERY.md`, optional `logs/`. See **`reference/FOLDER-CONVENTION.md`**.
- No duplicate task copies in other folders.

## Contract & templates (ở gốc — không đổi path)

- **`TEMPLATE.md`** — main authoring template
- **`DISCOVERY-TEMPLATE.md`** — shared discovery template for raw/unclear tasks
- **`SCHEMA.md`** — contract for required sections and outputs (strict gate)

## Reference (`reference/`)

Operational guides live under **`reference/`** (see **`reference/README.md`**):

- `FOLDER-CONVENTION.md` — folder vs flat layout, runtime/reports
- `WORKFLOW-4-PHASES.md` — automation phases map
- `MIGRATION-TO-STRICT-CONTRACT.md` — upgrade legacy task files
- `METRICS.md` — KPI tracking
- `HUMAN-GATE-CHECKLIST.md` — human validation after AL handoff

Shared execution log template (unchanged path):

- `logs/TEMPLATE.md`

## Standard workflow

1. (Optional but recommended for unclear tasks) Run discovery with `DISCOVERY-TEMPLATE.md`, then validate with:
   - `powershell -File .operational-resources-use1000/al-run/scripts/preflight-discovery.ps1 -DiscoveryFile ".operational-resources-use1000/al-run/current-task/<path-to-DISCOVERY.md or flat discovery>.md"`
   - Continue only when discovery preflight passes.
2. Create task file from `TEMPLATE.md`.
3. Fill scope, AC, AC->test mapping, context pack, DoD, and required `task_contract`.
4. Run:
   - `powershell -File .operational-resources-use1000/al-run/scripts/start-task.ps1 -TaskFile ".operational-resources-use1000/al-run/current-task/..."` (flat file or `.../TASK.md` in folder mode; see **`reference/FOLDER-CONVENTION.md`**).
4b. **Human: giao AL implement** trong IDE (Cursor): `@TASK.md` + prompt — chi tiết **`../HUMAN-AL-WORKFLOW-GUIDE.md`** mục **Bước B2**; tóm tắt nhanh **`../../workspace/guides/how-to-use-operational-system.md`** mục **C.1**.
5. **AL implements** the task using the §8 context pack (default owner of code and tests after input gate passes; see `SCHEMA.md` Role split). Human does not substitute for the primary coding path unless the task records an exception.
6. **AL** runs tests and records evidence (for example under the work-item `logs/` folder in folder mode).
7. Run:
   - `powershell -File .operational-resources-use1000/al-run/scripts/close-task.ps1 -TaskFile ".operational-resources-use1000/al-run/current-task/..." -TestEvidence "<path-to-evidence>"`
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

- `../task-lifecycle/README.md`
- `../task-lifecycle/FROM-TICKET-TO-DONE.md`
- `../../workspace/skills/workflow/implement-feature/README.md`
- `../../workspace/rules/`

**Last updated:** 2026-04-19 (`reference/` layout — contract files stay at root)
