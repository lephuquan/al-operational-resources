# Bản đồ `.operational-resources/` (Directory map)

Tài liệu này mô tả **cấu trúc thư mục**, **nội dung chính** và **mục đích** từng phần — để bạn và AI định vị nhanh. Chi tiết từng skill nằm trong `skills/README.md`.

**Đường gốc (trong repo):** `.operational-resources/`

---

## Sơ đồ tổng quan

```text
.operational-resources/
├── AGENTS.md                 # Ngữ cảnh & cách làm việc với AI (ưu tiên đọc)
├── PLAYBOOK.md               # Stub → task-lifecycle (link cũ)
├── MAP.md                    # (file này) Bản đồ thư mục
├── WORKFLOW.md               # Stub → task-lifecycle (link cũ)
├── task-lifecycle/           # Luồng một task: ticket → Done (nguồn chính)
│   ├── README.md
│   └── FROM-TICKET-TO-DONE.md
├── guides/                   # Hướng dẫn: triển khai & duy trì docs/skills/rules
│   ├── README.md
│   ├── bootstrap-docs-skills-rules.md
│   └── review-and-update-docs-skills-rules.md
├── README-GIT-LOCAL.md       # Ẩn/hiện thư mục này khỏi Git local
├── rules/                    # Quy tắc cá nhân (Cursor / AI)
├── docs/                     # Tài liệu ngữ cảnh dự án (ưu tiên đọc sau rules)
│   ├── setup/                # Local run & config (01-…05-)
│   ├── api/                  # Contract HTTP (01-…12-)
│   ├── architecture/         # Kiến trúc BE (01-…09-)
│   ├── decisions/          # ADR (README + TEMPLATE + NNN-*.md)
│   └── specs/              # Đặc tả feature (README + TEMPLATE + feature-*.md)
├── skills/                   # Playbook (README + SKILL-TEMPLATE + SKILL + checklist)
└── notes/                    # Ghi chú cá nhân (không thay rules/docs)
```

---

## File ở gốc

| File | Mục đích |
|------|----------|
| **`AGENTS.md`** | “Khung” làm việc với AI: nguyên tắc, thứ tự ưu tiên đọc `rules/` → `docs/`, hành vi cấm. |
| **`PLAYBOOK.md`** | **Stub redirect** tới `task-lifecycle/` — giữ path cũ. |
| **`MAP.md`** | Bản đồ thư mục (file này). |
| **`WORKFLOW.md`** | **Stub redirect** tới `task-lifecycle/` — giữ path cũ. |
| **`README-GIT-LOCAL.md`** | Hướng dẫn dùng `.git/info/exclude` để không track hoặc track thư mục này trên máy bạn. |

---

## `task-lifecycle/` — Một task: ticket → Done

| File | Mục đích |
|------|----------|
| **`task-lifecycle/README.md`** | Điểm vào; trỏ tới guide đầy đủ và `skills/workflow/`. |
| **`task-lifecycle/FROM-TICKET-TO-DONE.md`** | **Nguồn chính:** DoR, từng bước, prompt, evidence, DoD (gộp nội dung cũ của `PLAYBOOK` + `WORKFLOW`). |

---

## `guides/` — Triển khai & duy trì tài nguyên

| File | Mục đích |
|------|----------|
| **`guides/README.md`** | Mục lục: neo tới `task-lifecycle/` + hai guide bootstrap / review. |
| **`guides/bootstrap-docs-skills-rules.md`** | Dự án mới hoặc mở rộng `rules/`, `docs/`, `skills/`. |
| **`guides/review-and-update-docs-skills-rules.md`** | Rà soát định kỳ hoặc khi có thay đổi lớn. |

---

## `rules/` — Quy tắc cá nhân

| Nội dung | Mục đích |
|----------|----------|
| **`00-personal-priority.md`** | Ưu tiên cao nhất; đọc trước; trỏ task tập trung tại `docs/current-task/`. |
| **`01`–`08-*.md`** | Tổng quan dự án, coding standards, API, frontend/backend, security, testing, review checklist. |
| **`README.md`** | Giải thích: **không** đặt file task trong `rules/`; task chỉ ở `docs/current-task/`. |

**Lưu ý:** Không chứa file task `current-task-*.md` — đã loại bỏ để tránh trùng với `docs/current-task/`.

---

## `docs/` — Tài liệu ngữ cảnh dự án

| Thư mục / file | Mục đích |
|----------------|----------|
| **`README.md`** | Thứ tự đọc khuyến nghị cho AI. |
| **`setup/`** | Chạy local, cấu hình, triển khai tóm tắt — file `01-`…`05-` (xem `setup/01-README.md`). Không chứa secret. |
| **`project-overview.md`** | Tổng quan dự án, stack, scope. |
| **`architecture/`** | Kiến trúc BE (file `01-`…`09-`): overview, stack, package, DB, layer, integration, transaction, security code. |
| **`decisions/`** | ADR: `README.md` (index + lifecycle), `TEMPLATE.md`, file `NNN-topic.md`. |
| **`api/`** | Chuẩn API cá nhân (file đánh số `01-`…`12-`): overview, format, auth, versioning, pagination, endpoint list, contract template, changelog, deprecation, OpenAPI link. |
| **`specs/`** | Đặc tả nghiệp vụ theo feature: `README.md` (index + so với task/API), `TEMPLATE.md`, `feature-*.md`. |
| **`knowledge-base/`** | Tri thức: prompt, naming, patterns, error codes, security, troubleshooting. |
| **`current-task/`** | **Nguồn duy nhất** cho task đang làm: `README.md` (dashboard), `TEMPLATE.md` (English + `TL;DR (VI)`), file `YYYYMMDD-*.md`. |

