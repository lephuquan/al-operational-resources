# Skill: Secure API Endpoint

## TL;DR (VI)

- Cấu hình **`SecurityFilterChain`** (Spring Security 6+): **order** matcher, **default deny** cho API nội bộ; **public** chỉ những route đã liệt kê (health, login, docs nếu team cho phép).
- **Authn**: JWT filter / OAuth2 **resource server** / form login — đồng bộ với `docs/api/04-authentication.md`; không log credential.
- **Authz**: `authorizeHttpRequests` + **`@EnableMethodSecurity`** / `@PreAuthorize` cho role/scope **thô**; kiểm tra **IDOR / ownership** trong **service**.
- **CSRF** tắt hoặc cấu hình đúng khi **state-changing** qua cookie; API **Bearer-only** thường **disable CSRF** cho path đó (document).
- **CORS**: chỉ origin cần thiết; tránh `*` với credential.
- **Verify**: anonymous → 401; authenticated sai quyền → 403; align với **`global-exception-handler`**.

## Goal

Protect HTTP endpoints with consistent **authentication**, **authorization**, and safe defaults (CSRF/CORS) so only intended callers can access resources.

## Preconditions

- Team auth pattern documented (`docs/api/04-authentication.md`): Bearer JWT, session, API key, or resource server.
- Inventory of **public** vs **protected** routes (e.g. `08-endpoint-list.md`).

## Steps

1. **Classify routes**
   - List **public** paths (health, auth callback, static OpenAPI if applicable).
   - Everything else under `/api/**` (or your prefix) defaults to **authenticated** unless explicitly public.

2. **Define `SecurityFilterChain`**
   - Use **`securityMatcher`** / `requestMatchers` so actuator, swagger, and API chains do not fight each other when you have multiple beans.
   - Order: **specific** rules before broad `anyRequest()`.

3. **Authentication**
   - Centralize token parsing / session establishment in one filter or resource-server config.
   - Load **signing keys / JWK set** from env or secret manager — never committed secrets.
   - Validate **issuer**, **audience**, **exp** (with small clock skew per `09-security-architecture-backend.md`).

4. **Authorization at the edge**
   - Use `authorizeHttpRequests` for path + coarse roles (`hasRole`, `hasAuthority`).
   - Add **`@PreAuthorize`** on controllers for consistent method-level checks where it helps readability.

5. **Authorization in the domain**
   - For **resource ownership**, **state transitions**, and **multi-tenant** rules, enforce in **service** (and keep controller checks as a thin duplicate only if team requires).
   - Do not assume every internal call path goes through `@PreAuthorize`.

6. **CSRF**
   - If browsers send **cookies** for session auth, enable CSRF protection or equivalent for unsafe HTTP methods.
   - For **pure Bearer** APIs, typically **disable CSRF** for those matchers — document the decision.

7. **CORS**
   - Configure allowed **origins**, **methods**, and **headers** explicitly; avoid reflecting arbitrary `Origin` in production.

8. **Related hardening**
   - Input validation at DTO boundary — **`skills/security/validate-input/SKILL.md`**.
   - Rate limiting / WAF often at **gateway** — mention in runbook if not in app.

9. **Errors and observability**
   - Map **`AuthenticationException`** → **401**, **`AccessDeniedException`** → **403** consistently with **`skills/error-handling/global-exception-handler/README.md`**.
   - Log **event type** (auth failure) without tokens or PII.

10. **Test**
   - **Anonymous** on protected route → 401 (or 403 per your policy — document).
   - **Authenticated** user **without** role → 403.
   - **Wrong tenant / IDOR** → 403 or 404 (pick team policy; stay consistent).

## Output

- Updated security configuration (filter chain, method security), short note on public allowlist, and tests or manual checklist results for 401/403 paths.

## References

- `skills/security/secure-api-endpoint/README.md`
- `docs/api/04-authentication.md`
- `docs/api/05-error-handling.md`
- `docs/architecture/09-security-architecture-backend.md`
- `skills/security/validate-input/SKILL.md`
- `skills/security/security-review/README.md`
- `skills/error-handling/global-exception-handler/README.md`
- `skills/devops/health-check-endpoint/README.md`
- `skills/integration/implement-webhook-handler/README.md`

**Last updated:** 2026-04-11
