# Task â€” ShelfLog: REST CRUD + phÃ¢n trang cho shelf items

## TL;DR (VI)

- **SIM-DEMO-2** â€” Task **chÃ­nh** (feature): API **ShelfItem** theo brief; lÃ m sau khi **SIM-DEMO-1** (`20260414-shelflog-infra.md`) **Done**.
- CRUD + phÃ¢n trang + lá»c `category`, validation **quantity â‰¤ 999**; **PostgreSQL** (dev) + **H2** (test) Ä‘Ã£ cÃ³ tá»« infra â€” khÃ´ng láº·p baseline `pom`/profile trong ticket nÃ y trá»« khi cáº§n chá»‰nh.
- Luá»“ng: **`task-lifecycle/`**. Báº£n máº«u: `simulator/DEMO-TICKET-20260411-shelf-items-api.md`.

> **Quy Æ°á»›c:** TÃ i liá»‡u ShelfLog chá»‰ **`.operational-resources/docs/`**; Ä‘á»•i AC thÃ¬ Ä‘á»“ng bá»™ `current-task` + báº£n máº«u simulator.

---

## Metadata (báº¯t buá»™c)

| TrÆ°á»ng | GiÃ¡ trá»‹ |
|--------|---------|
| **Loáº¡i task** | `feature` |
| **ID file** | `20260411-shelf-items-api.md` |
| **Ticket / issue** | SIM-DEMO-2 (phá»¥ thuá»™c SIM-DEMO-1) |
| **Tráº¡ng thÃ¡i** | Draft |
| **Æ¯u tiÃªn** | Medium |
| **Owner** | (báº¡n) |

---

## 0. Definition of Ready â€” trÆ°á»›c khi nhá» AI implement (checkbox)

- [x] Ticket/spec cÃ³ **má»¥c tiÃªu** vÃ  **AC** rÃµ (brief + Â§3 dÆ°á»›i Ä‘Ã¢y).
- [x] **Pháº¡m vi** Â§2 Ä‘Ã£ Ä‘iá»n; **ngoÃ i pháº¡m vi** ghi rÃµ.
- [x] **CÃ¢u há»i má»Ÿ** Â§11: khÃ´ng blocker â€” giáº£ Ä‘á»‹nh náº±m trong brief.
- [x] **Skill + doc** Ä‘Ã£ liá»‡t kÃª Â§8.
- [x] Náº¿u lá»‡ch pháº¡m vi: ghi **Â§7**.

---

## 1. TÃ³m táº¯t má»™t dÃ²ng (báº¯t buá»™c)

Cung cáº¥p REST API versioned táº¡i `/api/v1/shelf-items` Ä‘á»ƒ táº¡o, Ä‘á»c, sá»­a, xÃ³a vÃ  liá»‡t kÃª báº£n ghi **ShelfItem** cÃ³ phÃ¢n trang vÃ  lá»c `category`, lÆ°u trÃªn **PostgreSQL** (dev qua Docker theo brief), validation khá»›p brief simulator; test cÃ³ thá»ƒ dÃ¹ng **H2** theo profile test.

---

## 2. Nguá»“n, pháº¡m vi, giáº£ Ä‘á»‹nh (báº¯t buá»™c)

### 2.1 LiÃªn káº¿t chÃ­nh

- **Ticket / mÃ´ táº£:** Demo simulator â€” **`.operational-resources/simulator/DEMO-PROJECT-BRIEF.md`** (**Â§3â€“4** rÃ ng buá»™c ká»¹ thuáº­t + sáº£n pháº©m).
- **Spec:** `.operational-resources/docs/specs/feature-shelflog-items.md`.
- **API / contract:** `docs/api/08-endpoint-list.md`, `docs/api/10-current-api-changes.md` â€” cáº­p nháº­t khi Ä‘á»•i hÃ nh vi.
- **ADR:** `docs/decisions/006-shelflog-demo-postgres-docker.md`.
- **Tiá»n Ä‘á» infra (SIM-DEMO-1):** `docs/current-task/20260414-shelflog-infra.md` â€” pháº£i Done trÆ°á»›c khi coi ticket nÃ y sáºµn sÃ ng implement Ä‘áº§y Ä‘á»§.
- **Ticket máº«u (copy khi reset):** `.operational-resources/simulator/DEMO-TICKET-20260411-shelf-items-api.md`.

### 2.2 Trong pháº¡m vi / ngoÃ i pháº¡m vi

