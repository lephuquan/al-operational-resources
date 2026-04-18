# Feature: Order Management

**Mã**: FEA-ORDER-001  
**Trạng thái**: In Progress

## 1. Mô tả

Cho phép người dùng tạo đơn hàng, xem lịch sử và quản lý trạng thái đơn hàng.

## 2. Main user stories

- As a customer, I can create new order with multiple items
- As a customer, I can apply voucher when creating order
- As a customer, I can view my order history

## 3. Acceptance criteria

- Kiểm tra stock real-time trước khi tạo order
- Tính tổng tiền + phí vận chuyển + giảm giá voucher
- Gửi email xác nhận sau khi tạo order thành công [nếu có]
- Trạng thái order: PENDING → CONFIRMED → PROCESSING → SHIPPED → DELIVERED

## 4. API endpoints

- `POST   /api/v2/orders`
- `GET    /api/v2/orders`
- `GET    /api/v2/orders/:id`
- `PATCH  /api/v2/orders/:id/status` (admin only)

## 5. Edge cases

- Sản phẩm hết hàng trong lúc tạo order
- Voucher không còn hiệu lực
- Đơn hàng đã thanh toán không cho phép hủy
