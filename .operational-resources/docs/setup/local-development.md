# Chạy ứng dụng trên máy dev (local)

<!-- Đổi tiêu đề phụ hoặc thêm mục nếu dự án có nhiều app (API + web + worker). -->

## Mục đích

Mô tả **từ clone repo đến chạy được** trên máy cá nhân: công cụ cần có, lệnh cài đặt, lệnh chạy, URL/port kiểm tra.

---

## Điều kiện tiên quyết

| Công cụ | Phiên bản gợi ý | Ghi chú |
|---------|-----------------|---------|
| JDK | 17+ | <!-- hoặc Node 20 LTS, Python 3.11, … --> |
| Maven / Gradle | | <!-- bỏ cột không dùng --> |
| Docker (tùy chọn) | | |
| IDE | IntelliJ / VS Code / … | |

---

## Clone & nhánh làm việc

```text
git clone <url-repo>
cd <thư-mục-dự-án>
git checkout <nhánh-feature-hoặc-develop>
```

---

## Cài dependency

```text
<!-- Ví dụ Java: -->
./mvnw -q -DskipTests package
```

```text
<!-- Ví dụ Node: -->
npm ci
```

---

## Chạy ứng dụng (development)

| Thành phần | Lệnh / cách chạy | URL hoặc port |
|------------|------------------|---------------|
| API / server | `<!-- ./mvnw spring-boot:run -Dspring-boot.run.profiles=local -->` | `http://localhost:8080` |
| Frontend (nếu có) | | |
| Worker / consumer (nếu có) | | |

**Profile / mode:** `<!-- ví dụ: spring.profiles.active=local -->`

---

## Kiểm tra nhanh sau khi chạy

- [ ] Health: `<!-- GET /actuator/health hoặc tương đương -->`
- [ ] Swagger / OpenAPI (nếu có): `<!-- URL -->`

---

## Docker / Compose (nếu dùng)

```text
<!-- docker compose up -d -->
```

Ghi rõ service nào bắt buộc trước khi chạy app (DB, Redis, …).

---

## Ghi chú riêng máy (không bắt buộc)

<!-- Ví dụ: phải bật VPN để reach staging DB — chỉ mô tả hành vi, không ghi credential. -->

---

**Last updated:** 2026-04-08
