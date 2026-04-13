# Bản mô tả dự án demo — ShelfLog API (Spring Boot)

**Vai trò:** Một **nguồn sự thật** cho dịch vụ **giả định**, chỉ phục vụ kiểm tra **docs + task lifecycle + code** trong repo này. Coi như module kiểu **greenfield** (tách bạch, dễ hiểu).

**Cập nhật lần cuối:** 2026-04-14

---

## 1. Tóm tắt sản phẩm

| Mục | Giá trị |
|-----|---------|
| **Tên** | ShelfLog |
| **Một dòng** | REST API theo dõi đồ trên “kệ” cá nhân (đồ dùng / sở thích): tiêu đề, danh mục, số lượng, ghi chú. |
| **Người dùng** | Một người / công cụ cá nhân (demo v1: không đa tenant, **không** xác thực). |
| **Không làm (v1)** | OAuth2, giao diện admin, xóa mềm + audit trail đầy đủ, event sourcing, rate limit ngoài mặc định của framework. |

---

## 2. Stack kỹ thuật (cố định cho demo)

| Lớp | Lựa chọn |
|-----|-----------|
| **Môi trường container (bắt buộc)** | **Docker Engine** + **Docker Compose** (plugin `docker compose`) — **yêu cầu kỹ thuật** để chạy PostgreSQL nhất quán giữa máy dev, không gọi là bước “triển khai production”. File chuẩn: **`simulator/docker-compose.postgres.yml`**. |
| Runtime | Java **17** |
| Framework | **Spring Boot 3.2+** (align with `pom.xml`, e.g. 3.5.x) |
| Build | **Maven** (ưu tiên `mvnw` nếu có) |
| Web | Spring Web, `spring-boot-starter-validation` |
| Truy cập dữ liệu | **Spring Data JPA** + **Hibernate** |
| **CSDL khi chạy ứng dụng (dev/demo)** | **PostgreSQL 16** trong container — cổng host **5433** → 5432 trong container (theo compose). |
| **CSDL khi chạy test tự động** | **H2** in-memory (profile `test` hoặc tương đương) — **chỉ** để test nhanh, **không** thay Postgres làm DB mặc định lúc `spring-boot:run`. |
| Kiểm thử | JUnit 5, Mockito, `@SpringBootTest`; **Testcontainers không bắt buộc** nếu IT dùng H2 đủ cho demo. |
| API | JSON, `application/json`, UTF-8 |

**Ghi chú:** Việc dùng Docker ở đây là **chuẩn kỹ thuật môi trường dev** (cùng một Postgres cho mọi người chạy demo), không mô tả pipeline deploy hay hạ tầng thật.

---

## 3. Mô hình miền

### 3.1 Thực thể: `ShelfItem`

| Trường | Kiểu | Quy tắc |
|--------|------|---------|
| `id` | UUID (lưu UUID hoặc chuỗi 36 ký tự) | Server sinh |
| `title` | chuỗi | Bắt buộc, **1–200** ký tự, trim khoảng trắng đầu cuối |
| `category` | enum | Bắt buộc: `OFFICE`, `HOBBY`, `KITCHEN`, `OTHER` |
| `quantity` | số nguyên | Bắt buộc, **0–999** |
| `notes` | chuỗi | Tuỳ chọn, tối đa **2000** ký tự |
| `createdAt` | `Instant` | Ghi khi tạo, không đổi |
| `updatedAt` | `Instant` | Ghi khi tạo/cập nhật |

### 3.2 Quy tắc nghiệp vụ

- **BR1:** `quantity` không được vượt **999** (validation + lỗi API rõ ràng).
- **BR2:** `title` sau khi trim không được rỗng.
- **BR3:** `DELETE` xóa hẳn bản ghi (**hard delete**) cho đơn giản demo.

---

## 4. HTTP API (v1)

Base path: **`/api/v1/shelf-items`**

| Phương thức | Đường dẫn | Mô tả |
|-------------|-----------|--------|
| `POST` | `/api/v1/shelf-items` | Tạo một bản ghi; **201** + body tài nguyên đã tạo |
| `GET` | `/api/v1/shelf-items` | Danh sách phân trang; query: `page` (bắt đầu 0), `size` (mặc định 20, tối đa 100), tuỳ chọn `category` |
| `GET` | `/api/v1/shelf-items/{id}` | Chi tiết theo id; **404** nếu không có |
| `PUT` | `/api/v1/shelf-items/{id}` | Thay thế toàn bộ trường được phép sửa; **404** nếu không có; validation giống tạo |
| `DELETE` | `/api/v1/shelf-items/{id}` | Xóa cứng; **204** không body |

### 4.1 Dạng request/response (phác thảo)

- Body tạo/cập nhật (JSON): `title`, `category`, `quantity`, `notes` (có thể bỏ `notes` hoặc null tùy quy ước bạn ghi trong spec).
- Response danh sách: kiểu `Page` của Spring hoặc JSON tùy chỉnh `{ "content": [...], "page": n, "size": n, "totalElements": n }` — **phải ghi rõ** trong `.operational-resources/docs/api/08-endpoint-list.md` và `docs/specs/feature-shelflog-items.md`.

### 4.2 Lỗi

- **400** — dữ liệu không hợp lệ: nên có gợi ý theo từng field (Bean Validation hoặc JSON kiểu Problem Details đơn giản).
- **404** — không tìm thấy id.
- **409** — tuỳ chọn nếu sau này có ràng buộc duy nhất; **v1 không bắt buộc**.

---

