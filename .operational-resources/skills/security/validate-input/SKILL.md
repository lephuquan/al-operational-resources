# Skill: Validate Input

## TL;DR (VI)

- Mọi input từ **HTTP** (body, query, path, header dùng cho nghiệp vụ): qua **DTO** + **`@Valid`** và constraint chuẩn; tham số đơn lẻ cũng nên có ràng buộc (`@Min`/`@Max`, `@Pattern`, …) khi framework hỗ trợ.
- **Custom `@Constraint`** cho rule cross-field; **validation groups** khi cùng DTO dùng nhiều flow (create vs update).
- **Không** expose field chỉ dành cho server (privilege, trạng thái nội bộ) trên DTO nhận từ client — tránh **mass assignment**.
- Lỗi validation → **400** + message theo chuẩn dự án; không leak chi tiết nội bộ — **`global-exception-handler`**.

## Goal

Validate **untrusted input** at the HTTP boundary using **Jakarta Bean Validation** (and complementary patterns) while keeping **business invariants** enforced in the **domain/service** layer.

## Preconditions

- Project uses Spring Web MVC / WebFlux with **`spring-boot-starter-validation`** (or equivalent).
- Error envelope for **400** defined or agreed (`docs/api/05-error-handling.md`).

## Steps

1. **Design request DTOs per use case**
   - Prefer **narrow** DTOs (create vs update) instead of one giant mutable object shared by every endpoint.
   - Omit fields the client must **not** set (`isAdmin`, `tenantId` from user, internal status codes). Derive those from auth context or server-side state.

2. **Apply standard constraints**
   - Use `@NotNull`, `@NotBlank`, `@Size`, `@Min`/`@Max`, `@Email`, `@Pattern`, `@Past`/`@Future`, etc., on the DTO.
   - For **collections**, validate elements (`@Valid` on nested types, `@NotEmpty` where appropriate).

3. **Trigger validation**
   - Annotate **`@RequestBody`** parameters with **`@Valid`** (or `@Validated` with groups at class level).
   - For **`@RequestParam`** / **`@PathVariable`**: use **`@Validated`** on the controller class and put constraints on simple parameters, or wrap primitives in a small record/DTO if needed.

4. **Validation groups (optional)**
   - Use **`jakarta.validation.groups.Default`** and custom interfaces (e.g. `OnCreate`, `OnUpdate`) when the same type is reused with different rules.

5. **Custom constraints**
   - Implement **`ConstraintValidator`** for cross-field or domain-specific syntax (e.g. country + postal code).
   - Keep validators **pure** (no heavy I/O); async or DB checks belong in the **service** with explicit errors.

6. **Maps and flexible JSON**
   - Avoid binding arbitrary **`Map<String, Object>`** from clients unless you whitelist keys and validate values.
   - Prefer typed DTOs; if using `JsonNode`, validate explicitly in code.

7. **Service-layer validation**
   - Re-validate **business rules** (balance sufficient, state machine, ownership) in services — not only Bean Validation.
   - Do not assume internal callers went through the controller.

8. **Error responses**
   - Map **`MethodArgumentNotValidException`**, **`ConstraintViolationException`**, and handler-specific errors to your **400** format.
   - Return **stable** field keys / codes for clients; avoid raw database or framework messages in production.

9. **OpenAPI / docs**
   - Keep **documented** constraints aligned with annotations (or note differences explicitly).

10. **Test**
   - At least one test per critical DTO: **invalid** payload → **400** with expected structure; happy path unchanged.

## Output

- Updated DTOs, controller annotations, optional custom validators, and tests; handler alignment if the project standard required changes.

## References

- `skills/security/validate-input/README.md`
- `skills/security/validate-input/checklist.md`
- `docs/architecture/09-security-architecture-backend.md` (section 4 — input/output)
- `docs/api/05-error-handling.md`
- `skills/error-handling/global-exception-handler/README.md`
- `skills/error-handling/map-exceptions-to-http/README.md`
- `skills/backend/create-rest-api/README.md`
- `skills/security/secure-api-endpoint/README.md`
- `skills/security/security-review/README.md`

**Last updated:** 2026-04-11
