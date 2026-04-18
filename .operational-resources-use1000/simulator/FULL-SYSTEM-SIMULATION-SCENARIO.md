# Full System Simulation Scenario (Human + AL)

## Purpose

This scenario is a full dry-run of the operational system from raw request to human merge decision.
Use it to validate process readiness, not only code delivery.

Outcome target:

- AL reaches **AL done** with code + tests + evidence + handoff.
- Human reaches **Task done** after review + MR + merge/close decision.

---

## Scope of simulation

- Includes discovery gate, task gate, implementation cycle, output gate, and human gate.
- Can run with any feature task (recommended: task under `docs/current-task/`).
- Uses scripts:
  - `scripts/preflight-discovery.ps1`
  - `scripts/start-task.ps1`
  - `scripts/close-task.ps1`

---

## Role model

| Role | Responsibility in simulation |
|------|------------------------------|
| Human (you) | Define intent, confirm decisions in discovery/task; **after handoff** — review code and evidence, create MR, decide merge/close, tick **§13.2**, own product/scope if outcomes diverge |
| AL | **Mandatory** implementation and testing after input gate passes and context is sufficient — workflow up to **AL done**, evidence, contract docs per task |

Default policy matches `docs/current-task/SCHEMA.md` (Role split): humans do not substitute for the primary coding path unless the task records an exception.

---

## Phase 0 - Preparation (Human)

1. Choose target task file (or create one from `docs/current-task/TEMPLATE.md`).
2. If requirement is unclear, create discovery file from `docs/current-task/DISCOVERY-TEMPLATE.md`.
3. Confirm baseline docs to read:
   - `SYSTEM-DEFINITION.md`
   - `task-lifecycle/FROM-TICKET-TO-DONE.md`
   - task file in `docs/current-task/`

Output:

- One canonical task file
- Optional discovery file for unclear tasks

---

## Phase 1 - Discovery Gate (Human + AL)

Run when task is raw/unclear:

```powershell
powershell -File .operational-resources/scripts/preflight-discovery.ps1 -DiscoveryFile ".operational-resources/docs/current-task/<discovery-file>.md"
```

If fail:

- Human fills unknown inputs/decisions
- AL re-checks until pass

Pass criteria:

- `Discovery preflight passed.`
- Discovery says `Discovery ready: Yes`

---

## Phase 2 - Task Input Gate (AL)

Validate strict task contract:

```powershell
powershell -File .operational-resources/scripts/start-task.ps1 -TaskFile ".operational-resources/docs/current-task/YYYYMMDD-slug.md"
```

If fail:

- Human/AL fix missing sections, context pack paths, required docs references
- Rerun until pass

Pass criteria:

- `Task gate passed.`
- Runtime session created in `docs/current-task/.runtime/`

---

## Phase 3 - Implementation Cycle (AL)

AL works in small slices:

1. Read context pack (`Rules`, `Docs`, `Skills`)
2. Implement code for scoped AC only
3. Update tests for changed behavior
4. Keep AC -> test mapping in task file aligned

Human checkpoints:

- Scope control (no overbuild)
- Ask-first decisions (dependency, architecture, shared interface)

---

## Phase 4 - Test + Evidence (AL)

Run required command and save evidence:

```powershell
.\mvnw.cmd -q test 2>&1 | Tee-Object -FilePath ".operational-resources/docs/current-task/logs/YYYYMMDD-test-evidence.txt"
```

Update task file:

- AC status
- section 4 (AC -> test mapping)
- section 12 (progress log with evidence path)
- section 13.1 (AL Done checklist)

---

## Phase 5 - Output Gate (AL)

Validate AL done and generate handoff report:

```powershell
powershell -File .operational-resources/scripts/close-task.ps1 -TaskFile ".operational-resources/docs/current-task/YYYYMMDD-slug.md" -TestEvidence ".operational-resources/docs/current-task/logs/YYYYMMDD-test-evidence.txt"
```

Pass criteria:

- `AL done gate completed.`
- Report generated in `docs/current-task/reports/`

---

## Phase 6 - Human Gate (Human)

Human performs final governance:

1. Review scope fit and code quality
2. Review test evidence + handoff report
3. Create MR with test instructions
4. Decide merge/close in external workflow

Done states:

- AL done: after Phase 5 pass
- Task done: after Phase 6 completes

---

## Failure drill (recommended)

Run at least one controlled fail case in simulation:

- Missing `task_contract` in task file -> verify start-task fails with clear message
- Unchecked `13.1` item -> verify close-task fails with clear message
- Missing context pack path -> verify start-task blocks implementation

This confirms your safety gates are active.

---

## Simulation completion checklist

- [ ] Discovery gate tested (pass/fail path)
- [ ] Start-task gate pass confirmed
- [ ] Code/test cycle executed
- [ ] Test evidence file created
- [ ] Close-task gate pass confirmed
- [ ] Handoff report created
- [ ] Human gate review completed

---

## Suggested cadence

- Run this full simulation when:
  - onboarding new developer
  - introducing new domain (Kafka, mail, payment, etc.)
  - changing workflow scripts/rules

- Run a lightweight subset weekly:
  - start-task + test evidence + close-task

---

**Last updated:** 2026-04-16
