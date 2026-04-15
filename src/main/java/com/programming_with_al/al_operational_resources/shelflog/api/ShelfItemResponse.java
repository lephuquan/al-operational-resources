package com.programming_with_al.al_operational_resources.shelflog.api;

import java.time.Instant;
import java.util.UUID;

import com.programming_with_al.al_operational_resources.shelflog.persistence.ShelfCategory;

public record ShelfItemResponse(
		UUID id,
		String title,
		ShelfCategory category,
		Integer quantity,
		String notes,
		Instant createdAt,
		Instant updatedAt) {
}

