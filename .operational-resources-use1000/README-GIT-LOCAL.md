# Ẩn / hiện `.operational-resources/` khỏi Git (chỉ máy local)

Thư mục này có thể là **tài liệu & cấu hình cá nhân**. Nếu bạn không muốn Git báo thay đổi (`git status`) nhưng **vẫn giữ file trên ổ đĩa**, dùng **exclude cục bộ** — không commit rule này lên repo, không ảnh hưởng máy khác.

## File cần sửa

- Đường dẫn (từ gốc repo): **`.git/info/exclude`**
- Ví dụ đầy đủ (Windows):  
  `...\al-operational-resources\.git\info\exclude`

## Ẩn khỏi Git local (Git không hiển thị thư mục này)

1. Mở file `.git/info/exclude` (Notepad, Cursor, v.v.).
2. Thêm **một dòng** ở cuối file:

```gitignore
.operational-resources/
```

3. Lưu file.
4. Kiểm tra:

```powershell
git status
```

Thư mục `.operational-resources/` sẽ **không còn** xuất hiện dưới dạng untracked (trừ khi đã được `git add` trước đó — xem mục “Đã từng add/commit” bên dưới).

## Hiện lại để Git nhìn thấy (để `git add` / commit / push)

1. Mở lại `.git/info/exclude`.
2. **Xóa** hoặc **comment** dòng `.operational-resources/` (thêm `#` ở đầu dòng):

```gitignore
# .operational-resources/
```

3. Lưu file.
4. Kiểm tra:

```powershell
git status
```

Bạn sẽ thấy `?? .operational-resources/` (untracked) hoặc thay đổi nếu đã track.

## Mở file `exclude` nhanh (PowerShell, tại gốc repo)

```powershell
notepad .git\info\exclude
```

Hoặc trong Cursor: `Ctrl+P` → gõ `.git/info/exclude` → Enter.

## Hiện thư mục `.git` trong Explorer (Windows)

- File Explorer → tab **View** → bật **Hidden items** (Hiện mục ẩn).

## Lưu ý quan trọng

| Tình huống | Cách xử lý |
|------------|------------|
| Chưa bao giờ `git add` `.operational-resources/` | Chỉ cần dòng trong `exclude` như trên là đủ để “ẩn” khỏi `status`. |
| Đã từng add/commit thư mục này | `exclude` **không** bỏ theo dõi file đã track. Cần gỡ index (ví dụ `git rm -r --cached .operational-resources/`) rồi commit — **hỏi team** trước khi làm. |
| Muốn cả team không commit thư mục này | Thêm vào **`.gitignore`** trong repo (khác với `exclude` — rule sẽ commit cho mọi người). |

## Tóm tắt

- **Ẩn local:** thêm `.operational-resources/` vào `.git/info/exclude`.
- **Hiện lại:** xóa / comment dòng đó.
- **Không** ảnh hưởng remote hay máy đồng nghiệp — đây là cấu hình **chỉ trên máy bạn**.