---

## `skills/` — Playbook (cách làm từng việc)

| Thư mục | Mục đích |
|---------|----------|
| **`README.md`** | Mục lục toàn bộ skill theo nhóm (backend, testing, security, …). |
| **`SKILL-TEMPLATE.md`** | Bản copy chuẩn cho `SKILL.md` mới (Goal → Output → References). |
| **`HOW-TO-ADD-TOPIC.md`** | Cách thêm skill/topic mới; code ở `src/`, tài liệu ở đây; trỏ `SKILL-TEMPLATE.md`. |
| **`backend/`** | REST (`create-rest-api` hub), service (`create-service-layer` hub), JPA (`create-jpa-entity` hub), upload (`implement-file-upload` hub), pagination/search (`implement-pagination-search` hub), … |
| **`debugging/`** | Stacktrace (`analyze-stacktrace` hub), local (`debug-backend-error` hub), production (`debug-production-issue` hub). |
| **`architecture/`** | Thiết kế feature, review kiến trúc; **`README.md`** trong nhóm làm hub. |
| **`code-quality/`** | Code review (`review-code` hub); detect smells (`detect-code-smells` hub); safe refactor (`refactor-clean-code` hub). |
| **`testing/`** | Unit test (`write-unit-test` hub), integration test (`write-integration-test` hub), test data (`create-test-data` hub). |
| **`database/`** | Schema design (`design-database-schema` hub), migration (`create-migration` hub), tối ưu query (`optimize-query` hub). |
| **`security/`** | Bảo vệ API (`secure-api-endpoint` hub), validate input (`validate-input` hub), rà soát bảo mật (`security-review` hub). |
| **`integration/`** | HTTP (`call-external-api` hub), webhooks (`implement-webhook-handler` hub), email (`integrate-email-service` hub), payment (`integrate-payment-gateway` hub), queues (`integrate-message-queue` hub). |
| **`performance/`** | API response (`optimize-api-response` hub), cache (`caching-strategy` hub), query (`analyze-query-performance` hub), memory (`reduce-memory-usage` hub). |
| **`observability/`** | Log (`add-logging` hub), metrics (`add-metrics` hub), tracing (`implement-request-tracing` hub), đọc log (`analyze-application-logs` hub). |
| **`error-handling/`** | global handler (`global-exception-handler` hub), envelope (`api-error-response-format` hub), HTTP mapping (`map-exceptions-to-http` hub). |
| **`devops/`** | Docker (`dockerize-service` hub), env/config (`configure-environment` hub), logging (`configure-logging` hub), health/probes (`health-check-endpoint` hub). |
| **`workflow/`** | Hub nhóm: **`README.md`**; triển khai feature (`implement-feature`), bug (`investigate-bug`), MR (`prepare-pull-request`). |

Mỗi skill thường có **`SKILL.md`**; một số có **`checklist.md`** hoặc **`examples.md`**.

---

## `notes/` — Ghi chú cá nhân

| Nội dung | Mục đích |
|----------|----------|
| **`README.md`** | Phân biệt: rules = luật, skills = quy trình, docs = tài liệu, **notes = trí nhớ** (insight, bug, research). |
| **`daily/`** | Nhật ký ngày. |
| **`debugging/`** | Lịch sử bug. |
| **`backend/`**, **`architecture/`**, **`research/`**, **`quick-reference/`** | Ghi chú theo chủ đề. |

**Không** dùng `notes/` thay cho `docs/api` hoặc `rules` cho chuẩn chung.

---

## Thứ tự đọc gợi ý cho AI (tóm tắt)

1. `AGENTS.md` → `rules/00-personal-priority.md`  
1b. Luồng một task (E2E): `task-lifecycle/README.md` hoặc `task-lifecycle/FROM-TICKET-TO-DONE.md`  
2. Các `rules/*.md` liên quan task  
3. `docs/project-overview.md` → `docs/architecture/01-README.md` → `docs/architecture/02-system-overview.md`  
4. `docs/setup/01-README.md` khi cần chạy local, cấu hình, hoặc ngữ cảnh triển khai  
5. `docs/current-task/<file>.md` (task đang làm)  
6. `skills/...` theo bảng trong task file  
7. `docs/specs/README.md`, `docs/api/`, `knowledge-base/` khi cần  

---

## Quan hệ với code thật (`src/`)

- **`.operational-resources/`** chứa **ngữ cảnh & quy trình** — không thay cho mã trong `src/`, `pom.xml`, CI.  
- Triển khai chạy được vẫn nằm ở **repo chính**; đồng bộ mô tả khi đổi contract hoặc kiến trúc.

**Last updated:** 2026-04-11
