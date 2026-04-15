package com.programming_with_al.al_operational_resources.shelflog.api;

import com.programming_with_al.al_operational_resources.shelflog.persistence.ShelfCategory;

import jakarta.validation.constraints.Max;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

public record ShelfItemUpsertRequest(
		@NotBlank @Size(max = 200) String title,
		@NotNull ShelfCategory category,
		@NotNull @Min(0) @Max(999) Integer quantity,
		@Size(max = 2000) String notes) {
}

