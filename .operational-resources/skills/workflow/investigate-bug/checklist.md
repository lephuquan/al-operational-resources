# Checklist: Investigate Bug

Dùng khi **chưa chắc root cause** hoặc **trước MR** bugfix.

## Thu thập

- [ ] Triệu chứng + **tác động** nghiệp vụ ghi trong task (§6B)
- [ ] **Version/deploy**, môi trường, **request/correlation id** (nếu có) đã ghi
- [ ] Log/stack **đã redact** secret/PII trước khi dán vào prompt công khai

## Tái hiện & phân tích

- [ ] Có **bước tái hiện** tối thiểu (curl, job, hoặc test)
- [ ] Nếu có exception: đã qua **`analyze-stacktrace`** (hoặc có lý do bỏ qua)
- [ ] Giả thuyết đã **loại trừ** bằng thử nghiệm nhỏ — không chỉ “đoán và sửa”

## Fix

- [ ] Fix **gắn root cause**, không refactor rộng ngoài scope ticket
- [ ] **Regression**: test mới hoặc lý do + bước kiểm tra thủ công rõ ràng

## Đóng vòng

- [ ] `./mvnw test` (hoặc lệnh team) **xanh**
- [ ] Task: progress log + **AC → test** cập nhật
- [ ] MR: **How to test** + link ticket (`prepare-pull-request`)

**Last updated:** 2026-04-11
