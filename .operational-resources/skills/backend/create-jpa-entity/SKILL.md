# Skill: Create JPA Entity

## TL;DR (VI)

- Tạo **entity JPA + repository** bám convention DB và kiến trúc layer; có migration khi cần.
- Quan hệ dùng **lazy có chủ đích**; tránh cascade vô hạn và `equals`/`hashCode`/`toString` trên association lazy ngoài transaction.
- Neo vào `docs/architecture/05-database-design.md` và package layout trong `04-folder-structure.md`.

## Goal

Thêm (hoặc chỉnh) persistence layer: entity map đúng bảng/cột, khóa chính và quan hệ an toàn, repository interface rõ ràng, kèm migration Flyway/Liquibase khi schema mới/đổi — sẵn sàng gọi từ service layer mà không rò rỉ chi tiết JPA ra controller.

## Preconditions

- Đã có hoặc sẽ có định nghĩa bảng/cột (trong task, spec, hoặc thiết kế DB).
- Spring Data JPA + Hibernate đang dùng trong dự án.
- Biết convention đặt tên bảng/cột và package entity/repository của team (`docs/architecture/`).

## Steps

1. **Neo vào thiết kế và vị trí code**
   - Đọc `docs/architecture/05-database-design.md`, `04-folder-structure.md`, `06-backend-layers-and-dependencies.md`.
   - Đặt entity/repository đúng package; không expose entity trực tiếp ra API (DTO ở tầng API).

2. **Mapping bảng và cột**
   - `@Entity`, `@Table(name = "...")` theo naming convention (snake_case DB vs camelCase Java nếu team có quy ước).
   - `@Column` cho nullability, length, precision; unique constraint khi nghiệp vụ yêu cầu.

3. **Khóa chính**
   - `@Id` + `@GeneratedValue(strategy = IDENTITY)` hoặc sequence phù hợp DB.
   - Hoặc UUID/`@GeneratedValue` với generator nếu team chuẩn hóa — ghi rõ trong task.

4. **Quan hệ (associations)**
   - `@ManyToOne` / `@OneToMany` / `@OneToOne` / `@ManyToMany` với `mappedBy`, `FetchType` có lý do.
   - Collection: mặc định **lazy**; tránh `EAGER` trừ khi đo lường được và có comment/ADR.
   - `cascade` và `orphanRemoval` chỉ bật khi đúng aggregate boundary; tránh cascade lan rộng.

5. **Audit và soft delete (nếu dùng)**
   - `createdAt` / `updatedAt`: Spring Data JPA Auditing hoặc `@PrePersist` / `@PreUpdate`.
   - Soft delete: cột `deletedAt` + filter ở query/repository, hoặc `@SQLDelete` + `@Where` nếu team đã chuẩn.

6. **equals / hashCode / toString**
   - Với entity: thường chỉ dùng **stable id** khi đã persist; tránh gọi getter lazy trong `equals`/`hashCode`/`toString`.

7. **Repository**
   - `interface XxxRepository extends JpaRepository<Entity, Id>`; method query theo naming hoặc `@Query` khi cần.
   - Tránh logic nghiệp vụ nặng trong repository; giữ ở service nếu phức tạp.

8. **Migration**
   - Schema mới hoặc đổi cột: thêm script Flyway/Liquibase theo `skills/database/create-migration/SKILL.md`.
   - Đồng bộ index/constraint với entity.

9. **Kiểm thử**
   - Ít nhất: repository test hoặc integration test slice qua service (theo policy team).

## Output

- Entity class(es) + repository interface(es).
- Migration script (khi có thay đổi schema).
- Ghi chú trong task nếu có quyết định đặc biệt (fetch, cascade, soft delete).

## References

- `docs/architecture/05-database-design.md`
- `docs/architecture/04-folder-structure.md`
- `docs/architecture/06-backend-layers-and-dependencies.md`
- `skills/database/create-migration/SKILL.md`
- `skills/backend/create-service-layer/SKILL.md`
- `skills/backend/create-rest-api/SKILL.md` (DTO, không leak entity)

**Last updated:** 2026-04-09
