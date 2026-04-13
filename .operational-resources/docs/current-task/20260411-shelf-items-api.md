# Task — ShelfLog: REST CRUD + phân trang cho shelf items

## TL;DR (VI)

- **SIM-DEMO-2** — Task **chính** (feature): API **ShelfItem** theo brief; làm sau khi **SIM-DEMO-1** (`20260414-shelflog-infra.md`) **Done**.
- CRUD + phân trang + lọc `category`, validation **quantity ≤ 999**; **PostgreSQL** (dev) + **H2** (test) đã có từ infra — không lặp baseline `pom`/profile trong ticket này trừ khi cần chỉnh.
- Luồng: **`task-lifecycle/`**. Bản mẫu: `simulator/DEMO-TICKET-20260411-shelf-items-api.md`.

> **Quy ước:** Tài liệu ShelfLog chỉ **`.operational-resources/docs/`**; đổi AC thì đồng bộ `current-task` + bản mẫu simulator.

---

## Metadata (bắt buộc)

| Trường | Giá trị |
|--------|---------|
| **Loại task** | `feature` |
| **ID file** | `20260411-shelf-items-api.md` |
| **Ticket / issue** | SIM-DEMO-2 (phụ thuộc SIM-DEMO-1) |
| **Trạng thái** | Draft |
| **Ưu tiên** | Medium |
| **Owner** | (bạn) |

---

## 0. Definition of Ready — trước khi nhờ AI implement (checkbox)

- [x] Ticket/spec có **mục tiêu** và **AC** rõ (brief + §3 dưới đây).
- [x] **Phạm vi** §2 đã điền; **ngoài phạm vi** ghi rõ.
- [x] **Câu hỏi mở** §11: không blocker — giả định nằm trong brief.
- [x] **Skill + doc** đã liệt kê §8.
- [x] Nếu lệch phạm vi: ghi **§7**.

---

## 1. Tóm tắt một dòng (bắt buộc)

Cung cấp REST API versioned tại `/api/v1/shelf-items` để tạo, đọc, sửa, xóa và liệt kê bản ghi **ShelfItem** có phân trang và lọc `category`, lưu trên **PostgreSQL** (dev qua Docker theo brief), validation khớp brief simulator; test có thể dùng **H2** theo profile test.

---

## 2. Nguồn, phạm vi, giả định (bắt buộc)

### 2.1 Liên kết chính

- **Ticket / mô tả:** Demo simulator — **`.operational-resources/simulator/DEMO-PROJECT-BRIEF.md`** (**§3–4** ràng buộc kỹ thuật + sản phẩm).
- **Spec:** `.operational-resources/docs/specs/feature-shelflog-items.md`.
- **API / contract:** `docs/api/08-endpoint-list.md`, `docs/api/10-current-api-changes.md` — cập nhật khi đổi hành vi.
- **ADR:** `docs/decisions/006-shelflog-demo-postgres-docker.md`.
- **Tiền đề infra (SIM-DEMO-1):** `docs/current-task/20260414-shelflog-infra.md` — phải Done trước khi coi ticket này sẵn sàng implement đầy đủ.
- **Ticket mẫu (copy khi reset):** `.operational-resources/simulator/DEMO-TICKET-20260411-shelf-items-api.md`.

### 2.2 Trong phạm vi / ngoài phạm vi

| Trong phạm vi (task này) | Ngoài phạm vi (task khác / sau) |
|---------------------------|----------------------------------|
| CRUD + list phân trang + lọc `category` | Auth, đa người dùng, xóa mềm |
| DTO + Bean Validation + service + JPA + REST | Testcontainers, đổi pipeline CI |
| Test đơn vị + **IT** (profile **`test`** / H2 đã cấu hình ở SIM-DEMO-1) | Frontend, publish artifact OpenAPI |
| Endpoint `/api/v1/shelf-items` + entity `ShelfItem` | Baseline **`pom`**, `application-*.yml`, Actuator-only IT (SIM-DEMO-1) |
| Doc API/spec khi đổi contract | Secret thật trong repo |

### 2.3 Giả định và phụ thuộc

- **Phụ thuộc bắt buộc:** **SIM-DEMO-1** hoàn tất (`20260414-shelflog-infra.md`): starters, profile `dev`/`test`, Actuator health IT.
- **Giả định:** Spring Boot 3.x + Java 17 + Maven; package gốc khớp `groupId` trong `pom.xml`.
- **Môi trường:** Docker + Compose cho chạy app **dev**; `./mvnw test` không cần Docker.
- **Không** thêm broker/message queue trừ khi task khác yêu cầu.

---

## 3. Tiêu chí chấp nhận (AC)

