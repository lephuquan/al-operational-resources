# Skill: Map Exceptions to HTTP

## TL;DR (VI)

- Xây **bảng ánh xạ** rõ ràng: loại lỗi nghiệp vụ / kỹ thuật → **HTTP status** + **`error.code`** ổn định — trước khi viết `@ExceptionHandler`.
- **HTTP** thể hiện *category*; **`error.code`** thể hiện *case* cụ thể cho client và monitoring.
- Đồng bộ với **`docs/api/05-error-handling.md`** và **`docs/knowledge-base/error-codes.md`**; triển khai trong **`global-exception-handler`**.

## Goal

Produce a **single source of truth** for which HTTP status and business error code each failure scenario uses, so API behavior is predictable and documentation matches runtime.

## Preconditions

- Contract tables in **`docs/api/05-error-handling.md`**.
- Error envelope rules in **`skills/error-handling/api-error-response-format/README.md`**.

## Steps

1. **Inventory failure scenarios**
   - List **user input** failures, **authorization**, **missing resources**, **state conflicts**, **business rule violations**, **rate limits**, **dependency / timeout**, **unexpected** errors.
   - Include framework cases already handled globally (validation → 400) so domain mapping does not contradict them.

2. **Assign HTTP semantics**
   - Use **`05-error-handling.md`** defaults as baseline:

     | Scenario | HTTP |
     |----------|------|
     | Validation / malformed input | 400 |
     | Missing or invalid auth | 401 |
     | Authenticated, not allowed | 403 |
     | Resource not found | 404 |
     | Conflict (duplicate, wrong state) | 409 |
     | Business rule cannot apply | 422 |
     | Rate limited | 429 |
     | Upstream / dependency failure | 502 / 503 |
     | Unexpected server error | 500 |

   - Adjust only where the team documents an exception (e.g. idempotent **POST** duplicate → **409** vs **200** — document in API docs).

3. **Resolve gray zones**
   - **404 vs 403:** avoid revealing existence of protected resources; often return **403** or generic **404** per security policy — document the choice.
   - **409 vs 422:** **409** = conflict with **current state** of a resource; **422** = rule rejection that is not strictly a “version conflict” (team nuance goes in `05-error-handling.md`).

4. **Stable `error.code`**
   - One code per distinguishable client/monitoring case; pattern **`MODULE_NNN`** (see **`05-error-handling.md`**).
   - Register every code in **`docs/knowledge-base/error-codes.md`** with HTTP status and short meaning.

5. **Design domain exceptions (optional but typical)**
   - Prefer a small hierarchy or **enum** that carries **`code`** and **HTTP status** (or a mapping function), so services throw domain types and the global handler reads status + code without giant `instanceof` chains.
   - Keep services free of **`ResponseEntity`** — mapping happens at the edge.

6. **Document the matrix**
   - Extend **`docs/api/05-error-handling.md`** sample table (or link to **`error-codes.md`**) so API readers see status + code together.
   - For public APIs, align with **`docs/api/09-contract-template.md`** or per-resource docs if errors are listed per endpoint.

7. **Implement in code**
   - Wire mapping in **`@RestControllerAdvice`** per **`skills/error-handling/global-exception-handler/README.md`**.
   - Ensure **one** handler path per exception type to avoid ambiguous status.

8. **Verify**
   - Tests or contract checks: critical paths return expected **status** and **`$.error.code`**.
   - Review: no **500** used for expected business failures.

## Output

- Updated **`docs/api/05-error-handling.md`** and/or **`docs/knowledge-base/error-codes.md`**.
- Domain exception types or mapping table in code (enum, registry, or explicit `switch`).
   - Handlers consuming that mapping.

## References

- `skills/error-handling/api-error-response-format/README.md`
- `skills/error-handling/global-exception-handler/README.md`
- `docs/api/03-response-format.md`, `docs/api/05-error-handling.md`
- `docs/knowledge-base/error-codes.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
