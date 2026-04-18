# Operational Resources System Definition

Last updated: 2026-04-17
Owner: Personal workspace

## 1) Purpose

Define `.operational-resources/` as a strict execution system where:

- input is a well-formed task contract,
- AL executes implementation + testing,
- human performs review + MR + merge/close outside AL.

This document is the canonical system definition.

## 2) Operating Model

### 2.1 Role split (mandatory)

- **AL**
  - Read task contract and context pack.
  - Implement code according to AC.
  - Create/update tests.
  - Run required test command.
  - Write evidence and handoff notes.
- **Human**
  - After **AL done** / handoff: review code quality and scope fit.
  - Review testing evidence.
  - Create MR and decide merge or defer.
  - Close task in external process; tick **§13.2** in the task file when applicable.
  - Own **product and scope** decisions (including updating the task early if AC or scope must change).

**Default implementation ownership:** once the strict **input gate** has passed and the task’s context pack is sufficient, **AL is the mandatory primary implementer** for code and tests through **AL done**. Humans focus on governance, review, and delivery after handoff—not on substituting for AL as the default coder. Exceptions must be written in the task (**§7** / **§11**). See `.operational-resources-use1000/al-run/current-task/SCHEMA.md` (Role split).

### 2.2 Done states

- **AL done**: code + tests + test evidence complete, ready for human review.
- **Task done**: human review complete, MR created/merged, external close completed.

## 3) Contracts

### 3.1 Input contract (strict)

Source of truth:

- **This repo:** `.operational-resources-use1000/al-run/current-task/SCHEMA.md`, `.operational-resources-use1000/al-run/current-task/TEMPLATE.md`
- **Synced template bundle:** `.operational-resources/docs/current-task/SCHEMA.md`, `.operational-resources/docs/current-task/TEMPLATE.md` (when present)

Mandatory requirements:

- Task file in `current-task/YYYYMMDD-slug.md`
- Required sections present and filled
- No template placeholders
- `task_contract` block present and valid
- DoR checked before AL starts
- Context pack includes Rules + Docs + Skills paths

### 3.2 Output contract (AL scope)

AL must produce:

- code changes in scope,
- test updates aligned with AC,
- test execution evidence,
- updated AC -> test mapping,
- handoff-ready report for human gate.

## 4) Gates and Automation

### 4.1 Input gate

- Script: `.operational-resources-use1000/al-run/scripts/start-task.ps1` (or `.operational-resources/scripts/start-task.ps1` in template-only layouts)
- Mode: fail-fast (missing contract/placeholder/DoR issues -> fail)

### 4.2 AL done gate

- Script: `.operational-resources-use1000/al-run/scripts/close-task.ps1` (or `.operational-resources/scripts/close-task.ps1` in template-only layouts)
- Validates AL output readiness and generates handoff report

### 4.3 Policy gate

- Rules: `.cursor/rules/task-workflow-enforcement.mdc`
- Hook: `.cursor/hooks.json` + `.cursor/hooks/shell-safety-gate.ps1`
- Goal: enforce safe execution and task-first behavior without blocking normal conversation

## 5) Core Directory Responsibilities (this repo layout)

Under `.operational-resources-use1000/`:

- **`al-run/current-task/`**: strict task contracts, logs, reports, dashboard
- **`al-run/scripts/`**: input/output/discovery gate automation
- **`al-run/task-lifecycle/`**: end-to-end process reference (ticket → done)
- **`workspace/rules/`**: execution policies and coding/review standards
- **`workspace/docs/`**: project context (architecture, API, setup, specs, ADR)
- **`workspace/skills/`**: how-to playbooks AL can follow
- **`workspace/simulator/`**: demo scenarios and sample tickets

## 6) Lifecycle (Task -> AL -> Human -> Done)

1. Human creates/fills task from template.
2. AL runs `start-task.ps1` and only proceeds if pass.
3. AL implements + tests + evidence.
4. AL runs `close-task.ps1` and hands off.
5. Human reviews code and testing evidence.
6. Human creates MR, merges, and closes task externally.

## 7) Non-goals

- AL does not auto-create MR unless explicitly requested.
- AL does not decide merge/close.
- System does not replace team governance or CI policy.

## 8) Acceptance Criteria for this system

System is considered operational when:

- new tasks pass strict input gate consistently,
- AL outputs are review-ready without missing evidence,
- human gate can complete MR/merge with clear traceability,
- task history is auditable through task file + logs + reports.
