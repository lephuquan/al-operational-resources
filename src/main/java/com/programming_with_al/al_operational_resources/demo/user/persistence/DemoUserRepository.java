package com.programming_with_al.al_operational_resources.demo.user.persistence;

import java.util.UUID;

import org.springframework.data.jpa.repository.JpaRepository;

public interface DemoUserRepository extends JpaRepository<DemoUserEntity, UUID> {

	boolean existsByEmailIgnoreCase(String email);
}
