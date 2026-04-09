# Checklist: Design Feature Architecture

Dùng trước khi bắt đầu implement. Mục nào không áp dụng thì có thể bỏ qua.

## Exit criteria

- [ ] Thiết kế đủ rõ để một engineer khác đọc và hiểu mà không cần giải thích trực tiếp
- [ ] Open questions được liệt kê tường minh (không ẩn trong assumptions)
- [ ] Có trạng thái rõ: **Ready** / **Blocked**

## Inputs

- [ ] Đã đọc spec hoặc task file; scope và non-goals rõ ràng
- [ ] Đã nắm thứ tự đọc `docs/architecture/01-README.md`
- [ ] Xác định được stakeholder/owner cho trade-offs còn mở

## Structure

- [ ] Feature đã map đúng layers theo `06-backend-layers-and-dependencies.md`
- [ ] Packages/paths bám `04-folder-structure.md`
- [ ] Async flow hoặc external calls bám `07-integrations.md` (nếu có)

## Contract & behavior

- [ ] Main request/response và validation đã ghi rõ (link hoặc sketch trong task)
- [ ] Error semantics nhất quán với `docs/api/` và error catalog của dự án (nếu có)
- [ ] Đã xem xét idempotency / transactions theo `08-transactions-and-consistency.md` khi cần
- [ ] Đã kiểm tra backward compatibility và versioning impact (nếu API public/shared)

## Data

- [ ] Đã liệt kê schema/migration impact (`05-database-design.md`)
- [ ] Đã cân nhắc indexes/constraints cho hot paths
- [ ] Đã ghi rủi ro read/write amplification theo traffic profile dự kiến

## Cross-cutting

- [ ] Security touchpoints bám `09-security-architecture-backend.md`
- [ ] Có observability (logs/metrics/traces) cho flow mới
- [ ] Có mô tả failure/retry strategy cho external integrations (nếu có)

## Decisions

- [ ] Đã tạo ADR và cập nhật index nếu decision đủ quan trọng (`docs/decisions/`)
- [ ] Đã có top 3 risks + mitigations trong design note

## Handoff to implementation

- [ ] Đề xuất coding sequence (gợi ý first PR slice)
- [ ] Phác test strategy (ranh giới unit/integration)
- [ ] Các mục out-of-scope được park rõ ràng cho giai đoạn sau

**Last updated:** 2026-04-08
