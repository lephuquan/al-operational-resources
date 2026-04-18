# 4-Phase AL Workflow

This document maps the implemented workflow to the 4 phases.

## Phase 1 - Standardization

- `TEMPLATE.md` as canonical task template.
- `SCHEMA.md` defines required sections and outputs.
- `logs/TEMPLATE.md` standardizes execution logs.

## Phase 2 - Light automation

- `scripts/start-task.ps1`: strict fail-fast input gate.
- `scripts/close-task.ps1`: AL done gate + handoff report.

## Phase 3 - Rules and hooks enforcement

- `.cursor/rules/task-workflow-enforcement.mdc` (always apply).
- `.cursor/rules/current-task-format.mdc` (task-file specific).
- `.cursor/hooks.json` + `.cursor/hooks/shell-safety-gate.ps1`.

## Phase 4 - MR-ready human workflow

- `.github/pull_request_template.md` for consistent PR quality.
- `HUMAN-GATE-CHECKLIST.md` defines 4 human gates.
- `METRICS.md` tracks workflow KPIs weekly.

## Final operating model

- AL executes up to `AL done` only (code + tests + evidence + handoff).
- Human executes review, MR, merge, and external close.

## Operational note

This baseline is intentionally strict on structure and light on hard blocking.
If needed, increase strictness by changing hook policies to fail closed.
