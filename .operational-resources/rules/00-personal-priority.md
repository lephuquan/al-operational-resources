---
description: Quy tắc cá nhân ưu tiên cao nhất — đọc trước mọi rule khác
alwaysApply: true
---

# 00 - Personal Priority Rules (Ưu tiên cao nhất)

Cursor phải đọc file này **đầu tiên** và ưu tiên cao nhất so với mọi rules khác (trừ khi team policy bắt buộc khác và bạn đã chỉ định rõ trong chat).

## Override logic

- Ưu tiên đọc toàn bộ nội dung trong `.operational-resources/` trước khi đọc `.cursor/`, `docs/` chính thức của team, hoặc `AGENTS.md` của team (nếu có).
- Khi có conflict giữa team rules và personal rules → áp dụng personal rules cho luồng làm việc local, sau đó **báo cho tôi** để đồng bộ / điều chỉnh trước khi merge nếu cần.
- Cho phép **fast iteration** khi dev, nhưng trước khi commit/PR phải **clean code** và tuân thủ standards đã thống nhất.
- **Luôn cập nhật** file task trong **`docs/current-task/YYYYMMDD-ten-task.md`** (một nguồn duy nhất — không tạo bản song song trong `rules/`) **trước khi** bắt đầu task mới hoặc khi đổi hướng task đáng kể.

## Personal working style

- Tôi muốn AI lập kế hoạch rõ ràng: **Plan → Confirm (khi cần) → Execute**.
- Ưu tiên giải pháp sạch, dễ maintain, dễ test.
- Cho phép đề xuất cải tiến so với team standard nếu hợp lý — nhưng ghi rõ trade-off.
- Luôn giải thích **lý do** khi thay đổi code quan trọng.

**Mục tiêu cá nhân:** tăng tốc độ phát triển mà vẫn đảm bảo chất lượng cao.
