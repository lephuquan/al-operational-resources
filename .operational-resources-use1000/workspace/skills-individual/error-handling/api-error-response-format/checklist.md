# Checklist: API Error Response Format

Dùng trước khi merge thay đổi envelope / DTO lỗi / handler.

## Contract

- [ ] Body lỗi khớp **`docs/api/03-response-format.md`** (`success: false`, nested `error`).
- [ ] Tên field JSON đúng: `code`, `message`, `details` (không lệch camel/snake so với contract).

## Content safety

- [ ] `message` không chứa stack trace, SQL, path file, tên class nội bộ, secret.
- [ ] `details` (nếu có) không lộ dữ liệu nhạy cảm; validation `reason` là text an toàn.

## Codes & HTTP

- [ ] Mỗi mã lỗi mới đã ghi trong **`docs/knowledge-base/error-codes.md`** (nếu team dùng file này).
- [ ] HTTP status khớp bảng khuyến nghị trong **`05-error-handling.md`** (không 200 + `success: false`).

## Implementation

- [ ] Controllers không tự dựng envelope lỗi lẻ tẻ — dùng type/builder/handler thống nhất.
- [ ] Có test tối thiểu assert `$.error.code` (và shape validation nếu đổi `details`).

**Last updated:** 2026-04-11
