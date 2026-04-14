# Demo execution log - SIM-DEMO-1 (`20260414-shelflog-infra.md`)

Mục tiêu: đây là file "đọc và làm theo" để hoàn thành task infra theo đúng hệ thống `.operational-resources/`.

Phạm vi: chỉ cho SIM-DEMO-1 (infra baseline), không implement business API `shelf-items` (thuộc SIM-DEMO-2).

---

## 0) Input cần có (bắt buộc)

- Task file canonical: `../docs/current-task/20260414-shelflog-infra.md`
- Luồng E2E: `../task-lifecycle/FROM-TICKET-TO-DONE.md`
- Brief simulator: `DEMO-PROJECT-BRIEF.md` (đọc kỹ sec 2, 6, 8, 9, 11)
- Setup/config docs:
  - `../docs/setup/02-local-development.md`
  - `../docs/setup/03-configuration.md`
- ADR:
  - `../docs/decisions/006-shelflog-demo-postgres-docker.md`
- Compose DB:
  - `docker-compose.postgres.yml`

Log:
- [ ] Đã đọc đủ input
- Time:
- Note:

---

## 1) DoR gate (trước khi code)

Đọc lại sec 0, 2, 3 trong task `20260414-shelflog-infra.md` và xác nhận:

- [ ] Scope rõ: Maven + profiles + Actuator + test
- [ ] Non-goal rõ: không làm `ShelfItem` API
- [ ] AC1..AC6 đã có và có cách verify
- [ ] Không có blocker mở

Evidence:
- [ ] Chép lại AC quan trọng vào ghi chú làm việc
- [ ] Có plan test `./mvnw.cmd -q test`

---

## 2) Tạo "working slice" cho infra

Làm từng cụm nhỏ theo đúng scope:

1) Dependencies (`pom.xml`)
- [ ] `spring-boot-starter-web`
- [ ] `spring-boot-starter-validation`
- [ ] `spring-boot-starter-data-jpa`
- [ ] `spring-boot-starter-actuator`
- [ ] `org.postgresql:postgresql` (runtime)
- [ ] `com.h2database:h2` (test)

2) Config files
- [ ] Tạo/cập nhật `src/main/resources/application.yml`
- [ ] Tạo/cập nhật `src/main/resources/application-dev.yml`
- [ ] Tạo/cập nhật `src/main/resources/application-test.yml`
- [ ] Tạo/cập nhật `src/test/resources/application.properties` (`spring.profiles.active=test`)

3) Health integration test
- [ ] Tạo/cập nhật `src/test/java/com/programming_with_al/al_operational_resources/infra/ActuatorHealthIntegrationTest.java`
- [ ] Assert `/actuator/health` -> `200` + `status=UP`

Log:
- Time:
- Files changed:
- Notes:

---

## 3) Chạy hạ tầng dev (Postgres docker) để verify local profile `dev`

PowerShell tại root repo:

```text
docker compose -f .operational-resources/simulator/docker-compose.postgres.yml up -d
```

Check:
- [ ] Container postgres lên
- [ ] Port host `5433` mở

Optional stop:

```text
docker compose -f .operational-resources/simulator/docker-compose.postgres.yml down
```

Log:
- Command output summary: Chạy lệnh `docker compose ... up -d` nhưng không kết nối được Docker engine.
- Issues: Docker Desktop chưa chạy (pipe `dockerDesktopLinuxEngine` không tồn tại).

---

## 4) Chạy test bắt buộc (AC6)

PowerShell tại root repo:

```text
./mvnw.cmd -q test
```

Bắt buộc pass:
- [ ] `AlOperationalResourcesApplicationTests`
- [ ] `ActuatorHealthIntegrationTest`
- [ ] Exit code = 0

Nếu fail:
- [ ] Ghi lỗi chính
- [ ] Ghi root-cause
- [ ] Ghi cách fix
- [ ] Re-run test pass

Log:
- Run #1: Chưa chạy xong trong phiên này vì lệnh test bị IDE bỏ qua quyền thực thi.
- Run #2 (nếu có): N/A
- Final status: Pending - cần bạn chạy lại thủ công theo lệnh ở trên.

---

## 5) Đối chiếu AC checklist (đồng bộ task file)

Mở `../docs/current-task/20260414-shelflog-infra.md` và đánh dấu:

- [ ] AC1 complete
- [ ] AC2 complete
- [ ] AC3 complete
- [ ] AC4 complete
- [ ] AC5 complete
- [ ] AC6 complete

