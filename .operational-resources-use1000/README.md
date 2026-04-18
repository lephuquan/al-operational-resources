# `.operational-resources-use1000/` — personal ops bundle

This directory is split into two hubs:

| Hub | Path | Purpose |
|-----|------|---------|
| **AL run** (task → AL → done) | [`al-run/`](al-run/) | `current-task/`, gate `scripts/`, `task-lifecycle/`, `HUMAN-AL-WORKFLOW-GUIDE.md`, `SYSTEM-DEFINITION.md` |
| **Workspace** (context & playbooks) | [`workspace/`](workspace/) | `docs/`, `rules/`, `skills/`, `simulator/`, `guides/`, `AGENTS.md`, `MAP.md` |

**Entry for AI:** read [`workspace/AGENTS.md`](workspace/AGENTS.md) first, then rules and docs under `workspace/`. For a ticket, open a file under [`al-run/current-task/`](al-run/current-task/).

**Scripts (from repo root):**

```powershell
powershell -File .operational-resources-use1000/al-run/scripts/start-task.ps1 -TaskFile ".operational-resources-use1000/al-run/current-task/<path-to-TASK.md>"
```
