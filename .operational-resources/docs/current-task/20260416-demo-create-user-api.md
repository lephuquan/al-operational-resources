# Task — Demo: simple POST create user API

## TL;DR (VI)

- Task nhỏ để thử quy trình: một endpoint **POST** tạo user tối giản (JSON in, JSON out), validation cơ bản, test + evidence cho AL done.
- Không chạy full kịch bản simulation; vẫn bám contract task trong `docs/current-task/`.
- Human: review, MR, merge, close ngoài AL.

> **Convention:** One task = one file under `docs/current-task/` only.

---

## Metadata (required)

| Field | Value |
|-------|--------|
| **Task type** | `chore` |
| **File ID** | `20260416-demo-create-user-api.md` |
| **Ticket / issue** | DEMO-USER-1 |
| **Status** | Review |
| **Priority** | Low |
| **Owner** | Human (local demo) |

### Machine-readable task_contract (required)

```yaml
task_contract:
  task_id: 20260416-demo-create-user-api
  ticket: DEMO-USER-1
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

- [x] Ticket/spec has a clear **goal** and **AC** (or explicitly: “No separate AC — technical goal only: …”).
- [x] **Scope** in §2 is filled; **out of scope** is explicit.
- [x] **Open questions** §11: no unresolved blockers — or **temporary assumptions** are written so AI can proceed (to confirm later).
- [x] **Skills + docs** listed in §8 (at least `rules/` + one relevant skill).
- [x] If scope diverges materially from the ticket: recorded in **§7 Revision** and (when needed) **synced with BA/lead**.

---

## 1. One-line summary (required)

Add a minimal `POST /api/v1/users` endpoint that accepts JSON, validates input, persists a user entity, returns 201 with created representation, with tests and evidence for handoff.

---

## 2. Sources, scope, and assumptions (required)

### 2.1 Official links

- **Ticket / description:** Local demo DEMO-USER-1 (no external tracker).
- **Spec:** None dedicated; scope defined in §3 of this file.
- **API / contract:** Update `.operational-resources/docs/api/08-endpoint-list.md` and `.operational-resources/docs/api/10-current-api-changes.md` when the endpoint is implemented.
- **Related ADR:** None required for this demo.

### 2.2 In scope / out of scope

| In scope (this task) | Out of scope (another task / later) |
|----------------------|----------------------------------------|
| Single `POST /api/v1/users` (JSON body: at least `email`, optional `name`) | `GET`/`PUT`/`DELETE` users, listing, pagination |
| One JPA entity + repository + service + controller slice | OAuth2/JWT, roles, multi-tenant |
| Bean Validation on request DTO | Email verification, password reset flows |
| Integration test(s) with profile `test` (H2) | Testcontainers, production hardening |

### 2.3 Assumptions and dependencies

- **Assumptions:** Repo already runs Spring Boot with JPA and test profile (H2) per existing project setup; no new Maven starters unless justified and asked first.
- **Dependencies:** None on other tickets; optional: ShelfLog demo tasks are unrelated.

---

## 3. Acceptance criteria (required when provided by BA/lead)

- [x] **AC1:** `POST /api/v1/users` with valid JSON returns **201** and a JSON body including a stable identifier for the created user (e.g. `id`) and echoed `email` (and `name` if provided).
- [x] **AC2:** Duplicate **email** (same email posted twice) returns **409** (or documented **400** if 409 is not used) with a consistent error envelope used elsewhere in the app; behavior must be documented in §3.1 and tests.
- [x] **AC3:** Invalid body (missing `email`, invalid email format, blank `name` when field sent empty) returns **400** with a parseable error payload.
- [x] **AC4:** `./mvnw.cmd -q test` passes with new/updated tests covering AC1–AC3 under profile `test`.

### 3.1 Detailed behavior (recommended for features — avoids happy-path-only AI work)

| Scenario | Expected result | Notes |
|----------|-----------------|-------|
| Happy path | 201 + body with id and email | Persist one row |
| Duplicate email | **409** + `USER_409_DUPLICATE_EMAIL` (same `ApiErrorResponse` envelope) | Case-insensitive match on `email` before insert |
| Missing email | 400 | Validation error |
| Invalid email format | 400 | Bean Validation or manual check |

---

## 4. AC → test mapping (required before “done” — except pure doc spike/chore)

| AC / goal | Description | Test (class#method or description) | Type |
|-----------|-------------|-------------------------------------|------|
| AC1 | Create valid user | `UserControllerIT#create_returns201` | IT |
| AC2 | Duplicate email rejected | `UserControllerIT#create_duplicateEmail_returnsConflict` | IT |
| AC3 | Validation errors | `UserControllerIT#create_invalidBody_returns400` | IT |
| AC4 | Full suite green | `./mvnw.cmd -q test` (command) | command |