| Trong pháº¡m vi (task nÃ y) | NgoÃ i pháº¡m vi (task khÃ¡c / sau) |
|---------------------------|----------------------------------|
| CRUD + list phÃ¢n trang + lá»c `category` | Auth, Ä‘a ngÆ°á»i dÃ¹ng, xÃ³a má»m |
| DTO + Bean Validation + service + JPA + REST | Testcontainers, Ä‘á»•i pipeline CI |
| Test Ä‘Æ¡n vá»‹ + **IT** (profile **`test`** / H2 Ä‘Ã£ cáº¥u hÃ¬nh á»Ÿ SIM-DEMO-1) | Frontend, publish artifact OpenAPI |
| Endpoint `/api/v1/shelf-items` + entity `ShelfItem` | Baseline **`pom`**, `application-*.yml`, Actuator-only IT (SIM-DEMO-1) |
| Doc API/spec khi Ä‘á»•i contract | Secret tháº­t trong repo |

### 2.3 Giáº£ Ä‘á»‹nh vÃ  phá»¥ thuá»™c

- **Phá»¥ thuá»™c báº¯t buá»™c:** **SIM-DEMO-1** hoÃ n táº¥t (`20260414-shelflog-infra.md`): starters, profile `dev`/`test`, Actuator health IT.
- **Giáº£ Ä‘á»‹nh:** Spring Boot 3.x + Java 17 + Maven; package gá»‘c khá»›p `groupId` trong `pom.xml`.
- **MÃ´i trÆ°á»ng:** Docker + Compose cho cháº¡y app **dev**; `./mvnw test` khÃ´ng cáº§n Docker.
- **KhÃ´ng** thÃªm broker/message queue trá»« khi task khÃ¡c yÃªu cáº§u.

---

## 3. TiÃªu chÃ­ cháº¥p nháº­n (AC)

- [ ] **AC1:** `POST /api/v1/shelf-items` táº¡o tÃ i nguyÃªn; tráº£ **201** + body cÃ³ `id`, timestamp vÃ  cÃ¡c trÆ°á»ng Ä‘Ã£ lÆ°u.
- [ ] **AC2:** `GET /api/v1/shelf-items/{id}` tráº£ **200** khi tá»“n táº¡i, **404** khi khÃ´ng cÃ³.
- [ ] **AC3:** `PUT /api/v1/shelf-items/{id}` thay tháº¿ trÆ°á»ng Ä‘Æ°á»£c phÃ©p; **404** khi khÃ´ng cÃ³; validation nhÆ° lÃºc táº¡o.
- [ ] **AC4:** `DELETE /api/v1/shelf-items/{id}` tráº£ **204** vÃ  xÃ³a báº£n ghi; **404** khi khÃ´ng cÃ³.
- [ ] **AC5:** `GET /api/v1/shelf-items` há»— trá»£ `page`, `size` (tá»‘i Ä‘a 100), lá»c tuá»³ chá»n `category`; JSON phÃ¢n trang **á»•n Ä‘á»‹nh** (Ä‘Ã£ ghi trong doc).
- [ ] **AC6:** `quantity` sai (>999 hoáº·c Ã¢m), `title` rá»—ng, `category` khÃ´ng há»£p lá»‡ â†’ **400** vá»›i payload lá»—i nháº­n diá»‡n Ä‘Æ°á»£c.

### 3.1 HÃ nh vi chi tiáº¿t (khuyáº¿n nghá»‹)

| Ká»‹ch báº£n | Káº¿t quáº£ mong Ä‘á»£i | Ghi chÃº |
|----------|------------------|---------|
| Táº¡o há»£p lá»‡ | 201 + JSON | `id` kiá»ƒu UUID |
| List trang 0 size 20 | 200 + metadata trang | Máº·c Ä‘á»‹nh size 20 náº¿u bá» query |
| Lá»c category=HOBBY | Chá»‰ báº£n ghi khá»›p | Khá»›p enum chÃ­nh xÃ¡c |
| GET id khÃ´ng tá»“n táº¡i | 404 | CÃ¹ng kiá»ƒu body lá»—i vá»›i toÃ n API |
| PUT quantity 1000 | 400 | BR1 |
| DELETE rá»“i GET láº¡i | 404 | Hard delete |

---

## 4. Ãnh xáº¡ AC â†’ test (báº¯t buá»™c trÆ°á»›c khi coi xong)

