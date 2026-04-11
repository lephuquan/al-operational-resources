# Checklist: Design database schema

Dùng trước khi chốt thiết kế hoặc trước khi viết migration đầu tiên.

## Mô hình

- [ ] Entity, thuộc tính, quan hệ (cardinality) đã rõ từ spec/task
- [ ] Surrogate vs natural key đã chốt theo convention

## Toàn vẹn

- [ ] FK + hành vi DELETE/UPDATE phù hợp nghiệp vụ
- [ ] Unique constraint đúng business key; xử lý soft delete vs unique (partial index nếu cần)

## Hiệu năng

- [ ] Index cho query hot path đã liệt kê; không tạo index “dự phòng” vô hạn
- [ ] Cân nhắc ảnh hưởng ghi (write amplification) với index mới

## Vận hành & thay đổi

- [ ] Kế hoạch expand-contract hoặc downtime ghi rõ nếu bảng lớn / zero-downtime
- [ ] Backfill / default cho cột mới trên data cũ đã nghĩ tới

## Tài liệu

- [ ] `docs/architecture/05-database-design.md` (hoặc doc schema team) đã cập nhật
- [ ] ADR đã tạo nếu trade-off lớn (denormalize, kiểu đặc biệt, v.v.)

## Handoff

- [ ] Danh sách bước migration dự kiến đã giao cho `create-migration`

**Last updated:** 2026-04-09
