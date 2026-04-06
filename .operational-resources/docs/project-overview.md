# Project Overview

## Thông tin chung

- **Tên dự án**: al-operational-resources
- **Mã dự án** (nếu có): [PROJ-XXX]
- **Loại dự án**: Dự án lớn, phát triển dài hạn, làm việc nhóm
- **Phương thức phát triển**: Agile / Scrum

## Mục tiêu kinh doanh

- [Mô tả mục tiêu chính của dự án — ví dụ: nền tảng vận hành, API nội bộ, tích hợp dịch vụ…]
- **Giá trị cốt lõi**: [Tốc độ / Độ tin cậy / Trải nghiệm người dùng / Bảo mật — điền cụ thể]

## Phạm vi hiện tại (Scope)

- Các module đang phát triển: Auth, User Management, [Order, Payment, Notification, Dashboard…]
- Module đã hoàn thành: [liệt kê nếu có]
- Module sắp tới: […]

## Tech stack chính (repo hiện tại)

- **Frontend**: [chưa có trong repo — cập nhật nếu thêm SPA/monorepo]
- **Backend**: Spring Boot 3.x, Java 17, Maven
- **Database**: [PostgreSQL / H2 / … — cập nhật khi gắn persistence]
- **Cache**: [Redis — nếu có]
- **Authentication**: [JWT / session / OAuth — theo team]
- **Deployment**: [Docker / K8s / VM — theo team]
- **Testing**: JUnit 5, Spring Boot Test, Mockito

## Kiến trúc tổng quát

- **Layered / Clean boundaries** trên Spring (controller → service → repository)
- **DDD / CQRS / Event-driven**: [mức độ áp dụng — ghi rõ khi có]

## Rủi ro & thách thức lớn nhất

1. [Ví dụ: performance khi scale]
2. [Data consistency giữa các module/service]
3. [Tích hợp bên thứ ba]

## Stakeholders

- Product Owner: […]
- Tech Lead: […]
- Team size: [số người]

**Last updated**: 06/04/2026
