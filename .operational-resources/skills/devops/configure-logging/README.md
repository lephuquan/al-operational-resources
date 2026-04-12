# Configure Logging (index)

## TL;DR (VI)

- Playbook **Logback + Spring profile**: level, appenders, **rotation**, pattern **correlation id**, tránh log nhạy cảm.
- Bám **`skills/devops/configure-environment`** cho profile; code log → **`skills/observability/add-logging/README.md`**; trace id → **`skills/observability/implement-request-tracing/SKILL.md`**.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình XML/YAML, level, rotation, JSON, security |
| `examples.md` | `logback-spring.xml` dev/prod, rolling file, YAML level |
| `checklist.md` | Gate trước merge |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Xác định profile và nơi gom log (stdout vs file vs ELK).
2. Làm theo `SKILL.md`; copy/adapt `examples.md`.
3. Chạy `checklist.md`; cập nhật `docs/setup/` nếu dev cần hướng dẫn bật log đặc biệt.

## Liên kết nhanh

- `skills/devops/configure-environment/README.md`
- `skills/observability/add-logging/README.md`
- `skills/observability/implement-request-tracing/SKILL.md`
- `rules/06-security.md`

**Last updated:** 2026-04-11
