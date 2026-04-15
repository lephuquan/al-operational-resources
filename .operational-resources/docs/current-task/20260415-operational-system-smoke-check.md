# Task - Operational system smoke check

## TL;DR (VI)

- Tao mot task nho de kiem tra luong van hanh cua he thong `.operational-resources/`.
- Muc tieu: xac nhan input gate, test command, va output gate chay thong suot.

---

## Metadata (required)

| Field | Value |
|-------|--------|
| **Task type** | `ops` |
| **File ID** | `20260415-operational-system-smoke-check.md` |
| **Ticket / issue** | OPS-DEMO-20260415 |
| **Status** | Draft |
| **Priority** | Medium |
| **Owner** | Admin |

### Machine-readable task_contract (required)

```yaml
task_contract:
  task_id: 20260415-operational-system-smoke-check
  ticket: OPS-DEMO-20260415
  dependencies: []
  required_test_command: ./mvnw.cmd -q test
  required_outputs:
    - code_changes
    - test_updates
    - test_evidence
    - ac_test_mapping
    - handoff_notes
```

---

## 0. Definition of Ready - before asking AI to implement (checkboxes)

- [x] Goal and AC are clear for this smoke-check task.
- [x] Scope and out-of-scope are defined in section 2.
- [x] Open questions are empty and there are no blockers.
- [x] Rules, docs, and skills are listed in section 8.
- [x] No scope divergence from ticket.

---

## 1. One-line summary (required)

Run a controlled smoke check of the operational workflow so AL and human gates are validated before feature delivery.

---

## 2. Sources, scope, and assumptions (required)

### 2.1 Official links

- **Ticket / description:** Internal demo task OPS-DEMO-20260415.
- **Spec:** `docs/current-task/TEMPLATE.md`
- **API / contract:** Not applicable for this task.
- **Related ADR:** `SYSTEM-DEFINITION.md`

### 2.2 In scope / out of scope

| In scope (this task) | Out of scope (another task / later) |
|----------------------|----------------------------------------|
| Create one valid task from template | Implement business API features |
| Run input gate and required tests | Refactor architecture |
| Produce test evidence and handoff report | Create MR or merge changes |

### 2.3 Assumptions and dependencies

- **Assumptions:** Existing Maven tests continue to pass locally.
- **Dependencies:** `scripts/start-task.ps1`, `scripts/close-task.ps1`, `mvnw.cmd`.

---

## 3. Acceptance criteria (required when provided by BA/lead)

- [ ] AC1: Task file is created under `docs/current-task/` with required sections and valid `task_contract`.
- [ ] AC2: Input gate `start-task.ps1` passes for this task file.
- [ ] AC3: Required test command runs successfully and output is captured to an evidence file.
- [ ] AC4: Output gate `close-task.ps1` generates a handoff report successfully.

### 3.1 Detailed behavior (recommended for features - avoids happy-path-only AI work)

| Scenario | Expected result | Notes |
|----------|-----------------|-------|
| Run input gate | Gate passes with all checks OK | No placeholder text |
| Run test command | Exit code is 0 | Evidence file is created |
| Run output gate | Handoff report is generated | Human gate remains unchecked |

---

## 4. AC -> test mapping (required before done)

| AC / goal | Description | Test (class#method or description) | Type |
|-----------|-------------|-------------------------------------|------|
| AC1 | Task contract validity | `start-task.ps1` contract checks | script |
| AC2 | Input gate pass | `powershell -File start-task.ps1 -TaskFile ...` | script |
| AC3 | Test command pass | `./mvnw.cmd -q test` | integration |
| AC4 | Output gate pass | `powershell -File close-task.ps1 -TaskFile ... -TestEvidence ...` | script |

---

## 5. Non-functional and technical constraints

- **Performance / SLI:** Keep test execution under normal local runtime.
- **Security:** Do not add secrets to task, log, or report files.
- **API compatibility / versioning:** No API change in this task.
- **Idempotency / retry:** Script commands can be rerun safely.

---

## 6. Task-type block

### D - SPIKE / CHORE / OPS

- **Output:** one valid task contract + gate execution evidence.
- **AC -> Test:** script and command evidence only.

---

## 7. Revision

| Date | Change | Type | Action |
|------|--------|------|--------|
| 2026-04-15 | Initial smoke-check task creation | Small | Created from template with strict contract |

---

## 8. Context pack for AI

| Kind | Paths |
|------|-------|
| Rules | `rules/00-personal-priority.md`, `rules/08-review-checklist.md` |
| Docs | `SYSTEM-DEFINITION.md`, `docs/current-task/SCHEMA.md`, `docs/current-task/TEMPLATE.md` |
| Skills | `skills/workflow/implement-feature/README.md` |

Suggested prompt:
"Read this task first. Validate the operational workflow only. Do not implement business features."

---

## 9. Execution checklist

- [ ] Create task file from template
- [ ] Run input gate
- [ ] Run required tests and save evidence
- [ ] Run output gate and confirm handoff report

---

## 10. Detailed guidance for AI

- **MUST:** Keep scope limited to workflow validation and evidence generation.
- **SHOULD:** Use existing scripts without adding new dependencies.
- **ASK FIRST:** Any change to shared interfaces, project architecture, or dependency set.

---

## 11. Open questions, risks, and blockers

- None.

---

## 12. Progress log

- **[2026-04-15]** Task file created from template and prepared for gate validation.

---

## 13. Definition of Done (check before MR)

### 13.1 AL Done (must be complete before handoff)

- [x] Section 0 Definition of Ready checked
- [ ] Code + tests match sections 3-4
- [ ] Required test command executed and evidence saved
- [ ] AC -> test mapping reflects final state
- [ ] Progress log includes implementation and test evidence summary

### 13.2 Human Done (outside AL execution)

- [ ] Human reviewed code quality and scope fit
- [ ] Human reviewed testing evidence
- [ ] Human created MR with test instructions
- [ ] Human decided merge/close in external process

---

**Last updated:** 2026-04-15
