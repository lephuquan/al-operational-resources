# Cấu hình & biến môi trường

## Mục đích

Liệt kê **tên** biến, file cấu hình và **ý nghĩa** — để cài đặt local và để AI không đoán sai. **Không** đưa giá trị bí mật vào file này.

---

## Quy tắc an toàn

- Chỉ ghi **tên biến** và mô tả; giá trị thật đặt trong env máy, vault, hoặc file **đã gitignore** (ví dụ `.env.local`).
- Không commit: mật khẩu, token API, private key, connection string đầy đủ.
- Nếu cần ví dụ: dùng placeholder kiểu `<your-api-key>` hoặc `***`.

---

## Profile / môi trường chạy

| Profile / tên | Khi nào dùng | File hoặc cờ liên quan |
|-----------------|--------------|-------------------------|
| `local` | Dev máy cá nhân | `application-local.yml` (ví dụ) |
| `dev` / `staging` / `prod` | Theo team | <!-- link wiki hoặc tên file --> |

---

## Biến môi trường (bảng tham chiếu)

| Tên biến | Bắt buộc | Mô tả | Ghi chú |
|----------|----------|-------|---------|
| `SPRING_PROFILES_ACTIVE` | | Profile Spring | Ví dụ: `local` |
| `SERVER_PORT` | | Port HTTP | Mặc định 8080 nếu không set |
| <!-- thêm dòng --> | | | |

---

## File cấu hình trong repo (không chứa secret)

| File | Vai trò |
|------|---------|
| `src/main/resources/application.yml` | Cấu hình mặc định |
| `application-local.yml` | Local — thường **gitignore** hoặc chỉ mẫu `*.example` |

---

## Nơi lưu secret khi dev

<!-- Ví dụ: Windows User env, 1Password, Doppler, Azure Key Vault — chỉ tên công cụ, không credential. -->

---

**Last updated:** 2026-04-08
