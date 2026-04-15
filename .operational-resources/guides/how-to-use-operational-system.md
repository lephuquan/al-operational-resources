# Tutorial - Cach dung he thong `.operational-resources/`

## Muc tieu

Tai lieu nay huong dan ban van hanh he thong theo dung mo hinh:

- **AL:** doc task, implement theo AC, cap nhat test, chay test, cap nhat evidence vao task/log.
- **Human:** review code, review testing evidence, tao MR, quyet dinh merge/close.

Trang thai Done:

- **AL done:** code + test + evidence day du, san sang review.
- **Task done:** sau khi human review xong, tao MR, merge/close theo quy trinh ben ngoai.

---

## 1) Ban do thanh phan

- `SYSTEM-DEFINITION.md`: dinh nghia chuan van hanh.
- `docs/current-task/`: noi duy nhat chua task canonical.
- `scripts/start-task.ps1`: input gate (fail-fast).
- `scripts/preflight-discovery.ps1`: discovery gate (pass/fail before task implementation).
- `scripts/close-task.ps1`: output gate (AL done + handoff report).
- `task-lifecycle/FROM-TICKET-TO-DONE.md`: luong day du ticket -> done.

---

## 2) Quick start (10-15 phut)

### Buoc 0 - Discovery gate cho task tho/khong ro dau vao

Khi task con mo hoac ban chua chac ve cong nghe (vi du Kafka, email, payment):

1. Copy `docs/current-task/DISCOVERY-TEMPLATE.md`.
2. Yeu cau AL sinh "domain-specific discovery addendum" cho task do.
3. Ban nghien cuu va dien day du cau tra loi.
4. Chay discovery gate:

```powershell
powershell -File .operational-resources/scripts/preflight-discovery.ps1 -DiscoveryFile ".operational-resources/docs/current-task/<discovery-file>.md"
```

5. Chi khi `Discovery preflight passed` va `Discovery ready = Yes` thi moi chuyen sang Buoc A.

Prompt goi y:

```text
Context:
- Raw task: docs/current-task/YYYYMMDD-slug.md
- Discovery template: docs/current-task/DISCOVERY-TEMPLATE.md

Task:
- Analyze missing inputs for implementation readiness
- Generate domain-specific discovery questions (must-answer)
- Separate: critical blockers vs optional refinements

Expected output:
- Filled discovery checklist draft
- Concrete questions the human must answer
- Pass/fail recommendation for implementation readiness
```

### Buoc A - Tao task canonical

1. Copy `docs/current-task/TEMPLATE.md`.
2. Doi ten thanh `YYYYMMDD-slug.md`.
3. Dien day du:
   - Metadata
   - `task_contract`
   - AC
   - AC -> test mapping
   - Context pack (`Rules`, `Docs`, `Skills`)
   - `MUST / SHOULD / ASK FIRST`
   - `13.1 AL Done` va `13.2 Human Done`

### Buoc B - Chay input gate

Chay tai root repo:

```powershell
powershell -File .operational-resources/scripts/start-task.ps1 -TaskFile ".operational-resources/docs/current-task/YYYYMMDD-slug.md"
```

Neu fail: sua dung section hoac pattern bi bao loi roi chay lai.

Input gate hien kiem tra them:

- path trong context pack (`Rules`, `Docs`, `Skills`) co ton tai that hay khong
- voi task `feature`: co tham chieu toi docs toi thieu (`docs/api/08-endpoint-list.md`, `docs/api/10-current-api-changes.md`, `docs/specs/feature-shelflog-items.md`) hay khong

### Buoc C - Giao viec cho AL theo tung slice nho

Prompt goi y:

```text
Context:
- Current task: docs/current-task/YYYYMMDD-slug.md
- Rules/docs/skills: theo section 8 trong task

Task:
- Implement 1 vertical slice theo AC
- Khong vuot scope section 2

Expected output:
- Code changes
- Test updates
- Risk notes ngan
```

### Buoc D - Chay test va luu evidence

```powershell
.\mvnw.cmd -q test 2>&1 | Tee-Object -FilePath ".operational-resources/docs/current-task/logs/YYYYMMDD-test-evidence.txt"
```

### Buoc E - Chay output gate (AL done)

```powershell
powershell -File .operational-resources/scripts/close-task.ps1 `
  -TaskFile ".operational-resources/docs/current-task/YYYYMMDD-slug.md" `
  -TestEvidence ".operational-resources/docs/current-task/logs/YYYYMMDD-test-evidence.txt"
```

Lenh nay tao handoff report trong `docs/current-task/reports/`.

### Buoc F - Human gate (ngoai AL)

- Review code quality + scope fit.
- Review testing evidence.
- Tao MR + huong dan test.
- Quyết dinh merge/close.

---

## 3) Checklist van hanh chuan

Truoc khi AL code:

- [ ] (Neu task mo/unknown) Discovery gate da xong va `Discovery ready = Yes`
- [ ] Task nam trong `docs/current-task/`
- [ ] Khong placeholder
- [ ] Co `task_contract`
- [ ] DoR da check

Truoc khi handoff:

- [ ] AC -> test mapping da cap nhat
- [ ] Test command da chay that
- [ ] Evidence file ton tai
- [ ] `13.1 AL Done` da hoan thanh

Truoc khi dong task:

- [ ] Human da review code va evidence
- [ ] MR da tao
- [ ] Da merge/close theo process ben ngoai

---

## 4) Loi thuong gap va cach xu ly

- **`Missing required section: task_contract block`**
  - Them block `task_contract` theo `docs/current-task/TEMPLATE.md`.
- **`Missing required pattern: Context pack Rules/Docs/Skills path`**
  - Trong section 8, phai co bang co cac dong bat dau bang `| Rules |`, `| Docs |`, `| Skills |`.
- **`Missing required pattern: MUST guidance`**
  - Trong section 10, phai co 3 dong: `- **MUST:**`, `- **SHOULD:**`, `- **ASK FIRST:**`.
- **`Missing AL Done subsection (13.1)`**
  - Tach section 13 thanh `13.1 AL Done` va `13.2 Human Done`.

---

## 5) Nguyen tac de he thong on dinh

- Mot task = mot file canonical trong `docs/current-task/`.
- AL chi lam den `AL done`, khong tu merge/close.
- Moi thay doi contract API/architecture phai dong bo docs lien quan.
- Luon de lai trace: task file + log + report.

---

## 6) Tai lieu doc tiep

- `SYSTEM-DEFINITION.md`
- `task-lifecycle/FROM-TICKET-TO-DONE.md`
- `docs/current-task/SCHEMA.md`
- `docs/current-task/TEMPLATE.md`
- `docs/current-task/HUMAN-GATE-CHECKLIST.md`

**Last updated:** 2026-04-15
