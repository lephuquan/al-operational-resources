# Tutorial - Cach dung he thong `.operational-resources/`

## Muc tieu

Tai lieu nay huong dan ban van hanh he thong theo dung mo hinh:

- **AL:** doc task; **sau khi `start-task.ps1` pass va §8 du tai nguyen, AL la nguoi code + test bat buoc** toi AL done; cap nhat evidence vao task/log va doc contract neu task yeu cau.
- **Human:** sau handoff — review code, review testing evidence, tao MR, quyet dinh merge/close, tick §13.2, quyet dinh san pham/scope hoac chi dao AC som neu can.

Trang thai Done:

- **AL done:** code + test + evidence day du, san sang review.
- **Task done:** sau khi human review xong, tao MR, merge/close theo quy trinh ben ngoai.

---

## 1) Ban do thanh phan

- `SYSTEM-DEFINITION.md`: dinh nghia chuan van hanh.
- `current-task/`: noi duy nhat chua task canonical.
- `scripts/start-task.ps1`: input gate (fail-fast).
- `scripts/preflight-discovery.ps1`: discovery gate (pass/fail before task implementation).
- `scripts/close-task.ps1`: output gate (AL done + handoff report).
- `task-lifecycle/FROM-TICKET-TO-DONE.md`: luong day du ticket -> done.

---

## 2) Quick start (10-15 phut)

### Buoc 0 - Discovery gate cho task tho/khong ro dau vao

Khi task con mo hoac ban chua chac ve cong nghe (vi du Kafka, email, payment):

1. Copy `current-task/DISCOVERY-TEMPLATE.md`.
2. Yeu cau AL sinh "domain-specific discovery addendum" cho task do.
3. Ban nghien cuu va dien day du cau tra loi.
4. Chay discovery gate:

```powershell
powershell -File .operational-resources-use1000/scripts/preflight-discovery.ps1 -DiscoveryFile ".operational-resources-use1000/current-task/<discovery-file>.md"
```

5. Chi khi `Discovery preflight passed` va `Discovery ready = Yes` thi moi chuyen sang Buoc A.

Prompt goi y:

```text
Context:
- Raw task: current-task/YYYYMMDD-slug.md
- Discovery template: current-task/DISCOVERY-TEMPLATE.md

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

1. Copy `current-task/TEMPLATE.md`.
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
powershell -File .operational-resources-use1000/scripts/start-task.ps1 -TaskFile ".operational-resources-use1000/current-task/YYYYMMDD-slug.md"
```

Neu fail: sua dung section hoac pattern bi bao loi roi chay lai.

Input gate hien kiem tra them:

- path trong context pack (`Rules`, `Docs`, `Skills`) co ton tai that hay khong
- voi task `feature`: co tham chieu toi docs toi thieu (`docs/api/08-endpoint-list.md`, `docs/api/10-current-api-changes.md`, `docs/specs/feature-shelflog-items.md`) hay khong

### Buoc C - AL implement (mac dinh bat buoc, khong phai Human code chinh)

Sau input gate: **AL** thuc hien code + test theo AC va §8. Human khong thay the buoc nay tru khi task ghi ngoai le (xem `current-task/SCHEMA.md`).

#### C.1 - Human: **giao AL** trong Cursor (buoc thao tac)

1. Mo **Cursor** → **Chat / Composer / Agent** (che do co the sua file + chay lenh trong repo).
2. **Dinh kem** file task bang `@`:
   - **Folder mode:** `@.operational-resources-use1000/current-task/<slug>/TASK.md`
   - **Flat mode:** `@.operational-resources-use1000/current-task/YYYYMMDD-slug.md`
3. *(Tuy chon)* Them `@` cac file trong §8 (Rules, Docs, Skills) de neo ngữ canh.
4. Gui tin nhan: dung **prompt toi thieu** o `HUMAN-AL-WORKFLOW-GUIDE.md` → muc **"Bước B2 — Human: giao AL implement"**, hoac copy **"Suggested prompt"** trong §8 cua file task (chinh duong dan neu can).
5. De AL chay lien mach toi AL done; Human chi tra loi khi AL hoi quyet dinh san pham / ASK FIRST.

#### C.2 - Noi dung prompt goi y (cho AL thuc thi)

```text
Context:
- Current task: (file task da dinh kem bang @)
- Rules/docs/skills: doc theo bang section 8 trong task

Task:
- Doc task §2-§4 truoc khi sua code
- Implement theo AC (co the theo slice neu task lon)
- Khong vuot scope section 2
- Chay task_contract.required_test_command; luu evidence; cap nhat §4 §12 §13.1 va doc API/spec neu AC yeu cau

Expected output:
- Code changes + test updates
- Duong dan file evidence cho close-task.ps1
- Risk notes ngan (neu co)
```

**Tham chiếu day du (tiếng Việt + prompt mẫu):** `HUMAN-AL-WORKFLOW-GUIDE.md` — **Bước B2** và các bước **C–F** phía sau.

### Buoc D - Chay test va luu evidence

```powershell
.\mvnw.cmd -q test 2>&1 | Tee-Object -FilePath ".operational-resources-use1000/current-task/logs/YYYYMMDD-test-evidence.txt"
```

### Buoc E - Chay output gate (AL done)

```powershell
powershell -File .operational-resources-use1000/scripts/close-task.ps1 `
  -TaskFile ".operational-resources-use1000/current-task/YYYYMMDD-slug.md" `
  -TestEvidence ".operational-resources-use1000/current-task/logs/YYYYMMDD-test-evidence.txt"
```

Lenh nay tao handoff report trong `current-task/reports/`.

### Buoc F - Human gate (ngoai AL)

- Review code quality + scope fit.
- Review testing evidence.
- Tao MR + huong dan test.
- Quyết dinh merge/close.

---

## 3) Checklist van hanh chuan

Truoc khi AL code:

- [ ] (Neu task mo/unknown) Discovery gate da xong va `Discovery ready = Yes`
- [ ] Task nam trong `current-task/`
- [ ] Khong placeholder
- [ ] Co `task_contract`
- [ ] DoR da check
- [ ] Human da **giao AL** (Cursor: `@TASK.md` + prompt) — xem **Buoc C.1** / `HUMAN-AL-WORKFLOW-GUIDE.md` **Bước B2**

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
  - Them block `task_contract` theo `current-task/TEMPLATE.md`.
- **`Missing required pattern: Context pack Rules/Docs/Skills path`**
  - Trong section 8, phai co bang co cac dong bat dau bang `| Rules |`, `| Docs |`, `| Skills |`.
- **`Missing required pattern: MUST guidance`**
  - Trong section 10, phai co 3 dong: `- **MUST:**`, `- **SHOULD:**`, `- **ASK FIRST:**`.
- **`Missing AL Done subsection (13.1)`**
  - Tach section 13 thanh `13.1 AL Done` va `13.2 Human Done`.

---

## 5) Nguyen tac de he thong on dinh

- Mot task = mot file canonical trong `current-task/`.
- AL chi lam den `AL done`, khong tu merge/close.
- Moi thay doi contract API/architecture phai dong bo docs lien quan.
- Luon de lai trace: task file + log + report.

---

## 6) Tai lieu doc tiep

- `SYSTEM-DEFINITION.md`
- `task-lifecycle/FROM-TICKET-TO-DONE.md`
- `current-task/SCHEMA.md`
- `current-task/TEMPLATE.md`
- `current-task/reference/HUMAN-GATE-CHECKLIST.md`

**Last updated:** 2026-04-15
