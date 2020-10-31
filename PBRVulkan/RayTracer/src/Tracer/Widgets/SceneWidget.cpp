#include "SceneWidget.h"

#include <imgui.h>

#include "../Menu.h"

namespace Interface
{
	void SceneWidget::Render(Tracer::Settings& settings)
	{
		const char* integrators[] = {
			"Path tracer",
			"SMS",
			"AO"
		};

		const char* scenes[] = {
			"Ajax",
			"Bedroom",
			"Boy",
			"Coffee cart",
			"Coffee maker",
			"Cornell box",
			"Dining room",
			"Dragon",
			"Hyperion",
			"Panther",
			"Spaceship",
			"Staircase",
			"Stormtroopers",
			"Teapot"
		};

		ImGui::Text("Shaders");

		ImGui::PushItemWidth(-1);
		ImGui::Combo(" ", &settings.IntegratorType, integrators, 3);
		ImGui::PopItemWidth();

		if (settings.IntegratorType == 2)
		{
			ImGui::Text("AO ray length");
			ImGui::SameLine();
			ImGui::InputFloat("AO_samples", &settings.AORayLength, 0.01);
		}

		ImGui::Text("Scene");

		ImGui::PushItemWidth(-1);
		ImGui::Combo("  ", &settings.SceneId, scenes, 14);
		ImGui::PopItemWidth();
	}
}
