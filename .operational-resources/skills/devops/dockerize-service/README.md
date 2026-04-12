# Dockerize Service (index)

## TL;DR (VI)

- Playbook **Dockerfile** cho **Spring Boot**: multi-stage, **non-root**, **exec** `ENTRYPOINT`, env **`JAVA_OPTS`** / **`SPRING_PROFILES_ACTIVE`** — **không** đóng gói secret.
- Kèm **`.dockerignore`**; health/probe nối với **Actuator** khi dùng container orchestration.

## Thư mục này chứa gì

| File | Mục đích |
|------|----------|
| `SKILL.md` | Quy trình build image, security, health |
| `examples.md` | Dockerfile mẫu, `.dockerignore`, lệnh build/run |
| `checklist.md` | Gate trước merge |
| `README.md` | File này |

## Thứ tự khuyến nghị

1. Đồng bộ **profile / env** với `skills/devops/configure-environment/`.
2. Làm theo `SKILL.md`; copy chỉnh từ `examples.md`.
3. Nếu deploy K8s: đọc `skills/devops/health-check-endpoint/README.md` cho liveness/readiness.
4. Chạy `checklist.md` và cập nhật `docs/setup/` (build context, tên biến).

## Liên kết nhanh

- `skills/devops/configure-environment/README.md`
- `skills/devops/configure-logging/SKILL.md`
- `skills/devops/health-check-endpoint/README.md`
- `rules/06-security.md`
- `docs/setup/02-local-development.md`, `docs/setup/04-deployment-overview.md`

**Last updated:** 2026-04-11
