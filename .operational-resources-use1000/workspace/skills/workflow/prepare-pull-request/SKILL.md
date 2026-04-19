# Skill: Prepare Pull Request

## TL;DR (VI)

- **Soát diff** trước: loại file lạ, **secret**, chỉnh nhầm **format** cả repo; tách refactor không liên quan sang PR khác nếu team khuyến khích.
- Mô tả PR là **hợp đồng** với reviewer: họ có thể verify mà không cần đoán ngữ cảnh.
- Ghi **risk** (migration, flag, cache, breaking API) và **rollback** (revert, feature flag off).

## Goal

Produce a **merge-ready** pull/merge request: **focused diff**, **clear description**, **verifiable test plan**, and **explicit risks** so reviewers can decide quickly.

## Preconditions

- Local branch is **rebased or merged** with target branch per team practice (or merge commit policy documented).
- Tests and linters are **defined** for the repo (`mvn`, `gradle`, `npm`, pre-commit, CI).

## Steps

1. **Inspect the diff**
   - Run `git diff main...HEAD` (or `origin/develop...`) and scan for **unintended** files, debug prints, `TODO` left in hot paths, and **secrets**.
   - Split **unrelated** changes into a follow-up PR if the team prefers small MRs.

2. **Run quality gates locally**
   - Execute **unit/integration** tests and **lint/format** commands your team expects before review.
   - Fix **flaky** failures or document **known** CI issues with a ticket link.

3. **Write the PR title**
   - Prefer **imperative** mood and scope: e.g. `Fix NPE in OrderMapper when dueDate is null`.
   - Include **ticket id** if convention requires: `[PROJ-123] …`.

4. **Write the description — What / Why / How to test**
   - **What:** bullet list of **user-visible** or **contract** changes.
   - **Why:** link **ticket** + one sentence business/technical reason.
   - **How to test:** numbered steps, sample **curl**, feature flag state, or “run `mvn test -Dtest=…`”.
   - **Screenshots / recordings** for UI changes.

5. **Risk and rollback**
   - Call out **DB migration**, **config** changes, **cache** invalidation, **breaking** API, **dual-write** periods.
   - State **rollback**: revert commit, run down migration, disable flag — whatever matches ops reality.

6. **Self-review**
   - Walk **`rules/08-review-checklist.md`** and **`skills/code-quality/review-code/README.md`** when used on the team.
   - For security-sensitive areas, cross-check **`skills/security/security-review/README.md`**.

7. **Metadata**
   - Set **labels**, **reviewers**, **milestone** per project rules.
   - Link **`current-task/<task>.md`** in the MR body when the task file drove the work.

8. **After push**
   - Confirm **CI** is green; respond to **bot** comments (coverage, conventional commit).
   - Mark **draft** until ready; avoid force-push noise unless team uses fixup flow.

## Output

- Pushed branch + filled MR/PR description ready for human review.

## References

- `skills/workflow/prepare-pull-request/README.md`
- `skills/workflow/prepare-pull-request/checklist.md`
- `rules/08-review-checklist.md`
- `skills/code-quality/review-code/README.md`
- `skills/security/security-review/README.md`
- `skills/workflow/implement-feature/README.md`
- `current-task/TEMPLATE.md` (§13 Definition of Done)
- `task-lifecycle/FROM-TICKET-TO-DONE.md` (§5 — Tạo MR)

**Last updated:** 2026-04-11
