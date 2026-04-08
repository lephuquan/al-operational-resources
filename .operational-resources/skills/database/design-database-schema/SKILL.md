# Skill: Design Database Schema

## Goal

Thiết kế schema: normalization, khóa ngoại, index, constraints, và chiến lược migration.

## Steps

1. Thu thập entity và quan hệ từ spec + domain.
2. Chọn khóa: surrogate key (long/UUID) theo convention.
3. Index: WHERE/JOIN/ORDER BY thường dùng; unique business key.
4. Soft delete: ảnh hưởng unique index (partial index nếu có).
5. Ghi vào `docs/architecture/05-database-design.md` + script migration.

## References

- `docs/decisions/` khi có trade-off lớn
