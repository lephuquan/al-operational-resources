# Feature: Authentication & Authorization

**Mã**: FEA-AUTH-001  
**Trạng thái**: Completed [cập nhật theo thực tế]

## 1. Mô tả

Hệ thống đăng nhập, đăng ký, quên mật khẩu và quản lý phiên làm việc.

## 2. User stories

- As a user, I want to login with email + password
- As a user, I want to reset password via email
- As a user, I want to stay logged in (refresh token)

## 3. Acceptance criteria

- Login thành công → trả access token + set refresh token cookie
- Sai mật khẩu 5 lần → khóa tài khoản tạm thời 15 phút
- Refresh token hết hạn → yêu cầu login lại

## 4. API endpoints

- `POST /api/v2/auth/login`
- `POST /api/v2/auth/register`
- `POST /api/v2/auth/refresh`
- `POST /api/v2/auth/logout`

## 5. Edge cases

- Tài khoản bị khóa
- Email chưa xác thực
- Refresh token bị revoke