- [ ] **AC1:** `POST /api/v1/shelf-items` tạo tài nguyên; trả **201** + body có `id`, timestamp và các trường đã lưu.
- [ ] **AC2:** `GET /api/v1/shelf-items/{id}` trả **200** khi tồn tại, **404** khi không có.
- [ ] **AC3:** `PUT /api/v1/shelf-items/{id}` thay thế trường được phép; **404** khi không có; validation như lúc tạo.
- [ ] **AC4:** `DELETE /api/v1/shelf-items/{id}` trả **204** và xóa bản ghi; **404** khi không có.
- [ ] **AC5:** `GET /api/v1/shelf-items` hỗ trợ `page`, `size` (tối đa 100), lọc tuỳ chọn `category`; JSON phân trang **ổn định** (đã ghi trong doc).
- [ ] **AC6:** `quantity` sai (>999 hoặc âm), `title` rỗng, `category` không hợp lệ → **400** với payload lỗi nhận diện được.

### 3.1 Hành vi chi tiết (khuyến nghị)

| Kịch bản | Kết quả mong đợi | Ghi chú |
|----------|------------------|---------|
| Tạo hợp lệ | 201 + JSON | `id` kiểu UUID |
| List trang 0 size 20 | 200 + metadata trang | Mặc định size 20 nếu bỏ query |
| Lọc category=HOBBY | Chỉ bản ghi khớp | Khớp enum chính xác |
| GET id không tồn tại | 404 | Cùng kiểu body lỗi với toàn API |
| PUT quantity 1000 | 400 | BR1 |
| DELETE rồi GET lại | 404 | Hard delete |

---

## 4. Ánh xạ AC → test (bắt buộc trước khi coi xong)

