# Skill: Integrate Email Service

## TL;DR (VI)

- Gửi mail qua **SMTP** (JavaMail / `JavaMailSender`) hoặc **HTTP API** provider (SendGrid, SES API, …) — cấu hình **host/credentials qua env**, không hardcode secret.
- **Template** (Thymeleaf, FreeMarker, …) + **escape** nội dung động tránh XSS trong HTML; **async** (`@Async` / queue) khi volume hoặc SLA không cần sync.
- **Không log** body/to/cc chứa PII trong prod; **bounce/complaint** qua webhook → **`implement-webhook-handler`**.

## Goal

Send transactional or notification email reliably behind a small **application port** (`EmailSender` / `NotificationPort`), with safe templates, observable failures, and configuration suitable for multiple environments.

## Preconditions

- Decision: **SMTP** vs **provider HTTP API** (and provider account / sandbox).
- **`docs/architecture/07-integrations.md`** “Notification (email)” row filled (protocol, template location).
- Secrets via env — **`skills/devops/configure-environment/README.md`**.

## Steps

1. **Define the port**
   - Expose a narrow interface from the **application** layer (e.g. `sendOrderConfirmation(orderId)`), not raw `MimeMessage` in domain services.
   - Implement the adapter in **infrastructure** (SMTP or HTTP client).

2. **Configuration**
   - Bind **`spring.mail.*`** for SMTP, or custom **`@ConfigurationProperties`** for API base URL + API key header names.
   - Document variable **names** in `docs/setup/`; never commit passwords or API keys.

3. **SMTP path (Spring Boot)**
   - Use **`JavaMailSender`** + **`MimeMessageHelper`** (or `SimpleMailMessage` only for plain text prototypes).
   - Enable **TLS** / port per provider; set **timeouts** where supported to avoid hanging threads.

4. **HTTP API path**
   - Use **`WebClient`** per **`skills/integration/call-external-api/README.md`**: timeouts, retries only where idempotent, map 4xx/5xx to domain errors.

5. **Templates**
   - Prefer **externalized** templates (classpath or provider) with explicit **context variables**; avoid huge inline HTML in Java.
   - For HTML: escape or sanitize **user-controlled** fragments; be careful with **URLs** (open redirect, phishing).

6. **Sync vs async**
   - Default **async** for user-facing request threads: **`@Async`** with a dedicated executor or **message queue** for high volume.
   - Use **sync** only when the use case truly requires immediate send confirmation and latency is acceptable.

7. **Retries and idempotency**
   - SMTP/API transient failures: limited retries with backoff **inside the adapter** or via queue consumer — avoid duplicate sends unless the operation is **idempotent** (same logical notification key).
   - Document duplicate-send risk for “at-least-once” consumers.

8. **Observability**
   - Log **event type**, **message id** (if returned), **outcome** — not full body.
   - Metrics: send success/failure rate, latency (`skills/observability/add-metrics/SKILL.md`).

9. **Bounces and complaints**
   - If the provider supports **webhooks** for bounce/complaint, implement with **`skills/integration/implement-webhook-handler/README.md`** and update suppression lists.

10. **Testing**
   - **Unit:** mock the port in application tests.
   - **Integration:** **GreenMail** / **MailHog** for SMTP, or provider **sandbox** + WireMock for HTTP APIs.

11. **Documentation**
   - Extend **`07-integrations.md`** with from-address policy, template repo path, and operational links.

## Output

- Port interface + adapter implementation + configuration.
   - Templates (if in repo) + tests.
   - Optional webhook handler slice for bounces.

## References

- `skills/backend/create-service-layer/README.md`
- `skills/devops/configure-environment/README.md`
- `skills/integration/call-external-api/README.md` (provider HTTP APIs)
- `skills/integration/implement-webhook-handler/README.md` (bounce/complaint webhooks)
- `skills/security/validate-input/SKILL.md` (untrusted content in templates)
- `skills/error-handling/map-exceptions-to-http/README.md`
- `docs/architecture/07-integrations.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
