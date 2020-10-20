/*
 *  Global structure used in shaders
 */

#define PI        3.14159265358979323
#define TWO_PI    6.28318530717958648

struct Material 
{ 
	vec4 albedo;
	vec4 emission;
	// Parameters
	float metallic;
	float roughness;
	float ior;
	float transmittance;
	// Textures
	int albedoTexID;
	int metallicRoughnessTexID;
	int normalmapTexID;
	int heightmapTexID;
};

struct Light 
{ 
	vec3 position; 
	vec3 emission; 
	vec3 u; 
	vec3 v; 
	vec3 radiusAreaType; 
};

struct Uniform
{
	mat4 view;
	mat4 proj;
	vec3 direction;
	vec2 random;
	uint lights;
	bool useHDR;
	uint spp;
	uint maxDepth;
};

struct RayPayload
{
	vec3 color;
	vec3 direction;
};
