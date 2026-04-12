# Skill: Investigate Bug

## TL;DR (VI)

- **Không đoán mù**: mỗi bước có **bằng chứng** (log redacted, request id, version, bước tái hiện).
- **Thu hẹp** từ triệu chứng → layer (API / service / DB / integration) bằng tái hiện cục bộ hoặc log/trace.
- **Failing test** trước fix khi khả thi; fix **nhỏ nhất** giải quyết root cause; cập nhật **AC → test** trong task.

## Goal

Investigate and fix a defect **methodically** so the root cause is **evidence-based**, the fix is **minimal**, and regressions are **prevented** by tests or documented checks.

## Preconditions

- A **ticket** or internal report with symptom; ideally a **`docs/current-task/*.md`** file with **Task type = bugfix** and block **B — BUGFIX** filled (`docs/current-task/TEMPLATE.md`).
- Access to **logs** or stack traces (redact secrets/PII before sharing in prompts).

## Steps

1. **Capture the facts**
   - Record: environment (prod/stage/local), **version/commit**, user or system **inputs**, **time range**, **request/correlation id** if available.
   - Paste stack trace into task or notes; follow **`skills/debugging/analyze-stacktrace/README.md`** to find the **root frame** and **`Caused by`**.

2. **Reproduce**
   - Aim for **minimal** reproduction: smallest API call, job, or unit scenario.
   - If only reproducible in prod: use **`skills/debugging/debug-production-issue/README.md`** for safe triage, then reproduce on **local/staging** with redacted data when possible.
   - For local dev workflows: **`skills/debugging/debug-backend-error/README.md`**.

3. **Form hypotheses — rank and falsify**
   - List 2–5 plausible causes (config, null edge, race, bad migration, external dependency).
   - For each hypothesis, define **one experiment** (log line, breakpoint, temporary assertion, DB query) that **confirms or rules out** the cause.

4. **Narrow the blast radius**
   - Identify **single module/class** responsible before editing widely.
   - Avoid drive-by refactors in the same MR unless required for the fix.

5. **Regression test first (when feasible)**
   - Add a **failing** unit or integration test that demonstrates the bug — **`skills/testing/write-unit-test/README.md`**, **`skills/testing/write-integration-test/README.md`**.
   - If too expensive (flaky environment, hardware), document **manual repro steps** in the task and add a lighter test proxy.

6. **Implement the minimal fix**
   - Change the **smallest** surface that addresses the **root** cause, not only the symptom.
   - Keep behavior for **unaffected paths** unchanged; watch **API compatibility** if the bugfix touches contracts.

7. **Verify**
   - Run **targeted** tests then full **`mvn test`** / team command.
   - Re-run the **exact** reproduction path; add a **negative** case if the bug was a silent wrong result.

8. **Document**
   - Update task **Progress log** and **AC → Test** mapping.
   - Append a short entry to **`notes/debugging/bug-history.md`** if the bug is **recurring** or **subtle** (search keywords for the next person).

9. **Handoff**
   - Prepare MR with **What / Why / How to test** — **`skills/workflow/prepare-pull-request/SKILL.md`**.
   - Note **risk** (data migration, cache, rollout) for reviewers.

## Output

- Root cause summary (1–3 sentences) with evidence pointers.
- Code fix + tests (or documented manual verification).
- Updated task file and optional `bug-history` entry.

## References

- `skills/workflow/investigate-bug/README.md`
- `skills/workflow/investigate-bug/checklist.md`
- `docs/current-task/TEMPLATE.md` (§6B — BUGFIX)
- `docs/current-task/README.md`
- `skills/debugging/analyze-stacktrace/README.md`
- `skills/debugging/debug-backend-error/README.md`
- `skills/debugging/debug-production-issue/README.md`
- `skills/testing/write-unit-test/README.md`
- `skills/testing/write-integration-test/README.md`
- `skills/testing/create-test-data/README.md`
- `skills/workflow/prepare-pull-request/SKILL.md`
- `notes/debugging/bug-history.md`

**Last updated:** 2026-04-11
