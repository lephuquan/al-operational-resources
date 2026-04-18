# Quy ước thư mục: một work item = một thư mục

Mục tiêu: tách rõ **discovery** (làm rõ yêu cầu) và **task** (contract implement), vẫn giữ một chỗ duy nhất cho mọi artefact của cùng một ticket.

## Cấu trúc đề xuất

```text
current-task/
  <YYYYMMDD-short-slug>/          # một work item (trùng “slug” với tên thư mục)
    TASK.md                       # file task canonical (chạy start-task / close-task trỏ vào đây)
    DISCOVERY.md                  # (tuỳ chọn) discovery đã pass preflight
    runtime/                      # (tự tạo) session JSON: *.task.session.json, *.discovery.session.json
    reports/                      # (tự tạo) báo cáo handoff từ close-task.ps1
    logs/                         # (tuỳ chọn) evidence test riêng work item
      ...
  reference/                      # quy ước thư mục, workflow, migration, metrics, human gate (xem reference/README.md)
  SCHEMA.md                       # contract nghiêm — giữ ở gốc current-task
  TEMPLATE.md
  DISCOVERY-TEMPLATE.md
  .runtime/                       # (legacy, flat task) session JSON khi -TaskFile là file .md phẳng
  reports/                        # (legacy) handoff cho task phẳng
  ...
```

## Quy tắc đặt tên

- **Thư mục:** `YYYYMMDD-short-slug` (ví dụ `20260417-shelflog-csv-export`).
- **Task:** luôn tên cố định **`TASK.md`** trong thư mục đó (dễ script, dễ nhớ).
- **Discovery:** cố định **`DISCOVERY.md`** nếu có (preflight-discovery trỏ tới file này).

## Liên kết trong discovery

Trong bảng metadata **Task file**, ghi đường dẫn đầy đủ tới `TASK.md`, ví dụ:

`.operational-resources-use1000/al-run/current-task/20260417-shelflog-csv-export/TASK.md`

## Lệnh (ví dụ)

```powershell
powershell -File .operational-resources-use1000/al-run/scripts/preflight-discovery.ps1 -DiscoveryFile ".operational-resources-use1000/al-run/current-task/20260417-shelflog-csv-export/DISCOVERY.md"
```

```powershell
powershell -File .operational-resources-use1000/al-run/scripts/start-task.ps1 -TaskFile ".operational-resources-use1000/al-run/current-task/20260417-shelflog-csv-export/TASK.md"
```

## Tương thích ngược

Các task cũ dạng **một file phẳng** `YYYYMMDD-slug.md` vẫn hợp lệ cho đến khi migrate; script chỉ cần `-TaskFile` trỏ đúng file tồn tại. Session JSON cho task phẳng vẫn ghi vào `current-task/.runtime/`; handoff vào `current-task/reports/` (cùng cây `current-task` mà script resolve).

---

**Last updated:** 2026-04-19
