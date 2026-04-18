package com.programming_with_al.al_operational_resources.shelflog.persistence;

import java.util.UUID;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

public interface ShelfItemRepository extends JpaRepository<ShelfItemEntity, UUID> {

	Page<ShelfItemEntity> findByCategory(ShelfCategory category, Pageable pageable);

	long countByCategory(ShelfCategory category);
}

