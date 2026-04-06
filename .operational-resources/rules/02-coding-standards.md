# 02 - Coding Standards (Chung)

Repo này là **Java / Spring Boot**. Các quy tắc dưới đây áp dụng cho backend; nếu sau này có TypeScript/frontend, bổ sung file riêng hoặc mục trong `04-frontend.md`.

## General rules

- Viết code sạch, dễ đọc, dễ bảo trì.
- Method nên ngắn gọn (mục tiêu khoảng **80 dòng** trở xuống khi có thể); tách nếu phức tạp.
- Comment ngắn cho logic **không hiển nhiên** (business rule, workaround, performance).
- Tên biến/hàm có nghĩa; tránh `data`, `item`, `x` nếu không đủ ngữ cảnh.

## Naming convention (Java)

- Variable / method: `camelCase`
- Class / interface / enum: `PascalCase`
- Package: `lowercase.dot.notation`
- Constant: `UPPER_SNAKE_CASE`
- Test class: `*Test` hoặc `*IT` (integration) theo convention team

## File & module (khuyến nghị)

- Một class public chính per file.
- Tổ chức theo package/feature khi dự án lớn (tránh “god package”).

## Code style

- Ưu tiên **early return** để giảm lồng ghép.
- Tránh nested `if` quá sâu (mục tiêu **tối đa ~3 tầng**; refactor nếu hơn).
- Ưu tiên **composition** hơn inheritance sâu.
- Dùng `final` cho biến local khi không gán lại (theo style team / formatter).
