# Task Contract Schema (Strict)

This file defines the strict input contract for task execution in
`.operational-resources-use1000/current-task/` (this repo) or, in template-only layouts, `.operational-resources/docs/current-task/`.

## Purpose

- Ensure AL can implement and test without ambiguity.
- Make outputs easy for humans to review and decide merge.
- Enforce a stable handoff between AL and human gates.

## Role split (mandatory)

- **AL responsibilities:** read task, implement AC, update/create tests, run tests, write evidence, prepare handoff.
- **Human responsibilities:** after handoff, review code and testing evidence, create MR, merge or reject, close the task in the external tracker/process, tick **§13.2** in the task file, and own **product / scope** decisions (including early direction if AC or scope must change).

### Implementation ownership (default in this workspace)

When **§0 Definition of Ready** is satisfied, **`start-task.ps1` has passed**, and the **§8 context pack** lists real, sufficient resources, **AL (the coding agent) is the primary owner of implementation**—application code, automated tests, test command execution, evidence capture, and contract/spec updates required by the task—through **AL done**. Humans **do not** take the primary coding path in the default workflow.

Record a deliberate exception in **§7 Revision** and/or **§11 Open questions** if a human (or another party) must implement all or part of the code instead of AL.

## Required sections

Each task file must include these sections:

1. `## Metadata`
2. `## 0. Definition of Ready`
3. `## 1. One-line summary`
4. `## 2. Sources, scope, and assumptions`
5. `## 3. Acceptance criteria`
6. `## 4. AC -> test mapping`
7. `## 8. Context pack for AI`
8. `## 10. Detailed guidance for AI`
9. `## 12. Progress log`
10. `## 13. Definition of Done`

## Required metadata fields

- Task type
- File ID
- Ticket / issue
- Status
- Priority
- Owner

## Required machine-readable block

Every task must include:

```yaml
task_contract:
  task_id: 20260411-shelf-items-api
  ticket: SIM-DEMO-2
  dependencies:
    - 20260414-shelflog-infra
  required_test_command: ./mvnw.cmd -q test
  required_outputs:
    - code_changes
    - test_updates
    - test_evidence
    - ac_test_mapping
    - handoff_notes
```

## Strict input rules

- No template placeholders allowed (`…`, `PROJ-123`, `YYYYMMDD-slug`, `[Short title]`).
- All Definition of Ready checkboxes in `## 0.` must be checked before AL starts.
- Context pack must contain explicit paths for Rules, Docs, and Skills.
- `MUST`, `SHOULD`, `ASK FIRST` lines in `## 10.` must be concrete (not placeholders).
- AC list must be testable and mapped in `## 4.`.

## Output contract

`close-task.ps1` validates **AL done** only:

- Code + tests updated for AC scope.
- Required test command executed with evidence file.
- AC -> test mapping updated.
- Handoff report generated for human review gate.

## Done state definitions

- **AL done:** code + test + evidence complete and ready for human review.
- **Task done:** human review complete, MR created/merged, task closed outside AL.

## Validation strategy

- Use `start-task.ps1` as hard input gate (fail-fast).
- Use `close-task.ps1` as AL output gate and handoff generator.

---

**Last updated:** 2026-04-17
