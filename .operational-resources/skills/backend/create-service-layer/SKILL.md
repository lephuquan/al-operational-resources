# Skill: Create Service Layer

## TL;DR (VI)

- Service = **use case / orchestration**: business logic rõ, **transaction** đặt đúng chỗ, dễ **unit test** (mock repo/client).
- Không nhét HTTP/Web concern; gọi ngoài hệ thống qua **port/client** có tên rõ.
- Bám **`docs/architecture/06-backend-layers-and-dependencies.md`** và **`08-transactions-and-consistency.md`**.

## Goal

Triển khai lớp service (application/use-case) điều phối domain + persistence + integration: invariant rõ, lỗi nghiệp vụ có dạng ổn định, ranh giới transaction và idempotency/retry được cân nhắc — sẵn sàng gọi từ controller mà không lộ chi tiết DB.

## Preconditions

- Use case đã mô tả trong task/spec (input, output, lỗi, edge case) hoặc đã qua `design-feature-architecture`.
- Repository hoặc client phụ thuộc đã có hoặc sẽ tạo trong cùng slice.
- Biết convention package service và quy tắc `@Transactional` của team.

## Steps

1. **Chốt use case**
   - Một public method (hoặc nhóm nhỏ) = một luồng nghiệp vụ rõ; tránh “god service”.
   - Liệt kê invariant, pre/post điều kiện, và exception domain (có mã/loại ổn định nếu team chuẩn hóa).

2. **Interface (tuỳ team)**
   - Nếu cần test/mock hoặc nhiều implementation: `XxxService` interface + `XxxServiceImpl`.
   - Module nhỏ có thể một class concrete — ghi rõ trong task nếu bỏ interface.

3. **Dependency injection**
   - Constructor injection cho repository, mapper, `*Client` (HTTP, queue, …).
   - Tránh `@Autowired` field nếu team ưu tiên constructor.

4. **Transaction boundary**
   - `@Transactional` trên method ghi nhiều bước / cần rollback nhất quán.
   - Read-only: `@Transactional(readOnly = true)` cho query thuần.
   - Tránh transaction bọc quanh remote call dài (timeout giữ lock) — tách bước hoặc pattern outbox/saga theo `08-transactions-and-consistency.md`.

5. **Integration và ports**
   - Gọi HTTP/email/payment qua lớp adapter/`XxxClient` có interface riêng khi cần test/substitute.
   - Không để URL/secret hardcode trong service; dùng config/properties.

6. **Domain errors**
   - Ném exception domain hoặc `Result` type theo convention; **không** trả stack trace/ SQLException thô ra controller — map ở `@ControllerAdvice`.

7. **Observability**
   - Log milestone (INFO), chi tiết (DEBUG); không log PII/secret.

8. **Test**
   - Unit test: Mockito stub repository/client; cover happy path + nhánh lỗi nghiệp vụ.
   - Integration test (tuỳ policy) khi logic phụ thuộc DB thật.

## Output

- Class service (và interface nếu có) + domain exception types khi cần + unit test tối thiểu.

## References

- `docs/architecture/06-backend-layers-and-dependencies.md`
- `docs/architecture/08-transactions-and-consistency.md`
- `docs/architecture/04-folder-structure.md`
- `docs/knowledge-base/coding-patterns.md`
- `skills/backend/create-rest-api/SKILL.md`
- `skills/backend/create-jpa-entity/SKILL.md`
- `skills/error-handling/map-exceptions-to-http/SKILL.md`

**Last updated:** 2026-04-09
