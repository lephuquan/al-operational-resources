# Skill: Configure Environment

## TL;DR (VI)

- Chuẩn hóa **Spring profiles** (`dev`, `staging`, `prod`, …): config **không secret** trong `application-{profile}.yml`; **secret chỉ** env / secret manager.
- Dùng **`@ConfigurationProperties`** có validation; feature flag qua property có **tài liệu**.
- Không commit file chứa secret (`.env` prod, credential trong repo).

## Goal

Cấu hình môi trường rõ ràng, an toàn, và tái lập được trên máy dev/CI/prod: mọi người biết biến nào bắt buộc, giá trị mặc định an toàn, và cách override không lộ secret.

## Preconditions

- Biết các môi trường team dùng (local, staging, prod) và cách chạy app (`docs/setup/`).
- Có chỗ lưu secret (env, Vault, cloud secret manager) theo policy tổ chức.

## Steps

1. **Tách profile**
   - `application.yml` — default chung (không chứa secret).
   - `application-dev.yml`, `application-staging.yml`, `application-prod.yml` — chỉ khác biệt cần thiết.
   - Override cuối: biến môi trường `SPRING_APPLICATION_JSON` hoặc `SPRING_CONFIG_ADDITIONAL_LOCATION` nếu team dùng.

2. **Secret và nhạy cảm**
   - Không đặt password, API key, private key trong Git.
   - Map secret → `${VAR_NAME}` hoặc `${sm://...}` tùy nền tảng; document **tên biến** trong README/setup (không giá trị).

3. **Type-safe config**
   - `@ConfigurationProperties(prefix = "app")` + `@Validated` + constraint trên field bắt buộc.
   - Fail fast khi thiếu property quan trọng (`@NotBlank`, custom `@PostConstruct` check).

4. **Feature flags**
   - `app.features.xyz-enabled` + `@ConditionalOnProperty` hoặc toggle trong code có comment.
   - Ghi trong `docs/setup/` hoặc task: flag nào bật ở môi trường nào.

5. **Local developer experience**
   - `.env.example` hoặc `application-local.yml.example` (commit) — không chứa secret thật.
   - `.env` / `application-local.yml` cá nhân — **gitignore**; hướng dẫn copy từ example.

6. **Kiểm tra**
   - Chạy app với từng profile chính; smoke health + một endpoint business.
   - CI: inject env giả (dummy) để context load được.

7. **Tài liệu**
   - Cập nhật `docs/setup/` (tên biến, profile, URL public); đồng bộ với team nếu là contract vận hành.

## Output

- File YAML/profile + (tuỳ chọn) class `@ConfigurationProperties` + doc biến bắt buộc + gitignore cập nhật nếu cần.

## References

- `docs/setup/01-README.md`, `docs/setup/02-local-development.md`, `docs/setup/04-deployment-overview.md`
- `rules/06-security.md`
- `skills/devops/configure-logging/SKILL.md`
- `skills/devops/dockerize-service/README.md` (env trong container)

**Last updated:** 2026-04-09
