# Task â€” ShelfLog simulator: infrastructure baseline (Maven, profiles, DB, Actuator)

## TL;DR (VI)

- **SIM-DEMO-1** â€” Chuáº©n bá»‹ **háº¡ táº§ng tháº­t** cho demo ShelfLog: dependencies Spring Web / Validation / JPA / Actuator, Postgres (`dev`) + H2 (`test`), cáº¥u hÃ¬nh YAML, IT kiá»ƒm tra `/actuator/health`.
- **Pháº£i xong trÆ°á»›c** ticket **SIM-DEMO-2** (`20260411-shelf-items-api.md` â€” API shelf items).
- TÃ i liá»‡u: chá»‰ **`.operational-resources/docs/`**; ticket máº«u: `simulator/DEMO-TICKET-20260414-shelflog-infra.md`.

---

## Metadata (báº¯t buá»™c)

| TrÆ°á»ng | GiÃ¡ trá»‹ |
|--------|---------|
| **Loáº¡i task** | `ops` |
| **ID file** | `20260414-shelflog-infra.md` |
| **Ticket / issue** | SIM-DEMO-1 |
| **Tráº¡ng thÃ¡i** | Done |
| **Æ¯u tiÃªn** | High |
| **Owner** | (báº¡n) |

---

## 0. Definition of Ready

- [x] Má»¥c tiÃªu ká»¹ thuáº­t vÃ  AC Â§3 rÃµ.
- [x] Pháº¡m vi Â§2; ticket feature phá»¥ thuá»™c Ä‘Æ°á»£c ghi trong `20260411-shelf-items-api.md`.

---

## 1. TÃ³m táº¯t má»™t dÃ²ng (báº¯t buá»™c)

Thiáº¿t láº­p baseline Spring Boot cho ShelfLog: starters cáº§n cho REST + JPA + validation + Actuator, profile **`dev`** (PostgreSQL qua Docker) vÃ  **`test`** (H2), Ä‘á»ƒ ticket SIM-DEMO-2 chá»‰ táº­p trung domain/API.

---

## 2. Nguá»“n, pháº¡m vi, giáº£ Ä‘á»‹nh (báº¯t buá»™c)

### 2.1 LiÃªn káº¿t chÃ­nh

- **Brief:** `.operational-resources/simulator/DEMO-PROJECT-BRIEF.md` Â§2, Â§6, Â§8.
- **ADR:** `docs/decisions/006-shelflog-demo-postgres-docker.md`.
- **Setup / config:** `docs/setup/02-local-development.md`, `docs/setup/03-configuration.md`.
- **Ticket tiáº¿p theo:** `docs/current-task/20260411-shelf-items-api.md` (SIM-DEMO-2).

### 2.2 Trong pháº¡m vi / ngoÃ i pháº¡m vi

| Trong pháº¡m vi | NgoÃ i pháº¡m vi |
|---------------|----------------|
| `pom.xml`: web, validation, data-jpa, actuator, postgresql (runtime), h2 (test) | Flyway/Liquibase, Testcontainers |
| `application.yml`, `application-dev.yml`, `application-test.yml` | Secret tháº­t ngoÃ i compose demo |
| `src/test/resources` kÃ­ch hoáº¡t profile `test` | Endpoint nghiá»‡p vá»¥ `/api/v1/...` |
| IT: `GET /actuator/health` â†’ 200, `status=UP` | Entity `ShelfItem`, repository, controller |

### 2.3 Giáº£ Ä‘á»‹nh vÃ  phá»¥ thuá»™c

- Cháº¡y app local: `docker compose -f .operational-resources/simulator/docker-compose.postgres.yml up -d` rá»“i `mvn spring-boot:run` vá»›i profile **`dev`**.
- `./mvnw test` **khÃ´ng** cáº§n Docker (H2).

---

## 3. TiÃªu chÃ­ cháº¥p nháº­n (AC)

- [x] **AC1:** `pom.xml` cÃ³ `spring-boot-starter-web`, `validation`, `data-jpa`, `actuator`, `postgresql` (runtime), `h2` (test).
- [x] **AC2:** Profile **`dev`**: JDBC tá»›i `localhost:5433/shelflog`, user/password khá»›p compose demo; `ddl-auto: update` (chá»‰ demo).
- [x] **AC3:** Profile **`test`**: H2 in-memory; `ddl-auto: create-drop`; tests máº·c Ä‘á»‹nh dÃ¹ng profile `test`.
- [x] **AC4:** Actuator expose **`/actuator/health`** (JSON); khÃ´ng báº­t toÃ n bá»™ endpoint actuator.
- [x] **AC5:** Ãt nháº¥t má»™t **IT** xÃ¡c nháº­n health **UP** vá»›i profile `test`.
- [x] **AC6:** `./mvnw test` pass trÃªn mÃ¡y sáº¡ch (khÃ´ng Postgres) nhá» H2.

