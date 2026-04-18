# Scripts — lệnh chạy nhanh

Chạy các lệnh dưới đây từ **gốc repo** (thư mục có `pom.xml`), trong **PowerShell** hoặc **CMD**.

Đổi `YYYYMMDD-slug.md` và đường dẫn evidence cho đúng task của bạn.

---

## 1) `preflight-discovery.ps1` — gate discovery (tùy chọn)

**Dùng khi:** yêu cầu còn mơ hồ; đã có file discovery (từ `docs/current-task/DISCOVERY-TEMPLATE.md`) và cần kiểm tra cấu trúc / readiness trước khi viết task chính đầy đủ.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".operational-resources/scripts/preflight-discovery.ps1" -DiscoveryFile ".operational-resources/docs/current-task/<discovery-file>.md"
```

- Có `-AllowUnready` nếu script hỗ trợ và bạn cố ý bỏ qua một số check (xem nội dung `.ps1`).

---

## 2) `start-task.ps1` — gate đầu vào task (input gate)

**Dùng khi:** bắt đầu làm việc trên một file task canonical; kiểm tra contract nghiêm (section, `task_contract`, §8 paths, DoR, …). Pass thì mới nên nhờ AL implement hoặc tự code.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".operational-resources/scripts/start-task.ps1" -TaskFile ".operational-resources/docs/current-task/YYYYMMDD-slug.md"
```

- `-AllowUnready`: chỉ dùng khi cố ý cho phép DoR chưa tick đủ (ít khi cần).

---

## 3) `close-task.ps1` — gate AL done + báo cáo handoff

**Dùng khi:** AL đã xong code + test, đã tick §13.1 và có file **test evidence**; script kiểm tra nhanh và tạo file handoff trong `docs/current-task/reports/`. **Không** thay Human tạo MR hay merge.

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File ".operational-resources/scripts/close-task.ps1" -TaskFile ".operational-resources/docs/current-task/YYYYMMDD-slug.md" -TestEvidence ".operational-resources/docs/current-task/logs/YYYYMMDD-slug-test-evidence.txt"
```

- `-Force`: chỉ khi cố ý bỏ qua một số check (xem `.ps1`); không khuyến khích dùng thường xuyên.

---

## Thứ tự điển hình

1. (Tuỳ chọn) `preflight-discovery.ps1` — nếu ticket raw.
2. `start-task.ps1` — trước implement.
3. Implement + chạy test + lưu evidence (ví dụ `Tee-Object` vào `docs/current-task/logs/...`).
4. `close-task.ps1` — sau khi §13.1 và evidence đã sẵn sàng.

---

**Last updated:** 2026-04-16
