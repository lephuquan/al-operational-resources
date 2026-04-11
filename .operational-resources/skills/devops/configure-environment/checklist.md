# Checklist: Configure environment

Dùng trước khi merge thay đổi cấu hình. Bỏ qua mục không áp dụng.

## Secret & Git

- [ ] Không secret/credential trong file được commit
- [ ] `.env` / file local nhạy cảm đã **gitignore** (nếu dùng)
- [ ] Có file **example** (`.env.example` / `application-local.yml.example`) không chứa giá trị thật

## Profile & override

- [ ] `application.yml` + `application-{profile}.yml` rõ ràng; không trùng lặp mơ hồ
- [ ] Biến env override được document (tên biến, không giá trị)

## Type-safe & validation

- [ ] Property bắt buộc có validation hoặc fail-fast khi thiếu
- [ ] Feature flag có tài liệu (bật/tắt theo môi trường)

## Vận hành

- [ ] Đã smoke chạy với profile dev/staging/prod tương ứng (hoặc CI load context)
- [ ] `docs/setup/` đã cập nhật nếu thêm biến mới cho dev/onboarding

**Last updated:** 2026-04-09
