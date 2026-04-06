# Technology Stack

**Last updated**: 06/04/2026

## Core stack (dự án Spring Boot hiện tại)

| Phần | Công nghệ | Phiên bản | Ghi chú |
|------|-----------|-----------|---------|
| Language | Java | 17 | |
| Backend | Spring Boot | 3.x | |
| Build | Maven | (theo `pom.xml`) | |
| Persistence | Spring Data JPA / JDBC | (khi thêm) | Thay thế ví dụ Prisma trong tài liệu gốc |
| Database | PostgreSQL / H2 / … | (chọn theo môi trường) | |
| Cache | Redis | (nếu dùng) | Session, rate limit, cache |
| Auth | JWT / OAuth2 / session | (theo team) | |
| Testing | JUnit 5, Mockito, Spring Boot Test | | |
| Deployment | Docker / K8s / … | (theo team) | |

## Frontend (nếu có — không nằm trong repo này)

| Phần | Công nghệ | Ghi chú |
|------|-----------|---------|
| UI | Next.js / React / … | Điền khi có app riêng hoặc monorepo |
| Styling | Tailwind + shadcn (ví dụ) | Chỉ khi team dùng |

## Dev tools

- Formatter / linter: theo team (Spotless, Checkstyle, EditorConfig…).
- CI/CD: [GitHub Actions / GitLab CI / …]
- Monorepo: [có/không]
