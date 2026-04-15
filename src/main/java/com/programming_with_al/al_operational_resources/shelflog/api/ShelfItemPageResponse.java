package com.programming_with_al.al_operational_resources.shelflog.api;

import java.util.List;

public record ShelfItemPageResponse(
		List<ShelfItemResponse> content,
		int page,
		int size,
		long totalElements) {
}

