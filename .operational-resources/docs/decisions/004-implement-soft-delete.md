# ADR-004: Soft delete cho entities quan trọng

**Ngày**: 2026-03-20  
**Trạng thái**: [Proposed | Accepted]

## Context

Cần giữ lịch sử dữ liệu và audit; tránh mất dữ liệu do nhầm xóa.

## Decision

Áp dụng soft delete (`deleted_at` / flag `is_deleted`) cho các entity cần audit [liệt kê cụ thể].

## Alternatives Considered

- Hard delete + audit log table: phức tạp query nhưng DB “sạch”.
- Archive tables: tốt cho dữ liệu lớn nhưng tăng chi phí vận hành.

## Consequences

- Query phải filter delete mặc định (tránh leak data đã xóa).
- Index và unique constraints cần thiết kế lại (ví dụ partial unique index).
