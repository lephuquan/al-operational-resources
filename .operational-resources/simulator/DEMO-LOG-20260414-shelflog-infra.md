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
- Command output summary:
- Issues:

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
- Run #1:
- Run #2 (nếu có):
- Final status:

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

- (điền tại đây theo từng bước)

---

## 9) Final output expected

Khi xong file này, bạn phải có:

1. Code infra baseline đã đúng scope
2. Test pass với `./mvnw.cmd -q test`
3. Task `20260414-shelflog-infra.md` đã tick AC/DoD
4. Dashboard `docs/current-task/README.md` đúng status
5. Sẵn sàng bắt đầu SIM-DEMO-2

**Last updated:** 2026-04-14
