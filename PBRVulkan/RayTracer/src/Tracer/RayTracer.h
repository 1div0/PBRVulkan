#pragma once

#include "../Vulkan/Application.h"

namespace Tracer
{
	class RayTracer final : public Vulkan::Application
	{
	public:
		RayTracer();
		~RayTracer();

		void Run() override;

	private:
		void RegisterCallbacks();
		void Render(VkFramebuffer framebuffer, VkCommandBuffer commandBuffer) override;
		void OnKeyChanged(int key, int scancode, int action, int mods) override;
		void OnCursorPositionChanged(double xpos, double ypos) override;
		void OnMouseButtonChanged(int button, int action, int mods) override;
		void OnScrollChanged(double xoffset, double yoffset) override;

		std::unique_ptr<class Menu> menu;
	};
}
