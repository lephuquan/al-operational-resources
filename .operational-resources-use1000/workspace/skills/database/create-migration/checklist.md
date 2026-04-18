# Checklist: Create migration

Dùng trước khi merge migration. Bỏ qua mục không áp dụng.

## Version & naming

- [ ] Version/changeset **duy nhất**; không trùng file đã merge
- [ ] Tên mô tả đúng thay đổi (dễ tìm trong lịch sử)

## DDL & dữ liệu

- [ ] Thứ tự expand → contract (nếu zero-downtime) đã xem xét
- [ ] Default / NOT NULL / backfill không làm fail trên DB có dữ liệu cũ
- [ ] Index phù hợp query; không tạo index thừa không cần thiết (hoặc đã ghi lý do)

## Lock & vận hành

- [ ] Đã cân nhắc lock thời gian dài trên bảng lớn (online strategy nếu cần)
- [ ] Không có DDL “ngầm” ngoài tool migration (tránh drift)

## Kiểm thử

- [ ] Đã chạy migration trên DB dev/staging (hoặc container) ít nhất một lần
- [ ] App khởi động và smoke path DB OK sau migrate

## Code & docs

- [ ] Entity JPA / mapping khớp schema mới
- [ ] MR/task ghi **rollback / forward-fix** hoặc “không rollback được”

**Last updated:** 2026-04-09
