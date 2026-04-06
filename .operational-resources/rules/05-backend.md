# 05 - Backend Guidelines

- **Clean Architecture / Layered Architecture**: tách rõ presentation (web/controller), application (service/use case), domain, infrastructure (repository, client ngoài).
- **Dependency injection**: constructor injection; tránh field injection trừ khi team cho phép.
- **Repository pattern** cho truy cập dữ liệu (Spring Data JPA hoặc abstraction team quy định).
- **Service layer** chứa business logic và orchestration.
- **Controller** chỉ mapping HTTP, validation trigger, mapping DTO — không nhét business logic dày.
- **Logging**: structured logging với **SLF4J + Logback** (tương đương vai trò Winston); log level hợp lý; không log PII/secret.