| AC / mục tiêu | Mô tả | Test (class#method hoặc mô tả) | Loại |
|----------------|-------|--------------------------------|------|
| AC1 | Tạo hợp lệ | `ShelfItemControllerIT#create_returns201` | IT |
| AC2 | GET theo id | `ShelfItemControllerIT#get_found_and_notFound` | IT |
| AC3 | PUT cập nhật | `ShelfItemControllerIT#put_updates_fields` | IT |
| AC4 | DELETE | `ShelfItemControllerIT#delete_then_get_404` | IT |
| AC5 | List + lọc | `ShelfItemControllerIT#list_pagination_and_category` | IT |
| AC6 | Validation | `ShelfItemControllerIT#validation_errors` (+ unit service nếu có) | IT / unit |

*(Đổi tên class test theo package thực tế; giữ traceability với AC.)*

---

## 5. Phi chức năng & ràng buộc kỹ thuật

- **Hiệu năng:** Demo — endpoint list dùng **phân trang DB** (không load-all).
- **Bảo mật:** Không auth; ghi “chỉ local/demo” trong spec/setup.
- **Tương thích API:** Giữ path `/api/v1/shelf-items` cho demo.
- **Idempotency:** POST không bắt buộc idempotent (nhiều lần tạo = nhiều bản ghi).

---

## 6. Khối theo loại task — giữ **một** khối, xóa các khối khác

### A — FEATURE

- **Tác động người dùng:** Dev chạy API local (sau khi `docker compose up`) và quản lý shelf qua HTTP.
- **Luồng implement gợi ý:** DTO + validation → service (rule) → repository JPA → controller → IT (`@SpringBootTest` + MockMvc/WebTestClient, profile **test** + H2) → cập nhật **`docs/api/08-endpoint-list.md`**, **`docs/api/10-current-api-changes.md`**, **`docs/specs/feature-shelflog-items.md`** khi đổi contract.
- **Mở rộng sau:** Auth, xóa mềm, luân chuyển tồn — task riêng.

### B — BUGFIX

*(xóa khối này khi dùng A)*

### C — REFACTOR

*(xóa)*

### D — SPIKE / CHORE / OPS

*(xóa)*

---

## 7. Revision — đổi yêu cầu khi đang làm

| Ngày | Thay đổi | Mức độ | Hành động (đã sync BA/lead? đã cập nhật AC/test?) |
|------|----------|--------|-----------------------------------------------------|
| 2026-04-11 | Ticket simulator ban đầu | Nhỏ | N/A — demo |
| 2026-04-11 | Docker là yêu cầu kỹ thuật dev; H2 cho test | Nhỏ | Đồng bộ brief + task |
| 2026-04-14 | ShelfLog: một nguồn `docs/`; bỏ `simulator/docs/`; brief §9 + MAP + task | Trung bình | Đồng bộ ticket mẫu |
| 2026-04-14 | Tách **SIM-DEMO-1** infra (`20260414-shelflog-infra.md`); ticket này đổi thành **SIM-DEMO-2** | Trung bình | Brief §11, simulator README |

---

## 8. Context pack cho AI — rules, doc, skill (bắt buộc: ít nhất rules + một skill)

| Loại | Đường dẫn |
|------|-----------|
| **Brief + compose** | `.operational-resources/simulator/DEMO-PROJECT-BRIEF.md`, `simulator/docker-compose.postgres.yml`, `simulator/README.md` |
| **Infra tiền đề (SIM-DEMO-1)** | `docs/current-task/20260414-shelflog-infra.md` |
| **Docs (ShelfLog — một nguồn)** | `docs/project-overview.md`, `docs/specs/feature-shelflog-items.md`, `docs/api/08-endpoint-list.md`, `docs/setup/02-local-development.md`, `docs/decisions/006-shelflog-demo-postgres-docker.md` |
| Rules | `rules/00-personal-priority.md`, `rules/02-coding-standards.md`, `rules/03-api-development.md`, `rules/08-review-checklist.md` |
| Docs (workspace chung) | `docs/architecture/06-backend-layers-and-dependencies.md`, `docs/api/01-README.md`, `docs/setup/01-README.md` |
| Skills | `skills/workflow/implement-feature/README.md`, `skills/backend/create-rest-api/README.md`, `skills/backend/create-service-layer/README.md`, `skills/backend/create-jpa-entity/README.md`, `skills/security/validate-input/README.md`, `skills/testing/write-integration-test/README.md`, `skills/devops/health-check-endpoint/README.md` |

**Prompt gợi ý (copy):**  
“Đọc `docs/current-task/20260414-shelflog-infra.md` (đã Done) rồi `20260411-shelf-items-api.md`, `docs/specs/feature-shelflog-items.md`, `docs/setup/02-local-development.md`, `simulator/DEMO-PROJECT-BRIEF.md`. Chỉ implement **API + domain** ShelfItem — không lặp baseline infra SIM-DEMO-1. Cập nhật `.operational-resources/docs/` khi đổi contract. Không OAuth; không vượt §2.2.”

---

## 9. Checklist thực thi (tùy chỉnh)

- [ ] Ràng buộc brief vào entity/DTO (độ dài title, quantity 0–999, enum).
- [ ] Controller dưới `/api/v1/shelf-items`; body lỗi thống nhất.
- [ ] Repository + `Pageable` cho list.
- [ ] Ít nhất một class IT cho AC1–AC6 (profile test).
- [ ] `./mvnw test` xanh.
- [ ] Doc (`.operational-resources/docs/`): `specs/feature-shelflog-items.md`, `api/08-endpoint-list.md`, `api/10-current-api-changes.md`, `setup/02-local-development.md`.

---

## 10. Hướng dẫn chi tiết cho AI (bắt buộc — ít nhất ba ý)

- **BẮT BUỘC:** **quantity 0–999**, **title 1–200** tại boundary API; **chạy dev** với Postgres sau `docker compose` theo brief; ghi rõ trong README/setup.
- **NÊN:** `page`/`size` mặc định hợp lý, **size tối đa 100**; IT dùng **random port** hoặc `@AutoConfigureMockMvc`.
- **HỎI TRƯỚC:** **Testcontainers**, bất kỳ **starter Maven mới** (đã có stack chính ở SIM-DEMO-1), hoặc đổi **global exception** cho cả repo.

---

## 11. Câu hỏi mở, rủi ro, blocker

- Nếu SIM-DEMO-1 chưa Done: chặn implement feature cho đến khi baseline infra xong.

---

## 12. Nhật ký tiến độ

- **[2026-04-11]** Tạo ticket simulator trong `simulator/` — sao chép vào `.operational-resources/docs/current-task/` trước khi code.
- **[2026-04-11]** Cập nhật: Docker + Postgres là yêu cầu kỹ thuật dev; H2 cho test.
- **[2026-04-14]** Đồng bộ ShelfLog vào `docs/` (spec, API, setup, kiến trúc, ADR-006); task file này là bản làm việc trong `current-task/`.
- **[2026-04-14]** Gỡ `simulator/docs/` — chỉ còn một nguồn `.operational-resources/docs/`.
- **[2026-04-14]** SIM-DEMO-1 infra baseline trong code; ticket này là SIM-DEMO-2.

---

## 13. Definition of Done (trước MR)

- [ ] §0 DoR thỏa (hoặc điều chỉnh có chủ đích)
- [ ] Code + test khớp §3–4 (và §7 nếu sửa)
- [ ] `./mvnw test` pass
- [ ] Tự review `rules/08-review-checklist.md`
- [ ] MR: mô tả + **Cách test** (gồm `docker compose ... up`) + ghi chú “simulator demo / SIM-DEMO-2”

---

**Cập nhật lần cuối:** 2026-04-14 (SIM-DEMO-2; sau SIM-DEMO-1)
