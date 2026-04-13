# Naming Conventions

Quy tắc đặt tên để codebase đồng nhất và dễ tìm kiếm.

## 1. Java (backend)

- **Variables / methods**: `camelCase` (`getUserData`, `isOrderValid`)
- **Classes / interfaces / enums**: `PascalCase` (`UserService`, `OrderStatus`)
- **Constants**: `UPPER_SNAKE_CASE` (`MAX_RETRY_ATTEMPT`)
- **Packages**: `lowercase`, không underscore

## 2. Database (PostgreSQL / …)

- **Table**: `snake_case`, số nhiều (ví dụ `users`, `order_items`)
- **Column**: `snake_case` (`created_at`, `is_deleted`)

## 3. API endpoints

- Danh từ, số nhiều: `GET /api/v2/orders`
- Tránh động từ trong URL: sai `/getOrders` — đúng `/orders`
