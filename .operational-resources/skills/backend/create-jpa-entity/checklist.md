# Checklist: Create JPA Entity

Dùng trước khi merge slice persistence. Bỏ qua mục không áp dụng.

## Thiết kế & vị trí

- [ ] Đã đối chiếu `docs/architecture/05-database-design.md` và package trong `04-folder-structure.md`
- [ ] Entity không được expose trực tiếp ra REST (có DTO / mapping ở API layer)

## Mapping

- [ ] `@Table` / `@Column` đúng convention tên bảng/cột của team
- [ ] Nullability, length, precision, unique phù hợp nghiệp vụ

## Khóa & quan hệ

- [ ] Chiến lược `@Id` / `@GeneratedValue` (hoặc UUID) đã chốt và nhất quán với DB
- [ ] Fetch type (lazy/eager) có lý do; tránh EAGER mặc định trên collection
- [ ] `cascade` / `orphanRemoval` không gây xóa/flush không chủ ý
- [ ] Không có `LazyInitializationException` do gọi association ngoài transaction (hoặc đã xử lý bằng fetch join/DTO projection có chủ đích)

## equals / hashCode / toString

- [ ] Không trigger lazy load trong `equals` / `hashCode` / `toString`
- [ ] Nếu dùng Lombok `@Data` trên entity: đã xem xét rủi ro (thường tránh hoặc exclude associations)

## Repository

- [ ] `JpaRepository` (hoặc base repo team) + query methods rõ ràng
- [ ] Query phức tạp có `@Query` hoặc Specification — tránh N+1 không kiểm soát

## Schema & migration

- [ ] Có file migration tương ứng khi thêm/sửa bảng/cột/index
- [ ] Migration đã chạy OK trên local (hoặc ghi rõ bước chạy trong task)

## Test

- [ ] Có test tối thiểu (repository IT hoặc slice qua service) cho path quan trọng

## An toàn

- [ ] Không log entity chứa PII nhạy cảm ở mức production
- [ ] Soft delete (nếu có) không làm lộ dữ liệu đã “xóa” qua API không đúng policy

**Last updated:** 2026-04-09
