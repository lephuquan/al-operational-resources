# Skill: API Error Response Format

## TL;DR (VI)

- Một **envelope** cho cả success và error: lỗi dùng **`success: false`** + object **`error`** (`code`, `message`, optional **`details`**).
- **`error.code`** ổn định cho client/i18n; **`message`** an toàn; **`details`** chỉ khi an toàn (validation → mảng field/reason).
- **HTTP status** vẫn là nguồn “category”; body bổ sung mã nghiệp vụ — **không** lộ stack, SQL, class nội bộ.

## Goal

Define and implement a **single, documented** JSON error shape so clients, tests, and `@ControllerAdvice` handlers stay aligned with `docs/api/03-response-format.md` and `docs/api/05-error-handling.md`.

## Preconditions

- Team contract in **`docs/api/03-response-format.md`** (and **`05-error-handling.md`** for codes and validation `details` shape).
- Optional registry: **`docs/knowledge-base/error-codes.md`** (or team equivalent).

## Steps

1. **Lock the schema**
   - Error branch: `success: false`, `error: { code, message, details? }` — no parallel legacy shapes for new endpoints.
   - Success branch stays `success: true`, `data`, optional `meta` (out of scope for this skill but must not contradict).

2. **Model in code**
   - Introduce shared types (e.g. `ApiError`, `ApiErrorResponse`, or wrapper builder) used only for error responses — avoid ad-hoc maps per controller.
   - Keep field names **identical** to docs (`code` not `errorCode` in JSON unless docs explicitly allow aliases).

3. **`error.code`**
   - Follow format in **`05-error-handling.md`** (e.g. `MODULE_NNN`); register new codes in **`error-codes.md`** when the team maintains it.
   - Same semantic failure keeps the **same code** across releases when meaning is unchanged.

4. **`error.message`**
   - Human-readable, **safe for end users** and logs on the client; no stack traces, SQL, file paths, or internal class names.
   - For 5xx, prefer generic client text; put technical detail in **server logs** only.

5. **`error.details`**
   - **`null`** or omitted when there is nothing extra to say.
   - **Validation:** use the **array** shape from **`05-error-handling.md`** (`field`, `reason` — safe text).
   - **Other:** only structured data that is **not secret** and **not exploitable** (no raw exception messages from upstream).

6. **HTTP status alignment**
   - Body `success: false` must match a **meaningful** 4xx/5xx status (see **`05-error-handling.md`** table). Do not return 200 with `success: false`.

7. **Optional i18n**
   - If the team uses keys: either expose a stable `code` and let the client translate, or add an optional `messageKey` **only** if documented in `docs/api/` — do not break existing clients silently.

8. **Verify**
   - Contract tests or `@WebMvcTest` samples assert JSON paths `$.success`, `$.error.code`, `$.error.message`.
   - Spot-check production-like profile: no verbose errors in body.

## Output

- Shared error DTO / builder module used by **`global-exception-handler`** flow.
- Updates to **`docs/knowledge-base/error-codes.md`** when adding codes.
- No change to success envelope unless explicitly in scope.

## References

- `docs/api/03-response-format.md`
- `docs/api/05-error-handling.md`
- `docs/knowledge-base/error-codes.md`
- `skills/error-handling/global-exception-handler/README.md`
- `skills/error-handling/map-exceptions-to-http/README.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
