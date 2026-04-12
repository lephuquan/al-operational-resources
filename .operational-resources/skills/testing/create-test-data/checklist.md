# Checklist: Create Test Data

Dùng khi thêm **factory/builder** mới, **fixture JSON**, hoặc **script seed** cho integration test.

## Design

- [ ] Default của factory/builder thỏa **invariant** domain (không tạo entity “dở dở” trừ khi test đó cố ý test invalid).
- [ ] Tên method mô tả **ý nghĩa** (`pendingOrder`, `adminUser`) thay vì chỉ `order1` — trừ khi team đã chuẩn hóa số thứ tự.

## Isolation

- [ ] Không có **static mutable** object bị sửa giữa các test.
- [ ] DB: có **rollback**, **@Sql cleanup**, hoặc strategy tương đương — không phụ thuộc thứ tự chạy không kiểm soát.

## Determinism

- [ ] Thời gian / random có **cố định** hoặc inject được khi test assert theo timestamp hoặc snapshot.

## Safety

- [ ] Không commit **secret thật**, **PII thật**, dump production.

## Integration

- [ ] Schema/migration đổi: fixture và **migration** đã đồng bộ (không còn cột cũ trong builder).

**Last updated:** 2026-04-11
