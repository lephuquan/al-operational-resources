# Luồng đầy đủ Human + AL (từ task đến Done)

**Mục đích:** một tài liệu duy nhất mô tả **ai làm gì**, **theo thứ tự nào**, kèm lệnh tham chiếu — bám mô hình đã chốt: sau khi task **đủ tài nguyên** và pass **`start-task.ps1`**, **AL (agent) là người code và test bắt buộc** tới **AL done**; Human **không** thay thế bước code chính trừ khi task ghi **ngoại lệ** (§7 / §11). Sau handoff, Human làm review + MR + merge/close + tick **§13.2** + quyết định sản phẩm/scope tới **Task done**.

**Tài liệu liên quan (đọc khi cần chi tiết hơn):**

- Định nghĩa hệ thống: `SYSTEM-DEFINITION.md`
- Contract task nghiêm: `current-task/SCHEMA.md`, `current-task/TEMPLATE.md`
- Kịch bản dry-run đầy đủ (có discovery): [`../workspace/simulator/FULL-SYSTEM-SIMULATION-SCENARIO.md`](../workspace/simulator/FULL-SYSTEM-SIMULATION-SCENARIO.md)
- Checklist human gate: `current-task/reference/HUMAN-GATE-CHECKLIST.md`

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
| **Giao AL implement** (sau khi gate pass): mở Cursor, `@TASK.md`, gửi prompt — **Bước B2** | **Có** (khởi tạo phiên làm việc) | Thực hiện theo prompt; không thay Human làm code chính |
| Discovery khi yêu cầu chưa rõ (`preflight-discovery.ps1`) | Chốt câu trả lời / quyết định thiếu | Soạn discovery, đề xuất câu hỏi, chạy script khi được giao |
| Đọc §8 Context pack (Rules/Docs/Skills) | Nên đọc nhanh một lượt | **Bắt buộc** đọc trước khi code |
| Implement + unit/IT + sửa lỗi (sau input gate, task đủ §8) | — | **Bắt buộc (AL)** — Human không làm bước code chính trừ khi task ghi ngoại lệ |
| Chạy `./mvnw.cmd -q test` + lưu evidence | Có thể yêu cầu / xác minh | **Có** (thực hiện và ghi path evidence vào task §12) |
| Cập nhật doc API / spec khi đổi contract | Chốt wording nếu cần | **Có** (theo task) |
| Tick §13.1 AL Done + mapping AC §4 | — | **Có** |
| Review code + review evidence | **Có** | — |
| Tạo MR, merge, đóng ticket ngoài hệ thống | **Có** | — |
| Tick §13.2 Human Done + Status **Done** | **Có** | Chỉ gợi ý / không thay quyết định merge |
| Quyết định sản phẩm / chỉnh AC hoặc scope sớm | **Có** (chốt ý định, cập nhật task §7) | Soạn đề xuất kỹ thuật theo yêu cầu Human |

---

## 3) Luồng chuẩn (task đã rõ — không bắt buộc discovery)

**Ghi chú đường dẫn:** Các lệnh mẫu dưới đây dùng **`.operational-resources-use1000/al-run/scripts/`** và **`.operational-resources-use1000/al-run/current-task/`**. Bản sync `.operational-resources/` (template) vẫn có thể dùng `docs/current-task/` — xem `SYSTEM-DEFINITION.md`.

**Giả định:** AC và phạm vi đã đủ rõ trong một file `current-task/YYYYMMDD-slug.md`.

### Bước A — Human: chuẩn bị task

1. Sao chép `current-task/TEMPLATE.md` → `current-task/YYYYMMDD-slug.md`.
2. Điền đủ: metadata, `task_contract`, §0 DoR, §2 scope, §3 AC, §4 AC→test, §8 context pack (đường dẫn file **phải tồn tại**), §10 MUST/SHOULD/ASK FIRST, §13.1/13.2.
3. (Tuỳ chọn) Đặt **Status** = `Draft` → `In Progress` khi bắt đầu.

### Bước B — Human hoặc AL: input gate

Chạy (tại gốc repo chứa `pom.xml`):

```powershell
powershell -File .operational-resources-use1000/al-run/scripts/start-task.ps1 -TaskFile ".operational-resources-use1000/al-run/current-task/YYYYMMDD-slug.md"
```

- **Pass:** tiếp tục implement.
- **Fail:** sửa task file theo thông báo script (thiếu section, placeholder, DoR chưa tick, path §8 sai, …). Có thể dùng `-AllowUnready` chỉ khi **cố ý** bỏ qua DoR (không khuyến khích).

### Bước B2 — Human: **giao AL implement** (trong Cursor / agent IDE)

