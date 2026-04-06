# Folder Structure

## Repo hiện tại (Spring Boot — Maven)

```
project-root/
├── src/main/java/.../          # Mã nguồn ứng dụng
├── src/main/resources/         # application.properties/yml, static, templates
├── src/test/java/              # Test
├── pom.xml
└── .operational-resources/     # Tài liệu & rules cá nhân (không commit nếu exclude)
```

## Monorepo (nếu áp dụng sau này)

```
apps/
├── web/              # Frontend (ví dụ Next.js)
└── api/              # Backend (Spring Boot)
packages/
├── shared-contracts/ # OpenAPI / DTO shared (ví dụ)
└── ...
```

## Backend structure (Spring Boot — gợi ý)

```
src/main/java/com/example/app/
├── config/             # @Configuration, security, beans
├── common/             # exception, util, mappers (nếu có)
├── api/ hoặc web/      # @RestController
├── application/        # @Service, use cases
├── domain/             # entities, domain services (khi tách)
└── infrastructure/     # JPA repositories, adapters
```

**Quy tắc:** Mỗi module lớn nên giữ ranh giới rõ; tránh “fat controller” và logic SQL rải rác ngoài repository/query layer.
