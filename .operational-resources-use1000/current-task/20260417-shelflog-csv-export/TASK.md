# Task — ShelfLog: export shelf items to CSV (download)

## TL;DR (VI)

- Work item **SHELF-EXPORT-1**: thêm endpoint **GET** xuất **CSV** cho ShelfLog demo, cùng tham số lọc/phân trang với list; tối đa **5000** dòng mỗi lần; vượt cap trả **413** JSON (không trả CSV một phần).
- Discovery đã chốt: `DISCOVERY.md` (cùng thư mục). Contract API cập nhật `docs/api/08-endpoint-list.md`, `docs/api/10-current-api-changes.md`, và mô tả hành vi trong `docs/specs/feature-shelflog-items.md`.
- Tiền đề: API list/CRUD shelf items (SIM-DEMO-2) đã có trong codebase demo.

> **Convention:** Canonical file là `TASK.md` trong thư mục work item `20260417-shelflog-csv-export/`.

---

## Metadata (required)

| Field | Value |
|-------|--------|
| **Task type** | `feature` |
| **File ID** | `20260417-shelflog-csv-export` |
| **Ticket / issue** | SHELF-EXPORT-1 |
| **Status** | Review (AL done) |
| **Priority** | Medium |
| **Owner** | Human (local demo) |

### Machine-readable task_contract (required)

```yaml
task_contract:
  task_id: 20260417-shelflog-csv-export
  ticket: SHELF-EXPORT-1
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

- [x] Ticket/spec has a clear **goal** and **AC** (merged from discovery into this file).
- [x] **Scope** in §2 is filled; **out of scope** is explicit.
- [x] **Open questions** §11: no unresolved blockers for implementation.
- [x] **Skills + docs** listed in §8 (rules + skills + API/spec paths).
- [x] If scope diverges materially from discovery: will record in **§7 Revision**.

---

## 1. One-line summary (required)

Add a versioned **GET** endpoint that returns a downloadable **UTF-8 CSV** of shelf items for the ShelfLog demo, reusing list query semantics, enforcing a **5000-row** cap with **413** on violation, and mitigating **CSV injection** for spreadsheet safety.

---

## 2. Sources, scope, and assumptions (required)

### 2.1 Official links

- **Ticket / description:** SHELF-EXPORT-1; discovery: `DISCOVERY.md` (same folder).
- **Simulator brief:** `.operational-resources-use1000/simulator/DEMO-PROJECT-BRIEF.md` (ShelfLog demo context).
- **Spec:** `docs/specs/feature-shelflog-items.md` (extend with export behavior and limits).
- **API / contract:** Maintain `docs/api/08-endpoint-list.md`, `docs/api/10-current-api-changes.md`; align errors with `docs/api/05-error-handling.md` where applicable.
- **Prior shelf items work (reference):** SIM-DEMO-2 baseline is summarized in `.operational-resources-use1000/simulator/DEMO-PROJECT-BRIEF.md` and `docs/specs/feature-shelflog-items.md` (no separate task file in this repo snapshot).
- **Local runbook:** `.operational-resources-use1000/docs/setup/02-local-development.md`.

Contract doc paths used by automation checks (same filenames under `.operational-resources-use1000/docs/` in this repo): `docs/api/08-endpoint-list.md`, `docs/api/10-current-api-changes.md`, and `docs/specs/feature-shelflog-items.md`.

### 2.2 In scope / out of scope

| In scope (this task) | Out of scope (later / other tickets) |
|----------------------|----------------------------------------|
| `GET /api/v1/shelf-items/export` returning CSV attachment | Scheduled exports, email, S3 upload |
| Same query parameters as list (`page`, `size`, `category` as applicable) | New auth model or non-public demo |
| UTF-8 CSV, comma delimiter, dot decimals; no BOM by default | XLSX or other binary formats |
| Hard cap **5000** data rows per response; **413** + JSON if cap exceeded | Raising cap without new decision |
| Escape CSV injection prefixes (`=`, `+`, `-`, `@`) | Changing CRUD semantics for shelf items |

### 2.3 Assumptions and dependencies

- **Product dependency:** List + CRUD for `/api/v1/shelf-items` already exists (SIM-DEMO-2 baseline); this task adds export only.
- **Stack:** Spring Boot 3.x, existing ShelfLog persistence and validation rules for list queries.
- **Demo security:** Endpoints remain public for local demo; no new secrets in repo.

---

## 3. Acceptance criteria (required when provided by BA/lead)

- [x] **AC1:** `GET /api/v1/shelf-items/export` returns **200** with `Content-Type` including `text/csv` and UTF-8, and `Content-Disposition: attachment` with a sensible filename (for example containing `shelf-items` and date or run id).
- [x] **AC2:** CSV uses **comma** delimiter, **UTF-8** without BOM by default, includes a **header row**, and columns cover the exported shelf item fields in a stable order documented in spec/API docs.
- [x] **AC3:** Query parameters match the **list** endpoint contract for pagination and optional `category` filter (same semantics as `GET /api/v1/shelf-items`); default `page`/`size` behavior consistent with list unless spec documents an export-specific default.
- [x] **AC4:** If the filtered result would return **more than 5000 item rows** in one CSV response, the API returns **413 Payload Too Large** with a **JSON** error body using the same envelope as other API errors (no partial CSV body). *(Implemented as: **total matching rows** for the filter, before pagination, exceeds 5000 → 413; see §7.)*
- [x] **AC5:** Cell values that start with `=`, `+`, `-`, or `@` are written in a spreadsheet-safe way (for example prefix with tab or single-quote per agreed pattern); behavior documented briefly in spec or API notes.
- [x] **AC6:** Automated tests cover: successful CSV download (status, headers, non-empty body with header line), at least one **413** scenario when row cap is exceeded, and at least one cell proving injection mitigation.
- [x] **AC7:** `docs/api/08-endpoint-list.md`, `docs/api/10-current-api-changes.md`, and `docs/specs/feature-shelflog-items.md` are updated for the new route, limits, and error case.

### 3.1 Detailed behavior (recommended for features — avoids happy-path-only AI work)

| Scenario | Expected result | Notes |
|----------|-----------------|-------|
| Happy path: small filtered set | 200, CSV attachment, header + rows | Openable in common spreadsheet tools |
| Valid filters, under cap | Rows reflect filters and pagination | Same semantics as list |
| Matching rows exceed 5000 for this response | 413 JSON, no CSV stream | Per discovery Q2 |
| Field value starts with `=` | Escaped or prefixed so Excel does not treat as formula | Mitigation from discovery |
| Invalid query (same as list validation) | Same status/body style as list endpoint | Reuse validation rules |

---

## 4. AC → test mapping (required before “done” — except pure doc spike/chore)

| AC / goal | Description | Test (class#method or description) | Type |
|-----------|-------------|-------------------------------------|------|
| AC1 | CSV response headers and attachment | `ShelfItemExportControllerTest#export_returnsCsvWithDisposition` | integration |
| AC2 | Delimiter and header row | `ShelfItemExportControllerTest#export_csvFormatAndHeader` | integration |
| AC3 | Query params parity with list | `ShelfItemExportControllerTest#export_respectsCategoryAndPagination` (+ `export_invalidSize_returns400` for `size` bound) | integration |
| AC4 | Row cap returns 413 JSON | `ShelfItemExportControllerTest#export_exceedsCap_returns413` | integration |
| AC5 | Injection-safe cell | `ShelfItemExportControllerTest#export_escapesFormulaPrefix` | integration |
| AC6 | Suite coverage | `ShelfItemExportControllerTest` (methods above) | integration |
| AC7 | Docs updated | `docs/api/08-endpoint-list.md`, `10-current-api-changes.md`, `specs/feature-shelflog-items.md` updated in this MR | N/A + reason |

