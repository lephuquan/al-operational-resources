# Task — ShelfLog simulator: infrastructure baseline (Maven, profiles, DB, Actuator)

## TL;DR (VI)

- **Bản mẫu SIM-DEMO-1:** canonical trong **`docs/current-task/20260414-shelflog-infra.md`**; sao chép file này nếu reset ticket infra.
- Chuẩn bị **hạ tầng thật** cho ShelfLog: Web / Validation / JPA / Actuator, Postgres (`dev`) + H2 (`test`), IT `/actuator/health`.
- **Phải xong trước** **SIM-DEMO-2** (shelf items API). Tài liệu chỉ **`.operational-resources/docs/`**.

---

## Metadata (bắt buộc)

| Trường | Giá trị |
|--------|---------|
| **Loại task** | `ops` |
| **ID file** | `20260414-shelflog-infra.md` |
| **Ticket / issue** | SIM-DEMO-1 |
| **Trạng thái** | Done |
| **Ưu tiên** | High |
| **Owner** | (bạn) |

---

## 0. Definition of Ready

- [x] Mục tiêu kỹ thuật và AC §3 rõ.
- [x] Phạm vi §2; ticket feature phụ thuộc được ghi trong `20260411-shelf-items-api.md`.

---

## 1. Tóm tắt một dòng (bắt buộc)

Thiết lập baseline Spring Boot cho ShelfLog: starters cần cho REST + JPA + validation + Actuator, profile **`dev`** (PostgreSQL qua Docker) và **`test`** (H2), để ticket SIM-DEMO-2 chỉ tập trung domain/API.

---

## 2. Nguồn, phạm vi, giả định (bắt buộc)

### 2.1 Liên kết chính

- **Brief:** `.operational-resources/simulator/DEMO-PROJECT-BRIEF.md` §2, §6, §8.
- **ADR:** `docs/decisions/006-shelflog-demo-postgres-docker.md`.
- **Setup / config:** `docs/setup/02-local-development.md`, `docs/setup/03-configuration.md`.
- **Ticket tiếp theo:** `docs/current-task/20260411-shelf-items-api.md` (SIM-DEMO-2).

### 2.2 Trong phạm vi / ngoài phạm vi

| Trong phạm vi | Ngoài phạm vi |
|---------------|----------------|
| `pom.xml`: web, validation, data-jpa, actuator, postgresql (runtime), h2 (test) | Flyway/Liquibase, Testcontainers |
| `application.yml`, `application-dev.yml`, `application-test.yml` | Secret thật ngoài compose demo |
| `src/test/resources` kích hoạt profile `test` | Endpoint nghiệp vụ `/api/v1/...` |
| IT: `GET /actuator/health` → 200, `status=UP` | Entity `ShelfItem`, repository, controller |

### 2.3 Giả định và phụ thuộc

- Chạy app local: `docker compose -f .operational-resources/simulator/docker-compose.postgres.yml up -d` rồi `mvn spring-boot:run` với profile **`dev`**.
- `./mvnw test` **không** cần Docker (H2).

---

## 3. Tiêu chí chấp nhận (AC)

- [x] **AC1:** `pom.xml` có `spring-boot-starter-web`, `validation`, `data-jpa`, `actuator`, `postgresql` (runtime), `h2` (test).
- [x] **AC2:** Profile **`dev`**: JDBC tới `localhost:5433/shelflog`, user/password khớp compose demo; `ddl-auto: update` (chỉ demo).
- [x] **AC3:** Profile **`test`**: H2 in-memory; `ddl-auto: create-drop`; tests mặc định dùng profile `test`.
- [x] **AC4:** Actuator expose **`/actuator/health`** (JSON); không bật toàn bộ endpoint actuator.
- [x] **AC5:** Ít nhất một **IT** xác nhận health **UP** với profile `test`.
- [x] **AC6:** `./mvnw test` pass trên máy sạch (không Postgres) nhờ H2.

### 3.1 Hành vi chi tiết

| Kịch bản | Kết quả |
|----------|---------|
| `mvnw test` | Pass; context + JPA + H2 khởi động |
| `spring-boot:run` + `dev` + Postgres up | App start |
| `spring-boot:run` không profile | Fail thiếu datasource (chấp nhận — dùng `dev`) |

---

## 4. Ánh xạ AC → test

| AC | Test | Loại |
|----|------|------|
| AC5–AC6 | `ActuatorHealthIntegrationTest#health_returnsUp` | IT |
| AC3 | `AlOperationalResourcesApplicationTests#contextLoads` (profile test) | IT |

---

## 5. Phi chức năng

- Credential trong `application-dev.yml` chỉ cho **demo local** (khớp compose); không dùng production.

---

## 6. Khối theo loại task — D — OPS

- **Output:** Repo chạy được với stack ShelfLog tối thiểu; ticket feature có thể bắt đầu ngay.
- **AC → Test:** đã gán ở §4.

### A — FEATURE

*(đã xóa)*

### B — BUGFIX

*(đã xóa)*

### C — REFACTOR

*(đã xóa)*

---

## 7. Revision

| Ngày | Thay đổi | Mức độ | Hành động |
|------|----------|--------|-----------|
| 2026-04-14 | Tạo SIM-DEMO-1 — tách infra khỏi SIM-DEMO-2 | Trung bình | Cập nhật brief §11, simulator README, ticket API |

---

## 8. Context pack cho AI

| Loại | Đường dẫn |
|------|-----------|
| Brief + compose | `simulator/DEMO-PROJECT-BRIEF.md`, `simulator/docker-compose.postgres.yml` |
| Docs | `docs/setup/02-local-development.md`, `docs/setup/03-configuration.md`, `docs/decisions/006-shelflog-demo-postgres-docker.md` |
| Rules | `rules/02-coding-standards.md`, `rules/08-review-checklist.md` |
| Skills | `skills/devops/dockerize-service/README.md`, `skills/devops/configure-environment/README.md`, `skills/devops/health-check-endpoint/README.md` |

**Prompt gợi ý:**  
“Đọc task `20260414-shelflog-infra.md` và brief §2/§6. Chỉ baseline infra — không thêm REST shelf-items (thuộc SIM-DEMO-2).”

---

## 9. Checklist thực thi

- [x] Dependencies và YAML như AC.
- [x] IT actuator.
- [x] `./mvnw test` xanh.
- [x] Đồng bộ ticket mẫu trong `simulator/`.

---

## 10. Hướng dẫn cho AI

- **BẮT BUỘC:** Không thêm entity/controller shelf trong ticket này.
- **NÊN:** Ghi chú rõ lệnh chạy dev trong MR / `docs/setup/02`.
- **HỎI TRƯỚC:** Testcontainers, Flyway, đổi cổng compose.

---

## 11. Câu hỏi mở

- Không.

---

## 12. Nhật ký tiến độ

- **[2026-04-14]** Triển khai baseline: `pom.xml`, `application*.yml`, `ActuatorHealthIntegrationTest`, `src/test/resources/application.properties` (`spring.profiles.active=test`).

---

## 13. Definition of Done

- [x] §3 AC đạt
- [x] `./mvnw test` pass
- [x] Ticket SIM-DEMO-2 có thể bắt đầu (infra ổn định)

---

**Cập nhật lần cuối:** 2026-04-14
