# Bảng đề xuất hướng giải pháp — AL triển khai task chính xác

Mục tiêu: **giảm lệch context**, **tăng độ khớp AC ↔ test**, **neo AL vào đúng tài nguyên** trong quy trình task → AL → done.

Cách dùng: khi soạn / review task, Human đối chiếu từng hàng; có thể copy hàng liên quan vào **§7 Revision** hoặc **§11** nếu cần ghi nhận quyết định.

---

## Bảng tổng hợp

| ID | Vấn đề / rủi ro | Hướng giải pháp (đề xuất) | Ưu tiên | Ai chịu trách nhiệm | “Xong” khi nào (bằng chứng) |
|:---:|-----------------|---------------------------|:-------:|---------------------|------------------------------|
| A1 | §8 Context pack **quá rộng** (quá nhiều rules/docs/skills) → AL đọc không đều, ưu tiên sai hoặc bỏ sót | Giữ **5–12 path** thật sự cần cho *slice* hiện tại; ưu tiên 1 playbook skill + API/spec + rules tối thiểu; tránh “dump” cả cây `rules/` | **P0** | Human (author task) | Bảng §8 gọn; `start-task.ps1` pass; mỗi dòng §8 mở ra file đúng việc |
| A2 | §8 **quá mỏng** → AL đoán convention / test pattern | Bổ sung file **sát code** (controller/service/test mẫu), hoặc 1 rule/stack cụ thể; ghi trong **§2** nguồn “đọc trước khi sửa file X” | **P0** | Human + AL (đề xuất trong draft) | §2/§8 có anchor rõ; AC không còn chỗ “implicit” |
| A3 | Đường dẫn §8 sai hoặc lệch sau refactor (`workspace/`, `al-run/`) | Mỗi lần sửa §8/§2: chạy lại **`al-run/scripts/start-task.ps1`**; dùng path đầy đủ `.operational-resources-use1000/workspace/...` hoặc `current-task/...` (script resolve) | **P0** | Human (trước khi giao AL) | Log terminal / output: `Task gate passed` sau thay đổi path |
| A4 | **`AGENTS.md`** mang tính chung; task không mirror ràng buộc kỹ thuật → AL generic hóa | Trong **§10 MUST/SHOULD/ASK FIRST** ghi ràng buộc slice: package, pattern lỗi, lệnh test, “không đổi module Y” | **P1** | Human | §10 có ≥3 mục cụ thể; không mâu thuẫn với rules đã chọn §8 |
| A5 | **§4 AC → test** mơ hồ (“có test”) → coverage yếu nhưng vẫn pass gate | Mỗi AC: **ít nhất một** chỉ báo test (class `#method` hoặc tên file IT mới); cập nhật tên thật sau khi AL viết test | **P1** | AL (implement) + Human (review §4) | §4 có mapping cụ thể; evidence trong §12 trỏ đúng lệnh đã chạy |
| A6 | **Simulator / MAP / template** lẫn với doc sản phẩm → AL làm đúng brief nhưng lệch code | §8 ưu tiên **`workspace/docs/specs`**, **`workspace/docs/api`**, code thật; brief chỉ làm *bối cảnh* khi task là demo | **P1** | Human | §2.1 nêu rõ “source of truth là spec/API/repo” |
| A7 | Prompt giao AL **không chuẩn** → variance giữa các phiên | Dùng prompt tối thiểu **`al-run/HUMAN-AL-WORKFLOW-GUIDE.md` (Bước B2)** + **§8 Suggested prompt** trong `TASK.md`; luôn **`@TASK.md`** | **P2** | Human | Mỗi phiên có checklist: đính kèm TASK + (tuỳ chọn) 2–3 file §8 |
| A8 | **Doc lệch code** (spec/API cũ) | Cùng MR / cùng vòng task: cập nhật `workspace/docs/api` + spec khi đổi contract; task ghi AC doc | **P2** | AL + Human review | AC doc tick; file changelog/spec khớp behavior trong PR |

---

## Ánh xạ nhanh: vấn đề → hành động trong file task

| ID | Vị trí trong task (thường) | Hành động |
|:---:|----------------------------|-----------|
| A1, A2 | **§8** | Rút gọn / bổ sung path; đối chiếu “đủ để một dev mới implement không hỏi thêm” |
| A3 | **§8, §2** | Chạy `start-task.ps1` sau mỗi chỉnh path |
| A4 | **§10**, **§7/§11** | Ghi ràng buộc kỹ thuật slice + ngoại lệ (nếu có) |
| A5 | **§4, §12** | Mapping AC ↔ test cụ thể + evidence path |
| A6 | **§2.1, §8 Docs** | Phân tầng: code/spec trước, brief sau |
| A7 | (ngoài file task) | Quy trình Human trong Cursor |
| A8 | **§3 AC**, **docs** | AC7-style hoặc tương đương “doc đã sync” |

---

## Ghi chú triển khai

- Bảng này **không** thay `SCHEMA.md`; chỉ bổ trợ cách “điền” contract cho hiệu quả AL cao.
- **`TEMPLATE.md`**: đã thêm **§2.4** (anchor code), ngưỡng **A1** trong §8, và checkbox DoR **A1/A2**.
- **Task mẫu** `20260417-shelflog-csv-export/TASK.md`: §8 tỉa còn **12** path backtick; **§2.4** liệt kê controller/service/test/export exception — `start-task.ps1` pass sau chỉnh.

---

## Checklist vận hành A1 + A2 (Human)

| Bước | A1 (thu §8) | A2 (neo code) |
|------|-------------|----------------|
| 1 | Liệt kê dự kiến path §8; chuyển brief/README/setup sang **§2.1** nếu chỉ bối cảnh | Mở repo, xác định 2–5 file `src/` / test đụng tới slice |
| 2 | Giữ **Rules** tối thiểu (stack + test + API) | Điền **§2.4** bảng Area \| Path |
| 3 | **Docs** = spec/API/error/pagination trực tiếp cho AC; bỏ file “nice to have” | Đảm bảo path tồn tại (không typo package) |
| 4 | **Skills** = 1 workflow + 1 playbook sát việc (ví dụ REST + IT) | Nếu không có code (doc-only): ghi N/A + path doc trong §2.1 |
| 5 | Chạy `al-run/scripts/start-task.ps1` | Cùng một lệnh — gate kiểm §8 tồn tại |

**Last updated:** 2026-04-16
