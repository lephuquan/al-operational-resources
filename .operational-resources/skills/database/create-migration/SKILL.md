# Skill: Create Migration

## Goal

Thêm migration Flyway/Liquibase: idempotent theo version, reviewable, rollback plan.

## Steps

1. Đặt tên file theo convention: `V{version}__description.sql`.
2. DDL: tránh lock lâu trên bảng lớn (online migration strategy).
3. Backfill data trong migration riêng nếu phức tạp.
4. Test migration trên DB copy/staging.
5. Cập nhật entity JPA khớp schema.