Update this table when **§7** changes AC.

---

## 5. Non-functional and technical constraints (fill when relevant)

- **Performance / SLI:** Hard cap 5000 rows per export; prefer indexed list query paths (reuse list strategy).
- **Security:** Demo public API; mitigate CSV formula injection per AC5.
- **API compatibility:** Additive endpoint under `/api/v1/`; no breaking change to existing list JSON contract.
- **Idempotency / retry:** GET export is safe to retry; identical inputs should yield equivalent CSV for stable sorts.

---

## 6. Task-type block — keep **one** block, delete the others

### A — FEATURE

- **User impact:** Operators can download shelf data as CSV for offline review.
- **Suggested implementation flow:** Reuse list query/service layer where possible; add controller method producing `text/csv`; stream or buffer within cap; map domain rows to CSV rows with escaping; integration tests with MockMvc; update `docs/api/08-endpoint-list.md`, `docs/api/10-current-api-changes.md`, `docs/specs/feature-shelflog-items.md`.
- **Future extension:** Async export, auth, higher caps behind feature flags — separate tasks.

---

## 7. Revision — requirement changes while in progress (required when anything changes)

| Date | Change | Type | Action (synced BA/lead? AC/tests updated?) |
|------|--------|------|--------------------------------------------|
| 2026-04-17 | Task file created from discovery SHELF-EXPORT-1 | Small | Initial AC and mapping |
| 2026-04-19 | AC4 clarified in task: 413 when **total matching rows** for filter exceed 5000 (not “rows in one page only”) | Small | Aligns implementation + docs with safety intent |

---

## 8. Context pack for AI — rules, docs, skills (required: at least rules + one skill)

Paths AI should read (repo-relative where noted):

