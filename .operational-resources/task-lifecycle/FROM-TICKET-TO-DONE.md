# Từ ticket đến Done — luồng một task (AL + `.operational-resources/`)

## TL;DR (VI)

- **Input chuẩn:** một file trong `docs/current-task/` + ticket/AC; **output:** code + test đã chạy + MR rõ ràng + task đóng có kiểm soát.
- Đọc **rules → docs → task → skills** theo thứ tự dưới đây; triển khai theo **cụm nhỏ** với prompt có cấu trúc.
- **Triển khai / duy trì** tài liệu (bootstrap, review): `guides/README.md`.

---

## 1. Mục tiêu & vai trò

Phối hợp giữa:

- Ticket / BA / Lead (nguồn yêu cầu chính thức)
- Bạn (chốt hướng, quyết định)
- AL (thực thi theo prompt + tài nguyên trong `.operational-resources/`)

**Nguyên tắc:** Ticket team là **nguồn yêu cầu chính thức**; `.operational-resources/` là **ngữ cảnh + quy tắc cá nhân + playbook** — không thay quyết định BA/Lead khi conflict; ưu tiên sync trước khi merge.

---

## 2. Đầu vào (nguồn & điều kiện)

| Nguồn | Vai trò |
|-------|--------|
| Ticket (Jira/Azure/…) | AC, scope, deadline, link thiết kế |
| BA / Lead / Tech | Ràng buộc nghiệp vụ, ưu tiên, exception |
| `.operational-resources/` | Rules, docs, skills, `current-task`, notes |

**Trước khi nhờ AL code lớn:** ticket phải đủ để biết *làm gì* và *xong khi nào*; nếu thiếu — ghi câu hỏi trong file task và hỏi stakeholder trước.

---

## 3. Input / Output chuẩn (task file)

### Input (bắt buộc)

- Một file task: `docs/current-task/YYYYMMDD-*.md`
- Link ticket + AC
- Scope + constraints quan trọng

### Output (bắt buộc)

- Code trong `src/` (hoặc phạm vi code thật của dự án)
- Test đã **chạy** (theo yêu cầu task/team)
- Self-review + risk notes
- MR/PR: What / Why / How to test

---

## 4. Definition of Ready (DoR)

Trước khi AL implement lớn:

- [ ] Mục tiêu rõ: feature / bugfix / refactor
- [ ] AC hoặc tiêu chí tương đương để biết done
- [ ] Scope và non-goals
- [ ] Context pack: rules + docs + ít nhất một skill liên quan
- [ ] Open questions (nếu có) + owner xác nhận

Chưa đạt DoR → làm rõ task trước, không đẩy AL đoán ngầm.

---

## 5. Luồng từng bước (chi tiết)

### Bước 1 — Thu thập yêu cầu & đóng gói ngữ cảnh

**1.1 Đọc có thứ tự** (cho bạn và prompt AL)

1. `rules/00-personal-priority.md` → `AGENTS.md`
2. `rules/01-project-overview.md`, `02-coding-standards.md`, các rule liên quan (API, backend, security, testing)
3. `docs/project-overview.md` → `docs/architecture/01-README.md` → `docs/architecture/02-system-overview.md`
4. `docs/setup/` khi cần local/profile/env (`docs/setup/01-README.md`)
5. `docs/specs/README.md` + `feature-*.md` liên quan + `docs/api/` nếu đụng API
6. `docs/current-task/` — tạo/cập nhật file task (1.2)
7. `skills/README.md` — chọn skill phù hợp
8. Ticket — copy AC, link, id vào task (**không** paste secret)

**1.2 Một file task duy nhất** `docs/current-task/YYYYMMDD-ten-task.md`

- Copy `docs/current-task/TEMPLATE.md`; không đặt task trong `rules/`.
- Điền tối thiểu: metadata, tóm tắt, ticket, AC, **AC → Test**, **một khối §6** (feature/bugfix/refactor/…), hướng dẫn AI, open questions.
- **Bugfix:** bám `skills/workflow/investigate-bug/README.md` (bằng chứng → tái hiện → fix tối thiểu → regression).
- Cập nhật dashboard `docs/current-task/README.md`.

**Output:** file task đủ context để `@` trong Cursor.

### Bước 2 — Gọi AL triển khai

1. Prompt: **Context** (task + rules) → **Task** (bước cụ thể) → **Constraint** (không đổi X).
2. Feature: `skills/workflow/implement-feature/README.md` (+ `SKILL.md`). Bugfix: thêm `investigate-bug` hub.
3. Chỉ định skill chi tiết từ `skills/README.md` (REST, JPA, test, …).
4. Làm **từng cụm** (vertical slice); sau mỗi cụm: review diff, build/test khi có thể.

