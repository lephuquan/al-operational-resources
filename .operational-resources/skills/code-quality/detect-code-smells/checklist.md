# Checklist: Detect code smells

Dùng khi self-scan hoặc trước khi chốt báo cáo smell. Bỏ qua mục không áp dụng.

## Scope

- [ ] Phạm vi đã chốt (PR / package / module)
- [ ] Đã xem test liên quan để giảm false positive

## Cấu trúc & kích thước

- [ ] Method quá dài hoặc quá nhiều nhánh lồng đã được ghi nhận
- [ ] Class có quá nhiều dependency hoặc nhiều lý do thay đổi (SRP)

## API & layering

- [ ] Controller không chứa business nặng; không leak entity JPA ra API
- [ ] Tham số boolean/flag dư thừa đã được ghi nhận nếu gây khó đọc

## Trùng lặp & tái sử dụng

- [ ] Duplicate logic (copy-paste) đã trỏ ít nhất hai vị trí

## Hiệu năng & dữ liệu

- [ ] N+1 / query trong loop / remote trong loop đã được rà trong scope
- [ ] Transaction + remote call dài đã được ghi nhận nếu thấy

## Đầu ra

- [ ] Mỗi smell có: vị trí cụ thể + severity (P0/P1/P2) + một bước xử lý đề xuất
- [ ] Không chỉ nhận xét chung không gắn code

**Last updated:** 2026-04-09
