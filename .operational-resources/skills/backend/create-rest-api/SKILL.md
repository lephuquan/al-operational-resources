# Skill: Create REST API (Spring Boot)

## TL;DR (VI)

- Thêm **endpoint REST** mới: controller mỏng, **DTO + validation**, HTTP status đúng, **không** nhét business logic nặng vào controller.
- Lỗi domain map sang HTTP tập trung qua **`@ControllerAdvice`** (không try/catch rải rác).
- Bám **`docs/api/`** (envelope, versioning) và **`rules/03-api-development.md`**.

## Goal

Triển khai một hoặc nhiều HTTP endpoint mới (hoặc mở rộng có kiểm soát) với contract rõ: request/response, validation, mã trạng thái, và test tối thiểu — đồng bộ docs API cá nhân khi đổi contract công khai.

## Preconditions

- Path, method, shape request/response đã rõ hoặc đang draft trong `docs/api/` (và/hoặc trong `docs/current-task/*.md`).
- Service layer (hoặc port/use-case) đã có hoặc sẽ tạo **cùng slice** (xem `skills/backend/create-service-layer/SKILL.md`).
- Biết envelope/response format của dự án (`docs/api/03-response-format.md` hoặc tương đương).

## Steps

1. **Neo vào contract và kiến trúc**
   - Đọc `docs/api/01-README.md`, `03-response-format.md`, file versioning/pagination nếu endpoint liên quan.
   - Đối chiếu `docs/architecture/04-folder-structure.md`, `06-backend-layers-and-dependencies.md` để đặt controller/DTO đúng package.

2. **Định nghĩa DTO**
   - Request/response dùng record hoặc class trong package `api` / `dto` theo convention.
   - Jakarta Validation trên input: `@NotNull`, `@NotBlank`, `@Size`, `@Valid` lồng nhau khi cần.

3. **Controller**
   - `@RestController` + `@RequestMapping` với **version path** nếu team dùng (ví dụ `/api/v2/...`).
   - Tham số: `@Valid @RequestBody`, `@PathVariable`, `@RequestParam`, `Pageable`/`Sort` khi cần.
   - Gọi service; trả `ResponseEntity` với status đúng (201 create, 204 no content, 404 not found, …) hoặc wrapper thống nhất (`ApiResponse`…).

4. **Lỗi và HTTP**
   - Không map exception thủ công trong từng method trừ case rất hẹp đã chuẩn hóa.
   - Dùng global handler (`@ControllerAdvice`) và policy trong `docs/api/05-error-handling.md` (nếu có) + skill `skills/error-handling/*` khi cần chỉnh wiring.

5. **Security (nếu áp dụng)**
   - Method security / roles / public permit theo `docs/architecture/09-security-architecture-backend.md` và API auth doc.

6. **Test**
   - `@WebMvcTest` cho controller (mock service) hoặc integration test theo policy team.
   - Tối thiểu: một happy path + một case validation hoặc error mapping.

7. **Docs**
   - Cập nhật `docs/api/08-endpoint-list.md`, `docs/api/10-current-api-changes.md` khi thêm/đổi contract.

## Output

- Controller + DTO (+ mapper nếu team tách) + test tối thiểu.
- Docs API đã cập nhật nếu endpoint là contract công khai.

## References

- `docs/api/01-README.md`, `docs/api/03-response-format.md`, `docs/api/05-error-handling.md` (nếu có)
- `docs/architecture/04-folder-structure.md`, `docs/architecture/06-backend-layers-and-dependencies.md`, `docs/architecture/09-security-architecture-backend.md`
- `rules/03-api-development.md`
- `skills/backend/create-service-layer/SKILL.md`
- `skills/security/validate-input/README.md`
- `skills/testing/create-test-data/README.md`
- `skills/testing/write-integration-test/README.md` (MockMvc / slice sau khi có endpoint)
- `skills/performance/optimize-api-response/README.md`
- `skills/error-handling/global-exception-handler/README.md`, `skills/error-handling/map-exceptions-to-http/README.md` (khi cần)

**Last updated:** 2026-04-11
