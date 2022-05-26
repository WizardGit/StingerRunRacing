Shader "Unlit/Transparent Colored Golden" {
	Properties {
		_MainTex ("Main Tex", 2D) = "white" {}
		_MaskTex ("Mask Tex", 2D) = "black" {}
		_EffectsTex ("Effects Tex", 2D) = "black" {}
		_ColorR ("Color (R)", Vector) = (1,1,1,1)
		_USpeedR ("U Speed (R)", Float) = 0
		_VSpeedR ("V Speed (R)", Float) = 0
		_UTileR ("U Tile (R)", Float) = 1
		_VTileR ("V Tile (R)", Float) = 1
		_ColorG ("Color (G)", Vector) = (1,1,1,1)
		_USpeedG ("U Speed (G)", Float) = 0
		_VSpeedG ("V Speed (G)", Float) = 0
		_UTileG ("U Tile (G)", Float) = 1
		_VTileG ("V Tile (G)", Float) = 1
		_ColorB ("Color (B)", Vector) = (1,1,1,1)
		_USpeedB ("U Speed (B)", Float) = 0
		_VSpeedB ("V Speed (B)", Float) = 0
		_UTileB ("U Tile (B)", Float) = 1
		_VTileB ("V Tile (B)", Float) = 1
		_DistortionIntensity ("Distortion Intensity", Range(0, 2)) = 1
		_USpeedD ("U Speed (D)", Float) = 0
		_VSpeedD ("V Speed (D)", Float) = 0
		_UTileD ("U Tile (D)", Float) = 1
		_VTileD ("V Tile (D)", Float) = 1
		[HideInInspector] _Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
	}
	SubShader {
		LOD 100
		Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			LOD 100
			Tags { "CanUseSpriteAtlas" = "true" "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "PreviewType" = "Plane" "QUEUE" = "Transparent" "RenderType" = "Transparent" "SHADOWSUPPORT" = "true" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			Cull Off
			GpuProgramID 52107
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_0_1[7];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_1_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_1_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec2 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = unity_MatrixVP[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
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
						vec4 _MainTex_ST;
						vec4 _MaskTex_ST;
						vec4 _ColorG;
						float _USpeedG;
						float _VSpeedG;
						vec4 _EffectsTex_ST;
						float _USpeedR;
						float _VSpeedR;
						vec4 _ColorR;
						float _UTileG;
						float _VTileG;
						float _UTileR;
						float _VTileR;
						float _USpeedB;
						float _VSpeedB;
						float _UTileB;
						float _VTileB;
						vec4 _ColorB;
						float _USpeedD;
						float _VSpeedD;
						float _UTileD;
						float _VTileD;
						float _DistortionIntensity;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _EffectsTex;
					uniform  sampler2D _MaskTex;
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec2 u_xlat5;
					void main()
					{
					    u_xlat0.x = _TimeEditor.y + _Time.y;
					    u_xlat5.xy = u_xlat0.xx * vec2(_USpeedD, _VSpeedD);
					    u_xlat5.xy = vec2(_UTileD, _VTileD) * vs_TEXCOORD0.xy + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat1 = texture(_EffectsTex, u_xlat5.xy);
					    u_xlat5.xy = u_xlat1.xy + vec2(-0.5, -0.5);
					    u_xlat5.xy = u_xlat5.xy * vec2(_DistortionIntensity);
					    u_xlat1.xy = vs_TEXCOORD0.xy * _MaskTex_ST.xy + _MaskTex_ST.zw;
					    u_xlat1 = texture(_MaskTex, u_xlat1.xy);
					    u_xlat5.xy = u_xlat5.xy * u_xlat1.yy;
					    u_xlat5.xy = u_xlat5.xy * vec2(0.0250000004, 0.0250000004) + vs_TEXCOORD0.xy;
					    u_xlat5.xy = u_xlat5.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2 = texture(_MainTex, u_xlat5.xy);
					    u_xlat3 = vs_TEXCOORD0.xyxy * vec4(_UTileR, _VTileR, _UTileG, _VTileG);
					    u_xlat5.xy = vec2(_USpeedR, _VSpeedR) * u_xlat0.xx + u_xlat3.xy;
					    u_xlat3.xy = vec2(_USpeedG, _VSpeedG) * u_xlat0.xx + u_xlat3.zw;
					    u_xlat0.xw = u_xlat0.xx * vec2(_USpeedB, _VSpeedB);
					    u_xlat0.xw = vs_TEXCOORD0.xy * vec2(_UTileB, _VTileB) + u_xlat0.xw;
					    u_xlat0.xw = u_xlat0.xw * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat4 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat4.xyz = u_xlat4.zzz * _ColorB.xyz;
					    u_xlat0.xw = u_xlat3.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat3 = texture(_EffectsTex, u_xlat0.xw);
					    u_xlat3.xyz = u_xlat3.yyy * _ColorG.xyz;
					    u_xlat0.xy = u_xlat5.xy * _EffectsTex_ST.xy + _EffectsTex_ST.zw;
					    u_xlat0 = texture(_EffectsTex, u_xlat0.xy);
					    u_xlat0.xyz = u_xlat0.xxx * _ColorR.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.yyy + u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.zzz + u_xlat0.xyz;
					    return;
					}"
				}
			}
		}
	}
	CustomEditor "ShaderForgeMaterialInspector"
}