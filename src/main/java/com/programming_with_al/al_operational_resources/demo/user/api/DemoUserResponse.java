package com.programming_with_al.al_operational_resources.demo.user.api;

import java.util.UUID;

public record DemoUserResponse(UUID id, String email, String name) {
}
