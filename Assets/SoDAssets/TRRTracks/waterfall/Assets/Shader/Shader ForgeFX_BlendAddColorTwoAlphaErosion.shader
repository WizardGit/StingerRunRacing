Shader "Shader Forge/FX_BlendAddColorTwoAlphaErosion" {
	Properties {
		_USpeedA ("U Speed A", Float) = 0
		_VSpeedA ("V Speed A", Float) = 0
		_USpeedB ("U Speed B", Float) = 0
		_VSpeedB ("V Speed B", Float) = 0
		_TexA ("Tex A", 2D) = "white" {}
		_TexB ("Tex B", 2D) = "white" {}
		_DistortionTex ("Distortion Tex", 2D) = "black" {}
		_USpeedD ("U Speed D", Float) = 0
		_VSpeedD ("V Speed D", Float) = 0
		_DistortionIntensity ("Distortion Intensity", Range(0, 2)) = 0
		[HideInInspector] _Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent+10" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent+10" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
			ZWrite Off
			GpuProgramID 37582
			Program "vp" {
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform UnityPerFrame {
						vec4 unused_0_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_0_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_COLOR0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_COLOR0;
					vec4 u_xlat0;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * in_POSITION0.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD0 = in_TEXCOORD0;
					    vs_COLOR0 = in_COLOR0;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _TimeEditor;
						float _USpeedA;
						float _VSpeedA;
						float _VSpeedB;
						float _USpeedB;
						vec4 _TexA_ST;
						vec4 _TexB_ST;
						vec4 _DistortionTex_ST;
						float _USpeedD;
						float _VSpeedD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _DistortionTex;
					uniform  sampler2D _TexA;
					uniform  sampler2D _TexB;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_COLOR0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec2 u_xlat2;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat2.xy = vec2(_USpeedD, _VSpeedD) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat2.xy * _DistortionTex_ST.xy + _DistortionTex_ST.zw;
					    u_xlat1 = texture(_DistortionTex, u_xlat2.xy);
					    u_xlat2.xy = vec2(_USpeedA, _VSpeedA) * u_xlat0.xx + vs_TEXCOORD0.xy;
					    u_xlat2.xy = u_xlat1.xy * vec2(vec2(_DistortionIntensity, _DistortionIntensity)) + u_xlat2.xy;
					    u_xlat2.xy = u_xlat2.xy * _TexA_ST.xy + _TexA_ST.zw;
					    u_xlat1 = texture(_TexA, u_xlat2.xy);
					    u_xlat2.xy = vs_TEXCOORD0.ww + vs_TEXCOORD0.xy;
					    u_xlat0.xy = vec2(_USpeedB, _VSpeedB) * u_xlat0.xx + u_xlat2.xy;
					    u_xlat0.xy = u_xlat0.xy * _TexB_ST.xy + _TexB_ST.zw;
					    u_xlat0 = texture(_TexB, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat0 = u_xlat0 * vec4(2.5, 2.5, 2.5, 2.5);
					    u_xlat0 = (-u_xlat0) * vs_COLOR0 + vec4(1.0, 1.0, 1.0, 1.0);
					    SV_Target0 = (-u_xlat0) + vs_TEXCOORD0.zzzz;
					    SV_Target0 = clamp(SV_Target0, 0.0, 1.0);
					    return;
					}"
				}
			}
		}
	}
	CustomEditor "ShaderForgeMaterialInspector"
}