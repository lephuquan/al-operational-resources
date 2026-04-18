# 01 - Project Overview

- **Tên dự án**: al-operational-resources
- **Mô tả**: Dịch vụ Spring Boot (Maven) cho tài nguyên vận hành — làm việc nhóm, phát triển dài hạn.
- **Loại dự án**: Dự án lớn, làm việc nhóm
- **Kiến trúc**: Layered Architecture (Spring: controller → service → repository)
- **Tech stack chính**:
  - Frontend: [chưa có trong repo này — cập nhật nếu thêm]
  - Backend: Spring Boot 3.x
  - Language: Java 17
  - Database: [PostgreSQL / H2 / … — cập nhật khi gắn persistence]
  - Other: Maven, JUnit 5, Spring Boot Test

## Scope & modules chính

- Auth, User, [Order, Payment, Notification — bổ sung theo roadmap thực tế]

## Important constraints

- Phải tuân thủ coding standards và architecture của team.
- Mọi thay đổi lớn (kiến trúc, contract API, DB) phải có plan rõ ràng và được xác nhận khi cần.
