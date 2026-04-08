# `docs/setup/` — Chạy local & cấu hình (personal docs)

Thư mục này là **điểm vào** cho: cách **cài đặt**, **chạy**, **cấu hình** và **môi trường triển khai** — phục vụ bạn và AI khi cần ngữ cảnh vận hành, **không** thay cho `README` chính thức của team ở root repo (nếu có).

**Nguyên tắc:** ghi **tên** biến, profile, URL public; **không** lưu mật khẩu, token, connection string đầy đủ, khóa private.

---

## Nội dung trong thư mục

| File | Mục đích |
|------|----------|
| **`README.md`** | File này — mục đích, cách triển khai bộ tài liệu `setup/` cho dự án. |
| **`local-development.md`** | Điều kiện tiên quyết, clone, cài dependency, lệnh chạy, URL/port, profile local. |
| **`configuration.md`** | Biến môi trường (chỉ tên), file cấu hình, profile Spring/`NODE_ENV`, nơi lưu secret an toàn. |
| **`deployment-overview.md`** | Môi trường (dev/stage/prod), pipeline/artifact ở mức tóm tắt, liên kết tài liệu team. |
| **`troubleshooting-local.md`** | Lỗi thường gặp khi chạy máy — cập nhật dần theo thực tế. |

Có thể **thêm** file theo dự án (ví dụ `docker.md`, `database-local.md`) khi cần; nên liệt kê trong bảng trên hoặc mục “Tài liệu bổ sung” dưới đây.

---

## Cách triển khai `setup/` cho hầu hết dự án

Áp dụng khi bắt đầu dự án mới hoặc khi đồng bộ lại tài liệu cá nhân.

### Bước 1 — Tạo khung (một lần)

1. Sao chép nội dung mẫu từ các file `*.md` hiện có (placeholder `<!-- ... -->` hoặc mục “Điền theo dự án”).
2. Đảm bảo có đủ tối thiểu: **`local-development.md`**, **`configuration.md`**, **`troubleshooting-local.md`** (có thể để ngắn ban đầu).

### Bước 2 — Điền theo stack (chọn phần liên quan)

| Loại dự án | Ưu tiên điền trong |
|------------|---------------------|
| Backend (Spring, Node, …) | `local-development.md` (lệnh build/run/test), `configuration.md` (profile, env). |
| Frontend (React, Vue, …) | URL dev server, biến `VITE_*` / `NEXT_PUBLIC_*` (chỉ tên và ý nghĩa). |
| Monorepo | Một mục “Thứ tự chạy” hoặc file `workspaces.md` nếu phức tạp. |
| Docker / Compose | Mục trong `local-development.md` hoặc file `docker.md` riêng. |
| DB / migration | Lệnh migrate local, tên DB/schema; **không** paste chuỗi kết nối có mật khẩu. |

### Bước 3 — Liên kết

- Trong **`docs/project-overview.md`** hoặc `docs/README.md`: một dòng trỏ tới `docs/setup/` cho người/AI “lần đầu chạy”.
- Trong **`MAP.md`**: đã có mục `setup/` — giữ đồng bộ khi đổi tên file.

### Bước 4 — Bảo trì

- Khi đổi port, profile, hoặc lệnh chạy chuẩn — cập nhật `setup/` trong cùng MR hoặc ngay sau.
- Ghi vấn đề lặp lại vào `troubleshooting-local.md` thay vì chỉ chat nội bộ.

---

## Quan hệ với các thư mục khác

| Thư mục | Khác biệt so với `setup/` |
|---------|---------------------------|
| **`docs/architecture/`** | Kiến trúc, luồng dữ liệu — không nhắm “lệnh chạy máy dev”. |
| **`docs/knowledge-base/troubleshooting-manual.md`** | Tri thức lỗi nghiệp vụ / production — `setup/troubleshooting-local.md` tập trung **máy dev**. |
| **`notes/quick-reference/`** | Ghi chú cá nhân ngắn; có thể **link** tới `docs/setup/` thay vì nhân đôi nội dung dài. |
| **Root `README` của team** | Nguồn chính thức cho cả team; `setup/` là bản **cá nhân + đủ chi tiết cho AI**. |

---

**Last updated:** 2026-04-08
