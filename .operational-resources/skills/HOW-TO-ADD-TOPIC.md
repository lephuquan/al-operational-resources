# Triển khai một chủ đề mới (topic) — ở đâu, như thế nào?

Một **chủ đề** (Redis, Kafka, OpenAPI, CI, OAuth2, …) thường cần **hai phần**: (1) triển khai thật trong repo và (2) ghi lại trong `.operational-resources/` để AI và bạn thống nhất cách làm.

## 1. Phần bắt buộc trong codebase (không nằm trong `.operational-resources/`)

| Loại | Vị trí điển hình | Ghi chú |
|------|------------------|---------|
| Dependency | `pom.xml` | Starter Redis, Kafka, Springdoc, … |
| Cấu hình | `src/main/resources/application*.yml` | Profile `dev`/`prod`; **secret** qua biến môi trường |
| Code Java | `src/main/java/...` | `@Configuration`, listener, client, security, … |
| Migration DB | `src/main/resources/db/migration/` (Flyway) hoặc Liquibase | Nếu chủ đề liên quan schema |
| Docker / local stack | `docker-compose.yml` (nếu team dùng) | Postgres, Redis, Kafka local |
| Pipeline CI | `.github/workflows/` hoặc GitLab CI | Build, test, deploy |

**Nguyên tắc:** phần “chạy được” luôn ở **tree chính của dự án** (`src/`, `pom.xml`, …). `.operational-resources/` **không** thay thế file cấu hình thật.

## 2. Phần nên có trong `.operational-resources/` (tài liệu + skill)

| Mục đích | Nơi đặt | Nội dung gợi ý |
|----------|---------|----------------|
| Quyết định kỹ thuật (tại sao chọn A không chọn B) | `docs/decisions/TEMPLATE.md` → `NNN-topic.md` | ADR ngắn; cập nhật `decisions/README.md` |
| Đặc tả tính năng (business / AC) | `docs/specs/TEMPLATE.md` → `feature-<slug>.md` | Cập nhật bảng index trong `docs/specs/README.md` |
| Playbook từng bước cho AI / lặp lại sau này | `skills/<nhóm>/<topic-slug>/SKILL.md` | Goal → Preconditions → Steps → References |
| Checklist / ví dụ dài | `checklist.md`, `examples.md` cùng thư mục skill | Tùy độ dài |
| Mã lỗi, contract API | `docs/knowledge-base/error-codes.md`, `docs/api/*` | Khi chủ đề đổi API hoặc lỗi |
| Ghi chú vận hành cá nhân | `notes/` | Khắc phục sự cố, insight |

## 3. Quy trình đề xuất (thứ tự)

1. **Xác định phạm vi** — chủ đề giải quyết vấn đề gì; có ảnh hưởng security/contract không.
2. **ADR (nếu đáng kể)** — copy `docs/decisions/TEMPLATE.md`, đặt số `NNN-`, cập nhật index trong `docs/decisions/README.md`.
3. **Triển khai code + config** trong `src/` và `pom.xml` (và CI nếu cần).
4. **Thêm hoặc cập nhật skill** — `skills/<category>/<name>/SKILL.md` (xem mục 4).
5. **Đồng bộ docs** — `docs/api/`, `error-codes.md`, `docs/architecture/03-tech-stack.md` nếu đổi hành vi công khai.
6. **Cập nhật** `skills/README.md` (mục lục) nếu thêm skill mới.

## 4. Cách tạo một skill mới (cấu trúc thư mục)

Tạo thư mục:

```text
.operational-resources/skills/<nhóm>/<tên-chủ-đề>/
├── SKILL.md          # bắt buộc
├── checklist.md      # tùy chọn
└── examples.md       # tùy chọn (snippet, lệnh, cấu hình mẫu không chứa secret)
```

**`<nhóm>`** ví dụ: `backend`, `integration`, `devops`, `security` — trùng với các nhóm hiện có để dễ tìm.

**`SKILL.md` nên có các mục:**

- **Goal** — kết quả mong đợi
- **Preconditions** — đã có gì (Java 17, Spring Boot 3, …)
- **Steps** — đánh số, hành động cụ thể
- **Output** — artifact (file/class/config) cần tồn tại
- **References** — link tới `docs/`, ADR, tài liệu Spring

Sau đó thêm một dòng vào bảng trong `skills/README.md` (mục lục).

## 5. Tránh nhầm lẫn

- **Không** copy nguyên `application.yml` production có secret vào `.operational-resources/`.
- **Không** nhân đôi: cùng một nội dung dài ở cả `docs/` và `rules/` — một nơi là “chuẩn”, nơi kia chỉ **trỏ link**.
- **Team:** thay đổi hành vi API hoặc chuẩn chung cần **đồng bộ** với `docs/` chính thức của team khi merge.

## Tóm tắt một câu

**Code & config** → `src/` (+ `pom.xml`, CI, Docker nếu có).  
**Cách làm + quyết định + playbook AI** → `.operational-resources/docs/` + `skills/` (+ `decisions/`, `notes/` khi cần).
