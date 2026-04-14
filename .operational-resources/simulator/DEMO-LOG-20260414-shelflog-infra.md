# Demo execution log - SIM-DEMO-1 (`20260414-shelflog-infra.md`)

Muc tieu: day la file "doc va lam theo" de hoan thanh task infra theo dung he thong `.operational-resources/`.

Phan vi: chi cho SIM-DEMO-1 (infra baseline), khong implement business API `shelf-items` (thuoc SIM-DEMO-2).

---

## 0) Input can co (bat buoc)

- Task file canonical: `../docs/current-task/20260414-shelflog-infra.md`
- Luong E2E: `../task-lifecycle/FROM-TICKET-TO-DONE.md`
- Brief simulator: `DEMO-PROJECT-BRIEF.md` (doc ky sec 2, 6, 8, 9, 11)
- Setup/config docs:
  - `../docs/setup/02-local-development.md`
  - `../docs/setup/03-configuration.md`
- ADR:
  - `../docs/decisions/006-shelflog-demo-postgres-docker.md`
- Compose DB:
  - `docker-compose.postgres.yml`

Log:
- [ ] Da doc du input
- Time:
- Note:

---

## 1) DoR gate (truoc khi code)

Doc lai sec 0, 2, 3 trong task `20260414-shelflog-infra.md` va xac nhan:

- [ ] Scope ro: Maven + profiles + Actuator + test
- [ ] Non-goal ro: khong lam `ShelfItem` API
- [ ] AC1..AC6 da co va co cach verify
- [ ] Khong co blocker mo

Evidence:
- [ ] Chap lai AC quan trong vao ghi chu lam viec
- [ ] Co plan test `./mvnw.cmd -q test`

---

## 2) Tao "working slice" cho infra

Lam tung cum nho theo dung scope:

1) Dependencies (`pom.xml`)
- [ ] `spring-boot-starter-web`
- [ ] `spring-boot-starter-validation`
- [ ] `spring-boot-starter-data-jpa`
- [ ] `spring-boot-starter-actuator`
- [ ] `org.postgresql:postgresql` (runtime)
- [ ] `com.h2database:h2` (test)

2) Config files
- [ ] Tao/cap nhat `src/main/resources/application.yml`
- [ ] Tao/cap nhat `src/main/resources/application-dev.yml`
- [ ] Tao/cap nhat `src/main/resources/application-test.yml`
- [ ] Tao/cap nhat `src/test/resources/application.properties` (`spring.profiles.active=test`)

3) Health integration test
- [ ] Tao/cap nhat `src/test/java/com/programming_with_al/al_operational_resources/infra/ActuatorHealthIntegrationTest.java`
- [ ] Assert `/actuator/health` -> `200` + `status=UP`

Log:
- Time:
- Files changed:
- Notes:

---

## 3) Chay ha tang dev (Postgres docker) de verify local profile `dev`

PowerShell tai root repo:

```text
docker compose -f .operational-resources/simulator/docker-compose.postgres.yml up -d
```

Check:
- [ ] Container postgres len
- [ ] Port host `5433` mo

Optional stop:

```text
docker compose -f .operational-resources/simulator/docker-compose.postgres.yml down
```

Log:
- Command output summary:
- Issues:

---

## 4) Chay test bat buoc (AC6)

PowerShell tai root repo:

```text
./mvnw.cmd -q test
```

Bat buoc pass:
- [ ] `AlOperationalResourcesApplicationTests`
- [ ] `ActuatorHealthIntegrationTest`
- [ ] Exit code = 0

Neu fail:
- [ ] Ghi loi chinh
- [ ] Ghi root-cause
- [ ] Ghi cach fix
- [ ] Re-run test pass

Log:
- Run #1:
- Run #2 (neu co):
- Final status:

---

## 5) Doi chieu AC checklist (dong bo task file)

Mo `../docs/current-task/20260414-shelflog-infra.md` va danh dau:

- [ ] AC1 complete
- [ ] AC2 complete
- [ ] AC3 complete
- [ ] AC4 complete
- [ ] AC5 complete
- [ ] AC6 complete

Cap nhat section:
- [ ] Sec 4 (AC -> test) phu hop class test hien tai
- [ ] Sec 12 (Nhat ky tien do) ghi dung nhung gi da lam
- [ ] Sec 13 (DoD) tick xong

Log:
- Updated sections:
- Note:

---

## 6) Dong bo simulator ticket + dashboard

Can dong bo theo he thong:

- [ ] `../simulator/DEMO-TICKET-20260414-shelflog-infra.md` phan anh dung task canonical
- [ ] `../docs/current-task/README.md` dashboard status dung (`Done`)
- [ ] Neu co doi contract: cap nhat `../docs/api/10-current-api-changes.md`

Log:
- Files synced:
- Note:

---

## 7) Self-review truoc khi chuyen sang SIM-DEMO-2

Checklist nhanh:
- [ ] Khong co logic business `ShelfItem` trong task infra
- [ ] Khong lo secret that
- [ ] Chi dung stack da duoc phe duyet trong task/brief
- [ ] Tai lieu phan anh dung implementation
- [ ] SIM-DEMO-2 co the bat dau (infra preconditions dat)

Ket luan:
- [ ] SIM-DEMO-1 Done
- [ ] Ready for SIM-DEMO-2

---

## 8) Execution log (dien trong qua trinh lam)

### Entry template

- Timestamp:
- Step:
- Action:
- Files:
- Evidence:
- Issue/Risk:
- Next:

### Entries

- (dien tai day theo tung buoc)

---

## 9) Final output expected

Khi xong file nay, ban phai co:

1. Code infra baseline da dung scope
2. Test pass voi `./mvnw.cmd -q test`
3. Task `20260414-shelflog-infra.md` da tick AC/DoD
4. Dashboard `docs/current-task/README.md` dung status
5. San sang bat dau SIM-DEMO-2

**Last updated:** 2026-04-14
