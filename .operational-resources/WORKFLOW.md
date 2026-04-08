# Flow làm việc: Task → triển khai (AL) → test → review → MR

Tài liệu này mô tả **quy trình một task** khi bạn dùng `.operational-resources/` cùng **ticket/BA/leader** và **AL (AI trong Cursor)**. Đây là khung tham chiếu; có thể rút gọn cho task nhỏ.

**Nguyên tắc:** Ticket team là **nguồn yêu cầu chính thức**; `.operational-resources/` là **ngữ cảnh + quy tắc cá nhân + playbook** — không thay thế quyết định BA/Lead khi có conflict (ưu tiên sync với team trước khi merge).

---

## 0. Đầu vào

| Nguồn | Vai trò |
|-------|---------|
| Ticket (Jira/Azure/…) | Acceptance criteria, scope, deadline, link thiết kế |
| BA / Lead / Tech | Ràng buộc nghiệp vụ, ưu tiên, exception |
| `.operational-resources/` | Rules, docs, skills, `current-task`, notes |

**Điều kiện tối thiểu trước khi code:** ticket có mô tả đủ để biết *làm gì* và *xong khi nào*; nếu thiếu — ghi rõ câu hỏi trong file task (bước 1) và hỏi lại stakeholder **trước** khi nhờ AL viết code lớn.

---

## 1. Thu thập yêu cầu & đóng gói ngữ cảnh

### 1.1 Đọc có thứ tự (cho bạn và cho prompt AL)

1. `rules/00-personal-priority.md` → `AGENTS.md`
2. `rules/01-project-overview.md`, `02-coding-standards.md`, các rule liên quan (API, backend, security, testing)
3. `docs/project-overview.md` → `docs/architecture/01-README.md` → `docs/architecture/02-system-overview.md`
4. `docs/setup/` — khi cần chạy local, profile, biến môi trường hoặc ngữ cảnh triển khai (xem `docs/setup/README.md`)
5. `docs/specs/` (feature liên quan) + `docs/api/` nếu đụng API
6. `docs/current-task/` — tạo hoặc cập nhật file task (xem 1.2)
7. `skills/README.md` — chọn skill phù hợp (REST, service, JPA, error, test…)
8. Ticket team — copy **AC, link, số hiệu** vào task file (không paste secret)

### 1.2 Tạo / cập nhật **một file duy nhất** `docs/current-task/YYYYMMDD-ten-task.md`

- Copy từ **`docs/current-task/TEMPLATE.md`** (tiêu đề/hướng dẫn **English** + `TL;DR (VI)`); không tạo bản song song trong `rules/`.
- Điền tối thiểu: metadata, tóm tắt, nguồn/ticket, AC (hoặc lý do không có), **AC → Test**, **một khối loại task** (feature / bugfix / refactor / …), hướng dẫn cho AI, câu hỏi mở (nội dung điền có thể VI hoặc EN).
- Cập nhật bảng Dashboard trong `docs/current-task/README.md`.

**Output của bước 1:** một file task “đủ context” để `@` trong Cursor — xem `docs/current-task/README.md` (single source of truth).

---

## 2. Gọi AL triển khai (dựa trên skills + tài nguyên)

1. Prompt có cấu trúc: **Context** (file task + rule liên quan) → **Task** (bước cụ thể trong checklist) → **Constraint** (không đổi X, tuân `rules/…`).
2. Chỉ định skill: ví dụ “Follow `skills/backend/create-rest-api/SKILL.md` và checklist đính kèm.”
3. Làm **từng cụm** (vertical slice hoặc lớp) — tránh nhờ AL sửa cả codebase một lần.
4. Sau mỗi cụm: bạn review nhanh diff; chạy build/test local khi có thể.

**Output:** code trong `src/` + test; cập nhật tiến độ trong file task (Progress log).

---

## 3. Testing (AL hỗ trợ + bạn chủ động)

| Việc | Gợi ý |
|------|--------|
| AL sinh / sửa test | Dùng `skills/testing/write-unit-test`, `write-integration-test` |
| Bạn chạy thật | `./mvnw test` (hoặc lệnh team) — **cổng bắt buộc** trước MR |
| Thiếu test cho nhánh quan trọng | Bổ sung hoặc ghi rõ lý do trong task/MR |

Không coi “AL đã viết test” là đủ nếu **chưa chạy** trên máy bạn.

### 3.1 Bắt buộc: ánh xạ AC (ticket) → test

Trong file `docs/current-task/…` (theo `TEMPLATE.md`), dùng bảng **AC → Test** để:

- Biết **test nào chứng minh** từng acceptance criterion từ BA/Lead
- Tránh viết test “đủ coverage” nhưng **không cover** yêu cầu nghiệp vụ

Khi review MR, đối chiếu nhanh: mỗi AC có ít nhất một test (unit/integration/E2E) hoặc lý do miễn trừ (ví dụ chỉ đổi refactor nội bộ).

**Không cần** công cụ riêng trong `.operational-resources/` — một bảng markdown trong task file là đủ.

---

## 4. Review code & checklist chất lượng

1. Self-review theo `rules/08-review-checklist.md` + `skills/code-quality/review-code/checklist.md` (nếu dùng).
2. Đối chiếu **chính sách team** (format, branch, conventional commit) — phần này có thể nằm ngoài `.operational-resources/`; ghi link trong MR.
3. Security/PII/secrets: `rules/06-security.md`, `docs/knowledge-base/security-privacy-rules.md`.
4. Nếu đổi contract API: đồng bộ `docs/api/` (personal) và kế hoạch sync docs team.
5. Pipeline CI của team (nếu có): đảm bảo build/test (và các bước team yêu cầu) pass trước khi merge.

**Output:** bạn tin tưởng diff đủ để cho đồng nghiệp review.

---

## 5. Tạo MR (Merge Request / Pull Request)

1. Branch theo convention team.
2. Mô tả MR: **What / Why / How to test** + link ticket + ảnh hưởng (breaking hay không).
3. Đính kèm hoặc tóm tắt: đã chạy test, checklist đã xong.
4. Không push secret; không WIP trừ khi team cho phép draft MR.

**Lưu ý:** `AGENTS.md` khuyến nghị không auto-push — bạn chủ động `git push` và tạo MR.

---

## Tối ưu & điều chỉnh

- **Task nhỏ:** có thể gộp bước 1–2; vẫn nên có vài dòng trong `current-task/`.
- **Task lớn / nhiều PR:** tách task file hoặc checklist theo phase; mỗi MR một mục tiêu rõ.
- **Trùng BA vs personal docs:** khi mâu thuẫn — **ticket + lead** thắng cho hành vi sản phẩm; cập nhật personal docs sau khi thống nhất.

---

## Có nên triển khai tài liệu này ngay không?

**Nên.** Một file flow (tài liệu này) giúp bạn:

- Không phải nhớ hết thứ tự đọc `rules/` / `docs/` / `skills/`.
- Prompt AL nhất quán (task → context pack → implement → test → review → MR).
- Giảm sót bước (đặc biệt **chạy `mvn test`** và **đối chiếu ticket**).

Cập nhật file khi team đổi quy trình (CI, template MR, …).

---

## Liên kết nhanh

- Task (chuẩn): `docs/current-task/TEMPLATE.md`
- Thêm skill / chủ đề mới: `skills/HOW-TO-ADD-TOPIC.md`
- Git local (ẩn/hiện thư mục): `README-GIT-LOCAL.md`

**Last updated:** 2026-04-08
