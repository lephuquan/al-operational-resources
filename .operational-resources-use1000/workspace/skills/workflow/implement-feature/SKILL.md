# Skill: Implement Feature (End-to-End)

## TL;DR (VI)

- Playbook **triển khai feature có kiểm soát** từ file `current-task` đến code, test, docs, self-review — làm theo **slice nhỏ**, không nhờ AL sửa cả repo một lần.
- Luôn bám **AC → test**, `rules/` + `docs/` + skill con (`create-rest-api`, …).
- Luồng tổng ticket → Done: `task-lifecycle/README.md` → `FROM-TICKET-TO-DONE.md`.

## Goal

Hoàn thành một feature (hoặc phần feature trong scope task) với: code đúng kiến trúc, test chứng minh AC, docs/API đồng bộ khi cần, và sẵn sàng chuyển sang MR — không refactor lớn ngoài scope task.

## Preconditions

- Có file task trong `current-task/*.md` (đã điền tối thiểu theo `TEMPLATE.md`).
- Đã đạt **DoR** cơ bản: AC rõ hoặc có cách đo done; scope/non-goals không mơ hồ (xem `task-lifecycle/FROM-TICKET-TO-DONE.md` §4).
- Đã có **context pack** trong task (rules + docs + skill liên quan) hoặc bổ sung trước khi code.

## Steps

1. **Chốt scope và slice đầu tiên**
   - Đọc task + spec liên quan (`docs/specs/feature-*.md` nếu có).
   - Ghi rõ first vertical slice (ví dụ: một endpoint + service + test happy path).
   - Nếu thiết kế chưa đủ: dùng `skills/architecture/design-feature-architecture/SKILL.md` trước khi code lớn.

2. **Triển khai theo lớp và skill con**
   - Bám `docs/architecture/06-backend-layers-and-dependencies.md` và package convention (`04-folder-structure.md`).
   - Thứ tự điển hình: contract/DTO → domain/service → persistence → controller (điều chỉnh theo dự án).
   - Gọi skill chi tiết khi cần (vào **`README.md`** hub trước, rồi `SKILL.md`):
     - `skills/backend/create-rest-api/README.md`
     - `skills/backend/create-service-layer/README.md`
     - `skills/backend/create-jpa-entity/README.md`
     - `skills/security/validate-input/README.md` khi thêm/sửa DTO request
     - `skills/security/secure-api-endpoint/README.md` khi đụng auth/route
     - `skills/error-handling/global-exception-handler/README.md` (và skill lỗi liên quan) khi đụng HTTP mapping

3. **Làm việc với AL theo cụm nhỏ**
   - Prompt: Context (task + rules + skill) → Task (một slice) → Constraints → Expected output (xem `examples.md`).
   - Sau mỗi cụm: xem diff, chạy compile/test nhanh nếu có thể.

4. **Test và ánh xạ AC**
   - Bảng **AC → Test** trong task file phải được cập nhật.
   - Dùng `skills/testing/write-unit-test/README.md` và `skills/testing/write-integration-test/README.md` khi cần.
   - Chạy test thật (ví dụ `./mvnw test`) — không coi “AL đã viết test” là đủ.

5. **Đồng bộ docs khi đổi hành vi công khai**
   - API: `docs/api/08-endpoint-list.md`, `docs/api/10-current-api-changes.md` và file contract liên quan.
   - Lỗi/mã lỗi: `docs/knowledge-base/error-codes.md` nếu dự án dùng catalog.

6. **Self-review và chuẩn bị handoff MR**
   - `rules/08-review-checklist.md` + `skills/code-quality/review-code/README.md` (và `checklist.md` trong folder).
   - Chuẩn bị MR theo `skills/workflow/prepare-pull-request/README.md` (hoặc checklist team).

## Output

- Code + test trong phạm vi task.
- Task file cập nhật: progress log, AC → test, risk/open questions nếu còn.
- Docs cá nhân đã chỉnh nếu đổi contract/API.
- Trạng thái rõ: sẵn sàng MR hoặc còn blocker (ghi trong task).

## References

- Task lifecycle (E2E): `task-lifecycle/README.md`, `task-lifecycle/FROM-TICKET-TO-DONE.md`
- Task: `current-task/README.md`, `current-task/TEMPLATE.md`
- Specs: `docs/specs/README.md`
- Kiến trúc: `docs/architecture/01-README.md`, `06-backend-layers-and-dependencies.md`
- API: `docs/api/01-README.md`
- Skills liên quan: `skills/architecture/design-feature-architecture/SKILL.md`, `skills/backend/create-rest-api/README.md`, `skills/backend/create-service-layer/README.md`, `skills/backend/create-jpa-entity/README.md`, `skills/security/validate-input/README.md`, `skills/security/secure-api-endpoint/README.md`, `skills/testing/create-test-data/README.md`, `skills/testing/write-unit-test/README.md`, `skills/testing/write-integration-test/README.md`, `skills/code-quality/review-code/README.md`, `skills/workflow/investigate-bug/README.md` (bugfix), `skills/workflow/prepare-pull-request/README.md`

**Last updated:** 2026-04-11
