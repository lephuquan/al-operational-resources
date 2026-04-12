# Configure Environment (index)

## TL;DR (VI)

- Playbook **Spring profiles + env**: tách `application-{profile}.yml`, **secret qua biến môi trường**, config type-safe với **`@ConfigurationProperties`**.
- Có **example** cho dev; file chứa secret thật **không** vào Git.
- Neo tài liệu vận hành: **`docs/setup/`**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình profile, secret, validation, flags, docs |
| `examples.md` | YAML mẫu, ConfigurationProperties, `.env.example` |
| `checklist.md` | Gate trước merge |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Đọc `docs/setup/` hiện tại của dự án.
2. Làm theo `SKILL.md`; cập nhật example + gitignore.
3. Chạy `checklist.md` và cập nhật `docs/setup/` với **tên** biến bắt buộc.

## Liên kết nhanh

- `docs/setup/01-README.md`, `docs/setup/02-local-development.md`
- `rules/06-security.md`
- `skills/devops/configure-logging/SKILL.md`
- `skills/devops/dockerize-service/README.md`

**Last updated:** 2026-04-09
