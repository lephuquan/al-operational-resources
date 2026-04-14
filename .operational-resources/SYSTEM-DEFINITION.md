# Operational Resources System Definition

Last updated: 2026-04-14
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
  - Review code quality and scope fit.
  - Review testing evidence.
  - Create MR and decide merge.
  - Close task in external process.

### 2.2 Done states

- **AL done**: code + tests + test evidence complete, ready for human review.
- **Task done**: human review complete, MR created/merged, external close completed.

## 3) Contracts

### 3.1 Input contract (strict)

Source of truth:

- `.operational-resources/docs/current-task/SCHEMA.md`
- `.operational-resources/docs/current-task/TEMPLATE.md`

Mandatory requirements:

- Task file in `docs/current-task/YYYYMMDD-slug.md`
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

- Script: `.operational-resources/scripts/start-task.ps1`
- Mode: fail-fast (missing contract/placeholder/DoR issues -> fail)

### 4.2 AL done gate

- Script: `.operational-resources/scripts/close-task.ps1`
- Validates AL output readiness and generates handoff report

### 4.3 Policy gate

- Rules: `.cursor/rules/task-workflow-enforcement.mdc`
- Hook: `.cursor/hooks.json` + `.cursor/hooks/shell-safety-gate.ps1`
- Goal: enforce safe execution and task-first behavior without blocking normal conversation

## 5) Core Directory Responsibilities

- `docs/current-task/`: strict task contracts, logs, reports, dashboard
- `rules/`: execution policies and coding/review standards
- `docs/`: project context (architecture, API, setup, specs, ADR)
- `skills/`: how-to playbooks AL can follow
- `task-lifecycle/`: end-to-end process reference
- `simulator/`: demo scenarios and sample tickets

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