| Kind | Paths |
|------|--------|
| Rules | `.operational-resources-use1000/rules/00-personal-priority.md`, `.operational-resources-use1000/rules/02-coding-standards.md`, `.operational-resources-use1000/rules/03-api-development.md`, `.operational-resources-use1000/rules/07-testing.md` |
| Docs | `.operational-resources-use1000/docs/api/01-README.md`, `.operational-resources-use1000/docs/api/05-error-handling.md`, `.operational-resources-use1000/docs/api/07-pagination-filtering.md`, `.operational-resources-use1000/docs/api/08-endpoint-list.md`, `.operational-resources-use1000/docs/api/10-current-api-changes.md`, `.operational-resources-use1000/docs/specs/feature-shelflog-items.md`, `.operational-resources-use1000/docs/setup/02-local-development.md`, `.operational-resources-use1000/simulator/DEMO-PROJECT-BRIEF.md`, `current-task/20260417-shelflog-csv-export/DISCOVERY.md` |
| Skills | `.operational-resources-use1000/skills/workflow/implement-feature/SKILL.md`, `.operational-resources-use1000/skills/backend/create-rest-api/SKILL.md`, `.operational-resources-use1000/skills/testing/write-integration-test/README.md`, `.operational-resources-use1000/skills/error-handling/api-error-response-format/SKILL.md` |

**Suggested prompt (copy):**  
Read this `TASK.md` first, then `DISCOVERY.md` in the same folder. Follow rules and skills in the table. Reuse existing list semantics; do not add Maven starters or change global security architecture without **ASK FIRST** in §10.

**Human — giao AL implement:** sau khi `start-task.ps1` pass, mở Cursor → Chat/Agent → `@` file `TASK.md` này → dán prompt trên hoặc prompt tối thiểu trong **`../../HUMAN-AL-WORKFLOW-GUIDE.md`** (**Bước B2**); chi tiết thao tác **`../../guides/how-to-use-operational-system.md`** (**C.1**).

---

## 9. Execution checklist (customize)

- [x] Confirm list endpoint query contract in code matches §3.1 expectations.
- [x] Implement export endpoint + CSV mapping + cap + escaping.
- [x] Add integration tests for AC1–AC6.
- [x] Run `./mvnw.cmd -q test` and save evidence under `logs/` in this work item folder.
- [x] Update API and spec markdown files (AC7).

---

## 10. Detailed guidance for AI (required — at least three items)

- **MUST:** Enforce the **5000-row** cap per response; on violation return **413** with JSON error envelope consistent with `docs/api/05-error-handling.md`, never a partial CSV body.
- **MUST:** Apply **CSV injection** mitigation for leading `=`, `+`, `-`, `@` in exported cell values.
- **SHOULD:** Reuse the existing list service/repository path to avoid divergent filter logic; add focused integration tests (MockMvc or project standard).
- **SHOULD:** Document the export route, cap, and 413 behavior in `docs/api/08-endpoint-list.md` and `docs/api/10-current-api-changes.md`.
- **ASK FIRST:** New Maven dependencies, shared global exception contract changes beyond this endpoint, or raising/removing the row cap.

---

## 11. Open questions, risks, and blockers

- None for implementation start; discovery unknowns U-01 and U-02 are closed.
- **Residual risk:** Very wide rows or large text fields could still stress memory below row cap; monitor in demo and document if observed.

---

## 12. Progress log

- **[2026-04-17]** Authored full `TASK.md` from `DISCOVERY.md` and template; ready for `start-task.ps1` gate.
- **[2026-04-17]** Ran `start-task.ps1` successfully; session written under `runtime/20260417-shelflog-csv-export.task.session.json`.
- **[2026-04-19]** Implemented `GET /api/v1/shelf-items/export` (CSV, cap via total match > 5000 → `SHELF_413_EXPORT`, formula-safe cells), `ShelfItemExportControllerTest`, `ExportTooLargeException`, `ShelfItemCsvFormatter`, `countByCategory`; updated API/spec docs under `.operational-resources-use1000/docs/`.
- **[2026-04-19]** Test evidence: `logs/20260419-shelflog-export-test-evidence.txt` (command `./mvnw.cmd -q test`, exit **0**).
- **[2026-04-16]** Ops: canonical `current-task/` tree moved from `.operational-resources-use1000/docs/current-task/` to `.operational-resources-use1000/current-task/`; scripts + docs paths updated; §8 adjusted so `start-task.ps1` resolves only existing files.

---

## 13. Definition of Done (check before MR)

### 13.1 AL Done (must be complete before handoff)

- [x] §0 Definition of Ready fully checked before implementation
- [x] Code + tests match §3–4 (and §7 if revised)
- [x] Required test command in `task_contract.required_test_command` executed and evidence saved
- [x] §4 AC → test mapping updated to final state
- [x] §12 progress log contains implementation + test evidence summary

### 13.2 Human Done (outside AL execution)

- [ ] Human reviewed code quality and scope fit
- [ ] Human reviewed testing evidence
- [ ] Human created MR with test instructions
- [ ] Human decided merge/close in external process

---

**Last updated:** 2026-04-19
