# Skill: Create JPA Entity

## Goal

Tạo entity JPA an toàn: mapping đúng cột/bảng, quan hệ lazy/eager có chủ đích, equals/hashCode nếu cần.

## Steps

1. Đặt tên bảng/cột theo convention DB (`@Table`, `@Column`).
2. Khóa chính: `@Id` + `@GeneratedValue` (hoặc UUID strategy).
3. Quan hệ: `@ManyToOne` / `@OneToMany` — mặc định lazy cho collection; tránh cascade vô hạn.
4. `createdAt`/`updatedAt`: Auditing hoặc `@PrePersist`/`@PreUpdate`.
5. Soft delete: `deletedAt` + query filter (hoặc `@SQLDelete` + `@Where` nếu team dùng).
6. Repository: `JpaRepository<Entity, Id>` + query methods hoặc `@Query` khi phức tạp.

## Output

- Entity + repository + (tuỳ chọn) migration Flyway/Liquibase.

## References

- `docs/architecture/database-design.md`
