# Checklist: Refactor an toàn

Dùng trước mỗi PR refactor hoặc sau chuỗi bước nhỏ.

## Trước khi sửa

- [ ] Scope refactor đã chốt (không “làm luôn cả module”)
- [ ] Có test che chở hành vi (hoặc plan characterization test rõ ràng)
- [ ] Đã đọc/smell list từ `detect-code-smells` nếu refactor bám theo báo cáo

## Trong lúc refactor

- [ ] Mỗi bước nhỏ: compile + test liên quan xanh
- [ ] Không đổi contract public (API/DTO/error) trừ khi có task/ADR riêng
- [ ] Không trộn thay đổi không liên quan (format, rename mass không cần thiết)

## Hành vi & rủi ro

- [ ] Đã kiểm tra path exception, null, transaction không bị lệch sau extract/move
- [ ] Không làm hỏng logging/metrics có ý nghĩa vận hành (hoặc đã cố ý đổi và ghi trong MR)

## Trước merge

- [ ] Đã chạy test suite phạm vi đủ (module hoặc full theo policy)
- [ ] MR mô tả: **behavior preserved**, danh sách bước chính, follow-up (nếu có)

**Last updated:** 2026-04-09