Cập nhật section:
- [ ] Sec 4 (AC -> test) phù hợp class test hiện tại
- [ ] Sec 12 (Nhật ký tiến độ) ghi đúng những gì đã làm
- [ ] Sec 13 (DoD) tick xong

Log:
- Updated sections:
- Note:

---

## 6) Đồng bộ simulator ticket + dashboard

Cần đồng bộ theo hệ thống:

- [ ] `../simulator/DEMO-TICKET-20260414-shelflog-infra.md` phản ánh đúng task canonical
- [ ] `../docs/current-task/README.md` dashboard status đúng (`Done`)
- [ ] Nếu có đổi contract: cập nhật `../docs/api/10-current-api-changes.md`

Log:
- Files synced:
- Note:

---

## 7) Self-review trước khi chuyển sang SIM-DEMO-2

Checklist nhanh:
- [ ] Không có logic business `ShelfItem` trong task infra
- [ ] Không lộ secret thật
- [ ] Chỉ dùng stack đã được phê duyệt trong task/brief
- [ ] Tài liệu phản ánh đúng implementation
- [ ] SIM-DEMO-2 có thể bắt đầu (infra preconditions đạt)

Kết luận:
- [ ] SIM-DEMO-1 Done
- [ ] Ready for SIM-DEMO-2

---

## 8) Execution log (điền trong quá trình làm)

### Entry template

- Timestamp:
- Step:
- Action:
- Files:
- Evidence:
- Issue/Risk:
- Next:

### Entries

- Timestamp: 2026-04-14
  Step: 3 - Chạy hạ tầng dev (Docker Postgres)
  Action: Thực thi `docker compose -f .operational-resources/simulator/docker-compose.postgres.yml up -d` và `docker compose ... ps`
  Files: Không đổi file
  Evidence: Lỗi kết nối `//./pipe/dockerDesktopLinuxEngine`
  Issue/Risk: Docker Desktop chưa khởi động, nên không verify được profile `dev`
  Next: Mở Docker Desktop, chạy lại step 3

- Timestamp: 2026-04-14
  Step: 4 - Chạy test bắt buộc
  Action: Đã gửi lệnh `./mvnw.cmd -q test`
  Files: Không đổi file
  Evidence: Lệnh bị IDE skip (không có output test)
  Issue/Risk: Chưa có bằng chứng AC6 trong lần chạy này
  Next: Chạy lại thủ công `./mvnw.cmd -q test` và ghi kết quả vào mục Log step 4

---

## 9) Final output expected

Khi xong file này, bạn phải có:

1. Code infra baseline đã đúng scope
2. Test pass với `./mvnw.cmd -q test`
3. Task `20260414-shelflog-infra.md` đã tick AC/DoD
4. Dashboard `docs/current-task/README.md` đúng status
5. Sẵn sàng bắt đầu SIM-DEMO-2

**Last updated:** 2026-04-14

- Timestamp: 2026-04-14 23:40:46
  Step: 0
  Action: Confirm required inputs
  Files: Khong doi file bang script
  Evidence: Confirmed by operator
  Issue/Risk: None
  Next: Proceed DoR gate

- Timestamp: 2026-04-14 23:40:47
  Step: 1
  Action: DoR gate confirmation
  Files: Khong doi file bang script
  Evidence: Checklist confirmed
  Issue/Risk: None
  Next: Validate infra files

- Timestamp: 2026-04-14 23:40:47
  Step: 2
  Action: Validated baseline artifacts/dependencies
  Files: Khong doi file bang script
  Evidence: File existence + dependency markers checked
  Issue/Risk: Check warnings if any missing
  Next: Run Docker step

- Timestamp: 2026-04-14 23:40:47
  Step: 3
  Action: Skipped Docker by flag
  Files: Khong doi file bang script
  Evidence: Operator used -SkipDocker
  Issue/Risk: Dev profile not verified
  Next: Continue to tests

- Timestamp: 2026-04-14 23:40:47
  Step: 4
  Action: Skipped test by flag
  Files: Khong doi file bang script
  Evidence: Operator used -SkipTests
  Issue/Risk: No AC6 evidence
  Next: Run tests manually before closing task

- Timestamp: 2026-04-14 23:40:47
  Step: 5-7
  Action: Manual checklist/self-review required
  Files: Khong doi file bang script
  Evidence: Instructions shown in console
  Issue/Risk: Pending manual updates
  Next: Finish manual sync and close SIM-DEMO-1
