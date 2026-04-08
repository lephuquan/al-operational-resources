# Security architecture (backend code)

## TL;DR (VI)

- Bổ sung cho `docs/api/04-authentication.md`: **trong code** đặt filter chain, validate token, phân quyền nghiệp vụ ở **service**.
- Không log token/password; dùng least privilege cho DB user.

**Last updated:** 2026-04-08

## 1. Scope

This document covers **server-side** security mechanics. HTTP-facing auth standards remain in `docs/api/04-authentication.md`.

## 2. Authentication

| Concern | Practice |
|---------|----------|
| Token validation | Centralized filter or OAuth2 resource server configuration |
| Clock skew | Allow small leeway for JWT `exp` validation |
| Secret storage | Environment variables or secret manager — never `application.yml` in repo |

## 3. Authorization

| Level | Where |
|-------|--------|
| Route-level | Security filter chain / method security for coarse roles |
| Resource-level | Application/domain services: ownership, state machine, custom policies |

**Rule:** Do not rely only on `@PreAuthorize` for complex business rules — duplicate critical checks in services if annotations can be bypassed by internal calls.

## 4. Input and output

- Validate all external input at boundary (DTO + Bean Validation).
- Sanitize or reject unexpected fields if using flexible JSON maps.
- Avoid reflecting raw exception messages to clients (`docs/api/05-error-handling.md`).

## 5. Data protection

- Passwords: strong hashing (BCrypt/Argon2) per team policy.
- PII: minimize fields stored; document retention in team privacy docs.
- At-rest encryption: database TDE / column encryption — infrastructure decision; note here if it affects code paths.

## 6. Operational security

- Dependency scanning in CI.
- Least privilege DB credentials for application runtime.
- Audit logs for sensitive actions (who did what, without secrets).

## Related

- API auth contract: `docs/api/04-authentication.md`
- Rules: `rules/06-security-best-practices.md` (if present in your workspace)
- Secure endpoint skill: `skills/security/secure-api-endpoint/`
