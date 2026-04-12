# Checklist: Integrate Email Service

Dùng trước khi merge adapter email, template, hoặc thay provider.

## Config & secrets

- [ ] Host, port, user, password/API key chỉ qua **env** hoặc secret store; không trong Git.
- [ ] `docs/setup/` hoặc `07-integrations.md` ghi **tên** biến bắt buộc.

## Architecture

- [ ] Domain/application **không** phụ thuộc trực tiếp `JavaMailSender` / `WebClient` thô — có **port** + adapter.

## Content safety

- [ ] HTML có dữ liệu user: **escape** hoặc sanitize theo policy; cẩn thận link động.
- [ ] **From / Reply-To** tuân policy domain (SPF/DKIM do vận hành xử lý — ít nhất ghi trong doc).

## Runtime

- [ ] Gửi từ request path người dùng: đã **async** hoặc queue nếu volume/timeout không chấp nhận được.
- [ ] Timeout / retry không gây **duplicate** không kiểm soát (ghi rõ semantics).

## Privacy & logging

- [ ] Prod: không log **to/cc/bcc**, subject có PII, hay full body.

## Testing

- [ ] Unit test với mock port.
- [ ] Ít nhất một integration test SMTP testcontainer/GreenMail **hoặc** sandbox provider (theo team).

## Optional webhooks

- [ ] Bounce/complaint: dùng `implement-webhook-handler` + cập nhật suppression nếu có.

**Last updated:** 2026-04-11
