# Luồng đầy đủ Human + AL (từ task đến Done)

**Mục đích:** một tài liệu duy nhất mô tả **ai làm gì**, **theo thứ tự nào**, kèm lệnh tham chiếu — bám mô hình đã chốt: AL làm implement + test + evidence tới **AL done**; Human làm review + MR + merge/close tới **Task done**.

**Tài liệu liên quan (đọc khi cần chi tiết hơn):**

- Định nghĩa hệ thống: `SYSTEM-DEFINITION.md`
- Contract task nghiêm: `docs/current-task/SCHEMA.md`, `docs/current-task/TEMPLATE.md`
- Kịch bản dry-run đầy đủ (có discovery): `simulator/FULL-SYSTEM-SIMULATION-SCENARIO.md`
- Checklist human gate: `docs/current-task/HUMAN-GATE-CHECKLIST.md`

---

## 1) Hai mốc “Done” (bắt buộc phân biệt)

| Mốc | Ý nghĩa | Ai xác nhận |
|-----|---------|-------------|
| **AL done** | Code + test + evidence + cập nhật task/log theo contract; sẵn sàng để Human review | AL (thực hiện) + script `close-task.ps1` hỗ trợ gate output |
| **Task done** | Đã review, MR, merge/close theo quy trình bên ngoài repo | Human |

---

## 2) Vai trò tóm tắt

| Việc | Human | AL |
|------|:-----:|:---:|
| Tạo / điền file task từ `TEMPLATE.md` | Có thể | Có thể hỗ trợ soạn, nhưng Human chốt scope/AC |
| Chạy input gate `start-task.ps1` | Thường Human hoặc giao AL chạy trong máy bạn | Có thể chạy nếu bạn giao và môi trường cho phép |
| Discovery khi yêu cầu chưa rõ (`preflight-discovery.ps1`) | Chốt câu trả lời / quyết định thiếu | Soạn discovery, đề xuất câu hỏi, chạy script khi được giao |
| Đọc §8 Context pack (Rules/Docs/Skills) | Nên đọc nhanh một lượt | **Bắt buộc** đọc trước khi code |
| Implement + unit/IT + sửa lỗi | — | **Có** |
| Chạy `./mvnw.cmd -q test` + lưu evidence | Có thể yêu cầu / xác minh | **Có** (thực hiện và ghi path evidence vào task §12) |
| Cập nhật doc API / spec khi đổi contract | Chốt wording nếu cần | **Có** (theo task) |
| Tick §13.1 AL Done + mapping AC §4 | — | **Có** |
| Review code + review evidence | **Có** | — |
| Tạo MR, merge, đóng ticket ngoài hệ thống | **Có** | — |
| Tick §13.2 Human Done + Status **Done** | **Có** | Chỉ gợi ý / không thay quyết định merge |

---

## 3) Luồng chuẩn (task đã rõ — không bắt buộc discovery)

**Giả định:** AC và phạm vi đã đủ rõ trong một file `docs/current-task/YYYYMMDD-slug.md`.

### Bước A — Human: chuẩn bị task

1. Sao chép `docs/current-task/TEMPLATE.md` → `docs/current-task/YYYYMMDD-slug.md`.
2. Điền đủ: metadata, `task_contract`, §0 DoR, §2 scope, §3 AC, §4 AC→test, §8 context pack (đường dẫn file **phải tồn tại**), §10 MUST/SHOULD/ASK FIRST, §13.1/13.2.
3. (Tuỳ chọn) Đặt **Status** = `Draft` → `In Progress` khi bắt đầu.

### Bước B — Human hoặc AL: input gate

Chạy (tại gốc repo chứa `pom.xml`):

```powershell
powershell -File .operational-resources/scripts/start-task.ps1 -TaskFile ".operational-resources/docs/current-task/YYYYMMDD-slug.md"
```

