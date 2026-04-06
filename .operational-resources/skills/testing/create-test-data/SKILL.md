# Skill: Create Test Data

## Goal

Tạo dữ liệu test rõ ràng: factory/builder, tái sử dụng, không magic number không giải thích.

## Steps

1. Tạo `OrderFactory` / builder cho entity phức tạp.
2. Giữ default hợp lệ; override field cụ thể trong từng test.
3. Tránh share mutable state giữa tests.
4. Với DB: seed tối thiểu; xóa hoặc rollback sau test.