Update this table when **§7** changes AC.

---

## 5. Non-functional and technical constraints (fill when relevant)

- **Security:** Demo only; do not log raw secrets; no auth in scope.
- **API compatibility:** New endpoint under `/api/v1/`; document in API files when added.
- **Persistence:** Use JPA entity table for demo users (name chosen in implementation, documented in handoff).

---

## 6. Task-type block — keep **one** block, delete the others

### D — SPIKE / CHORE / OPS

- **Output:** Working minimal endpoint + tests + doc touch for endpoint list/changelog.
- **AC → Test:** mapped in §4; no N/A.

---

## 7. Revision — requirement changes while in progress (required when anything changes)

| Date | Change | Type | Action (synced BA/lead? AC/tests updated?) |
|------|--------|------|--------------------------------------------|
| 2026-04-16 | Initial task for demo user POST | Small | baseline |
| 2026-04-16 | Implemented POST `/api/v1/users`, ITs, API docs; duplicate email uses 409 | Medium | AC/tests/docs updated |

**Rules:**

- **Small change:** update §3–4 and checklists; one line here.
- **Large change:** pause implementation until agreed with BA/lead; or split task / new ticket — note in Action column.

---

## 8. Context pack for AI — rules, docs, skills (required: at least rules + one skill)

Paths AI should read (fill real paths; delete unused rows):

| Kind | Paths (examples) |
|------|------------------|
| Rules | `.operational-resources/rules/00-personal-priority.md`, `.operational-resources/rules/02-coding-standards.md` |
| Docs | `.operational-resources/docs/api/01-README.md`, `.operational-resources/docs/architecture/06-backend-layers-and-dependencies.md` |
| Skills | `.operational-resources/skills/backend/create-rest-api/SKILL.md`, `.operational-resources/skills/workflow/implement-feature/README.md` |

**Suggested prompt (copy):**  
“Read this task file first. Follow the rules and skills in the table above. Implement only §2.2 in-scope items. Do not add dependencies or change architecture broadly without asking.”

---

## 9. Execution checklist (customize)

- [x] Add DTO + validation for create user request.
- [x] Add entity/repository/service/controller under an agreed package (match existing app package conventions).
- [x] Add IT tests for AC1–AC3 (profile `test`).
- [x] Update API list and changelog under `.operational-resources/docs/api/`.
- [x] Run `./mvnw.cmd -q test` and attach evidence path to §12.

---

## 10. Detailed guidance for AI (required — at least three items)

- **MUST:** Use Bean Validation (or equivalent) on the request body; return consistent HTTP error responses for 400/409 paths used in this repo.
- **SHOULD:** Prefer `@SpringBootTest` + `MockMvc` (or existing project test style) for the new endpoint ITs.
- **ASK FIRST:** Any new Maven dependency, shared exception handler change affecting all APIs, or database migration tool (Flyway/Liquibase) introduction.

---

## 11. Open questions, risks, and blockers

- None for this demo scope.

---

## 12. Progress log

- **[2026-04-16]** Task file created for demo POST user API (AL not started until human runs input gate).
- **[2026-04-16]** AL: implemented `POST /api/v1/users` (`demo.user` package), JPA table `demo_users`, `ConflictException` + handler for **409** (`USER_409_DUPLICATE_EMAIL`), ITs `UserControllerIT`. Test evidence: `.operational-resources/docs/current-task/logs/20260416-demo-create-user-test-evidence.txt` (command: `./mvnw.cmd -q test`).

---

## 13. Definition of Done (check before MR)

### 13.1 AL Done (must be complete before handoff)

- [x] §0 Definition of Ready fully checked before implementation
- [x] Code + tests match §3–4 (and §7 if revised)
- [x] Required test command in `task_contract.required_test_command` executed and evidence saved
- [x] §4 AC -> test mapping updated to final state
- [x] §12 progress log contains implementation + test evidence summary

### 13.2 Human Done (outside AL execution)

- [ ] Human reviewed code quality and scope fit
- [ ] Human reviewed testing evidence
- [ ] Human created MR with test instructions
- [ ] Human decided merge/close in external process

---

**Last updated (task):** 2026-04-16