- **Pass:** tiếp tục implement.
- **Fail:** sửa task file theo thông báo script (thiếu section, placeholder, DoR chưa tick, path §8 sai, …). Có thể dùng `-AllowUnready` chỉ khi **cố ý** bỏ qua DoR (không khuyến khích).

### Bước C — AL: đọc ngữ cảnh (một bước riêng, nên làm rõ ràng)

1. Đọc toàn bộ file task (ưu tiên §2 scope, §3 AC, §4 mapping).
2. Mở và đọc **từng file** trong bảng **§8** (Rules, Docs, Skills).

**Dừng lại ở đây nếu phát hiện scope không khả thi hoặc thiếu quyết định** — quay Human cập nhật task / §7 Revision.

### Bước D — AL: implement + test (trong phạm vi §2.2)

1. Code theo AC từng lát nhỏ (tránh overbuild).
2. Thêm/cập nhật test theo §4.
3. Cập nhật tài liệu contract nếu task yêu cầu (ví dụ `docs/api/08-endpoint-list.md`, `10-current-api-changes.md`).

### Bước E — AL: chạy test + evidence

Ví dụ lưu log:

```powershell
.\mvnw.cmd -q test 2>&1 | Tee-Object -FilePath ".operational-resources/docs/current-task/logs/YYYYMMDD-slug-test-evidence.txt"
```

Sau đó cập nhật task:

- Tick AC §3 khi đạt.
- §12: ghi lệnh đã chạy + **đường dẫn file evidence**.
- §4: đảm bảo tên class/method test khớp thực tế.

### Bước F — AL: đóng “AL done” (output gate)

```powershell
powershell -File .operational-resources/scripts/close-task.ps1 -TaskFile ".operational-resources/docs/current-task/YYYYMMDD-slug.md" -TestEvidence ".operational-resources/docs/current-task/logs/YYYYMMDD-slug-test-evidence.txt"
```

- Script kiểm tra §13.1 và sinh báo cáo handoff dưới `docs/current-task/reports/` (nếu cấu hình như hiện tại trong repo).

### Bước G — Human: review + MR + đóng task

1. Review code (scope, chất lượng, rủi ro).
2. Review evidence test (log, exit code, AC đã cover).
3. Tạo MR (mô tả + **How to test** + link task file).
4. Merge theo quy trình của bạn.
5. Trong file task: tick **§13.2**, đổi **Status** → `Done`, thêm dòng **§12** (đã merge MR / link).

---

## 4) Nhánh tùy chọn: Discovery (khi yêu cầu còn mơ hồ)

**Khi dùng:** ticket mới chỉ có ý tưởng, thiếu AC, thiếu scope, hoặc nhiều lựa chọn kỹ thuật chưa chốt.

**Human:**

1. Tạo file discovery từ `docs/current-task/DISCOVERY-TEMPLATE.md` (nếu repo có bản mẫu này — xem `FULL-SYSTEM-SIMULATION-SCENARIO.md`).
2. Trả lời / điền các mục chưa rõ.

**Human hoặc AL:**

```powershell
powershell -File .operational-resources/scripts/preflight-discovery.ps1 -DiscoveryFile ".operational-resources/docs/current-task/<discovery-file>.md"
```

**Sau khi discovery pass:** chuyển kết quả vào task chính (AC, §2, §7), rồi mới chạy `start-task.ps1` như luồng chuẩn.

**Khi không cần:** task demo đã đủ AC (như `20260416-demo-create-user-api.md`) — **bỏ qua** discovery.

---

## 5) Nguyên tắc vận hành (tránh lệch track)

- **Một nguồn sự thật:** luôn bám file `docs/current-task/YYYYMMDD-slug.md` cho scope/AC.
- **Không mở rộng ngoài §2.2** trừ khi Human cập nhật task + §7 Revision.
- **Không thêm dependency Maven** trừ khi task / Human cho phép (thường nằm trong §10 ASK FIRST).
- **Human giữ quyền** merge và “Task done”; AL không thay thế bước đó.

---

**Last updated:** 2026-04-16
