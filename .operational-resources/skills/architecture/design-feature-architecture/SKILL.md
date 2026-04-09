# Skill: Design Feature Architecture

## TL;DR (VI)

- Thiết kế feature **trước khi code**: ranh giới layer, contract API, dữ liệu, lỗi, NFR; ghi ADR nếu quyết định quan trọng.
- Đọc spec/task → neo vào `docs/architecture/` → phác luồng, migration, tích hợp → cập nhật task hoặc ADR.
- Luôn kết thúc bằng output có thể dùng ngay cho bước implement: design note + risk list + decision log.

## Goal

Tạo một bản thiết kế **rõ ràng, đủ dùng và tối giản** cho feature mới hoặc feature mở rộng: boundaries giữa module/layer, hình dạng HTTP/API, thay đổi persistence, failure modes, và trade-off theo mức ưu tiên - bám kiến trúc backend hiện có - trước khi bắt đầu implement.

## Preconditions

- Đã có intent cho feature: `docs/specs/feature-*.md` và/hoặc `docs/current-task/*.md`.
- Đã có baseline architecture trong `docs/architecture/` (đọc từ `01-README.md` và các file đánh số liên quan).
- Xác định được người chốt scope/trade-off (scope owner) để xử lý assumption còn mở.

## Steps

1. **Đọc requirements và boundaries**
   - Parse spec/task để chốt scope, acceptance criteria, non-goals, và kỳ vọng rollout.
   - Chỗ còn thiếu dữ liệu phải ghi thành assumptions rõ ràng (không tự đoán ngầm).
2. **Neo vào architecture baseline**
   - Map feature vào runtime/package boundaries hiện có bằng:
     - `docs/architecture/02-system-overview.md`
     - `docs/architecture/04-folder-structure.md`
     - `docs/architecture/06-backend-layers-and-dependencies.md`
   - Quyết định orchestration nằm ở đâu (controller/service/domain), có cần async/event flow không (`07-integrations.md`).
3. **Định nghĩa API/behavior contract**
   - Phác request/response, validation, error semantics nhất quán với `docs/api/`.
   - Chốt idempotency và consistency behavior cho retry/duplicate request (`08-transactions-and-consistency.md`).
4. **Thiết kế data và persistence impact**
   - Xác định tạo mới bảng/entity hay mở rộng schema hiện có.
   - Chốt migration/index/constraint impact (`05-database-design.md`).
   - Đánh dấu hot paths và rủi ro read/write amplification.
5. **Rà soát cross-cutting concerns**
   - Security authorization và xử lý dữ liệu nhạy cảm (`09-security-architecture-backend.md`).
   - Observability signals (logs/metrics/traces) cho critical flows.
   - Performance guardrails và strategy khi integration thất bại (`07-integrations.md`).
6. **Chốt decisions và output**
   - Viết design note ngắn gọn trong task hiện tại.
   - Nếu decision khó đảo ngược hoặc tồn tại dài hạn, tạo ADR (`docs/decisions/TEMPLATE.md` → `NNN-topic.md`) và cập nhật index.
   - Công bố top risks + mitigations trước khi bắt đầu code.

## Output

- Một design note trong `docs/current-task/<task>.md`, gồm:
  - Scope và non-goals
  - Layer/module boundaries
  - API sketch và error behavior
  - Data changes (schema/migration/index)
  - Top 3 risks + mitigations
- ADR chỉ tạo khi cần (significant, long-lived, hoặc cross-team impact).
- Checkpoint rõ ràng "ready for implementation": phần nào code ngay được, phần nào còn cần xác nhận.

## References

- Rules: `rules/` (ràng buộc chung của workspace)
- Docs: `docs/architecture/01-README.md` (thứ tự đọc), `02-system-overview.md`, `04-folder-structure.md`, `05-database-design.md`, `06-backend-layers-and-dependencies.md`, `07-integrations.md`, `08-transactions-and-consistency.md`, `09-security-architecture-backend.md`
- API: `docs/api/01-README.md` và các file đánh số liên quan
- Specs: `docs/specs/README.md`
- Tasks: `docs/current-task/README.md`, `docs/current-task/TEMPLATE.md`
- Decisions: `docs/decisions/README.md`, `docs/decisions/TEMPLATE.md`
- Related skills: `skills/workflow/implement-feature/SKILL.md`, `skills/backend/create-rest-api/SKILL.md`, `skills/backend/create-service-layer/SKILL.md`, `skills/architecture/review-project-architecture/SKILL.md`

**Last updated:** 2026-04-08
