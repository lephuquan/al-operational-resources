package com.programming_with_al.al_operational_resources.shelflog.application;

import java.util.UUID;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.programming_with_al.al_operational_resources.common.ResourceNotFoundException;
import com.programming_with_al.al_operational_resources.shelflog.api.ShelfItemPageResponse;
import com.programming_with_al.al_operational_resources.shelflog.api.ShelfItemResponse;
import com.programming_with_al.al_operational_resources.shelflog.api.ShelfItemUpsertRequest;
import com.programming_with_al.al_operational_resources.shelflog.persistence.ShelfCategory;
import com.programming_with_al.al_operational_resources.shelflog.persistence.ShelfItemEntity;
import com.programming_with_al.al_operational_resources.shelflog.persistence.ShelfItemRepository;

@Service
public class ShelfItemService {

	private static final String NOT_FOUND_CODE = "SHELF_404";

	private final ShelfItemRepository repository;

	public ShelfItemService(ShelfItemRepository repository) {
		this.repository = repository;
	}

	@Transactional
	public ShelfItemResponse create(ShelfItemUpsertRequest request) {
		final ShelfItemEntity entity = new ShelfItemEntity();
		applyUpsert(entity, request);
		return toResponse(repository.save(entity));
	}

	@Transactional(readOnly = true)
	public ShelfItemResponse getById(UUID id) {
		return toResponse(findByIdOrThrow(id));
	}

	@Transactional
	public ShelfItemResponse update(UUID id, ShelfItemUpsertRequest request) {
		final ShelfItemEntity entity = findByIdOrThrow(id);
		applyUpsert(entity, request);
		return toResponse(repository.save(entity));
	}

	@Transactional
	public void delete(UUID id) {
		final ShelfItemEntity entity = findByIdOrThrow(id);
		repository.delete(entity);
	}

	@Transactional(readOnly = true)
	public ShelfItemPageResponse list(int page, int size, ShelfCategory category) {
		final Pageable pageable = PageRequest.of(page, size, Sort.by(Sort.Direction.DESC, "createdAt"));
		final Page<ShelfItemEntity> result = category == null
				? repository.findAll(pageable)
				: repository.findByCategory(category, pageable);
		return new ShelfItemPageResponse(
				result.getContent().stream().map(this::toResponse).toList(),
				result.getNumber(),
				result.getSize(),
				result.getTotalElements());
	}

	private ShelfItemEntity findByIdOrThrow(UUID id) {
		return repository.findById(id)
				.orElseThrow(() -> new ResourceNotFoundException(NOT_FOUND_CODE, "Shelf item not found"));
	}

	private void applyUpsert(ShelfItemEntity entity, ShelfItemUpsertRequest request) {
		entity.setTitle(request.title().trim());
		entity.setCategory(request.category());
		entity.setQuantity(request.quantity());
		entity.setNotes(request.notes());
	}

	private ShelfItemResponse toResponse(ShelfItemEntity entity) {
		return new ShelfItemResponse(
				entity.getId(),
				entity.getTitle(),
				entity.getCategory(),
				entity.getQuantity(),
				entity.getNotes(),
				entity.getCreatedAt(),
				entity.getUpdatedAt());
	}
}

