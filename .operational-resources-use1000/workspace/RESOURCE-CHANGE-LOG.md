# Nhật ký cập nhật tài nguyện workspace (`RESOURCE-CHANGE-LOG`)

Last updated: 2026-04-17

File nằm ở **gốc `workspace/`** (cùng cấp `AGENTS.md`, `MAP.md`) — nhật ký **vận hành bundle**, tách khỏi `docs/` ngữ cảnh dự án.

## Mục đích

- Ghi lại **delta có kiểm soát** khi thêm/sửa/xóa tài nguyện trong **`workspace/`** (ví dụ `rules/`, `skills/`, `docs/`, `guides/`, simulator, v.v.) hoặc khi **bối cảnh theo dự án** thay đổi đáng kể.
- Giúp human và AI **truy vết** “đã đổi gì, ở đâu, vì sao”, tránh mất dấu thay đổi khi bundle lớn dần.

**Phạm vi:** chỉ nhật ký **tài nguyện & tài liệu vận hành** trong bundle `workspace/` — không thay cho git history hay task log trong `al-run/current-task/`.

## Khi nào nên thêm một dòng

- Thêm hoặc xóa file/rule/skill/doc đáng kể; đổi **cấu trúc** thư mục hoặc catalog (`MAP.md`, `skills/README.md`, …).
- Đồng bộ **contract** (API, spec, ADR) với code — nên ghi kèm path doc đã đổi.
- Onboard **dự án mới** hoặc đổi stack/giả định chính trong `docs/project-overview.md` (hoặc tương đương).

## Định dạng mục (copy khi thêm)

Mỗi mục **mới nhất ở trên cùng** (reverse chronological).

```markdown
### YYYY-MM-DD — Tiêu đề ngắn (một dòng)

| Trường | Giá trị |
|--------|---------|
| **Loại** | `rules` \| `skills` \| `docs` \| `guides` \| `simulator` \| `cross` \| `other` |
| **Tóm tắt** | Một câu: đã làm gì |
| **Đường dẫn** | `.operational-resources-use1000/workspace/...` hoặc path tương đối từ gốc repo |
| **Dự án / ticket** | (tuỳ chọn) ví dụ ShelfLog, PROJ-123 |
| **Ghi chú** | (tuỳ chọn) link MR, lý do breaking change |
```

---

## Log (mới → cũ)

### 2026-04-17 — Di chuyển nhật ký lên gốc `workspace/`

| Trường | Giá trị |
|--------|---------|
| **Loại** | `cross` |
| **Tóm tắt** | Chuyển `RESOURCE-CHANGE-LOG.md` từ `workspace/docs/` sang `workspace/`; cập nhật `guides/`, `MAP.md`, `docs/README.md`. |
| **Đường dẫn** | `.operational-resources-use1000/workspace/RESOURCE-CHANGE-LOG.md` |
| **Dự án / ticket** | — |
| **Ghi chú** | Neo vận hành cạnh `AGENTS.md` / `MAP.md`. |

### 2026-04-17 — Khởi tạo nhật ký tài nguyện workspace

| Trường | Giá trị |
|--------|---------|
| **Loại** | `docs` |
| **Tóm tắt** | Thêm nhật ký delta và neo lần đầu trong `guides/`, `MAP.md`, `docs/README.md` (vị trí ban đầu: `docs/RESOURCE-CHANGE-LOG.md`). |
| **Đường dẫn** | (lịch sử) `.operational-resources-use1000/workspace/docs/RESOURCE-CHANGE-LOG.md` |
| **Dự án / ticket** | — |
| **Ghi chú** | Đã thay bằng file tại gốc `workspace/` — xem mục log phía trên. |
