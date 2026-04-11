# Examples: File upload

Snippet baseline. Không dùng path/secret thật. Điều chỉnh envelope, package, storage theo dự án.

## 1) Controller

```java
@PostMapping(value = "/upload", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
public ResponseEntity<ApiResponse<FileUploadResponse>> upload(
        @RequestParam("file") MultipartFile file) {
    FileUploadResponse response = fileUploadService.store(file);
    return ResponseEntity.ok(ApiResponse.ok(response));
}
```

## 2) Service — validate + tên an toàn

```java
import java.util.Locale;
import java.util.Set;
import java.util.UUID;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.server.ResponseStatusException;

@Service
@RequiredArgsConstructor
public class FileUploadService {

    private static final long MAX_BYTES = 10 * 1024 * 1024;
    private static final Set<String> ALLOWED_EXT = Set.of("pdf", "png", "jpg", "jpeg");

    private final FileStorage storage;

    public FileUploadResponse store(MultipartFile file) {
        if (file == null || file.isEmpty()) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "FILE_EMPTY");
        }
        if (file.getSize() > MAX_BYTES) {
            throw new ResponseStatusException(HttpStatus.PAYLOAD_TOO_LARGE, "FILE_TOO_LARGE");
        }
        String ext = safeExtension(file.getOriginalFilename());
        if (!ALLOWED_EXT.contains(ext)) {
            throw new ResponseStatusException(HttpStatus.UNSUPPORTED_MEDIA_TYPE, "FILE_TYPE_NOT_ALLOWED");
        }
        String storedName = UUID.randomUUID() + "." + ext;
        String publicRef = storage.save(storedName, file);
        return new FileUploadResponse(publicRef, file.getSize(), file.getContentType());
    }

    private static String safeExtension(String original) {
        if (original == null || !original.contains(".")) {
            return "";
        }
        String base = original.substring(original.lastIndexOf('.') + 1).toLowerCase(Locale.ROOT);
        return base.replaceAll("[^a-z0-9]", "");
    }
}
```

## 3) Storage port (gợi ý)

```java
public interface FileStorage {

    /** Returns public id or URL-safe reference for clients. */
    String save(String storedObjectName, MultipartFile file);
}
```

## 4) `application.yml`

```yaml
spring:
  servlet:
    multipart:
      max-file-size: 10MB
      max-request-size: 12MB
```

## 5) MockMvc — multipart (skeleton)

```java
@Test
void upload_ok() throws Exception {
    MockMultipartFile file = new MockMultipartFile(
            "file", "test.png", MediaType.IMAGE_PNG_VALUE, "fake".getBytes(StandardCharsets.UTF_8));

    mockMvc.perform(multipart("/api/v1/files/upload").file(file))
            .andExpect(status().isOk());
}
```

## Lưu ý

- Với ảnh/document quan trọng: cân nhắc scan virus, giới hạn độ phân giải, hoặc chuyển xử lý sang async queue.
- CDN/public URL: không expose bucket key đầy đủ nếu policy yêu cầu dùng signed URL.

**Last updated:** 2026-04-09
