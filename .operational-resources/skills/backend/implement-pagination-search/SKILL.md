# Skill: Implement Pagination & Search

## TL;DR (VI)

- API **list** có **phân trang** và **lọc/tìm kiếm** ổn định; không `findAll()` full bảng.
- Controller nhận **`Pageable`** (hoặc query params có **giới hạn** `size`); repository trả **`Page<T>`** + dynamic query (`Specification` / `@Query` / DSL).
- Tránh **N+1**; response có **meta** (total, page, size) theo `docs/api/`.

## Goal

Triển khai endpoint danh sách có phân trang, sort an toàn, và bộ lọc/tìm kiếm có kiểm soát — hiệu năng chấp nhận được (index, không load quan hệ lazy lặp), contract thống nhất với tài liệu API cá nhân.

## Preconditions

- Đã đọc `docs/api/07-pagination-filtering.md` và `docs/api/03-response-format.md` (envelope + meta).
- Entity/repository tương ứng đã có hoặc sẽ tạo trong cùng slice.
- Biết giới hạn `max page size` của team (tránh client gửi `size=999999`).

## Steps

1. **Tham số phân trang**
   - Ưu tiên `Pageable pageable` trên controller (Spring bind `page`, `size`, `sort`).
   - Hoặc DTO riêng với validation: `@Min(0) int page`, `@Min(1) @Max(100) int size`, sort whitelist.
   - **Clamp** `size` không vượt max (config hoặc constant).

2. **Sort an toàn**
   - Chỉ cho sort theo **whitelist** field (tránh sort theo cột tùy ý từ query string → injection/rò thông tin).
   - Map alias API → property entity rõ ràng.

3. **Repository layer**
   - `Page<Entity>` từ `JpaSpecificationExecutor` + `Specification` hoặc `@Query` động / Criteria API.
   - Filter: equality, `LIKE` có chừng (prefix/suffix), date range; **escape** `%`/`_` nếu dùng LIKE với user input.
   - Đảm bảo có **index** phù hợp cho filter/search hot (ghi chú migration nếu thêm index).

4. **Tránh N+1**
   - List có association: `JOIN FETCH` trong query có phân trang (lưu ý **duplicate root** với fetch join — cân nhắc `@EntityGraph`, DTO projection, hoặc batch size theo policy Hibernate).
   - Hoặc tách endpoint detail; list chỉ trả id/summary.

5. **Response**
   - Map `Page` → DTO list + **meta**: `totalElements`, `totalPages`, `number`, `size`, `first`, `last` (hoặc subset theo contract).
   - Khớp envelope trong `docs/api/03-response-format.md`.

6. **Search keyword**
   - Chuẩn hóa: trim, giới hạn độ dài, optional normalize unicode.
   - Full-text / trigram: chỉ khi team đã chọn; ghi rõ trong task/ADR.

7. **Test**
   - Test repository/spec với slice hoặc `@DataJpaTest` (tuỳ policy).
   - Test controller: page mặc định, size clamp, sort bị từ chối nếu không whitelist.

## Output

- Endpoint list + service/repository query + DTO response có meta.
- Cập nhật `docs/api/08-endpoint-list.md`, `10-current-api-changes.md` nếu API public mới/đổi.

## References

- `docs/api/07-pagination-filtering.md`
- `docs/api/03-response-format.md`
- `docs/api/02-api-overview.md`
- `docs/architecture/05-database-design.md` (index)
- `skills/backend/create-rest-api/SKILL.md`
- `skills/performance/optimize-api-response/README.md`
- `skills/backend/create-service-layer/SKILL.md`
- `skills/backend/create-jpa-entity/SKILL.md`
- `skills/database/optimize-query/SKILL.md` (khi cần tối ưu)

**Last updated:** 2026-04-11
