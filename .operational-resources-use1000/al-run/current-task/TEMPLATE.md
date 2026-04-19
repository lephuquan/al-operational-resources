# Task — [Short title]

## TL;DR (VI)

- Copy file này → đổi tên `YYYYMMDD-slug.md` → xóa khối §6 không dùng.
- Phần **hướng dẫn và tiêu đề** giữ **English**; nội dung điền có thể VI hoặc EN tùy ticket.
- Mỗi task **một file**, chỉ trong `current-task/`.

> **Convention:** One task = **one file** `YYYYMMDD-task-name.md` under **only** `current-task/`. Do not duplicate tasks under `rules/`.  
> Copy this file → rename → remove sections you do not need (by task type).

> **Execution (this repo):** After `start-task.ps1` passes and §8 is sufficient, **AL is the mandatory primary implementer** for code and tests through **AL done**; humans own **post-handoff** review, MR, merge, **§13.2**, and product/scope. Exceptions: document in **§7** / **§11**. See `SCHEMA.md` — Role split.

---

## Metadata (required)

| Field | Value |
|-------|--------|
| **Task type** | `feature` \| `bugfix` \| `refactor` \| `spike` \| `chore` \| `ops` |
| **File ID** | `YYYYMMDD-slug.md` |
| **Ticket / issue** | Link or id (e.g. PROJ-123) |
| **Status** | Draft \| In Progress \| Review \| Blocked \| Done |
| **Priority** | High \| Medium \| Low |
| **Owner** | (you / team) |

### Machine-readable task_contract (required)

