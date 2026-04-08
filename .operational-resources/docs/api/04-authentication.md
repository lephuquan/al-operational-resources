# Authentication and authorization

## TL;DR (VI)

- Mô tả **pattern** (Bearer, cookie refresh, API key) — chọn đúng cái team đang dùng.
- **Authn** ở edge/gateway/security filter; **authz** nghiệp vụ phức tạp nên kiểm tra ở **service layer**.

**Last updated:** 2026-04-08

## Goals

- Clear **authentication** (who is the caller) and **authorization** (what they may do).
- Avoid duplicating business authorization rules only in controller annotations.

## Common patterns (pick what your project uses)

| Pattern | Typical transport | Notes |
|---------|-------------------|--------|
| Bearer JWT | `Authorization: Bearer <access_token>` | Short-lived access token; refresh strategy below. |
| Refresh token | HttpOnly **Secure** cookie + `SameSite` policy | Prefer server-set cookie for web clients; document cookie names. |
| OAuth2 / OIDC | Authorization Server + bearer access token | Document issuer, audiences, scopes. |
| API key | `X-Api-Key` or `Authorization: ApiKey ...` | For machine-to-machine; rotate keys; never log key values. |
| mTLS | Client certificates | Usually at gateway; document if clients must present certs. |

## Access and refresh (example layout)

Illustrative only — replace names and lifetimes with your team’s values:

- **Access token:** JWT, short TTL (e.g. 15 minutes), sent as `Authorization: Bearer`.
- **Refresh token:** HttpOnly cookie, longer TTL, used only by `POST .../auth/refresh` (or OAuth refresh endpoint).
- **Logout:** Invalidate refresh (rotation/blacklist) and clear cookie; optionally revoke access if you maintain a denylist.

## Roles and permissions

Define a **small set of roles** (e.g. `ADMIN`, `USER`) and optional **fine-grained permissions** (`resource:action`). Document:

- Which routes are **public** (health, login, public catalog).
- Which routes require **authenticated** user only.
- Which routes require **specific roles** or permissions.

**Rule:** Express *simple* checks at controller boundary (`@PreAuthorize`, route guards); enforce **complex rules** (ownership, state machine) in the **service/domain** layer.

## Protected routes (template)

- Default: all routes under `/api/v{major}/**` require authentication **except** an explicit allowlist (login, register, public read, etc.).
- Document the allowlist in `08-endpoint-list.md` (Auth column = `Public`).

## Client responsibilities

- Send access token on every authenticated request (unless using session cookies for everything).
- Handle **401** (re-auth) and **403** (forbidden) distinctly on the client.

## Backend stack notes

- **Spring Boot:** `SecurityFilterChain`, JWT filter or resource server, `@PreAuthorize` where appropriate; keep token validation configuration in one place.
- **Never** log raw tokens or refresh tokens.

## Related documents

- Errors for auth failures: `05-error-handling.md`
- Endpoint inventory: `08-endpoint-list.md`
