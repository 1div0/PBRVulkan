#pragma once

#include <glm/glm.hpp>

namespace Uniforms
{
	struct Global
	{
		glm::mat4 view = glm::mat4(1.f);
		glm::mat4 projection = glm::mat4(1.f);
		glm::vec3 direction{};
		alignas(16) glm::vec2 random{};
		uint32_t lights{};
		uint32_t hasHDR{};
	};
}
