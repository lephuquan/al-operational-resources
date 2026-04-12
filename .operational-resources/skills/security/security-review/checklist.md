# Checklist: Security Review

Tick trước **merge** (hoặc trước **release** nếu review theo batch). Bỏ qua mục không áp dụng — ghi rõ *N/A* và lý do.

## Secrets & config

- [ ] Không hardcode **password**, **API key**, **private key**, **client secret** trong code/test đẩy lên repo.
- [ ] Secret chỉ từ **env** / **secret manager**; file mẫu (`.example`) không chứa giá trị thật.
- [ ] Không bật **debug** / **swagger** không bảo vệ trên **production** (trừ policy team).

## Authn & authz

- [ ] Route mới/sửa đã phân loại **public** vs **authenticated** đúng contract.
- [ ] Hành động nhạy cảm có **role/permission** hoặc kiểm tra **ownership/tenant** ở tầng đúng (không chỉ tin UI).
- [ ] Không có đường **internal** (job, listener) **bypass** kiểm tra quyền.

## Injection & parsing

- [ ] SQL / JPQL: **parameterized**; không nối chuỗi từ input user.
- [ ] Không thêm **deserialization** không an toàn (ObjectInputStream từ không tin cậy, v.v.).

## Input / output

- [ ] DTO có **`@Valid`**; không **mass assign** field nội bộ (role, balance, …) từ client.
- [ ] Lỗi API không lộ **stack trace** / chi tiết DB cho client — khớp `05-error-handling`.

## Data exposure & IDOR

- [ ] Truy cập theo **id** (UUID, orderId, …): xác minh resource **thuộc** user/tenant đúng.
- [ ] Response không trả field **PII** / nội bộ không cần cho use case.

## XSS & content

- [ ] Nếu có **HTML** do user: có encode/CSP hoặc pipeline an toàn theo chuẩn team.

## Integration & SSRF

- [ ] URL/callback từ ngoài: **validate** hoặc **allowlist**; tránh gọi nội bộ/metadata IP nếu không chủ đích.

## File / upload (nếu có)

- [ ] Giới hạn **kích thước** / loại file; tránh **path traversal**; lưu trữ an toàn.

## Log & audit

- [ ] Log không chứa **token**, **password**, **full thẻ/thông tin thanh toán** nhạy cảm.
- [ ] Hành động quan trọng (nếu policy yêu cầu): có **audit** (ai/làm gì/khi nào).

## Dependencies

- [ ] CI hoặc reviewer đã xem **dependency scan** / advisory cho thay đổi liên quan (hoặc xác nhận pipeline chạy).

**Last updated:** 2026-04-11
