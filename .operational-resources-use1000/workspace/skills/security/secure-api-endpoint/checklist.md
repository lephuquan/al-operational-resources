# Checklist: Secure API Endpoint

Dùng trước khi merge thay đổi **Spring Security**, route public, hoặc rule **authz**.

## Matcher & defaults

- [ ] **Public allowlist** đã được liệt kê và **không** mở rộng vô tình (không `/**` permit trừ khi có lý do và review).
- [ ] **`anyRequest()`** / default cho API là **authenticated** (hoặc tương đương policy team).

## Authn

- [ ] Secret / JWK / client credential chỉ từ **env** hoặc **secret manager** — không trong repo.
- [ ] **Không log** JWT, refresh token, password, API key (kể cả partial).

## Authz

- [ ] Role/scope **thô** ở boundary; rule **ownership / IDOR** có kiểm tra ở **service** (hoặc layer team quy định).
- [ ] Internal call paths (scheduler, listener) không **bypass** policy nhờ thiếu check.

## CSRF / CORS

- [ ] **CSRF** phù hợp mô hình (cookie session vs Bearer-only) — có ghi chú nếu disable.
- [ ] **CORS** không mở `*` kèm credential; origin khớp môi trường.

## Errors

- [ ] **401 / 403** đồng bộ với **`global-exception-handler`** và contract API.

## Tests

- [ ] Có ít nhất một kiểm tra (test tự động hoặc checklist thủ công có bằng chứng): no auth → từ chối; sai role → 403.

**Last updated:** 2026-04-11
