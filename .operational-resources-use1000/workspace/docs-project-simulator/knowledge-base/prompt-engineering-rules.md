# AI Prompting Best Practices

Tài liệu hướng dẫn tương tác với AI trong dự án này để đạt hiệu suất “Vibe Coding” tối đa.

## 1. Cấu trúc prompt chuẩn (Context–Task–Constraint)

Khi bắt đầu task mới trong `current-task/`:

- **Ngôn ngữ:** `TEMPLATE.md` và tiêu đề mục dùng **English**; nội dung ticket/AC bạn điền có thể **tiếng Việt hoặc English** tùy nguồn — giữ nhất quán trong một file.
- **Context**: "Dựa trên `architecture/02-system-overview.md` và `specs/feature-xxx.md`…"
- **Task**: "Hãy triển khai `OrderService.createOrder()` với transaction…"
- **Constraint**: "Spring Boot + JPA, tránh N+1, tuân thủ `knowledge-base/naming-conventions.md`."

## 2. Lệnh tắt (concept)

- `/refactor`: tối ưu code, **không đổi hành vi**.
- `/document`: Javadoc cho public API quan trọng.
- `/test`: JUnit 5 + Mockito cho class/method hiện tại.

## 3. Quy tắc phản hồi mong muốn

- Giải thích **tại sao** trước khi đưa **cái gì** (khi thay đổi không tầm thường).
- Nếu method > ~50 dòng logic, đề xuất tách helper/service.
- Ưu tiên code rõ ràng hơn “clever” một dòng.
