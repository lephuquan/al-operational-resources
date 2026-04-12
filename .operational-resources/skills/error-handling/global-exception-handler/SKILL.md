# Skill: Global Exception Handler

## TL;DR (VI)

- Một **`@RestControllerAdvice`** (hoặc tương đương) **gom** mọi exception từ REST layer → **HTTP status** + body theo **`api-error-response-format`** / `docs/api/03-response-format.md`.
- Handler **cụ thể trước**, **`Exception` / `Throwable` fallback sau**; log **server-side** đầy đủ (kèm correlation id nếu có), **không** đưa stack vào JSON.
- Kiểm tra bằng **`@WebMvcTest`** (hoặc slice test) cho status + `$.error.code`.

## Goal

Centralize exception-to-response mapping so controllers stay thin, every error response matches the **project envelope**, and clients get **stable `error.code`** values with safe messages.

## Preconditions

- Shared error types or builders per **`skills/error-handling/api-error-response-format/README.md`**.
- Mapping table for domain cases per **`skills/error-handling/map-exceptions-to-http/README.md`** and **`docs/api/05-error-handling.md`**.

## Steps

1. **Single entry point**
   - Add one **`@RestControllerAdvice`** (optionally scoped with `assignableTypes` / `basePackageClasses` if multiple APIs coexist).
   - Avoid duplicating the same `@ExceptionHandler` across many advice classes unless modular monolith boundaries require it — document the split.

2. **Order: specific → generic**
   - Register handlers for **framework** and **domain** exceptions before a broad **`Exception`** handler.
   - Do not let a catch-all swallow cases that need different HTTP semantics (e.g. **409** vs **404**).

3. **Bean Validation (request body / model)**
   - Handle **`MethodArgumentNotValidException`** → **400** with `error.code` from contract (e.g. `COMMON_400_VALIDATION`) and **`details`** as the **array** shape in **`05-error-handling.md`**.
   - Map each **`FieldError`** / **`ObjectError`** to `field` + `reason`; keep `reason` safe (use default messages or controlled catalog, not raw internal errors).

4. **Constraint violations (e.g. `@Validated` on parameters)**
   - Handle **`ConstraintViolationException`** → **400** with the same validation envelope pattern where applicable.

5. **Malformed JSON / binding**
   - Handle **`HttpMessageNotReadableException`**, **`MissingServletRequestParameterException`**, **`MethodArgumentTypeMismatchException`** as **400** with a stable code (document in **`error-codes.md`**).

6. **Domain / application exceptions**
   - Use project base types (e.g. `BusinessException` with `code` + HTTP hint) and map each family to the right status per **`map-exceptions-to-http`**.
   - Populate **`message`** from a safe catalog or i18n strategy agreed with **`api-error-response-format`**.

7. **Spring Security (when present)**
   - **`AccessDeniedException`** → **403**; **`AuthenticationException`** (or entry point) often → **401** — align with **`secure-api-endpoint`** and actual security config; avoid double-wrapping.

8. **Fallback**
   - **`Exception`** (or non-client errors only) → **500** with generic `message` and stable code (e.g. `COMMON_500`); **log** at **ERROR** with full stack server-side.
   - Optional: differentiate **timeout / upstream** if you use dedicated exception types → **502/503** per mapping table.

9. **Logging**
   - Log once per failure path with **level** appropriate to severity; include **correlation / request id** if MDC is set (`skills/observability/implement-request-tracing/SKILL.md`).

10. **Tests**
   - **`@WebMvcTest`** with **`@Import`** or standalone setup: assert **HTTP status** and JSON paths **`$.success`**, **`$.error.code`** (and `details` for validation).
   - Add at least one test per **new** domain exception family.

## Output

- `RestControllerAdvice` (or layered handlers) plus any small mappers/helpers.
   - Tests under `src/test/...`.
   - Updates to **`docs/knowledge-base/error-codes.md`** when introducing new codes.

## References

- `skills/error-handling/api-error-response-format/README.md`
- `skills/error-handling/map-exceptions-to-http/README.md`
- `docs/api/03-response-format.md`, `docs/api/05-error-handling.md`
- `docs/knowledge-base/error-codes.md`
- `skills/security/secure-api-endpoint/SKILL.md`
- `skills/observability/implement-request-tracing/SKILL.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
