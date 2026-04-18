package com.programming_with_al.al_operational_resources.shelflog.api;

import java.time.LocalDate;
import java.time.ZoneOffset;
import java.util.UUID;

import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.programming_with_al.al_operational_resources.shelflog.application.ShelfItemService;
import com.programming_with_al.al_operational_resources.shelflog.persistence.ShelfCategory;

import jakarta.validation.Valid;
import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;

@RestController
@Validated
@RequestMapping("/api/v1/shelf-items")
public class ShelfItemController {

	private final ShelfItemService service;

	public ShelfItemController(ShelfItemService service) {
		this.service = service;
	}

	@PostMapping
	public ResponseEntity<ShelfItemResponse> create(@Valid @RequestBody ShelfItemUpsertRequest request) {
		return ResponseEntity.status(HttpStatus.CREATED).body(service.create(request));
	}

	@PutMapping("/{id}")
	public ShelfItemResponse update(@PathVariable UUID id, @Valid @RequestBody ShelfItemUpsertRequest request) {
		return service.update(id, request);
	}

	@DeleteMapping("/{id}")
	public ResponseEntity<Void> delete(@PathVariable UUID id) {
		service.delete(id);
		return ResponseEntity.noContent().build();
	}

	@GetMapping
	public ShelfItemPageResponse list(
			@RequestParam(defaultValue = "0") @Min(0) int page,
			@RequestParam(defaultValue = "20") @Min(1) @Max(100) int size,
			@RequestParam(required = false) ShelfCategory category) {
		return service.list(page, size, category);
	}

	@GetMapping(value = "/export", produces = "text/csv;charset=UTF-8")
	public ResponseEntity<byte[]> exportCsv(
			@RequestParam(defaultValue = "0") @Min(0) int page,
			@RequestParam(defaultValue = "20") @Min(1) @Max(100) int size,
			@RequestParam(required = false) ShelfCategory category) {
		final byte[] body = service.exportToCsv(page, size, category);
		final String filename = "shelf-items-" + LocalDate.now(ZoneOffset.UTC) + ".csv";
		return ResponseEntity.ok()
				.header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\"" + filename + "\"")
				.contentType(MediaType.parseMediaType("text/csv;charset=UTF-8"))
				.body(body);
	}

	@GetMapping("/{id}")
	public ShelfItemResponse getById(@PathVariable UUID id) {
		return service.getById(id);
	}

}
