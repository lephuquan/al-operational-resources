# Mục tiêu cốt lõi (core objectives)

Last updated: 2026-04-17  
Scope: `.operational-resources-use1000/` — hệ thống vận hành task → AL → human done.

Tài liệu này là **điểm neo ý định** (intent anchor) cho bundle: bổ sung cho [`al-run/SYSTEM-DEFINITION.md`](al-run/SYSTEM-DEFINITION.md) và các contract trong [`al-run/current-task/`](al-run/current-task/).

---

## 1) Làm rõ task đầu vào trước khi implement

- **Mục đích hệ thống:** làm **rõ** task đầu vào (scope, AC, ngữ cảnh, ràng buộc) để thực thi an toàn và có thể kiểm tra.
- **Task chưa rõ:** không được coi là sẵn sàng cho AL implement. Phải **khai thác / discovery** (câu hỏi, thử nghiệm nhỏ, xác nhận với human) cho đến khi các lỗ hổng đầu vào được ghi nhận và **đóng** theo cách có thể kiểm chứng.
- **Tài liệu liên quan:** [`al-run/current-task/DISCOVERY-TEMPLATE.md`](al-run/current-task/DISCOVERY-TEMPLATE.md), gate và lifecycle trong [`al-run/SYSTEM-DEFINITION.md`](al-run/SYSTEM-DEFINITION.md), [`al-run/task-lifecycle/`](al-run/task-lifecycle/).

---

## 2) Đủ tài nguyện — không để AL đoán hay suy diễn

Trước khi AL được phép implement (sau input gate và đủ context theo contract):

- **Mọi tài nguyện và thông tin** cần cho thay đổi code/test phải **đủ cụ thể**: có thể truy vết tới repo (path), command, ví dụ hành vi, hoặc nguồn đã thống nhất — không dựa vào “hiểu ngầm” hay mô tả trừu tượng.
- **Tiền đề “đủ để AL implement”** dùng cùng một thanh chuẩn với con người: **một developer mới vào dự án có thể đọc task (và discovery nếu có), hiểu, và hoàn thành công việc** mà không phải tự phỏng đoán phạm vi hay hợp đồng nghiệp vụ.
- Nếu tiêu chí trên **chưa** đạt → tiếp tục làm rõ task / discovery; **không** chuyển sang implement mặc định.

**Tham chiếu kỹ thuật:** [`al-run/current-task/SCHEMA.md`](al-run/current-task/SCHEMA.md), [`al-run/current-task/TEMPLATE.md`](al-run/current-task/TEMPLATE.md) (DoR, context pack, AC → test).

---

## 3) Cách human và AL cùng làm việc (phân trách nhiệm)

- **Cùng nhau:** human và AL **tương tác** để làm rõ và hoàn thiện **`TASK.md`** và tài liệu **discovery** (nếu có), cho đến khi đạt mục (1) và (2).
- **AL:** sau khi gate và contract thỏa mãn, AL **chịu trách nhiệm implement** (code + test + evidence theo output contract) — đây là lộ trình mặc định, trừ khi task ghi rõ ngoại lệ.
- **Human:** chịu trách nhiệm **review code**, **review evidence**, **tạo MR**, **merge**, **đóng ticket** (quy trình ngoài repo nếu có), và trong file task: tick **Human Done (§13.2)** cùng **Status Done** khi thực sự hoàn tất. AL chỉ hỗ trợ các bước human (ví dụ soạn checklist MR, nhắc tick) **khi được human yêu cầu**.

Chi tiết vai trò và trạng thái “AL done” / “task done”: [`al-run/SYSTEM-DEFINITION.md`](al-run/SYSTEM-DEFINITION.md), hướng dẫn vận hành: [`al-run/HUMAN-AL-WORKFLOW-GUIDE.md`](al-run/HUMAN-AL-WORKFLOW-GUIDE.md).

---

## 4) Task và tài liệu (`docs/` / context): thứ tự — tránh “phụ thuộc vô tận”

Cảm giác *“phải có đủ doc mới làm task, nhưng làm task mới sinh doc”* chỉ xảy ra khi trộn hai mức **đủ** khác nhau:

| Mức | Ý nghĩa | Khi nào cần |
|-----|---------|-------------|
| **Đủ cho một slice** | Đủ để một developer mới (và AL) thực hiện **đúng AC của task hiện tại** — có path, ví dụ, quyết định đã chốt trong task hoặc discovery. | Trước khi AL implement slice đó. |
| **Đủ mô tả hệ thống** | Tài liệu rộng, edge case, lịch sử — gần như **không bao giờ “xong hết”** trước mỗi ticket. | Theo thời gian; **không** là cổng bắt buộc cho mọi task. |

**Nguyên tắc cắt vòng:**

- **Task (contract + AC) là trục.** Scope và AC quyết định *cần* chứng minh gì trong code và test — không bắt “viết hết wiki” trước.
- **Doc / context theo slice, tối thiểu:** chỉ bổ sung trong `workspace/docs/` (và chỗ tương đương) những gì **bắt buộc để AC có thể kiểm tra** (ví dụ một đoạn spec, một mục API changelog nếu đổi hành vi công khai). Phần mở rộng làm sau khi hành vi đã rõ trong implementation.
- **Khi chưa viết được AC** vì thiếu quyết định nghiệp vụ hoặc contract → **không** vào implement; dùng **discovery** hoặc **spike / chore** riêng cho đến khi có thể ghi vào task những điều **cụ thể, có thể kiểm chứng** (mục (1)).
- **Sau task:** đưa sự thật bền từ code + AC vào `docs/`, `api/`, ADR theo convention repo (**promote** — một chiều task → code → doc), tránh doc mơ hồ viết trước rồi code đoán.

**Một câu nhớ:** task không phụ thuộc vào “cả kho doc”; **doc cho slice đó phụ thuộc vào AC của slice đó**. Vòng lặp là dấu hiệu đang đòi mức “mô tả hệ thống” thay vì mức “đủ cho slice”.

Tham chiếu bổ sung: [`workspace/docs/README.md`](workspace/docs/README.md) (promote sau khi task xong), [`al-run/current-task/DISCOVERY-TEMPLATE.md`](al-run/current-task/DISCOVERY-TEMPLATE.md).
