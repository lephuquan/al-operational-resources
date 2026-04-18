# 4-Phase AL Workflow

This document maps the implemented workflow to the 4 phases.

## Phase 1 - Standardization

- `../TEMPLATE.md` as canonical task template.
- `../SCHEMA.md` defines required sections and outputs.
- `../logs/TEMPLATE.md` standardizes execution logs.

## Phase 2 - Light automation

- `scripts/start-task.ps1`: strict fail-fast input gate.
- `scripts/close-task.ps1`: AL done gate + handoff report.

## Phase 3 - Rules and hooks enforcement

- `.cursor/rules/task-workflow-enforcement.mdc` (always apply).
- `.cursor/rules/current-task-format.mdc` (task-file specific).
- `.cursor/hooks.json` + `.cursor/hooks/shell-safety-gate.ps1`.

## Phase 4 - MR-ready human workflow

- `.github/pull_request_template.md` for consistent PR quality.
- `HUMAN-GATE-CHECKLIST.md` (this folder) defines 4 human gates.
- `METRICS.md` (this folder) tracks workflow KPIs weekly.

## Final operating model

- AL executes up to `AL done` only (code + tests + evidence + handoff). After `start-task.ps1` passes with a sufficient §8 context pack, **AL is the default mandatory owner of implementation** (not the human), unless the task documents an exception in §7 / §11 (`../SCHEMA.md`).
- Human executes **post-handoff** review, MR, merge, external close, **§13.2**, and product/scope decisions when intent or AC must change.

## Operational note

This baseline is intentionally strict on structure and light on hard blocking.
If needed, increase strictness by changing hook policies to fail closed.

**Last updated:** 2026-04-17
