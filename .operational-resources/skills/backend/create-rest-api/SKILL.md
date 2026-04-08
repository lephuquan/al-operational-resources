# Skill: Create REST API (Spring Boot)

## Goal

Thêm endpoint REST mới: controller rõ ràng, DTO có validation, mã HTTP đúng, không nhét business logic vào controller.

## Preconditions

- Contract API (path, method, request/response) đã rõ hoặc đang draft trong `docs/api/`.
- Service layer (hoặc port) đã có hoặc sẽ tạo cùng lúc.

## Steps

1. Định nghĩa request/response DTO (record hoặc class) trong package `api`/`dto` theo convention dự án.
2. Thêm Jakarta Validation (`@NotNull`, `@Size`, …) trên DTO đầu vào.
3. Tạo `@RestController` + mapping (`@GetMapping`, `@PostMapping`, …) với path version (`/api/v2/...` nếu đang dùng).
4. Method controller: nhận `@Valid @RequestBody` / `@PathVariable` / `Pageable` khi cần; gọi service; trả `ResponseEntity` hoặc DTO thống nhất.
5. Map lỗi domain sang HTTP qua `@ControllerAdvice` (không try/catch rải rác trong controller).
6. Viết test: `@WebMvcTest` cho controller hoặc integration test tùy policy team.

## Output

- Controller + DTO + test tối thiểu.
- Cập nhật `docs/api/08-endpoint-list.md` và `docs/api/10-current-api-changes.md` nếu đổi contract.

## References

- `docs/api/03-response-format.md`
- `rules/03-api-development.md`
