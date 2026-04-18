# Migration to Strict Task Contract

Use this when a legacy task file fails `start-task.ps1`.

## Required migration steps

1. Add the required `task_contract` YAML block in Metadata section.
2. Replace all placeholders (`…`, `PROJ-123`, `YYYYMMDD-slug`, template text).
3. Ensure `## 0.` checkboxes are fully checked before AL execution.
4. Convert `## 13.` into:
   - `### 13.1 AL Done`
   - `### 13.2 Human Done`
5. Ensure `## 10.` uses exact guidance keys:
   - `MUST`
   - `SHOULD`
   - `ASK FIRST`

## Common failures

- Missing `task_contract` block.
- Context pack does not include explicit Rules/Docs/Skills paths.
- Old DoD format without AL/Human split.

## Validate

Run:

`powershell -File .operational-resources-use1000/al-run/scripts/start-task.ps1 -TaskFile ".operational-resources-use1000/al-run/current-task/YYYYMMDD-slug.md"` (hoặc bản sync `.operational-resources/…/docs/current-task/…` nếu dùng template gốc)
