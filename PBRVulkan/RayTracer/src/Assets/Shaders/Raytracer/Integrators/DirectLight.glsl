/*
 * Direct light estimator
 */

vec3 directLight(in Material material, in Ray ray)
{
	vec3 L      = vec3(0);
	float tMin  = 0.001;
	float tMax  = INFINITY;
	uint flags  = gl_RayFlagsTerminateOnFirstHitNV | gl_RayFlagsOpaqueNV | gl_RayFlagsSkipClosestHitShaderNV;

	BsdfSample bsdfSample;

	vec3 surfacePos = payload.worldPos + payload.ffnormal * EPS;

	/* Environment Light */
	if (ubo.useHDR)
	{
		#ifdef USE_HDR
		vec3 color     = vec3(0);
		vec4 dirPdf    = envSample(color);
		vec3 lightDir  = dirPdf.xyz;
		float lightPdf = dirPdf.w;

		isShadowed = true;

		traceNV(TLAS, flags, 0xFF, 0, 0, 1, surfacePos, tMin, lightDir, tMax, 1);

		if (!isShadowed)
		{
			float bsdfPdf = UE4Pdf(ray, material, lightDir);
			float cosTheta = abs(dot(lightDir, payload.ffnormal));
			vec3 F = UE4Eval(ray, material, lightDir);
			float misWeight = powerHeuristic(lightPdf, bsdfPdf);

			if (misWeight > 0.0)
				L += (misWeight * F * cosTheta * color) / lightPdf;
		}
		#endif
	}

	if (ubo.lights > 0)
	{
		Light light;
		int index = int(rnd(seed) * float(ubo.lights));
		light = Lights[index];

		vec3 sampled      = sampleLight(light);
		vec3 lightNormal  = normalize(cross(light.u, light.v));
		vec3 emission     = light.emission * float(ubo.lights);
		vec3 lightDir     = sampled - surfacePos;
		float lightDist   = length(lightDir);
		float lightDistSq = lightDist * lightDist;

		lightDir /= sqrt(lightDistSq);

		isShadowed = true;

		// The light is visible from the surface. Less than 90� between vectors.
		if (dot(payload.ffnormal, lightDir) > 0.f)
		{
			tMax = lightDist - EPS;
			traceNV(TLAS, flags, 0xFF, 0, 0, 1, surfacePos, tMin, lightDir, tMax, 1);
		}

		if (!isShadowed)
		{
			float bsdfPdf = UE4Pdf(ray, material, lightDir);
			float lightPdf = lightDistSq / (light.area.x * abs(dot(lightNormal, lightDir)));
			float cosTheta = abs(dot(payload.ffnormal, lightDir));
			vec3 F = UE4Eval(ray, material, lightDir);

			L += (powerHeuristic(lightPdf, bsdfPdf) * F * cosTheta * emission) / lightPdf;
		}
	}

	return L;
}