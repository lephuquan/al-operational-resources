# ADR-001: Chọn Spring Data JPA cho persistence

**Ngày**: 2026-02-15  
**Trạng thái**: Accepted

## Context

Cần lớp truy cập dữ liệu phù hợp với Spring Boot, giảm boilerplate SQL thủ công, vẫn kiểm soát migration qua Flyway/Liquibase khi cần.

## Decision

Chọn **Spring Data JPA** (Hibernate) làm lớp persistence chính.

## Alternatives Considered

- JDBC template: linh hoạt nhưng nhiều code thủ công hơn.
- jOOQ / QueryDSL: mạnh cho query phức tạp, có thể bổ sung sau nếu cần.
- MyBatis: phù hợp SQL-centric, nhưng khác phong cách team nếu đã chuẩn hóa JPA.

## Consequences

**Positive**

- Tăng tốc CRUD và mapping entity.
- Hệ sinh thái Spring tích hợp sẵn.

**Negative**

- Cần cẩn thận N+1, lazy loading, và performance tuning.

**Risks**

- Schema drift nếu không quản lý migration và review query.
