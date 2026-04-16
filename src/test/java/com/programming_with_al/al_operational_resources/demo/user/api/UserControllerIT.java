package com.programming_with_al.al_operational_resources.demo.user.api;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.jsonPath;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.MediaType;
import org.springframework.test.web.servlet.MockMvc;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.programming_with_al.al_operational_resources.demo.user.persistence.DemoUserRepository;

@SpringBootTest
@AutoConfigureMockMvc
@SuppressWarnings("null")
class UserControllerIT {

	@Autowired
	private MockMvc mockMvc;

	@Autowired
	private ObjectMapper objectMapper;

	@Autowired
	private DemoUserRepository repository;

	@BeforeEach
	void setUp() {
		repository.deleteAll();
	}

	@Test
	void create_returns201() throws Exception {
		mockMvc.perform(post("/api/v1/users")
				.contentType(MediaType.APPLICATION_JSON)
				.content(createBody("alice@example.com", "Alice").toString()))
				.andExpect(status().isCreated())
				.andExpect(jsonPath("$.id").isString())
				.andExpect(jsonPath("$.email").value("alice@example.com"))
				.andExpect(jsonPath("$.name").value("Alice"));
	}

	@Test
	void create_duplicateEmail_returnsConflict() throws Exception {
		mockMvc.perform(post("/api/v1/users")
				.contentType(MediaType.APPLICATION_JSON)
				.content(createBody("dup@example.com", null).toString()))
				.andExpect(status().isCreated());

		mockMvc.perform(post("/api/v1/users")
				.contentType(MediaType.APPLICATION_JSON)
				.content(createBody("DUP@example.com", "Other").toString()))
				.andExpect(status().isConflict())
				.andExpect(jsonPath("$.success").value(false))
				.andExpect(jsonPath("$.error.code").value("USER_409_DUPLICATE_EMAIL"));
	}

	@Test
	void create_invalidBody_returns400() throws Exception {
		mockMvc.perform(post("/api/v1/users")
				.contentType(MediaType.APPLICATION_JSON)
				.content("{}"))
				.andExpect(status().isBadRequest())
				.andExpect(jsonPath("$.success").value(false))
				.andExpect(jsonPath("$.error.code").value("COMMON_400_VALIDATION"));

		mockMvc.perform(post("/api/v1/users")
				.contentType(MediaType.APPLICATION_JSON)
				.content(createBody("not-an-email", null).toString()))
				.andExpect(status().isBadRequest())
				.andExpect(jsonPath("$.error.code").value("COMMON_400_VALIDATION"));

		mockMvc.perform(post("/api/v1/users")
				.contentType(MediaType.APPLICATION_JSON)
				.content(createBody("valid@example.com", "").toString()))
				.andExpect(status().isBadRequest())
				.andExpect(jsonPath("$.error.code").value("COMMON_400_VALIDATION"));
	}

	private ObjectNode createBody(String email, String name) {
		final ObjectNode body = objectMapper.createObjectNode();
		body.put("email", email);
		if (name != null) {
			body.put("name", name);
		}
		return body;
	}
}
