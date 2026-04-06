# Examples: File Upload

```java
@PostMapping("/upload", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
public ResponseEntity<ApiResponse<FileUploadResponse>> upload(
        @RequestParam("file") MultipartFile file) {
    return ResponseEntity.ok(ApiResponse.ok(fileUploadService.store(file)));
}
```

Cấu hình ví dụ `application.yml`:

```yaml
spring:
  servlet:
    multipart:
      max-file-size: 10MB
      max-request-size: 12MB
```
