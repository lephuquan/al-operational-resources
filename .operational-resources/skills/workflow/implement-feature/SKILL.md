# Skill: Implement Feature (End-to-End)

## TL;DR (VI)

- Playbook **triển khai feature có kiểm soát** từ file `current-task` đến code, test, docs, self-review — làm theo **slice nhỏ**, không nhờ AL sửa cả repo một lần.
- Luôn bám **AC → test**, `rules/` + `docs/` + skill con (`create-rest-api`, …).
- Điểm vào tổng: `PLAYBOOK.md`; flow chi tiết: `WORKFLOW.md`.

## Goal

Hoàn thành một feature (hoặc phần feature trong scope task) với: code đúng kiến trúc, test chứng minh AC, docs/API đồng bộ khi cần, và sẵn sàng chuyển sang MR — không refactor lớn ngoài scope task.

## Preconditions

- Có file task trong `docs/current-task/*.md` (đã điền tối thiểu theo `TEMPLATE.md`).
- Đã đạt **DoR** cơ bản: AC rõ hoặc có cách đo done; scope/non-goals không mơ hồ (xem `PLAYBOOK.md`).
- Đã có **context pack** trong task (rules + docs + skill liên quan) hoặc bổ sung trước khi code.

## Steps

1. **Chốt scope và slice đầu tiên**
   - Đọc task + spec liên quan (`docs/specs/feature-*.md` nếu có).
   - Ghi rõ first vertical slice (ví dụ: một endpoint + service + test happy path).
   - Nếu thiết kế chưa đủ: dùng `skills/architecture/design-feature-architecture/SKILL.md` trước khi code lớn.

2. **Triển khai theo lớp và skill con**
   - Bám `docs/architecture/06-backend-layers-and-dependencies.md` và package convention (`04-folder-structure.md`).
   - Thứ tự điển hình: contract/DTO → domain/service → persistence → controller (điều chỉnh theo dự án).
   - Gọi skill chi tiết khi cần:
     - `skills/backend/create-rest-api/SKILL.md`
     - `skills/backend/create-service-layer/SKILL.md`
     - `skills/backend/create-jpa-entity/SKILL.md`
     - `skills/error-handling/*` khi đụng lỗi HTTP/global handler.

3. **Làm việc với AL theo cụm nhỏ**
   - Prompt: Context (task + rules + skill) → Task (một slice) → Constraints → Expected output (xem `examples.md`).
   - Sau mỗi cụm: xem diff, chạy compile/test nhanh nếu có thể.

4. **Test và ánh xạ AC**
   - Bảng **AC → Test** trong task file phải được cập nhật.
   - Dùng `skills/testing/write-unit-test`, `write-integration-test` khi cần.
   - Chạy test thật (ví dụ `./mvnw test`) — không coi “AL đã viết test” là đủ.

5. **Đồng bộ docs khi đổi hành vi công khai**
   - API: `docs/api/08-endpoint-list.md`, `docs/api/10-current-api-changes.md` và file contract liên quan.
   - Lỗi/mã lỗi: `docs/knowledge-base/error-codes.md` nếu dự án dùng catalog.

6. **Self-review và chuẩn bị handoff MR**
   - `rules/08-review-checklist.md` + `skills/code-quality/review-code/checklist.md`.
   - Chuẩn bị MR theo `skills/workflow/prepare-pull-request/SKILL.md` (hoặc checklist team).

## Output

- Code + test trong phạm vi task.
- Task file cập nhật: progress log, AC → test, risk/open questions nếu còn.
- Docs cá nhân đã chỉnh nếu đổi contract/API.
- Trạng thái rõ: sẵn sàng MR hoặc còn blocker (ghi trong task).

## References

- Playbook tổng: `PLAYBOOK.md`
- Flow tham chiếu: `WORKFLOW.md`
- Task: `docs/current-task/README.md`, `docs/current-task/TEMPLATE.md`
- Specs: `docs/specs/README.md`
- Kiến trúc: `docs/architecture/01-README.md`, `06-backend-layers-and-dependencies.md`
- API: `docs/api/01-README.md`
- Skills liên quan: `skills/architecture/design-feature-architecture/SKILL.md`, `skills/backend/create-rest-api/SKILL.md`, `skills/backend/create-service-layer/SKILL.md`, `skills/workflow/prepare-pull-request/SKILL.md`

**Last updated:** 2026-04-09
