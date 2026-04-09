# Playbook vận hành với AL (Task -> Done)

## TL;DR (VI)

- Đây là **điểm vào duy nhất** khi bạn muốn triển khai một task bằng AL.
- Input chuẩn: một file trong `docs/current-task/`.
- Trong quá trình làm: dùng `rules/ + docs/ + skills/` theo từng phase.
- Output chuẩn: code + test + review evidence + MR sẵn sàng merge.

---

## 1) Mục tiêu của playbook

Tài liệu này định nghĩa cách phối hợp giữa:

- Ticket/BA/Lead (nguồn yêu cầu chính thức)
- Bạn (người chốt hướng và ra quyết định)
- AL (thực thi theo prompt + tài nguyên trong `.operational-resources/`)

Đích đến là: hoàn thành task đúng yêu cầu, chất lượng đủ merge, và có bằng chứng kiểm chứng.

---

## 2) Input / Output chuẩn

## Input (bắt buộc)

- Một file task trong `docs/current-task/YYYYMMDD-*.md`
- Link ticket + acceptance criteria (AC)
- Phạm vi (scope) + ràng buộc quan trọng (constraints)

## Output (bắt buộc)

- Code đã triển khai trong `src/` (hoặc phạm vi code thật của dự án)
- Test đã chạy (ít nhất theo yêu cầu task/team)
- Self-review + risk notes
- MR/PR mô tả rõ What / Why / How to test

---

## 3) Definition of Ready (DoR) cho task

Trước khi yêu cầu AL code lớn, task phải đạt tối thiểu:

- [ ] Có mục tiêu rõ: feature/bugfix/refactor gì
- [ ] Có AC hoặc tiêu chí tương đương để xác định done
- [ ] Có scope và non-goals
- [ ] Có context pack: rules + docs + ít nhất 1 skill liên quan
- [ ] Có open questions (nếu còn) và owner để xác nhận

Nếu chưa đạt DoR: ưu tiên làm rõ task trước, không đẩy AL vào đoán ngầm.

---

## 4) Quy trình chuẩn 6 phase

## Phase 1 - Plan from current-task

1. Tạo/cập nhật `docs/current-task/<task>.md` từ template.
2. Ghi AC, assumptions, risks ban đầu, và context pack.
3. Chốt first slice để triển khai an toàn.

## Phase 2 - Implement with skills

1. Chọn skill phù hợp từ `skills/README.md`.
2. Prompt AL theo cấu trúc: Context -> Task -> Constraints -> Expected output.
3. Làm theo cụm nhỏ (vertical slice), review diff sau mỗi cụm.

## Phase 3 - Test & verify

1. Viết/cập nhật test theo AC.
2. Chạy test thật trên máy bạn (không chỉ dựa vào việc AL đã viết test).
3. Ghi kết quả test vào task file hoặc MR notes.

## Phase 4 - Review quality

1. Self-review với `rules/08-review-checklist.md` và skill review liên quan.
2. Soát security/secrets/PII.
3. Nếu đổi API/kiến trúc, cập nhật docs tương ứng.

## Phase 5 - Prepare MR/PR

1. Tổng hợp thay đổi: What / Why / How to test / Risk.
2. Đính kèm link task file và ticket.
3. Đảm bảo branch, commit, pipeline theo quy ước team.

## Phase 6 - Close task

1. Cập nhật trạng thái trong `docs/current-task/README.md`.
2. Chốt learned notes (nếu cần) vào `notes/`.
3. Đánh dấu phần nào cần follow-up task mới.

---

## 5) Prompt contract (mẫu dùng với AL)

Dùng mẫu này để AL ít lệch ngữ cảnh:

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

## 6) Evidence checklist trước khi MR

- [ ] AC -> Test mapping đầy đủ (hoặc ghi lý do miễn trừ)
- [ ] Build/test command đã chạy thành công
- [ ] Không có secret/PII trong code và docs
- [ ] Docs liên quan đã đồng bộ nếu có thay đổi contract/architecture
- [ ] Đã có self-review findings (nếu có) và cách xử lý

---

## 7) Definition of Done (DoD)

Task được xem là done khi:

- AC chính đã được cover bởi code + test
- Không còn blocker kỹ thuật ở scope hiện tại
- MR đủ thông tin để reviewer kiểm nhanh
- Rủi ro còn lại đã được nêu rõ (nếu có)

---

## 8) Anti-patterns cần tránh

- Prompt AL quá rộng, sửa cả codebase một lần
- Không chốt scope/non-goals trước khi code
- Chỉ dựa vào "AL nói đã xong test" mà không chạy thật
- Merge khi chưa kiểm tra risk/security cơ bản
- Để kiến thức rải rác, không cập nhật `current-task` làm nguồn chính

---

## 9) Liên kết nhanh

- Global flow tham chiếu: `WORKFLOW.md`
- Current-task template: `docs/current-task/TEMPLATE.md`
- Skills catalog: `skills/README.md`
- Cách thêm skill mới: `skills/HOW-TO-ADD-TOPIC.md`
- Directory map: `MAP.md`

**Last updated:** 2026-04-09