### 3.1 HÃ nh vi chi tiáº¿t

| Ká»‹ch báº£n | Káº¿t quáº£ |
|----------|---------|
| `mvnw test` | Pass; context + JPA + H2 khá»Ÿi Ä‘á»™ng |
| `spring-boot:run` + `dev` + Postgres up | App start |
| `spring-boot:run` khÃ´ng profile | Fail thiáº¿u datasource (cháº¥p nháº­n â€” dÃ¹ng `dev`) |

---

## 4. Ãnh xáº¡ AC â†’ test

| AC | Test | Loáº¡i |
|----|------|------|
| AC5â€“AC6 | `ActuatorHealthIntegrationTest#health_returnsUp` | IT |
| AC3 | `AlOperationalResourcesApplicationTests#contextLoads` (profile test) | IT |

---

## 5. Phi chá»©c nÄƒng

- Credential trong `application-dev.yml` chá»‰ cho **demo local** (khá»›p compose); khÃ´ng dÃ¹ng production.

---

## 6. Khá»‘i theo loáº¡i task â€” D â€” OPS

- **Output:** Repo cháº¡y Ä‘Æ°á»£c vá»›i stack ShelfLog tá»‘i thiá»ƒu; ticket feature cÃ³ thá»ƒ báº¯t Ä‘áº§u ngay.
- **AC â†’ Test:** Ä‘Ã£ gÃ¡n á»Ÿ Â§4.

### A â€” FEATURE

*(Ä‘Ã£ xÃ³a)*

### B â€” BUGFIX

*(Ä‘Ã£ xÃ³a)*

### C â€” REFACTOR

*(Ä‘Ã£ xÃ³a)*

---

## 7. Revision

| NgÃ y | Thay Ä‘á»•i | Má»©c Ä‘á»™ | HÃ nh Ä‘á»™ng |
|------|----------|--------|-----------|
| 2026-04-14 | Táº¡o SIM-DEMO-1 â€” tÃ¡ch infra khá»i SIM-DEMO-2 | Trung bÃ¬nh | Cáº­p nháº­t brief Â§11, simulator README, ticket API |

---

## 8. Context pack cho AI

| Loáº¡i | ÄÆ°á»ng dáº«n |
|------|-----------|
| Brief + compose | `simulator/DEMO-PROJECT-BRIEF.md`, `simulator/docker-compose.postgres.yml` |
| Docs | `docs/setup/02-local-development.md`, `docs/setup/03-configuration.md`, `docs/decisions/006-shelflog-demo-postgres-docker.md` |
| Rules | `rules/02-coding-standards.md`, `rules/08-review-checklist.md` |
| Skills | `skills/devops/dockerize-service/README.md`, `skills/devops/configure-environment/README.md`, `skills/devops/health-check-endpoint/README.md` |

**Prompt gá»£i Ã½:**  
â€œÄá»c task `20260414-shelflog-infra.md` vÃ  brief Â§2/Â§6. Chá»‰ baseline infra â€” khÃ´ng thÃªm REST shelf-items (thuá»™c SIM-DEMO-2).â€

---

## 9. Checklist thá»±c thi

- [x] Dependencies vÃ  YAML nhÆ° AC.
- [x] IT actuator.
- [x] `./mvnw test` xanh.
- [x] Äá»“ng bá»™ ticket máº«u trong `simulator/`.

---

## 10. HÆ°á»›ng dáº«n cho AI

- **Báº®T BUá»˜C:** KhÃ´ng thÃªm entity/controller shelf trong ticket nÃ y.
- **NÃŠN:** Ghi chÃº rÃµ lá»‡nh cháº¡y dev trong MR / `docs/setup/02`.
- **Há»ŽI TRÆ¯á»šC:** Testcontainers, Flyway, Ä‘á»•i cá»•ng compose.

---

## 11. CÃ¢u há»i má»Ÿ

- KhÃ´ng.

---

## 12. Nháº­t kÃ½ tiáº¿n Ä‘á»™

- **[2026-04-14]** Triá»ƒn khai baseline: `pom.xml`, `application*.yml`, `ActuatorHealthIntegrationTest`, `src/test/resources/application.properties` (`spring.profiles.active=test`).

---

## 13. Definition of Done

- [x] Â§3 AC Ä‘áº¡t
- [x] `./mvnw test` pass
- [x] Ticket SIM-DEMO-2 cÃ³ thá»ƒ báº¯t Ä‘áº§u (infra á»•n Ä‘á»‹nh)

---

**Cáº­p nháº­t láº§n cuá»‘i:** 2026-04-14

