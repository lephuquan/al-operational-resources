# Checklist: Pagination & Search

Dùng trước khi merge slice list API. Bỏ qua mục không áp dụng.

## Phân trang

- [ ] Có giới hạn `page size` tối đa (clamp/validation); không cho client kéo full bảng
- [ ] `page` không âm; `size` tối thiểu hợp lý (≥ 1)

## Sort

- [ ] Chỉ cho sort theo whitelist field; map tên API → property an toàn
- [ ] Không bind trực tiếp chuỗi sort từ client vào property tùy ý

## Query & hiệu năng

- [ ] Dùng `Page` / limit/offset đúng cách; không `findAll()` rồi paginate trong memory
- [ ] Filter/search có index hoặc đã ghi rõ rủi ro scan (và kế hoạch tối ưu)
- [ ] LIKE/search: escape ký tự đặc biệt khi cần; giới hạn độ dài keyword

## N+1 & quan hệ

- [ ] List không gây N+1 không kiểm soát (fetch join / graph / projection / batch)

## Response

- [ ] Meta pagination (total, page, size, …) khớp `docs/api/03-response-format.md` và `07-pagination-filtering.md`

## Test

- [ ] Ít nhất: default page, clamp size, một filter; sort hợp lệ / sort bị từ chối (nếu có policy)

## Docs

- [ ] Cập nhật `docs/api/08-endpoint-list.md` và `10-current-api-changes.md` khi đổi contract

**Last updated:** 2026-04-09
