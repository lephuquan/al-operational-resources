# Checklist: Code review

Dùng cho **self-review** hoặc **peer review**. Đánh dấu [N/A] nếu không áp dụng.

## Ngữ cảnh

- [ ] Đã đọc mô tả PR/task và hiểu mục tiêu thay đổi
- [ ] Biết cách reproduce / chạy test theo “How to test”

## Correctness & dữ liệu

- [ ] Logic và edge case (null, empty, conflict, retry) đã xem xét
- [ ] Transaction và consistency phù hợp thay đổi (ghi/nhiều bước/remote)

## Design

- [ ] Layering và naming chấp nhận được; không god method/class mới nguy hiểm
- [ ] API không lộ entity/internal detail không cần thiết

## API & lỗi

- [ ] Validation đầu vào đủ; error mapping nhất quán với contract
- [ ] Breaking change (nếu có) được ghi và docs đã xử lý

## Security

- [ ] Authz đúng scope endpoint/feature
- [ ] Không secret/PII trong code, log, response
- [ ] Input đáng ngờ (path, upload, SQL) đã xem nếu PR chạm tới

## Test

- [ ] Test chứng minh thay đổi; có negative/edge khi AC yêu cầu
- [ ] Không test flaky rõ ràng (hoặc đã ghi rõ lý do)

## Performance & vận hành

- [ ] N+1 / chatty I/O không xuất hiện mới
- [ ] Log/metric đủ để hỗ trợ incident (không ồn ào PII)

## Kết luận

- [ ] Must-fix (blocking) đã liệt kê rõ
- [ ] Nit/suggestion tách biệt; trạng thái review: Approve / Request changes / Comment

**Last updated:** 2026-04-09