| AC / má»¥c tiÃªu | MÃ´ táº£ | Test (class#method hoáº·c mÃ´ táº£) | Loáº¡i |
|----------------|-------|--------------------------------|------|
| AC1 | Táº¡o há»£p lá»‡ | `ShelfItemControllerIT#create_returns201` | IT |
| AC2 | GET theo id | `ShelfItemControllerIT#get_found_and_notFound` | IT |
| AC3 | PUT cáº­p nháº­t | `ShelfItemControllerIT#put_updates_fields` | IT |
| AC4 | DELETE | `ShelfItemControllerIT#delete_then_get_404` | IT |
| AC5 | List + lá»c | `ShelfItemControllerIT#list_pagination_and_category` | IT |
| AC6 | Validation | `ShelfItemControllerIT#validation_errors` (+ unit service náº¿u cÃ³) | IT / unit |

*(Äá»•i tÃªn class test theo package thá»±c táº¿; giá»¯ traceability vá»›i AC.)*

---

## 5. Phi chá»©c nÄƒng & rÃ ng buá»™c ká»¹ thuáº­t

- **Hiá»‡u nÄƒng:** Demo â€” endpoint list dÃ¹ng **phÃ¢n trang DB** (khÃ´ng load-all).
- **Báº£o máº­t:** KhÃ´ng auth; ghi â€œchá»‰ local/demoâ€ trong spec/setup.
- **TÆ°Æ¡ng thÃ­ch API:** Giá»¯ path `/api/v1/shelf-items` cho demo.
- **Idempotency:** POST khÃ´ng báº¯t buá»™c idempotent (nhiá»u láº§n táº¡o = nhiá»u báº£n ghi).

---

## 6. Khá»‘i theo loáº¡i task â€” giá»¯ **má»™t** khá»‘i, xÃ³a cÃ¡c khá»‘i khÃ¡c

### A â€” FEATURE

- **TÃ¡c Ä‘á»™ng ngÆ°á»i dÃ¹ng:** Dev cháº¡y API local (sau khi `docker compose up`) vÃ  quáº£n lÃ½ shelf qua HTTP.
- **Luá»“ng implement gá»£i Ã½:** DTO + validation â†’ service (rule) â†’ repository JPA â†’ controller â†’ IT (`@SpringBootTest` + MockMvc/WebTestClient, profile **test** + H2) â†’ cáº­p nháº­t **`docs/api/08-endpoint-list.md`**, **`docs/api/10-current-api-changes.md`**, **`docs/specs/feature-shelflog-items.md`** khi Ä‘á»•i contract.
- **Má»Ÿ rá»™ng sau:** Auth, xÃ³a má»m, luÃ¢n chuyá»ƒn tá»“n â€” task riÃªng.

### B â€” BUGFIX

*(xÃ³a khá»‘i nÃ y khi dÃ¹ng A)*

### C â€” REFACTOR

*(xÃ³a)*

### D â€” SPIKE / CHORE / OPS

*(xÃ³a)*

---

## 7. Revision â€” Ä‘á»•i yÃªu cáº§u khi Ä‘ang lÃ m

| NgÃ y | Thay Ä‘á»•i | Má»©c Ä‘á»™ | HÃ nh Ä‘á»™ng (Ä‘Ã£ sync BA/lead? Ä‘Ã£ cáº­p nháº­t AC/test?) |
|------|----------|--------|-----------------------------------------------------|
| 2026-04-11 | Ticket simulator ban Ä‘áº§u | Nhá» | N/A â€” demo |
| 2026-04-11 | Docker lÃ  yÃªu cáº§u ká»¹ thuáº­t dev; H2 cho test | Nhá» | Äá»“ng bá»™ brief + task |
| 2026-04-14 | ShelfLog: má»™t nguá»“n `docs/`; bá» `simulator/docs/`; brief Â§9 + MAP + task | Trung bÃ¬nh | Äá»“ng bá»™ ticket máº«u |
| 2026-04-14 | TÃ¡ch **SIM-DEMO-1** infra (`20260414-shelflog-infra.md`); ticket nÃ y Ä‘á»•i thÃ nh **SIM-DEMO-2** | Trung bÃ¬nh | Brief Â§11, simulator README |

---

## 8. Context pack cho AI â€” rules, doc, skill (báº¯t buá»™c: Ã­t nháº¥t rules + má»™t skill)

| Loáº¡i | ÄÆ°á»ng dáº«n |
|------|-----------|
| **Brief + compose** | `.operational-resources/simulator/DEMO-PROJECT-BRIEF.md`, `simulator/docker-compose.postgres.yml`, `simulator/README.md` |
| **Infra tiá»n Ä‘á» (SIM-DEMO-1)** | `docs/current-task/20260414-shelflog-infra.md` |
| **Docs (ShelfLog â€” má»™t nguá»“n)** | `docs/project-overview.md`, `docs/specs/feature-shelflog-items.md`, `docs/api/08-endpoint-list.md`, `docs/setup/02-local-development.md`, `docs/decisions/006-shelflog-demo-postgres-docker.md` |
| Rules | `rules/00-personal-priority.md`, `rules/02-coding-standards.md`, `rules/03-api-development.md`, `rules/08-review-checklist.md` |
| Docs (workspace chung) | `docs/architecture/06-backend-layers-and-dependencies.md`, `docs/api/01-README.md`, `docs/setup/01-README.md` |
| Skills | `skills/workflow/implement-feature/README.md`, `skills/backend/create-rest-api/README.md`, `skills/backend/create-service-layer/README.md`, `skills/backend/create-jpa-entity/README.md`, `skills/security/validate-input/README.md`, `skills/testing/write-integration-test/README.md`, `skills/devops/health-check-endpoint/README.md` |

**Prompt gá»£i Ã½ (copy):**  
â€œÄá»c `docs/current-task/20260414-shelflog-infra.md` (Ä‘Ã£ Done) rá»“i `20260411-shelf-items-api.md`, `docs/specs/feature-shelflog-items.md`, `docs/setup/02-local-development.md`, `simulator/DEMO-PROJECT-BRIEF.md`. Chá»‰ implement **API + domain** ShelfItem â€” khÃ´ng láº·p baseline infra SIM-DEMO-1. Cáº­p nháº­t `.operational-resources/docs/` khi Ä‘á»•i contract. KhÃ´ng OAuth; khÃ´ng vÆ°á»£t Â§2.2.â€

---

## 9. Checklist thá»±c thi (tÃ¹y chá»‰nh)

- [ ] RÃ ng buá»™c brief vÃ o entity/DTO (Ä‘á»™ dÃ i title, quantity 0â€“999, enum).
- [ ] Controller dÆ°á»›i `/api/v1/shelf-items`; body lá»—i thá»‘ng nháº¥t.
- [ ] Repository + `Pageable` cho list.
- [ ] Ãt nháº¥t má»™t class IT cho AC1â€“AC6 (profile test).
- [ ] `./mvnw test` xanh.
- [ ] Doc (`.operational-resources/docs/`): `specs/feature-shelflog-items.md`, `api/08-endpoint-list.md`, `api/10-current-api-changes.md`, `setup/02-local-development.md`.

---

## 10. HÆ°á»›ng dáº«n chi tiáº¿t cho AI (báº¯t buá»™c â€” Ã­t nháº¥t ba Ã½)

- **Báº®T BUá»˜C:** **quantity 0â€“999**, **title 1â€“200** táº¡i boundary API; **cháº¡y dev** vá»›i Postgres sau `docker compose` theo brief; ghi rÃµ trong README/setup.
- **NÃŠN:** `page`/`size` máº·c Ä‘á»‹nh há»£p lÃ½, **size tá»‘i Ä‘a 100**; IT dÃ¹ng **random port** hoáº·c `@AutoConfigureMockMvc`.
- **Há»ŽI TRÆ¯á»šC:** **Testcontainers**, báº¥t ká»³ **starter Maven má»›i** (Ä‘Ã£ cÃ³ stack chÃ­nh á»Ÿ SIM-DEMO-1), hoáº·c Ä‘á»•i **global exception** cho cáº£ repo.

---

## 11. CÃ¢u há»i má»Ÿ, rá»§i ro, blocker

- Náº¿u SIM-DEMO-1 chÆ°a Done: cháº·n implement feature cho Ä‘áº¿n khi baseline infra xong.

---

## 12. Nháº­t kÃ½ tiáº¿n Ä‘á»™

- **[2026-04-11]** Táº¡o ticket simulator trong `simulator/` â€” sao chÃ©p vÃ o `.operational-resources/docs/current-task/` trÆ°á»›c khi code.
- **[2026-04-11]** Cáº­p nháº­t: Docker + Postgres lÃ  yÃªu cáº§u ká»¹ thuáº­t dev; H2 cho test.
- **[2026-04-14]** Äá»“ng bá»™ ShelfLog vÃ o `docs/` (spec, API, setup, kiáº¿n trÃºc, ADR-006); task file nÃ y lÃ  báº£n lÃ m viá»‡c trong `current-task/`.
- **[2026-04-14]** Gá»¡ `simulator/docs/` â€” chá»‰ cÃ²n má»™t nguá»“n `.operational-resources/docs/`.
- **[2026-04-14]** SIM-DEMO-1 infra baseline trong code; ticket nÃ y lÃ  SIM-DEMO-2.

---

## 13. Definition of Done (trÆ°á»›c MR)

- [ ] Â§0 DoR thá»a (hoáº·c Ä‘iá»u chá»‰nh cÃ³ chá»§ Ä‘Ã­ch)
- [ ] Code + test khá»›p Â§3â€“4 (vÃ  Â§7 náº¿u sá»­a)
- [ ] `./mvnw test` pass
- [ ] Tá»± review `rules/08-review-checklist.md`
- [ ] MR: mÃ´ táº£ + **CÃ¡ch test** (gá»“m `docker compose ... up`) + ghi chÃº â€œsimulator demo / SIM-DEMO-2â€

---

**Cáº­p nháº­t láº§n cuá»‘i:** 2026-04-14 (SIM-DEMO-2; sau SIM-DEMO-1)

