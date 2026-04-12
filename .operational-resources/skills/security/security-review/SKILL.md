# Skill: Security Review

## TL;DR (VI)

- Đọc diff theo **rủi ro**: endpoint mới → **authn/authz** + **IDOR**; query/string → **injection**; integration → **SSRF** / secret; DTO → **mass assignment** + **validate-input**.
- **Không** hardcode secret; **không** log token/password/PII nhạy cảm; phản hồi lỗi **không** lộ stack/schema nội bộ.
- Chạy **`checklist.md`**; bổ sung **`examples.md`** khi cần bằng chứng (lệnh scan, bước test thủ công).

## Goal

Perform a **structured security pass** on a change set (PR or release) so common vulnerabilities and policy violations are caught before production.

## Preconditions

- Know the **threat model** at team level: public vs internal APIs, payment/PII scope (`rules/06-security.md`).
- Access to the diff and, for integrations, config (URLs, keys — **not** values in chat/logs).

## Steps

1. **Scope the review**
   - Tag files: controllers, security config, repositories, DTOs, integrations (HTTP, webhook, payment), migrations, config YAML.

2. **Secrets and credentials**
   - Search for hardcoded passwords, API keys, private keys, OAuth client secrets.
   - Confirm secrets come from **environment** or **secret manager**; no real values in repo or test fixtures committed by mistake.

3. **Authentication and session**
   - New or changed routes: are they **classified** public vs authenticated per `docs/api/04-authentication.md`?
   - Cookie/JWT settings: **HttpOnly**, **Secure**, **SameSite** where applicable; token lifetime documented.

4. **Authorization and IDOR**
   - For every resource id in path/body: does the code verify **tenant/ownership** or role in **service** layer, not only `@PreAuthorize` on coarse roles?
   - Admin-only or privileged actions explicitly protected — see **`skills/security/secure-api-endpoint/README.md`**.

5. **Injection and unsafe parsing**
   - SQL: only **parameterized** queries / JPA; no string-concat SQL.
   - Command execution, `ScriptEngine`, unsafe deserialization: flag if introduced.
   - XML/XXE if parsing external XML.

6. **Input and output**
   - DTOs use **`@Valid`** and safe binding; no binding **internal** fields (role, `isAdmin`) from client input — **`skills/security/validate-input/SKILL.md`**.
   - Responses do not expose **stack traces**, raw SQL, or internal IDs unnecessarily; align with **`docs/api/05-error-handling.md`**.

7. **XSS and content types**
   - If returning **HTML** or embedding user content, check encoding/CSP policy per frontend/stack.

8. **SSRF and outbound calls**
   - URLs from user input or webhooks: validate **allowlist** or block internal/metadata IPs — relevant for **`skills/integration/call-external-api/README.md`** style integrations.

9. **Files and uploads**
   - Path traversal, content-type sniffing, size limits, virus scan policy if team requires — cross-check **`skills/backend/implement-file-upload/README.md`** when touched.

10. **Logging and auditing**
    - No **tokens**, passwords, full PAN, or unnecessary PII in logs.
    - Sensitive actions: consider **audit** fields (who/when) if policy requires.

11. **Dependencies and supply chain**
    - Run or verify CI for **dependency scan** (e.g. OWASP Dependency-Check, Snyk, GitHub Dependabot).
    - New native or transitive deps: note attack surface increase.

12. **Configuration**
    - **CORS** not overly permissive; **debug** endpoints disabled in prod; **default accounts** removed.

13. **Verify**
    - Walk **`checklist.md`**; for high-risk areas, add or request **tests** (authz negative cases, IDOR).

## Output

- PR comments or a short report: **must-fix** vs **nice-to-have**, with file references and suggested owners.

## References

- `skills/security/security-review/README.md`
- `skills/security/security-review/checklist.md`
- `rules/06-security.md`
- `docs/architecture/09-security-architecture-backend.md`
- `docs/api/04-authentication.md`, `docs/api/05-error-handling.md`
- `skills/security/secure-api-endpoint/README.md`
- `skills/security/validate-input/SKILL.md`
- `skills/code-quality/review-code/README.md`
- `skills/integration/call-external-api/README.md`
- `skills/backend/implement-file-upload/README.md`

**Last updated:** 2026-04-11