```yaml
task_contract:
  task_id: YYYYMMDD-slug
  ticket: PROJ-123
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

## 0. Definition of Ready — before asking AI to implement (checkboxes)

Complete **before** large implementation; if not ready — note in §11 or set status **Blocked**.

- [ ] Ticket/spec has a clear **goal** and **AC** (or explicitly: “No separate AC — technical goal only: …”).
- [ ] **Scope** in §2 is filled; **out of scope** is explicit.
- [ ] **Open questions** §11: no unresolved blockers — or **temporary assumptions** are written so AI can proceed (to confirm later).
- [ ] **Skills + docs** listed in §8 (at least `rules/` + one relevant skill).
- [ ] **A1:** §8 đã tỉa — tổng số path trong backtick trên 3 dòng **Rules / Docs / Skills** ≤ **12** (hoặc ghi lý do ngoại lệ trong §11).
- [ ] **A2:** **§2.4** đã điền với anchor `src/...` tới chỗ sửa chính (hoặc *N/A — doc-only* có path doc).
- [ ] If scope diverges materially from the ticket: recorded in **§7 Revision** and (when needed) **synced with BA/lead**.

---

## 1. One-line summary (required)

[One sentence: what, for whom, business or technical outcome.]

---

## 2. Sources, scope, and assumptions (required)

### 2.1 Official links

- **Ticket / description:** (link or short summary)
- **Spec:** `docs/specs/...` (if any)
- **API / contract:** `docs/api/...` (if touched)
- **Related ADR:** `docs/decisions/README.md` (index) or `docs/decisions/NNN-topic.md` (if any)

### 2.2 In scope / out of scope

| In scope (this task) | Out of scope (another task / later) |
|----------------------|----------------------------------------|
| … | … |

### 2.3 Assumptions and dependencies

- **Assumptions** (if not confirmed with BA): …
- **Dependencies** (other team, service, feature flag, DB migration): …

### 2.4 Implementation anchors (recommended — **A2**)

Neo AL vào **code thật** (đọc trước khi sửa; tránh AL đoán pattern). Bảng gợi ý:

| Area | Path (`src/...` hoặc test) |
|------|----------------------------|
| Entry (controller / route) | `src/main/java/.../YourController.java` |
| Domain / use case | `src/main/java/.../YourService.java` |
| Tests tham chiếu | `src/test/java/.../YourIT.java` |

Xóa dòng không dùng. Nếu task chỉ doc — ghi *N/A — doc-only* và trỏ file doc cần sửa trong §2.1.

---

## 3. Acceptance criteria (required when provided by BA/lead)

If there is no separate AC — write: *“No separate AC — technical goal: …”* and still provide verifiable checklists.

- [ ] AC1: …
- [ ] AC2: …

### 3.1 Detailed behavior (recommended for features — avoids happy-path-only AI work)

| Scenario | Expected result | Notes |
|----------|-----------------|-------|
| Happy path | … | |
| Business / validation error | … | error code / HTTP |
| Edge case (null, empty, concurrent, …) | … | |
| Future change (extensibility) | … | optional: stable interface, feature flag |

---

## 4. AC → test mapping (required before “done” — except pure doc spike/chore)

| AC / goal | Description | Test (class#method or description) | Type |
|-----------|-------------|-------------------------------------|------|
| … | … | … | unit / IT / E2E / N/A + reason |

Update this table when **§7** changes AC.

---

## 5. Non-functional and technical constraints (fill when relevant)

- **Performance / SLI:** (e.g. p95, batch size)
- **Security:** (authz, PII, audit)
- **API compatibility / versioning:** breaking or not
- **Idempotency / retry:** (if external integration)

---

## 6. Task-type block — keep **one** block, delete the others

### A — FEATURE

- **User impact:** …
- **Suggested implementation flow:** DTO + validation → service → repo/DB → controller → tests → if contract changes: `docs/api/08-endpoint-list.md`, `docs/api/10-current-api-changes.md`, and `docs/api/12-openapi-source-of-truth.md` when applicable.
- **Future extension:** (optional) extension points without breaking contract — here or §3.1.

### B — BUGFIX

- **Symptom / business impact:** …
- **Evidence:** logs, input, environment
- **Reproduction:** …
- **Fix direction and regression tests:** …

### C — REFACTOR

- **Smell / risk:** …
- **Behavior unchanged:** (unless ticket allows change)
- **Strategy and regression:** …

### D — SPIKE / CHORE / OPS

- **Output:** doc / PoC / runbook
- **AC → Test:** may be N/A + reason

---

## 7. Revision — requirement changes while in progress (required when anything changes)

When AC or scope **changes** vs. task start (even small), add a row — keeps context for you and AI.

| Date | Change | Type | Action (synced BA/lead? AC/tests updated?) |
|------|--------|------|--------------------------------------------|
| YYYY-MM-DD | Short description | Small (wording) / Medium (new AC) / **Large** (business pivot) | e.g. updated §3–4; needs ticket PROJ-456 |

**Rules:**

- **Small change:** update §3–4 and checklists; one line here.
- **Large change:** pause implementation until agreed with BA/lead; or split task / new ticket — note in Action column.

---

## 8. Context pack for AI — rules, docs, skills (required: at least rules + one skill)

**Curation:** trước khi chốt §8, xem bảng gợi ý [`reference/AL-ACCURACY-SOLUTION-MATRIX.md`](reference/AL-ACCURACY-SOLUTION-MATRIX.md) (độ rộng §8, neo spec/code, gate).

**A1:** Trên **3 dòng** `Rules` / `Docs` / `Skills`, tổng số đường dẫn trong **backtick** nên **≤ 12**. README/brief/setup dài → để **§2.1**, không nhồi §8. **A2:** neo code trong **§2.4**, không trùng lặp hàng loạt path `src/` trong §8 (tránh vượt ngưỡng và trùng gate).

Paths AI should read (fill real paths under `.operational-resources-use1000/workspace/…` or repo; delete unused rows):

| Kind | Paths (examples) |
|------|------------------|
| Rules | `.operational-resources-use1000/workspace/rules/00-personal-priority.md`, … |
| Docs | `.operational-resources-use1000/workspace/docs/architecture/02-system-overview.md`, … |
| Skills | `.operational-resources-use1000/workspace/skills/backend/create-rest-api/SKILL.md`, … |

**Suggested prompt (copy):**  
“Read this task file first. Follow the rules and skills in the table above. Do not add dependencies or change architecture broadly without asking.”

**Human — how to assign AL to implement (after `start-task.ps1` passes):** open Cursor Chat/Composer/Agent, attach this task file with `@`, paste the prompt above or the minimal prompt in **`../HUMAN-AL-WORKFLOW-GUIDE.md`** section **Bước B2**; step-by-step also in **`../../workspace/guides/how-to-use-operational-system.md`** section **C.1**.

---

## 9. Execution checklist (customize)

- [ ] …
- [ ] …

---

## 10. Detailed guidance for AI (required — at least three items)

- **MUST:** … (e.g. Bean Validation on DTOs, do not log PII)
- **SHOULD:** … (e.g. add integration test for new endpoint)
- **ASK FIRST:** … (e.g. new starter dependency, shared schema change)

---

## 11. Open questions, risks, and blockers

- … (empty = none; or “waiting on X”)

---

## 12. Progress log

- **[YYYY-MM-DD]** What you did / found / decided (link §7 if scope changed)

---

## 13. Definition of Done (check before MR)

### 13.1 AL Done (must be complete before handoff)

- [ ] §0 Definition of Ready fully checked before implementation
- [ ] Code + tests match §3–4 (and §7 if revised)
- [ ] Required test command in `task_contract.required_test_command` executed and evidence saved
- [ ] §4 AC -> test mapping updated to final state
- [ ] §12 progress log contains implementation + test evidence summary

### 13.2 Human Done (outside AL execution)

- [ ] Human reviewed code quality and scope fit
- [ ] Human reviewed testing evidence
- [ ] Human created MR with test instructions
- [ ] Human decided merge/close in external process

---

**Last updated (template):** 2026-04-17