**Output:** code + test; cập nhật Progress log trong task.

### Bước 3 — Testing

| Việc | Gợi ý |
|------|--------|
| AL sinh/sửa test | `skills/testing/write-unit-test/README.md`, `write-integration-test/README.md` |
| Bạn chạy thật | `./mvnw test` (hoặc lệnh team) — **bắt buộc** trước MR |
| Thiếu test | Bổ sung hoặc ghi lý do trong task/MR |

**AC → Test** trong file task (theo `TEMPLATE.md`): mỗi AC có test hoặc lý do miễn trừ.

Không coi “AL đã viết test” là đủ nếu **chưa chạy** local.

### Bước 4 — Review chất lượng

1. `rules/08-review-checklist.md` + `skills/code-quality/review-code/` (nếu dùng).
2. Security / secrets / PII: `rules/06-security.md`, `docs/knowledge-base/security-privacy-rules.md` khi có.
3. Đổi API/kiến trúc → đồng bộ `docs/api/`, specs, architecture tương ứng.
4. CI team (nếu có): build/test pass trước merge.

### Bước 5 — Tạo MR/PR

1. Khung: `skills/workflow/prepare-pull-request/README.md` (`checklist.md`, `examples.md`).
2. Branch/commit theo convention team.
3. Mô tả: **What / Why / How to test** + link ticket + breaking (nếu có).
4. Tóm tắt: đã chạy test, checklist xong.
5. Không push secret; draft MR theo policy team.

`AGENTS.md`: không auto-push — bạn chủ động push và tạo MR.

### Bước 6 — Đóng task

1. Cập nhật `docs/current-task/README.md` (dashboard/status).
2. Learned notes vào `notes/` khi cần.
3. Follow-up → ticket/task mới nếu còn việc.

---

## 6. Sáu phase (bản đồ nhanh)

| Phase | Nội dung | Tương ứng |
|-------|----------|-----------|
| 1 | Plan từ `current-task` | Bước 1 |
| 2 | Implement với skills | Bước 2 |
| 3 | Test & verify | Bước 3 |
| 4 | Review chất lượng | Bước 4 |
| 5 | Prepare MR | Bước 5 |
| 6 | Close task | Bước 6 |

---

## 7. Prompt contract (mẫu AL)

```text
Context:
- Current task: docs/current-task/<task>.md
- Rules: <rules files>
- Skills: <skill files>
- Constraints: <must-not-change items>

Task:
- Implement <small slice name>
- Keep scope limited to <modules/files>

Expected output:
- Code changes
- Tests updated + command to run
- Short summary and risk notes
```

---

## 8. Evidence checklist trước khi MR

- [ ] AC → Test đầy đủ (hoặc lý do miễn trừ)
- [ ] Build/test đã chạy thành công
- [ ] Không secret/PII trong code và docs
- [ ] Docs đồng bộ nếu đổi contract/architecture
- [ ] Self-review findings đã xử lý hoặc ghi rõ

---

## 9. Definition of Done (DoD)

- AC chính được cover bởi code + test
- Không blocker kỹ thuật trong scope
- MR đủ thông tin để reviewer kiểm nhanh
- Rủi ro còn lại được nêu rõ (nếu có)

---

## 10. Anti-patterns

- Prompt quá rộng, sửa cả codebase một lần
- Không chốt scope/non-goals trước khi code
- Tin “AL xong test” mà không chạy thật
- Merge khi chưa soát risk/security cơ bản
- Không cập nhật `current-task` làm nguồn chính

---

## 11. Tối ưu & điều chỉnh

- **Task nhỏ:** có thể gộp bước; vẫn nên vài dòng trong `current-task/`.
- **Task lớn / nhiều PR:** tách checklist theo phase; mỗi MR một mục tiêu rõ.
- **Personal vs team docs:** ticket + lead thắng cho hành vi sản phẩm; cập nhật personal docs sau thống nhất.

Cập nhật tài liệu này khi team đổi CI, template MR, hoặc quy trình review.

---

## 12. Liên kết nhanh

- **Điểm vào thư mục này:** `task-lifecycle/README.md`
- **Triển khai / duy trì tài liệu:** `guides/README.md`
- **Task:** `docs/current-task/TEMPLATE.md`, `docs/current-task/README.md`
- **Skills phase:** `skills/workflow/implement-feature/README.md`, `investigate-bug/README.md`, `prepare-pull-request/README.md`
- **Catalog:** `skills/README.md` — **MAP:** `MAP.md`

**Last updated:** 2026-04-11
