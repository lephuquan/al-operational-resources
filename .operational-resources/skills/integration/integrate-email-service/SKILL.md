# Skill: Integrate Email Service

## Goal

Gửi email qua SMTP hoặc provider (SendGrid, SES): template, retry, không block request chính nếu không cần.

## Steps

1. Chọn sync vs async: `@Async` / queue nếu volume lớn.
2. Template engine (Thymelead/FreeMarker) hoặc HTML string có escape.
3. Không log nội dung email chứa PII trong prod.
4. Bounce/complaint: webhook nếu provider hỗ trợ.
5. Config qua env: host, port, user, password (secret).
