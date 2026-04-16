package com.programming_with_al.al_operational_resources.demo.user.application;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.programming_with_al.al_operational_resources.common.ConflictException;
import com.programming_with_al.al_operational_resources.demo.user.api.CreateUserRequest;
import com.programming_with_al.al_operational_resources.demo.user.api.DemoUserResponse;
import com.programming_with_al.al_operational_resources.demo.user.persistence.DemoUserEntity;
import com.programming_with_al.al_operational_resources.demo.user.persistence.DemoUserRepository;

@Service
public class DemoUserService {

	private static final String DUPLICATE_EMAIL_CODE = "USER_409_DUPLICATE_EMAIL";

	private final DemoUserRepository repository;

	public DemoUserService(DemoUserRepository repository) {
		this.repository = repository;
	}

	@Transactional
	public DemoUserResponse create(CreateUserRequest request) {
		final String email = request.email().trim();
		if (repository.existsByEmailIgnoreCase(email)) {
			throw new ConflictException(DUPLICATE_EMAIL_CODE, "Email already exists");
		}
		final DemoUserEntity entity = new DemoUserEntity();
		entity.setEmail(email);
		if (request.name() != null) {
			entity.setName(request.name().trim());
		}
		final DemoUserEntity saved = repository.save(entity);
		return new DemoUserResponse(saved.getId(), saved.getEmail(), saved.getName());
	}
}