Đây là bước **cụ thể** để Human chuyển từ “task đã pass gate” sang “AL bắt đầu code trong repo”. Không thay thế cho §8 trong task; chỉ là cách **khởi động** phiên làm việc với AL.

1. **Điều kiện:** `start-task.ps1` đã **Pass** (Bước B); task có §8 đủ đường dẫn thật.
2. Mở **Cursor** (hoặc IDE có AI agent với quyền sửa file + chạy lệnh): vào **Chat**, **Composer**, hoặc **Agent** (chế độ có thể chỉnh repo).
3. **Đính kèm ngữ cảnh** cho AL (tối thiểu):
   - File task canonical: dùng **`@`** + chọn `TASK.md` (folder mode) hoặc `YYYYMMDD-slug.md` (flat), ví dụ:  
     `.operational-resources-use1000/al-run/current-task/20260417-shelflog-csv-export/TASK.md`
   - *(Khuyến nghị)* Thêm `@` vài file trong bảng §8 (Rules/Docs/Skills) nếu muốn giảm lệch ngữ cảnh — không bắt buộc nếu AL tự resolve path được.
4. **Gửi yêu cầu** (dán prompt dưới đây hoặc copy từ **§8 “Suggested prompt”** trong chính file task), và nêu rõ: làm đến **AL done** (code + test + evidence + doc theo AC + tick §13.1 + chuẩn bị lệnh `close-task.ps1`).
5. Trong phiên đó, **Human không làm bước code chính**; chỉ trả lời khi AL hỏi quyết định sản phẩm hoặc khi cần chỉnh task (§7).

**Prompt tối thiểu (copy chỉnh đường dẫn cho đúng task):**

```text
Đọc kỹ file task đính kèm (ưu tiên §0 §2 §3 §4 §8 §10 §13.1).
Input gate start-task.ps1 đã pass. Theo quy ước repo, bạn (AL) là người implement chính: code + test trong scope, chạy đúng task_contract.required_test_command, lưu test evidence (path ghi vào §12), cập nhật tài liệu API/spec nếu AC yêu cầu, cập nhật §4 tên test thực tế, tick §13.1 khi đủ điều kiện.
Cho tôi lệnh PowerShell chính xác để chạy close-task.ps1 với -TaskFile và -TestEvidence sau khi bạn xong.
```

Sau khi gửi prompt, AL sẽ thực hiện các bước tương đương **Bước C → F** bên dưới (đọc context → code → test → handoff).

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
.\mvnw.cmd -q test 2>&1 | Tee-Object -FilePath ".operational-resources-use1000/al-run/current-task/logs/YYYYMMDD-slug-test-evidence.txt"
```

Sau đó cập nhật task:

- Tick AC §3 khi đạt.
- §12: ghi lệnh đã chạy + **đường dẫn file evidence**.
- §4: đảm bảo tên class/method test khớp thực tế.

### Bước F — AL: đóng “AL done” (output gate)

```powershell
powershell -File .operational-resources-use1000/al-run/scripts/close-task.ps1 -TaskFile ".operational-resources-use1000/al-run/current-task/YYYYMMDD-slug.md" -TestEvidence ".operational-resources-use1000/al-run/current-task/logs/YYYYMMDD-slug-test-evidence.txt"
```

- Script kiểm tra §13.1 và sinh báo cáo handoff dưới `current-task/reports/` (nếu cấu hình như hiện tại trong repo).

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

1. Tạo file discovery từ `current-task/DISCOVERY-TEMPLATE.md` (nếu repo có bản mẫu này — xem `FULL-SYSTEM-SIMULATION-SCENARIO.md`).
2. Trả lời / điền các mục chưa rõ.

**Human hoặc AL:**

```powershell
powershell -File .operational-resources-use1000/al-run/scripts/preflight-discovery.ps1 -DiscoveryFile ".operational-resources-use1000/al-run/current-task/<discovery-file>.md"
```

**Sau khi discovery pass:** chuyển kết quả vào task chính (AC, §2, §7), rồi mới chạy `start-task.ps1` như luồng chuẩn.

**Khi không cần:** task demo đã đủ AC (như `20260416-demo-create-user-api.md`) — **bỏ qua** discovery.

---

## 5) Nguyên tắc vận hành (tránh lệch track)

- **Một nguồn sự thật:** luôn bám file `current-task/YYYYMMDD-slug.md` cho scope/AC.
- **Không mở rộng ngoài §2.2** trừ khi Human cập nhật task + §7 Revision.
- **Không thêm dependency Maven** trừ khi task / Human cho phép (thường nằm trong §10 ASK FIRST).
- **Human giữ quyền** merge và “Task done”; AL không thay thế bước đó.

---

**Last updated:** 2026-04-16