## 5. Gợi ý cấu trúc package (dưới `src/main/java`)

Khớp package hiện có của repo nếu đã có; nếu greenfield:

```text
com.programming_with_al.al_operational_resources
├── AlOperationalResourcesApplication.java
├── shelflog
│   ├── api           # REST controller + DTO
│   ├── application   # service / use cases
│   └── persistence   # JPA entity + repository
```

Chi tiết và quy ước lớp: `docs/architecture/04-folder-structure.md` §6.

---

## 6. Cấu hình DataSource và Docker

### 6.1 Trước khi chạy ứng dụng (dev)

1. Cài **Docker** và **Docker Compose**.
2. Từ thư mục gốc repo:  
   `docker compose -f .operational-resources/simulator/docker-compose.postgres.yml up -d`
3. Ứng dụng dùng profile **`dev`** (hoặc tên tương đương): JDBC tới `localhost:5433`, database `shelflog`, user/password theo file compose (`shelves` / `shelves` trong ví dụ hiện tại — **đồng bộ với tài liệu setup**, không commit secret thật).

### 6.2 JPA (dev với Postgres)

- Dialect PostgreSQL; `ddl-auto` có thể là `update` **chỉ cho demo** (không dùng cho production).

### 6.3 Profile `test` — H2

- Chạy `./mvnw test` **không** bắt buộc mở Docker nếu IT dùng H2 in-memory.
- Ghi rõ trong `.operational-resources/docs/setup/02-local-development.md`: chạy app tay cần Docker + Postgres; chạy test có thể chỉ cần Maven + H2.

---

## 7. Bảo mật (v1)

- **Không** xác thực cho demo — ghi rõ trong doc: “API mở, chỉ dùng local/demo”.
- **Không** log full body request nếu có thể chứa nội dung nhạy cảm; tránh pattern PII trong log.

---

## 8. Quan sát tối thiểu

- **Spring Boot Actuator:** bật **`/actuator/health`** cho demo (liveness/readiness pattern in `skills/devops/health-check-endpoint/`). Không bật exposure rộng trong production — demo chỉ chạy local.
- Log: SLF4J, tham số hóa message; tránh log full body có thể chứa PII.

---

## 9. Checklist — tài liệu (một nguồn: `.operational-resources/docs/`)

**Chỉ** cập nhật dưới `.operational-resources/docs/` khi đổi hành vi hoặc contract (không có bản sao trong `simulator/`).

| Khu vực | Đường dẫn (từ `.operational-resources/docs/`) |
|---------|-----------------------------------------------|
| Thứ tự đọc / mục lục | `README.md` |
| Tổng quan + demo ShelfLog | `project-overview.md` (mục ShelfLog) |
| Setup + chạy local | `setup/02-local-development.md`, `setup/05-troubleshooting-local.md` |
| Cấu hình profile / JDBC | `setup/03-configuration.md` |
| Kiến trúc | `architecture/02-system-overview.md` (§ ShelfLog), `03-tech-stack.md`, `04-folder-structure.md`, `05-database-design.md` |
| API inventory + changelog | `api/08-endpoint-list.md`, `api/10-current-api-changes.md` |
| Spec nghiệp vụ | `specs/feature-shelflog-items.md`, `specs/README.md` |
| ADR | `decisions/006-shelflog-demo-postgres-docker.md`, `decisions/README.md` |
| Task thực thi (infra trước) | `current-task/20260414-shelflog-infra.md` (SIM-DEMO-1) |
| Task thực thi (feature) | `current-task/20260411-shelf-items-api.md` (SIM-DEMO-2) |

**Ticket mẫu:** `simulator/DEMO-TICKET-20260414-shelflog-infra.md`, `simulator/DEMO-TICKET-20260411-shelf-items-api.md`.

Quy ước lỗi JSON và envelope HTTP: `api/03-response-format.md`, `api/05-error-handling.md` trừ khi task ghi rõ ngoại lệ.

---

## 10. Hướng dẫn tường minh cho AI (copy-paste)

> Đọc `.operational-resources/simulator/DEMO-PROJECT-BRIEF.md` và `.operational-resources/docs/project-overview.md` → `docs/specs/feature-shelflog-items.md` → `docs/api/08-endpoint-list.md` → `docs/setup/02-local-development.md`. Coi brief là hợp đồng sản phẩm + kỹ thuật cho **ShelfLog**; mọi thay đổi contract chỉ ghi trong **`docs/`** (§9). Không bịa tính năng ngoài §3–4 trừ khi người dùng yêu cầu. **Docker Compose** cho PostgreSQL là **yêu cầu kỹ thuật** môi trường dev (§2, §6); H2 chỉ cho profile **test**.

---

## 11. Liên hệ với file task demo (thứ tự như dự án thật)

| Thứ tự | Ticket | File canonical (`docs/current-task/`) | File mẫu (`simulator/`) |
|--------|--------|----------------------------------------|-------------------------|
| **1 — Infra** | **SIM-DEMO-1** | `20260414-shelflog-infra.md` | `DEMO-TICKET-20260414-shelflog-infra.md` |
| **2 — Feature (chính)** | **SIM-DEMO-2** | `20260411-shelf-items-api.md` | `DEMO-TICKET-20260411-shelf-items-api.md` |

Làm **SIM-DEMO-1** trước (baseline Maven, profile `dev`/`test`, Actuator, Postgres/H2). **SIM-DEMO-2** triển khai API `/api/v1/shelf-items` và domain. Brief là **bối cảnh rộng**; mỗi task = một MR (hoặc nhánh) gợi ý.
