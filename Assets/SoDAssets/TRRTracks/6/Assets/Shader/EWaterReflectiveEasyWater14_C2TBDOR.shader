Shader "EWater/Reflective/EasyWater14_C2TBDOR" {
	Properties {
		_Color ("_Color", Vector) = (1,1,1,1)
		_Texture1 ("_Texture1", 2D) = "black" {}
		_BumpMap1 ("_BumpMap1", 2D) = "black" {}
		_Texture2 ("_Texture2", 2D) = "black" {}
		_BumpMap2 ("_BumpMap2", 2D) = "black" {}
		_MainTexSpeed ("_MainTexSpeed", Float) = 0
		_Bump1Speed ("_Bump1Speed", Float) = 0
		_Texture2Speed ("_Texture2Speed", Float) = 0
		_Bump2Speed ("_Bump2Speed", Float) = 0
		_DistortionMap ("_DistortionMap", 2D) = "black" {}
		_DistortionSpeed ("_DistortionSpeed", Float) = 0
		_DistortionPower ("_DistortionPower", Range(0, 0.02)) = 0
		_Specular ("_Specular", Range(0, 7)) = 1
		_Gloss ("_Gloss", Range(0.3, 2)) = 0.3
		_Opacity ("_Opacity", Range(-0.2, 1)) = 0
		_Reflection ("_Reflection", 2D) = "black" {}
		_ReflectPower ("_ReflectPower", Range(0, 0.8)) = 0
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha OneMinusSrcAlpha, SrcAlpha OneMinusSrcAlpha
			ColorMask RGB -1
			ZWrite Off
			GpuProgramID 17884
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
					    vs_TEXCOORD9 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
					    vs_TEXCOORD9 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
					    vs_TEXCOORD9 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_8[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD4.z = u_xlat2.y;
					    vs_TEXCOORD5.z = u_xlat2.z;
					    u_xlat0.x = u_xlat2.y * u_xlat2.y;
					    u_xlat0.x = u_xlat2.x * u_xlat2.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat0.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat1.x = dot(unity_SHAr, u_xlat2);
					    u_xlat1.y = dot(unity_SHAg, u_xlat2);
					    u_xlat1.z = dot(unity_SHAb, u_xlat2);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD9 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_8[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD4.z = u_xlat2.y;
					    vs_TEXCOORD5.z = u_xlat2.z;
					    u_xlat0.x = u_xlat2.y * u_xlat2.y;
					    u_xlat0.x = u_xlat2.x * u_xlat2.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat0.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat1.x = dot(unity_SHAr, u_xlat2);
					    u_xlat1.y = dot(unity_SHAg, u_xlat2);
					    u_xlat1.z = dot(unity_SHAb, u_xlat2);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD9 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_8[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD4.z = u_xlat2.y;
					    vs_TEXCOORD5.z = u_xlat2.z;
					    u_xlat0.x = u_xlat2.y * u_xlat2.y;
					    u_xlat0.x = u_xlat2.x * u_xlat2.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat0.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat1.x = dot(unity_SHAr, u_xlat2);
					    u_xlat1.y = dot(unity_SHAg, u_xlat2);
					    u_xlat1.z = dot(unity_SHAb, u_xlat2);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD9 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[31];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_14[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD4.z = u_xlat2.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD5.z = u_xlat2.z;
					    u_xlat18 = u_xlat2.y * u_xlat2.y;
					    u_xlat18 = u_xlat2.x * u_xlat2.x + (-u_xlat18);
					    u_xlat1 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat3.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat3.x = dot(unity_SHAr, u_xlat2);
					    u_xlat3.y = dot(unity_SHAg, u_xlat2);
					    u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat3.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat4 = u_xlat2.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat5 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat5 * u_xlat2.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat4;
					    u_xlat3 = u_xlat5 * u_xlat5 + u_xlat3;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD6.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD9 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[31];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_14[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD4.z = u_xlat2.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD5.z = u_xlat2.z;
					    u_xlat18 = u_xlat2.y * u_xlat2.y;
					    u_xlat18 = u_xlat2.x * u_xlat2.x + (-u_xlat18);
					    u_xlat1 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat3.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat3.x = dot(unity_SHAr, u_xlat2);
					    u_xlat3.y = dot(unity_SHAg, u_xlat2);
					    u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat3.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat4 = u_xlat2.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat5 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat5 * u_xlat2.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat4;
					    u_xlat3 = u_xlat5 * u_xlat5 + u_xlat3;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD6.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD9 = vec4(0.0, 0.0, 0.0, 0.0);
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[31];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_14[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD4.z = u_xlat2.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD5.z = u_xlat2.z;
					    u_xlat18 = u_xlat2.y * u_xlat2.y;
					    u_xlat18 = u_xlat2.x * u_xlat2.x + (-u_xlat18);
					    u_xlat1 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat3.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat3.x = dot(unity_SHAr, u_xlat2);
					    u_xlat3.y = dot(unity_SHAg, u_xlat2);
					    u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat3.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat4 = u_xlat2.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat5 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat5 * u_xlat2.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat4;
					    u_xlat3 = u_xlat5 * u_xlat5 + u_xlat3;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD6.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD9 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
					    vs_TEXCOORD9 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
					    vs_TEXCOORD9 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = vec3(0.0, 0.0, 0.0);
					    vs_TEXCOORD9 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_8[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD4.z = u_xlat2.y;
					    vs_TEXCOORD5.z = u_xlat2.z;
					    u_xlat0.x = u_xlat2.y * u_xlat2.y;
					    u_xlat0.x = u_xlat2.x * u_xlat2.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat0.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat1.x = dot(unity_SHAr, u_xlat2);
					    u_xlat1.y = dot(unity_SHAg, u_xlat2);
					    u_xlat1.z = dot(unity_SHAb, u_xlat2);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD9 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_8[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD4.z = u_xlat2.y;
					    vs_TEXCOORD5.z = u_xlat2.z;
					    u_xlat0.x = u_xlat2.y * u_xlat2.y;
					    u_xlat0.x = u_xlat2.x * u_xlat2.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat0.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat1.x = dot(unity_SHAr, u_xlat2);
					    u_xlat1.y = dot(unity_SHAg, u_xlat2);
					    u_xlat1.z = dot(unity_SHAb, u_xlat2);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD9 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_8[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat2.xyz = vec3(u_xlat12) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD4.z = u_xlat2.y;
					    vs_TEXCOORD5.z = u_xlat2.z;
					    u_xlat0.x = u_xlat2.y * u_xlat2.y;
					    u_xlat0.x = u_xlat2.x * u_xlat2.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat0.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat1.x = dot(unity_SHAr, u_xlat2);
					    u_xlat1.y = dot(unity_SHAg, u_xlat2);
					    u_xlat1.z = dot(unity_SHAb, u_xlat2);
					    u_xlat0.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD6.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD9 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat0.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat2.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = u_xlat0.xxx * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[31];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_14[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD4.z = u_xlat2.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD5.z = u_xlat2.z;
					    u_xlat18 = u_xlat2.y * u_xlat2.y;
					    u_xlat18 = u_xlat2.x * u_xlat2.x + (-u_xlat18);
					    u_xlat1 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat3.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat3.x = dot(unity_SHAr, u_xlat2);
					    u_xlat3.y = dot(unity_SHAg, u_xlat2);
					    u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat3.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat4 = u_xlat2.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat5 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat5 * u_xlat2.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat4;
					    u_xlat3 = u_xlat5 * u_xlat5 + u_xlat3;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD6.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD9 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[31];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_14[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD4.z = u_xlat2.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD5.z = u_xlat2.z;
					    u_xlat18 = u_xlat2.y * u_xlat2.y;
					    u_xlat18 = u_xlat2.x * u_xlat2.x + (-u_xlat18);
					    u_xlat1 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat3.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat3.x = dot(unity_SHAr, u_xlat2);
					    u_xlat3.y = dot(unity_SHAg, u_xlat2);
					    u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat3.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat4 = u_xlat2.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat5 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat5 * u_xlat2.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat4;
					    u_xlat3 = u_xlat5 * u_xlat5 + u_xlat3;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD6.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD9 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[31];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_14[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_2_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD7;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD9;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					float u_xlat19;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD7 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    vs_TEXCOORD3.w = u_xlat0.x;
					    u_xlat18 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat19 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat19 = inversesqrt(u_xlat19);
					    u_xlat2.xyz = vec3(u_xlat19) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.zxy;
					    u_xlat3.xyz = u_xlat2.yzx * u_xlat1.yzx + (-u_xlat3.xyz);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.z = u_xlat2.x;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.w = u_xlat0.y;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD4.z = u_xlat2.y;
					    vs_TEXCOORD5.w = u_xlat0.z;
					    vs_TEXCOORD5.z = u_xlat2.z;
					    u_xlat18 = u_xlat2.y * u_xlat2.y;
					    u_xlat18 = u_xlat2.x * u_xlat2.x + (-u_xlat18);
					    u_xlat1 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat1);
					    u_xlat3.y = dot(unity_SHBg, u_xlat1);
					    u_xlat3.z = dot(unity_SHBb, u_xlat1);
					    u_xlat1.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat3.xyz;
					    u_xlat2.w = 1.0;
					    u_xlat3.x = dot(unity_SHAr, u_xlat2);
					    u_xlat3.y = dot(unity_SHAg, u_xlat2);
					    u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    u_xlat1.xyz = u_xlat1.xyz + u_xlat3.xyz;
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat1.xyz = log2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat1.xyz = exp2(u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat1.xyz = max(u_xlat1.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat4 = u_xlat2.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat5 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat5 * u_xlat2.xxxx + u_xlat4;
					    u_xlat2 = u_xlat0 * u_xlat2.zzzz + u_xlat4;
					    u_xlat3 = u_xlat5 * u_xlat5 + u_xlat3;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat2 = u_xlat2 * u_xlat3;
					    u_xlat2 = max(u_xlat2, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat2;
					    u_xlat2.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat2.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat2.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD6.xyz = u_xlat0.xyz + u_xlat1.xyz;
					    vs_TEXCOORD9 = vec4(0.0, 0.0, 0.0, 0.0);
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat10;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat16) + _WorldSpaceLightPos0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat16 = max(u_xlat16, 0.0);
					    u_xlat16 = log2(u_xlat16);
					    u_xlat2.x = _Gloss * 128.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat2.x = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = dot(vec2(u_xlat16), vec2(vec2(_Specular, _Specular)));
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat4.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat4.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat4.xy;
					    u_xlat4 = texture(_Texture2, u_xlat4.xy);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD6.xyz;
					    u_xlat3.w = 0.0;
					    u_xlat5.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat5.xyz = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat5.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat5.xyz;
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat10.x = u_xlat5.x * u_xlat1.z;
					    u_xlat5.x = (-u_xlat1.z) * u_xlat5.x + 1.0;
					    u_xlat5.x = u_xlat5.x * _ReflectPower;
					    u_xlat2.w = _Opacity * 2.0 + (-u_xlat10.x);
					    u_xlat2 = u_xlat2 + u_xlat3;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10.x = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(1.0, 1.0);
					    u_xlat0.xz = u_xlat10.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat1 = texture(_Reflection, u_xlat0.xz);
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat5.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat10;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat16) + _WorldSpaceLightPos0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat16 = max(u_xlat16, 0.0);
					    u_xlat16 = log2(u_xlat16);
					    u_xlat2.x = _Gloss * 128.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat2.x = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = dot(vec2(u_xlat16), vec2(vec2(_Specular, _Specular)));
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat4.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat4.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat4.xy;
					    u_xlat4 = texture(_Texture2, u_xlat4.xy);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD6.xyz;
					    u_xlat3.w = 0.0;
					    u_xlat5.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat5.xyz = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat5.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat5.xyz;
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat10.x = u_xlat5.x * u_xlat1.z;
					    u_xlat5.x = (-u_xlat1.z) * u_xlat5.x + 1.0;
					    u_xlat5.x = u_xlat5.x * _ReflectPower;
					    u_xlat2.w = _Opacity * 2.0 + (-u_xlat10.x);
					    u_xlat2 = u_xlat2 + u_xlat3;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10.x = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(1.0, 1.0);
					    u_xlat0.xz = u_xlat10.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat1 = texture(_Reflection, u_xlat0.xz);
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat5.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat10;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat16) + _WorldSpaceLightPos0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat16 = max(u_xlat16, 0.0);
					    u_xlat16 = log2(u_xlat16);
					    u_xlat2.x = _Gloss * 128.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat2.x = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = dot(vec2(u_xlat16), vec2(vec2(_Specular, _Specular)));
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat4.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat4.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat4.xy;
					    u_xlat4 = texture(_Texture2, u_xlat4.xy);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD6.xyz;
					    u_xlat3.w = 0.0;
					    u_xlat5.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat5.xyz = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat5.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat5.xyz;
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat10.x = u_xlat5.x * u_xlat1.z;
					    u_xlat5.x = (-u_xlat1.z) * u_xlat5.x + 1.0;
					    u_xlat5.x = u_xlat5.x * _ReflectPower;
					    u_xlat2.w = _Opacity * 2.0 + (-u_xlat10.x);
					    u_xlat2 = u_xlat2 + u_xlat3;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10.x = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(1.0, 1.0);
					    u_xlat0.xz = u_xlat10.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat1 = texture(_Reflection, u_xlat0.xz);
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat5.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat10;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat16) + _WorldSpaceLightPos0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat16 = max(u_xlat16, 0.0);
					    u_xlat16 = log2(u_xlat16);
					    u_xlat2.x = _Gloss * 128.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat2.x = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = dot(vec2(u_xlat16), vec2(vec2(_Specular, _Specular)));
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat4.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat4.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat4.xy;
					    u_xlat4 = texture(_Texture2, u_xlat4.xy);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD6.xyz;
					    u_xlat3.w = 0.0;
					    u_xlat5.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat5.xyz = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat5.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat5.xyz;
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat10.x = u_xlat5.x * u_xlat1.z;
					    u_xlat5.x = (-u_xlat1.z) * u_xlat5.x + 1.0;
					    u_xlat5.x = u_xlat5.x * _ReflectPower;
					    u_xlat2.w = _Opacity * 2.0 + (-u_xlat10.x);
					    u_xlat2 = u_xlat2 + u_xlat3;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10.x = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(1.0, 1.0);
					    u_xlat0.xz = u_xlat10.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat1 = texture(_Reflection, u_xlat0.xz);
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat5.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat10;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat16) + _WorldSpaceLightPos0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat16 = max(u_xlat16, 0.0);
					    u_xlat16 = log2(u_xlat16);
					    u_xlat2.x = _Gloss * 128.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat2.x = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = dot(vec2(u_xlat16), vec2(vec2(_Specular, _Specular)));
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat4.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat4.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat4.xy;
					    u_xlat4 = texture(_Texture2, u_xlat4.xy);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD6.xyz;
					    u_xlat3.w = 0.0;
					    u_xlat5.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat5.xyz = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat5.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat5.xyz;
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat10.x = u_xlat5.x * u_xlat1.z;
					    u_xlat5.x = (-u_xlat1.z) * u_xlat5.x + 1.0;
					    u_xlat5.x = u_xlat5.x * _ReflectPower;
					    u_xlat2.w = _Opacity * 2.0 + (-u_xlat10.x);
					    u_xlat2 = u_xlat2 + u_xlat3;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10.x = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(1.0, 1.0);
					    u_xlat0.xz = u_xlat10.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat1 = texture(_Reflection, u_xlat0.xz);
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat5.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat10;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat16) + _WorldSpaceLightPos0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat16 = max(u_xlat16, 0.0);
					    u_xlat16 = log2(u_xlat16);
					    u_xlat2.x = _Gloss * 128.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat2.x = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = dot(vec2(u_xlat16), vec2(vec2(_Specular, _Specular)));
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat4.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat4.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat4.xy;
					    u_xlat4 = texture(_Texture2, u_xlat4.xy);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD6.xyz;
					    u_xlat3.w = 0.0;
					    u_xlat5.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat5.xyz = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat5.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat5.xyz;
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat10.x = u_xlat5.x * u_xlat1.z;
					    u_xlat5.x = (-u_xlat1.z) * u_xlat5.x + 1.0;
					    u_xlat5.x = u_xlat5.x * _ReflectPower;
					    u_xlat2.w = _Opacity * 2.0 + (-u_xlat10.x);
					    u_xlat2 = u_xlat2 + u_xlat3;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10.x = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(1.0, 1.0);
					    u_xlat0.xz = u_xlat10.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat1 = texture(_Reflection, u_xlat0.xz);
					    SV_Target0.xyz = u_xlat1.xyz * u_xlat5.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat10;
					float u_xlat15;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat16) + _WorldSpaceLightPos0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat16 = max(u_xlat16, 0.0);
					    u_xlat16 = log2(u_xlat16);
					    u_xlat2.x = _Gloss * 128.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat2.x = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = dot(vec2(u_xlat16), vec2(vec2(_Specular, _Specular)));
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat4.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat4.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat4.xy;
					    u_xlat4 = texture(_Texture2, u_xlat4.xy);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD6.xyz;
					    u_xlat3.w = 0.0;
					    u_xlat5.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat5.xyz = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat5.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat5.xyz;
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat10.x = u_xlat5.x * u_xlat1.z;
					    u_xlat5.x = (-u_xlat1.z) * u_xlat5.x + 1.0;
					    u_xlat5.x = u_xlat5.x * _ReflectPower;
					    u_xlat2.w = _Opacity * 2.0 + (-u_xlat10.x);
					    u_xlat2 = u_xlat2 + u_xlat3;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10.x = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(1.0, 1.0);
					    u_xlat0.xz = u_xlat10.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat1 = texture(_Reflection, u_xlat0.xz);
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat5.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat10;
					float u_xlat15;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat16) + _WorldSpaceLightPos0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat16 = max(u_xlat16, 0.0);
					    u_xlat16 = log2(u_xlat16);
					    u_xlat2.x = _Gloss * 128.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat2.x = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = dot(vec2(u_xlat16), vec2(vec2(_Specular, _Specular)));
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat4.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat4.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat4.xy;
					    u_xlat4 = texture(_Texture2, u_xlat4.xy);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD6.xyz;
					    u_xlat3.w = 0.0;
					    u_xlat5.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat5.xyz = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat5.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat5.xyz;
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat10.x = u_xlat5.x * u_xlat1.z;
					    u_xlat5.x = (-u_xlat1.z) * u_xlat5.x + 1.0;
					    u_xlat5.x = u_xlat5.x * _ReflectPower;
					    u_xlat2.w = _Opacity * 2.0 + (-u_xlat10.x);
					    u_xlat2 = u_xlat2 + u_xlat3;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10.x = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(1.0, 1.0);
					    u_xlat0.xz = u_xlat10.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat1 = texture(_Reflection, u_xlat0.xz);
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat5.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat10;
					float u_xlat15;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat16) + _WorldSpaceLightPos0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat16 = max(u_xlat16, 0.0);
					    u_xlat16 = log2(u_xlat16);
					    u_xlat2.x = _Gloss * 128.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat2.x = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = dot(vec2(u_xlat16), vec2(vec2(_Specular, _Specular)));
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat4.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat4.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat4.xy;
					    u_xlat4 = texture(_Texture2, u_xlat4.xy);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD6.xyz;
					    u_xlat3.w = 0.0;
					    u_xlat5.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat5.xyz = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat5.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat5.xyz;
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat10.x = u_xlat5.x * u_xlat1.z;
					    u_xlat5.x = (-u_xlat1.z) * u_xlat5.x + 1.0;
					    u_xlat5.x = u_xlat5.x * _ReflectPower;
					    u_xlat2.w = _Opacity * 2.0 + (-u_xlat10.x);
					    u_xlat2 = u_xlat2 + u_xlat3;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10.x = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(1.0, 1.0);
					    u_xlat0.xz = u_xlat10.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat1 = texture(_Reflection, u_xlat0.xz);
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat5.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat10;
					float u_xlat15;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat16) + _WorldSpaceLightPos0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat16 = max(u_xlat16, 0.0);
					    u_xlat16 = log2(u_xlat16);
					    u_xlat2.x = _Gloss * 128.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat2.x = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = dot(vec2(u_xlat16), vec2(vec2(_Specular, _Specular)));
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat4.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat4.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat4.xy;
					    u_xlat4 = texture(_Texture2, u_xlat4.xy);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD6.xyz;
					    u_xlat3.w = 0.0;
					    u_xlat5.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat5.xyz = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat5.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat5.xyz;
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat10.x = u_xlat5.x * u_xlat1.z;
					    u_xlat5.x = (-u_xlat1.z) * u_xlat5.x + 1.0;
					    u_xlat5.x = u_xlat5.x * _ReflectPower;
					    u_xlat2.w = _Opacity * 2.0 + (-u_xlat10.x);
					    u_xlat2 = u_xlat2 + u_xlat3;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10.x = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(1.0, 1.0);
					    u_xlat0.xz = u_xlat10.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat1 = texture(_Reflection, u_xlat0.xz);
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat5.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat10;
					float u_xlat15;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat16) + _WorldSpaceLightPos0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat16 = max(u_xlat16, 0.0);
					    u_xlat16 = log2(u_xlat16);
					    u_xlat2.x = _Gloss * 128.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat2.x = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = dot(vec2(u_xlat16), vec2(vec2(_Specular, _Specular)));
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat4.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat4.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat4.xy;
					    u_xlat4 = texture(_Texture2, u_xlat4.xy);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD6.xyz;
					    u_xlat3.w = 0.0;
					    u_xlat5.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat5.xyz = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat5.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat5.xyz;
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat10.x = u_xlat5.x * u_xlat1.z;
					    u_xlat5.x = (-u_xlat1.z) * u_xlat5.x + 1.0;
					    u_xlat5.x = u_xlat5.x * _ReflectPower;
					    u_xlat2.w = _Opacity * 2.0 + (-u_xlat10.x);
					    u_xlat2 = u_xlat2 + u_xlat3;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10.x = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(1.0, 1.0);
					    u_xlat0.xz = u_xlat10.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat1 = texture(_Reflection, u_xlat0.xz);
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat5.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTPROBE_SH" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat10;
					float u_xlat15;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat16) + _WorldSpaceLightPos0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat16 = max(u_xlat16, 0.0);
					    u_xlat16 = log2(u_xlat16);
					    u_xlat2.x = _Gloss * 128.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat2.x = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = dot(vec2(u_xlat16), vec2(vec2(_Specular, _Specular)));
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat4.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat4.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat4.xy;
					    u_xlat4 = texture(_Texture2, u_xlat4.xy);
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vs_TEXCOORD6.xyz;
					    u_xlat3.w = 0.0;
					    u_xlat5.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat5.xyz = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat5.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat5.xyz;
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat10.x = u_xlat5.x * u_xlat1.z;
					    u_xlat5.x = (-u_xlat1.z) * u_xlat5.x + 1.0;
					    u_xlat5.x = u_xlat5.x * _ReflectPower;
					    u_xlat2.w = _Opacity * 2.0 + (-u_xlat10.x);
					    u_xlat2 = u_xlat2 + u_xlat3;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10.x = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat10.xy = u_xlat1.xy * u_xlat10.xx + vec2(1.0, 1.0);
					    u_xlat0.xz = u_xlat10.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat1 = texture(_Reflection, u_xlat0.xz);
					    u_xlat0.xyz = u_xlat1.xyz * u_xlat5.xxx + u_xlat2.xyz;
					    SV_Target0.w = u_xlat2.w;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat15 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = vec3(u_xlat15) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.x;
					    u_xlat9 = u_xlat9 * (-u_xlat9);
					    u_xlat9 = exp2(u_xlat9);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.x;
					    u_xlat9 = u_xlat9 * (-u_xlat9);
					    u_xlat9 = exp2(u_xlat9);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.x;
					    u_xlat9 = u_xlat9 * (-u_xlat9);
					    u_xlat9 = exp2(u_xlat9);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.x;
					    u_xlat9 = u_xlat9 * (-u_xlat9);
					    u_xlat9 = exp2(u_xlat9);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.x;
					    u_xlat9 = u_xlat9 * (-u_xlat9);
					    u_xlat9 = exp2(u_xlat9);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" "LIGHTPROBE_SH" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.x;
					    u_xlat9 = u_xlat9 * (-u_xlat9);
					    u_xlat9 = exp2(u_xlat9);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.x;
					    u_xlat9 = u_xlat9 * (-u_xlat9);
					    u_xlat9 = exp2(u_xlat9);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.x;
					    u_xlat9 = u_xlat9 * (-u_xlat9);
					    u_xlat9 = exp2(u_xlat9);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.x;
					    u_xlat9 = u_xlat9 * (-u_xlat9);
					    u_xlat9 = exp2(u_xlat9);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.x;
					    u_xlat9 = u_xlat9 * (-u_xlat9);
					    u_xlat9 = exp2(u_xlat9);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.x;
					    u_xlat9 = u_xlat9 * (-u_xlat9);
					    u_xlat9 = exp2(u_xlat9);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "LIGHTMAP_ON" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
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
						vec4 unity_Lightmap_HDR;
						vec4 unused_0_1[3];
						vec4 _Color;
						float _MainTexSpeed;
						float _Texture2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Opacity;
						float _ReflectPower;
						vec4 unused_0_9[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Reflection;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D unity_Lightmap;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  float vs_TEXCOORD7;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec4 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat1 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat0.x = u_xlat0.x * _DistortionPower;
					    u_xlat0.x = u_xlat0.x * 5.0;
					    u_xlat3.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat3.xy;
					    u_xlat2 = texture(_Texture2, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat1.x = vs_TEXCOORD3.w;
					    u_xlat1.y = vs_TEXCOORD4.w;
					    u_xlat1.z = vs_TEXCOORD5.w;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat1.xyw = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat2.xyz;
					    u_xlat1.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat1.xyw;
					    u_xlat1.w = u_xlat1.z * 10.0;
					    u_xlat10 = dot(u_xlat1.xyw, u_xlat1.xyw);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat2.xy = u_xlat1.xy * vec2(u_xlat10) + vec2(1.0, 1.0);
					    u_xlat2.xy = u_xlat2.xy * vec2(0.5, 0.5) + u_xlat0.xx;
					    u_xlat2 = texture(_Reflection, u_xlat2.xy);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.x = (-u_xlat1.z) * u_xlat0.x + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat1.z;
					    SV_Target0.w = _Opacity * 2.0 + (-u_xlat0.x);
					    u_xlat0.x = u_xlat1.x * _ReflectPower;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat2.xyz;
					    u_xlat2 = texture(unity_Lightmap, vs_TEXCOORD6.xy);
					    u_xlat0.x = u_xlat2.w * unity_Lightmap_HDR.x;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat0.xxx;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    u_xlat9 = vs_TEXCOORD7 / _ProjectionParams.y;
					    u_xlat9 = (-u_xlat9) + 1.0;
					    u_xlat9 = u_xlat9 * _ProjectionParams.z;
					    u_xlat9 = max(u_xlat9, 0.0);
					    u_xlat9 = u_xlat9 * unity_FogParams.x;
					    u_xlat9 = u_xlat9 * (-u_xlat9);
					    u_xlat9 = exp2(u_xlat9);
					    SV_Target0.xyz = vec3(u_xlat9) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "FORWARD"
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend SrcAlpha One, SrcAlpha One
			ColorMask RGB -1
			ZWrite Off
			GpuProgramID 70679
			Program "vp" {
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD3.y = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat0.y;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.z = u_xlat0.z;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD4.y = u_xlat2.y;
					    vs_TEXCOORD5.y = u_xlat2.z;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD3.y = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat0.y;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.z = u_xlat0.z;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD4.y = u_xlat2.y;
					    vs_TEXCOORD5.y = u_xlat2.z;
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD3.y = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat0.y;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.z = u_xlat0.z;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD4.y = u_xlat2.y;
					    vs_TEXCOORD5.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SPOT" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SPOT" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SPOT" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT_COOKIE" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT_COOKIE" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT_COOKIE" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD7.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD3.y = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat0.y;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.z = u_xlat0.z;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD4.y = u_xlat2.y;
					    vs_TEXCOORD5.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD7.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD3.y = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat0.y;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.z = u_xlat0.z;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD4.y = u_xlat2.y;
					    vs_TEXCOORD5.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD7.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD3.y = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat0.y;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.z = u_xlat0.z;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD4.y = u_xlat2.y;
					    vs_TEXCOORD5.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "FOG_EXP2" "POINT" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "FOG_EXP2" "POINT" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "FOG_EXP2" "POINT" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD8 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD3.y = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat0.y;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.z = u_xlat0.z;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD4.y = u_xlat2.y;
					    vs_TEXCOORD5.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD8 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD3.y = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat0.y;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.z = u_xlat0.z;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD4.y = u_xlat2.y;
					    vs_TEXCOORD5.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[8];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD8 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD3.y = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat0.y;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.z = u_xlat0.z;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD4.y = u_xlat2.y;
					    vs_TEXCOORD5.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "FOG_EXP2" "SPOT" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "FOG_EXP2" "SPOT" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "FOG_EXP2" "SPOT" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "FOG_EXP2" "POINT_COOKIE" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "FOG_EXP2" "POINT_COOKIE" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "FOG_EXP2" "POINT_COOKIE" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD3.y = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat2.z;
					    vs_TEXCOORD3.z = u_xlat1.y;
					    vs_TEXCOORD4.x = u_xlat2.x;
					    vs_TEXCOORD5.x = u_xlat2.y;
					    vs_TEXCOORD4.z = u_xlat1.z;
					    vs_TEXCOORD5.z = u_xlat1.x;
					    vs_TEXCOORD4.y = u_xlat3.y;
					    vs_TEXCOORD5.y = u_xlat3.z;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP2" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD7.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD3.y = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat0.y;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.z = u_xlat0.z;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD4.y = u_xlat2.y;
					    vs_TEXCOORD5.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP2" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD7.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD3.y = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat0.y;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.z = u_xlat0.z;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD4.y = u_xlat2.y;
					    vs_TEXCOORD5.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP2" }
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
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2[4];
						vec4 _DistortionMap_ST;
						vec4 _Texture1_ST;
						vec4 _Texture2_ST;
						vec4 _BumpMap1_ST;
						vec4 _BumpMap2_ST;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
						vec4 unused_1_4;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec2 vs_TEXCOORD2;
					out vec2 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD3;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD8 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _DistortionMap_ST.xy + _DistortionMap_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _Texture1_ST.xy + _Texture1_ST.zw;
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Texture2_ST.xy + _Texture2_ST.zw;
					    vs_TEXCOORD1.zw = in_TEXCOORD0.xy * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD6.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD7.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD2.xy = in_TEXCOORD0.xy * _BumpMap2_ST.xy + _BumpMap2_ST.zw;
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD3.y = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat0.y;
					    vs_TEXCOORD4.x = u_xlat1.x;
					    vs_TEXCOORD5.x = u_xlat1.y;
					    vs_TEXCOORD4.z = u_xlat0.z;
					    vs_TEXCOORD5.z = u_xlat0.x;
					    vs_TEXCOORD4.y = u_xlat2.y;
					    vs_TEXCOORD5.y = u_xlat2.z;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTexture0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD6.yyy * unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD6.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD6.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + unity_WorldToLight[3].xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0 = texture(_LightTexture0, u_xlat0.xx);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlat5.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_DistortionMap, u_xlat5.xy);
					    u_xlat5.x = u_xlat1.x + -0.5;
					    u_xlat10.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat10.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat10.xy);
					    u_xlat10.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat10.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat10.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat10.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat10.y * u_xlat10.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat10.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10.x = min(u_xlat10.x, 1.0);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10.x);
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat3.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx + u_xlat4.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat10.x = max(u_xlat10.x, 0.0);
					    u_xlat10.x = log2(u_xlat10.x);
					    u_xlat15 = _Gloss * 128.0;
					    u_xlat10.x = u_xlat10.x * u_xlat15;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat15 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat3.w = u_xlat15 * u_xlat10.x;
					    u_xlat1 = u_xlat0.xxxx * u_xlat3;
					    u_xlat0.x = u_xlat1.w * _Specular;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat12.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat12.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat12.xy;
					    u_xlat3 = texture(_Texture2, u_xlat12.xy);
					    u_xlat2.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat2.xy;
					    u_xlat2 = texture(_Texture1, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat0.xyz = u_xlat4.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat4.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat4.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTexture0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD6.yyy * unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD6.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD6.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + unity_WorldToLight[3].xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0 = texture(_LightTexture0, u_xlat0.xx);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlat5.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_DistortionMap, u_xlat5.xy);
					    u_xlat5.x = u_xlat1.x + -0.5;
					    u_xlat10.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat10.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat10.xy);
					    u_xlat10.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat10.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat10.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat10.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat10.y * u_xlat10.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat10.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10.x = min(u_xlat10.x, 1.0);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10.x);
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat3.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx + u_xlat4.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat10.x = max(u_xlat10.x, 0.0);
					    u_xlat10.x = log2(u_xlat10.x);
					    u_xlat15 = _Gloss * 128.0;
					    u_xlat10.x = u_xlat10.x * u_xlat15;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat15 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat3.w = u_xlat15 * u_xlat10.x;
					    u_xlat1 = u_xlat0.xxxx * u_xlat3;
					    u_xlat0.x = u_xlat1.w * _Specular;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat12.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat12.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat12.xy;
					    u_xlat3 = texture(_Texture2, u_xlat12.xy);
					    u_xlat2.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat2.xy;
					    u_xlat2 = texture(_Texture1, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat0.xyz = u_xlat4.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat4.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat4.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTexture0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD6.yyy * unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD6.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD6.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + unity_WorldToLight[3].xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0 = texture(_LightTexture0, u_xlat0.xx);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlat5.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_DistortionMap, u_xlat5.xy);
					    u_xlat5.x = u_xlat1.x + -0.5;
					    u_xlat10.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat10.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat10.xy);
					    u_xlat10.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat10.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat10.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat10.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat10.y * u_xlat10.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat10.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10.x = min(u_xlat10.x, 1.0);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10.x);
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat3.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx + u_xlat4.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat10.x = max(u_xlat10.x, 0.0);
					    u_xlat10.x = log2(u_xlat10.x);
					    u_xlat15 = _Gloss * 128.0;
					    u_xlat10.x = u_xlat10.x * u_xlat15;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat15 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat3.w = u_xlat15 * u_xlat10.x;
					    u_xlat1 = u_xlat0.xxxx * u_xlat3;
					    u_xlat0.x = u_xlat1.w * _Specular;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat12.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat12.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat12.xy;
					    u_xlat3 = texture(_Texture2, u_xlat12.xy);
					    u_xlat2.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat2.xy;
					    u_xlat2 = texture(_Texture1, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat0.xyz = u_xlat4.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat4.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat4.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_13[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat13;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat16) + _WorldSpaceLightPos0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat16 = max(u_xlat16, 0.0);
					    u_xlat16 = log2(u_xlat16);
					    u_xlat2.x = _Gloss * 128.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat2.x = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = dot(vec2(u_xlat16), vec2(vec2(_Specular, _Specular)));
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat13.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat13.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat13.xy;
					    u_xlat4 = texture(_Texture2, u_xlat13.xy);
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_13[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat13;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat16) + _WorldSpaceLightPos0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat16 = max(u_xlat16, 0.0);
					    u_xlat16 = log2(u_xlat16);
					    u_xlat2.x = _Gloss * 128.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat2.x = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = dot(vec2(u_xlat16), vec2(vec2(_Specular, _Specular)));
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat13.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat13.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat13.xy;
					    u_xlat4 = texture(_Texture2, u_xlat13.xy);
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_13[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat13;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat16) + _WorldSpaceLightPos0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat16 = max(u_xlat16, 0.0);
					    u_xlat16 = log2(u_xlat16);
					    u_xlat2.x = _Gloss * 128.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat2.x = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = dot(vec2(u_xlat16), vec2(vec2(_Specular, _Specular)));
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat13.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat13.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat13.xy;
					    u_xlat4 = texture(_Texture2, u_xlat13.xy);
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "SPOT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0 = vs_TEXCOORD6.yyyy * unity_WorldToLight[1];
					    u_xlat0 = unity_WorldToLight[0] * vs_TEXCOORD6.xxxx + u_xlat0;
					    u_xlat0 = unity_WorldToLight[2] * vs_TEXCOORD6.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_WorldToLight[3];
					    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
					    u_xlat1 = texture(_LightTexture0, u_xlat1.xy);
					    u_xlatb15 = 0.0<u_xlat0.z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat0.xx);
					    u_xlat0.x = u_xlatb15 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat1.w * u_xlat0.x;
					    u_xlat0.x = dot(u_xlat0.xx, u_xlat2.xx);
					    u_xlat5.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_DistortionMap, u_xlat5.xy);
					    u_xlat5.x = u_xlat1.x + -0.5;
					    u_xlat10.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat10.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat10.xy);
					    u_xlat10.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat10.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat10.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat10.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat10.y * u_xlat10.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat10.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10.x = min(u_xlat10.x, 1.0);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10.x);
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat3.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx + u_xlat4.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat10.x = max(u_xlat10.x, 0.0);
					    u_xlat10.x = log2(u_xlat10.x);
					    u_xlat15 = _Gloss * 128.0;
					    u_xlat10.x = u_xlat10.x * u_xlat15;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat15 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat3.w = u_xlat15 * u_xlat10.x;
					    u_xlat1 = u_xlat0.xxxx * u_xlat3;
					    u_xlat0.x = u_xlat1.w * _Specular;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat12.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat12.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat12.xy;
					    u_xlat3 = texture(_Texture2, u_xlat12.xy);
					    u_xlat2.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat2.xy;
					    u_xlat2 = texture(_Texture1, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat0.xyz = u_xlat4.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat4.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat4.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "SPOT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0 = vs_TEXCOORD6.yyyy * unity_WorldToLight[1];
					    u_xlat0 = unity_WorldToLight[0] * vs_TEXCOORD6.xxxx + u_xlat0;
					    u_xlat0 = unity_WorldToLight[2] * vs_TEXCOORD6.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_WorldToLight[3];
					    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
					    u_xlat1 = texture(_LightTexture0, u_xlat1.xy);
					    u_xlatb15 = 0.0<u_xlat0.z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat0.xx);
					    u_xlat0.x = u_xlatb15 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat1.w * u_xlat0.x;
					    u_xlat0.x = dot(u_xlat0.xx, u_xlat2.xx);
					    u_xlat5.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_DistortionMap, u_xlat5.xy);
					    u_xlat5.x = u_xlat1.x + -0.5;
					    u_xlat10.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat10.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat10.xy);
					    u_xlat10.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat10.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat10.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat10.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat10.y * u_xlat10.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat10.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10.x = min(u_xlat10.x, 1.0);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10.x);
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat3.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx + u_xlat4.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat10.x = max(u_xlat10.x, 0.0);
					    u_xlat10.x = log2(u_xlat10.x);
					    u_xlat15 = _Gloss * 128.0;
					    u_xlat10.x = u_xlat10.x * u_xlat15;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat15 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat3.w = u_xlat15 * u_xlat10.x;
					    u_xlat1 = u_xlat0.xxxx * u_xlat3;
					    u_xlat0.x = u_xlat1.w * _Specular;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat12.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat12.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat12.xy;
					    u_xlat3 = texture(_Texture2, u_xlat12.xy);
					    u_xlat2.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat2.xy;
					    u_xlat2 = texture(_Texture1, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat0.xyz = u_xlat4.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat4.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat4.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "SPOT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0 = vs_TEXCOORD6.yyyy * unity_WorldToLight[1];
					    u_xlat0 = unity_WorldToLight[0] * vs_TEXCOORD6.xxxx + u_xlat0;
					    u_xlat0 = unity_WorldToLight[2] * vs_TEXCOORD6.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_WorldToLight[3];
					    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
					    u_xlat1 = texture(_LightTexture0, u_xlat1.xy);
					    u_xlatb15 = 0.0<u_xlat0.z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat0.xx);
					    u_xlat0.x = u_xlatb15 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat1.w * u_xlat0.x;
					    u_xlat0.x = dot(u_xlat0.xx, u_xlat2.xx);
					    u_xlat5.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_DistortionMap, u_xlat5.xy);
					    u_xlat5.x = u_xlat1.x + -0.5;
					    u_xlat10.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat10.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat10.xy);
					    u_xlat10.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat10.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat10.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat10.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat10.y * u_xlat10.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat10.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10.x = min(u_xlat10.x, 1.0);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10.x);
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat3.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx + u_xlat4.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat10.x = max(u_xlat10.x, 0.0);
					    u_xlat10.x = log2(u_xlat10.x);
					    u_xlat15 = _Gloss * 128.0;
					    u_xlat10.x = u_xlat10.x * u_xlat15;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat15 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat3.w = u_xlat15 * u_xlat10.x;
					    u_xlat1 = u_xlat0.xxxx * u_xlat3;
					    u_xlat0.x = u_xlat1.w * _Specular;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat12.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat12.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat12.xy;
					    u_xlat3 = texture(_Texture2, u_xlat12.xy);
					    u_xlat2.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat2.xy;
					    u_xlat2 = texture(_Texture1, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat0.xyz = u_xlat4.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat4.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat4.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "POINT_COOKIE" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD6.yyy * unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD6.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD6.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + unity_WorldToLight[3].xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1 = texture(_LightTexture0, u_xlat0.xyz);
					    u_xlat0 = texture(_LightTextureB0, vec2(u_xlat15));
					    u_xlat0.x = dot(u_xlat0.xx, u_xlat1.ww);
					    u_xlat5.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_DistortionMap, u_xlat5.xy);
					    u_xlat5.x = u_xlat1.x + -0.5;
					    u_xlat10.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat10.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat10.xy);
					    u_xlat10.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat10.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat10.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat10.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat10.y * u_xlat10.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat10.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10.x = min(u_xlat10.x, 1.0);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10.x);
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat3.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx + u_xlat4.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat10.x = max(u_xlat10.x, 0.0);
					    u_xlat10.x = log2(u_xlat10.x);
					    u_xlat15 = _Gloss * 128.0;
					    u_xlat10.x = u_xlat10.x * u_xlat15;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat15 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat3.w = u_xlat15 * u_xlat10.x;
					    u_xlat1 = u_xlat0.xxxx * u_xlat3;
					    u_xlat0.x = u_xlat1.w * _Specular;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat12.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat12.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat12.xy;
					    u_xlat3 = texture(_Texture2, u_xlat12.xy);
					    u_xlat2.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat2.xy;
					    u_xlat2 = texture(_Texture1, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat0.xyz = u_xlat4.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat4.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat4.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "POINT_COOKIE" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD6.yyy * unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD6.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD6.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + unity_WorldToLight[3].xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1 = texture(_LightTexture0, u_xlat0.xyz);
					    u_xlat0 = texture(_LightTextureB0, vec2(u_xlat15));
					    u_xlat0.x = dot(u_xlat0.xx, u_xlat1.ww);
					    u_xlat5.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_DistortionMap, u_xlat5.xy);
					    u_xlat5.x = u_xlat1.x + -0.5;
					    u_xlat10.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat10.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat10.xy);
					    u_xlat10.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat10.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat10.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat10.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat10.y * u_xlat10.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat10.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10.x = min(u_xlat10.x, 1.0);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10.x);
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat3.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx + u_xlat4.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat10.x = max(u_xlat10.x, 0.0);
					    u_xlat10.x = log2(u_xlat10.x);
					    u_xlat15 = _Gloss * 128.0;
					    u_xlat10.x = u_xlat10.x * u_xlat15;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat15 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat3.w = u_xlat15 * u_xlat10.x;
					    u_xlat1 = u_xlat0.xxxx * u_xlat3;
					    u_xlat0.x = u_xlat1.w * _Specular;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat12.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat12.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat12.xy;
					    u_xlat3 = texture(_Texture2, u_xlat12.xy);
					    u_xlat2.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat2.xy;
					    u_xlat2 = texture(_Texture1, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat0.xyz = u_xlat4.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat4.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat4.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "POINT_COOKIE" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD6.yyy * unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD6.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD6.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + unity_WorldToLight[3].xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1 = texture(_LightTexture0, u_xlat0.xyz);
					    u_xlat0 = texture(_LightTextureB0, vec2(u_xlat15));
					    u_xlat0.x = dot(u_xlat0.xx, u_xlat1.ww);
					    u_xlat5.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_DistortionMap, u_xlat5.xy);
					    u_xlat5.x = u_xlat1.x + -0.5;
					    u_xlat10.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat10.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat10.xy);
					    u_xlat10.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat10.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat10.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat10.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat10.y * u_xlat10.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat10.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10.x = min(u_xlat10.x, 1.0);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10.x);
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat3.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx + u_xlat4.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat10.x = max(u_xlat10.x, 0.0);
					    u_xlat10.x = log2(u_xlat10.x);
					    u_xlat15 = _Gloss * 128.0;
					    u_xlat10.x = u_xlat10.x * u_xlat15;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat15 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat3.w = u_xlat15 * u_xlat10.x;
					    u_xlat1 = u_xlat0.xxxx * u_xlat3;
					    u_xlat0.x = u_xlat1.w * _Specular;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat12.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat12.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat12.xy;
					    u_xlat3 = texture(_Texture2, u_xlat12.xy);
					    u_xlat2.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat2.xy;
					    u_xlat2 = texture(_Texture1, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat0.xyz = u_xlat4.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat4.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat4.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTexture0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat10;
					vec2 u_xlat13;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat17) + _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.x = log2(u_xlat5.x);
					    u_xlat10 = _Gloss * 128.0;
					    u_xlat5.x = u_xlat5.x * u_xlat10;
					    u_xlat5.x = exp2(u_xlat5.x);
					    u_xlat10 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat1.w = u_xlat10 * u_xlat5.x;
					    u_xlat5.xy = vs_TEXCOORD6.yy * unity_WorldToLight[1].xy;
					    u_xlat5.xy = unity_WorldToLight[0].xy * vs_TEXCOORD6.xx + u_xlat5.xy;
					    u_xlat5.xy = unity_WorldToLight[2].xy * vs_TEXCOORD6.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + unity_WorldToLight[3].xy;
					    u_xlat3 = texture(_LightTexture0, u_xlat5.xy);
					    u_xlat5.x = u_xlat3.w + u_xlat3.w;
					    u_xlat1 = u_xlat5.xxxx * u_xlat1;
					    u_xlat5.x = u_xlat1.w * _Specular;
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat13.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat13.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat13.xy;
					    u_xlat4 = texture(_Texture2, u_xlat13.xy);
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat2.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat2.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat2.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTexture0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat10;
					vec2 u_xlat13;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat17) + _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.x = log2(u_xlat5.x);
					    u_xlat10 = _Gloss * 128.0;
					    u_xlat5.x = u_xlat5.x * u_xlat10;
					    u_xlat5.x = exp2(u_xlat5.x);
					    u_xlat10 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat1.w = u_xlat10 * u_xlat5.x;
					    u_xlat5.xy = vs_TEXCOORD6.yy * unity_WorldToLight[1].xy;
					    u_xlat5.xy = unity_WorldToLight[0].xy * vs_TEXCOORD6.xx + u_xlat5.xy;
					    u_xlat5.xy = unity_WorldToLight[2].xy * vs_TEXCOORD6.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + unity_WorldToLight[3].xy;
					    u_xlat3 = texture(_LightTexture0, u_xlat5.xy);
					    u_xlat5.x = u_xlat3.w + u_xlat3.w;
					    u_xlat1 = u_xlat5.xxxx * u_xlat1;
					    u_xlat5.x = u_xlat1.w * _Specular;
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat13.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat13.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat13.xy;
					    u_xlat4 = texture(_Texture2, u_xlat13.xy);
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat2.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat2.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat2.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTexture0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat10;
					vec2 u_xlat13;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat17) + _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.x = log2(u_xlat5.x);
					    u_xlat10 = _Gloss * 128.0;
					    u_xlat5.x = u_xlat5.x * u_xlat10;
					    u_xlat5.x = exp2(u_xlat5.x);
					    u_xlat10 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat1.w = u_xlat10 * u_xlat5.x;
					    u_xlat5.xy = vs_TEXCOORD6.yy * unity_WorldToLight[1].xy;
					    u_xlat5.xy = unity_WorldToLight[0].xy * vs_TEXCOORD6.xx + u_xlat5.xy;
					    u_xlat5.xy = unity_WorldToLight[2].xy * vs_TEXCOORD6.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + unity_WorldToLight[3].xy;
					    u_xlat3 = texture(_LightTexture0, u_xlat5.xy);
					    u_xlat5.x = u_xlat3.w + u_xlat3.w;
					    u_xlat1 = u_xlat5.xxxx * u_xlat1;
					    u_xlat5.x = u_xlat1.w * _Specular;
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat13.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat13.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat13.xy;
					    u_xlat4 = texture(_Texture2, u_xlat13.xy);
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat5.xyz;
					    u_xlat0.xyz = u_xlat2.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat2.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat2.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "FOG_EXP2" "POINT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTexture0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD6.yyy * unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD6.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD6.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + unity_WorldToLight[3].xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0 = texture(_LightTexture0, u_xlat0.xx);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlat5.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_DistortionMap, u_xlat5.xy);
					    u_xlat5.x = u_xlat1.x + -0.5;
					    u_xlat10.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat10.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat10.xy);
					    u_xlat10.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat10.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat10.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat10.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat10.y * u_xlat10.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat10.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10.x = min(u_xlat10.x, 1.0);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10.x);
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat3.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx + u_xlat4.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat10.x = max(u_xlat10.x, 0.0);
					    u_xlat10.x = log2(u_xlat10.x);
					    u_xlat15 = _Gloss * 128.0;
					    u_xlat10.x = u_xlat10.x * u_xlat15;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat15 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat3.w = u_xlat15 * u_xlat10.x;
					    u_xlat1 = u_xlat0.xxxx * u_xlat3;
					    u_xlat0.x = u_xlat1.w * _Specular;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat12.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat12.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat12.xy;
					    u_xlat3 = texture(_Texture2, u_xlat12.xy);
					    u_xlat2.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat2.xy;
					    u_xlat2 = texture(_Texture1, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat15 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    u_xlat0.xyz = u_xlat4.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat4.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat4.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "FOG_EXP2" "POINT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTexture0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD6.yyy * unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD6.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD6.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + unity_WorldToLight[3].xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0 = texture(_LightTexture0, u_xlat0.xx);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlat5.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_DistortionMap, u_xlat5.xy);
					    u_xlat5.x = u_xlat1.x + -0.5;
					    u_xlat10.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat10.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat10.xy);
					    u_xlat10.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat10.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat10.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat10.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat10.y * u_xlat10.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat10.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10.x = min(u_xlat10.x, 1.0);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10.x);
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat3.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx + u_xlat4.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat10.x = max(u_xlat10.x, 0.0);
					    u_xlat10.x = log2(u_xlat10.x);
					    u_xlat15 = _Gloss * 128.0;
					    u_xlat10.x = u_xlat10.x * u_xlat15;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat15 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat3.w = u_xlat15 * u_xlat10.x;
					    u_xlat1 = u_xlat0.xxxx * u_xlat3;
					    u_xlat0.x = u_xlat1.w * _Specular;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat12.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat12.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat12.xy;
					    u_xlat3 = texture(_Texture2, u_xlat12.xy);
					    u_xlat2.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat2.xy;
					    u_xlat2 = texture(_Texture1, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat15 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    u_xlat0.xyz = u_xlat4.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat4.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat4.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "FOG_EXP2" "POINT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTexture0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD6.yyy * unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD6.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD6.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + unity_WorldToLight[3].xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0 = texture(_LightTexture0, u_xlat0.xx);
					    u_xlat0.x = u_xlat0.x + u_xlat0.x;
					    u_xlat5.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_DistortionMap, u_xlat5.xy);
					    u_xlat5.x = u_xlat1.x + -0.5;
					    u_xlat10.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat10.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat10.xy);
					    u_xlat10.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat10.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat10.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat10.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat10.y * u_xlat10.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat10.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10.x = min(u_xlat10.x, 1.0);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10.x);
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat3.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx + u_xlat4.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat10.x = max(u_xlat10.x, 0.0);
					    u_xlat10.x = log2(u_xlat10.x);
					    u_xlat15 = _Gloss * 128.0;
					    u_xlat10.x = u_xlat10.x * u_xlat15;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat15 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat3.w = u_xlat15 * u_xlat10.x;
					    u_xlat1 = u_xlat0.xxxx * u_xlat3;
					    u_xlat0.x = u_xlat1.w * _Specular;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat12.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat12.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat12.xy;
					    u_xlat3 = texture(_Texture2, u_xlat12.xy);
					    u_xlat2.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat2.xy;
					    u_xlat2 = texture(_Texture1, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat15 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    u_xlat0.xyz = u_xlat4.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat4.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat4.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_13[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat13;
					float u_xlat15;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat16) + _WorldSpaceLightPos0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat16 = max(u_xlat16, 0.0);
					    u_xlat16 = log2(u_xlat16);
					    u_xlat2.x = _Gloss * 128.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat2.x = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = dot(vec2(u_xlat16), vec2(vec2(_Specular, _Specular)));
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat13.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat13.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat13.xy;
					    u_xlat4 = texture(_Texture2, u_xlat13.xy);
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat15 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    u_xlat0.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_13[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat13;
					float u_xlat15;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat16) + _WorldSpaceLightPos0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat16 = max(u_xlat16, 0.0);
					    u_xlat16 = log2(u_xlat16);
					    u_xlat2.x = _Gloss * 128.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat2.x = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = dot(vec2(u_xlat16), vec2(vec2(_Specular, _Specular)));
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat13.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat13.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat13.xy;
					    u_xlat4 = texture(_Texture2, u_xlat13.xy);
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat15 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    u_xlat0.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_13[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					vec2 u_xlat13;
					float u_xlat15;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = u_xlat1.xyz * vec3(u_xlat16) + _WorldSpaceLightPos0.xyz;
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat16 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat2.xyz = vec3(u_xlat16) * u_xlat2.xyz;
					    u_xlat16 = dot(u_xlat5.xyz, u_xlat2.xyz);
					    u_xlat5.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.xyz = u_xlat5.xxx * _LightColor0.xyz;
					    u_xlat5.xyz = u_xlat5.xyz * vec3(2.0, 2.0, 2.0);
					    u_xlat16 = max(u_xlat16, 0.0);
					    u_xlat16 = log2(u_xlat16);
					    u_xlat2.x = _Gloss * 128.0;
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = exp2(u_xlat16);
					    u_xlat2.x = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat16 = u_xlat16 * u_xlat2.x;
					    u_xlat16 = dot(vec2(u_xlat16), vec2(vec2(_Specular, _Specular)));
					    u_xlat2.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat13.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat13.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat13.xy;
					    u_xlat4 = texture(_Texture2, u_xlat13.xy);
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat5.xyz + u_xlat2.xyz;
					    u_xlat15 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    u_xlat0.xyz = u_xlat1.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat1.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "FOG_EXP2" "SPOT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0 = vs_TEXCOORD6.yyyy * unity_WorldToLight[1];
					    u_xlat0 = unity_WorldToLight[0] * vs_TEXCOORD6.xxxx + u_xlat0;
					    u_xlat0 = unity_WorldToLight[2] * vs_TEXCOORD6.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_WorldToLight[3];
					    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
					    u_xlat1 = texture(_LightTexture0, u_xlat1.xy);
					    u_xlatb15 = 0.0<u_xlat0.z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat0.xx);
					    u_xlat0.x = u_xlatb15 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat1.w * u_xlat0.x;
					    u_xlat0.x = dot(u_xlat0.xx, u_xlat2.xx);
					    u_xlat5.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_DistortionMap, u_xlat5.xy);
					    u_xlat5.x = u_xlat1.x + -0.5;
					    u_xlat10.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat10.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat10.xy);
					    u_xlat10.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat10.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat10.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat10.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat10.y * u_xlat10.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat10.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10.x = min(u_xlat10.x, 1.0);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10.x);
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat3.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx + u_xlat4.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat10.x = max(u_xlat10.x, 0.0);
					    u_xlat10.x = log2(u_xlat10.x);
					    u_xlat15 = _Gloss * 128.0;
					    u_xlat10.x = u_xlat10.x * u_xlat15;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat15 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat3.w = u_xlat15 * u_xlat10.x;
					    u_xlat1 = u_xlat0.xxxx * u_xlat3;
					    u_xlat0.x = u_xlat1.w * _Specular;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat12.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat12.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat12.xy;
					    u_xlat3 = texture(_Texture2, u_xlat12.xy);
					    u_xlat2.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat2.xy;
					    u_xlat2 = texture(_Texture1, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat15 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    u_xlat0.xyz = u_xlat4.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat4.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat4.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "FOG_EXP2" "SPOT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0 = vs_TEXCOORD6.yyyy * unity_WorldToLight[1];
					    u_xlat0 = unity_WorldToLight[0] * vs_TEXCOORD6.xxxx + u_xlat0;
					    u_xlat0 = unity_WorldToLight[2] * vs_TEXCOORD6.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_WorldToLight[3];
					    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
					    u_xlat1 = texture(_LightTexture0, u_xlat1.xy);
					    u_xlatb15 = 0.0<u_xlat0.z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat0.xx);
					    u_xlat0.x = u_xlatb15 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat1.w * u_xlat0.x;
					    u_xlat0.x = dot(u_xlat0.xx, u_xlat2.xx);
					    u_xlat5.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_DistortionMap, u_xlat5.xy);
					    u_xlat5.x = u_xlat1.x + -0.5;
					    u_xlat10.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat10.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat10.xy);
					    u_xlat10.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat10.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat10.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat10.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat10.y * u_xlat10.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat10.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10.x = min(u_xlat10.x, 1.0);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10.x);
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat3.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx + u_xlat4.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat10.x = max(u_xlat10.x, 0.0);
					    u_xlat10.x = log2(u_xlat10.x);
					    u_xlat15 = _Gloss * 128.0;
					    u_xlat10.x = u_xlat10.x * u_xlat15;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat15 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat3.w = u_xlat15 * u_xlat10.x;
					    u_xlat1 = u_xlat0.xxxx * u_xlat3;
					    u_xlat0.x = u_xlat1.w * _Specular;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat12.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat12.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat12.xy;
					    u_xlat3 = texture(_Texture2, u_xlat12.xy);
					    u_xlat2.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat2.xy;
					    u_xlat2 = texture(_Texture1, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat15 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    u_xlat0.xyz = u_xlat4.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat4.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat4.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "FOG_EXP2" "SPOT" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					bool u_xlatb15;
					void main()
					{
					    u_xlat0 = vs_TEXCOORD6.yyyy * unity_WorldToLight[1];
					    u_xlat0 = unity_WorldToLight[0] * vs_TEXCOORD6.xxxx + u_xlat0;
					    u_xlat0 = unity_WorldToLight[2] * vs_TEXCOORD6.zzzz + u_xlat0;
					    u_xlat0 = u_xlat0 + unity_WorldToLight[3];
					    u_xlat1.xy = u_xlat0.xy / u_xlat0.ww;
					    u_xlat1.xy = u_xlat1.xy + vec2(0.5, 0.5);
					    u_xlat1 = texture(_LightTexture0, u_xlat1.xy);
					    u_xlatb15 = 0.0<u_xlat0.z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat2 = texture(_LightTextureB0, u_xlat0.xx);
					    u_xlat0.x = u_xlatb15 ? 1.0 : float(0.0);
					    u_xlat0.x = u_xlat1.w * u_xlat0.x;
					    u_xlat0.x = dot(u_xlat0.xx, u_xlat2.xx);
					    u_xlat5.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_DistortionMap, u_xlat5.xy);
					    u_xlat5.x = u_xlat1.x + -0.5;
					    u_xlat10.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat10.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat10.xy);
					    u_xlat10.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat10.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat10.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat10.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat10.y * u_xlat10.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat10.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10.x = min(u_xlat10.x, 1.0);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10.x);
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat3.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx + u_xlat4.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat10.x = max(u_xlat10.x, 0.0);
					    u_xlat10.x = log2(u_xlat10.x);
					    u_xlat15 = _Gloss * 128.0;
					    u_xlat10.x = u_xlat10.x * u_xlat15;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat15 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat3.w = u_xlat15 * u_xlat10.x;
					    u_xlat1 = u_xlat0.xxxx * u_xlat3;
					    u_xlat0.x = u_xlat1.w * _Specular;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat12.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat12.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat12.xy;
					    u_xlat3 = texture(_Texture2, u_xlat12.xy);
					    u_xlat2.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat2.xy;
					    u_xlat2 = texture(_Texture1, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat15 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    u_xlat0.xyz = u_xlat4.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat4.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat4.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "FOG_EXP2" "POINT_COOKIE" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD6.yyy * unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD6.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD6.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + unity_WorldToLight[3].xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1 = texture(_LightTexture0, u_xlat0.xyz);
					    u_xlat0 = texture(_LightTextureB0, vec2(u_xlat15));
					    u_xlat0.x = dot(u_xlat0.xx, u_xlat1.ww);
					    u_xlat5.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_DistortionMap, u_xlat5.xy);
					    u_xlat5.x = u_xlat1.x + -0.5;
					    u_xlat10.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat10.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat10.xy);
					    u_xlat10.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat10.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat10.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat10.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat10.y * u_xlat10.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat10.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10.x = min(u_xlat10.x, 1.0);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10.x);
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat3.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx + u_xlat4.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat10.x = max(u_xlat10.x, 0.0);
					    u_xlat10.x = log2(u_xlat10.x);
					    u_xlat15 = _Gloss * 128.0;
					    u_xlat10.x = u_xlat10.x * u_xlat15;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat15 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat3.w = u_xlat15 * u_xlat10.x;
					    u_xlat1 = u_xlat0.xxxx * u_xlat3;
					    u_xlat0.x = u_xlat1.w * _Specular;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat12.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat12.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat12.xy;
					    u_xlat3 = texture(_Texture2, u_xlat12.xy);
					    u_xlat2.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat2.xy;
					    u_xlat2 = texture(_Texture1, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat15 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    u_xlat0.xyz = u_xlat4.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat4.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat4.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "FOG_EXP2" "POINT_COOKIE" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD6.yyy * unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD6.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD6.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + unity_WorldToLight[3].xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1 = texture(_LightTexture0, u_xlat0.xyz);
					    u_xlat0 = texture(_LightTextureB0, vec2(u_xlat15));
					    u_xlat0.x = dot(u_xlat0.xx, u_xlat1.ww);
					    u_xlat5.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_DistortionMap, u_xlat5.xy);
					    u_xlat5.x = u_xlat1.x + -0.5;
					    u_xlat10.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat10.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat10.xy);
					    u_xlat10.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat10.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat10.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat10.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat10.y * u_xlat10.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat10.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10.x = min(u_xlat10.x, 1.0);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10.x);
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat3.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx + u_xlat4.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat10.x = max(u_xlat10.x, 0.0);
					    u_xlat10.x = log2(u_xlat10.x);
					    u_xlat15 = _Gloss * 128.0;
					    u_xlat10.x = u_xlat10.x * u_xlat15;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat15 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat3.w = u_xlat15 * u_xlat10.x;
					    u_xlat1 = u_xlat0.xxxx * u_xlat3;
					    u_xlat0.x = u_xlat1.w * _Specular;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat12.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat12.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat12.xy;
					    u_xlat3 = texture(_Texture2, u_xlat12.xy);
					    u_xlat2.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat2.xy;
					    u_xlat2 = texture(_Texture1, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat15 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    u_xlat0.xyz = u_xlat4.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat4.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat4.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "FOG_EXP2" "POINT_COOKIE" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec2 u_xlat5;
					vec2 u_xlat10;
					vec2 u_xlat12;
					float u_xlat15;
					void main()
					{
					    u_xlat0.xyz = vs_TEXCOORD6.yyy * unity_WorldToLight[1].xyz;
					    u_xlat0.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD6.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD6.zzz + u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz + unity_WorldToLight[3].xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat1 = texture(_LightTexture0, u_xlat0.xyz);
					    u_xlat0 = texture(_LightTextureB0, vec2(u_xlat15));
					    u_xlat0.x = dot(u_xlat0.xx, u_xlat1.ww);
					    u_xlat5.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat1 = texture(_DistortionMap, u_xlat5.xy);
					    u_xlat5.x = u_xlat1.x + -0.5;
					    u_xlat10.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat10.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat10.xy);
					    u_xlat10.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat10.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat10.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat10.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat10.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat10.y * u_xlat10.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat10.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat10.x = min(u_xlat10.x, 1.0);
					    u_xlat10.x = (-u_xlat10.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat10.x);
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat1.xyz;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, u_xlat1.xyz);
					    u_xlat2.y = dot(vs_TEXCOORD4.xyz, u_xlat1.xyz);
					    u_xlat2.z = dot(vs_TEXCOORD5.xyz, u_xlat1.xyz);
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat1.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat3.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat15 = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat4.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat10.xxx + u_xlat4.xyz;
					    u_xlat10.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.xyz = u_xlat10.xxx * u_xlat2.xyz;
					    u_xlat10.x = dot(u_xlat1.xyz, u_xlat2.xyz);
					    u_xlat10.x = max(u_xlat10.x, 0.0);
					    u_xlat10.x = log2(u_xlat10.x);
					    u_xlat15 = _Gloss * 128.0;
					    u_xlat10.x = u_xlat10.x * u_xlat15;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat15 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat3.w = u_xlat15 * u_xlat10.x;
					    u_xlat1 = u_xlat0.xxxx * u_xlat3;
					    u_xlat0.x = u_xlat1.w * _Specular;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat2.xy = u_xlat5.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat12.xy = (-u_xlat5.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat12.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat12.xy;
					    u_xlat3 = texture(_Texture2, u_xlat12.xy);
					    u_xlat2.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat2.xy;
					    u_xlat2 = texture(_Texture1, u_xlat2.xy);
					    u_xlat2.xyz = u_xlat3.xyz * u_xlat2.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * u_xlat1.xyz + u_xlat0.xzw;
					    u_xlat15 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    u_xlat0.xyz = u_xlat4.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat4.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat4.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier00 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP2" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTexture0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat10;
					vec2 u_xlat13;
					float u_xlat15;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat17) + _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.x = log2(u_xlat5.x);
					    u_xlat10 = _Gloss * 128.0;
					    u_xlat5.x = u_xlat5.x * u_xlat10;
					    u_xlat5.x = exp2(u_xlat5.x);
					    u_xlat10 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat1.w = u_xlat10 * u_xlat5.x;
					    u_xlat5.xy = vs_TEXCOORD6.yy * unity_WorldToLight[1].xy;
					    u_xlat5.xy = unity_WorldToLight[0].xy * vs_TEXCOORD6.xx + u_xlat5.xy;
					    u_xlat5.xy = unity_WorldToLight[2].xy * vs_TEXCOORD6.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + unity_WorldToLight[3].xy;
					    u_xlat3 = texture(_LightTexture0, u_xlat5.xy);
					    u_xlat5.x = u_xlat3.w + u_xlat3.w;
					    u_xlat1 = u_xlat5.xxxx * u_xlat1;
					    u_xlat5.x = u_xlat1.w * _Specular;
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat13.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat13.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat13.xy;
					    u_xlat4 = texture(_Texture2, u_xlat13.xy);
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat5.xyz;
					    u_xlat15 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    u_xlat0.xyz = u_xlat2.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat2.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat2.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier01 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP2" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTexture0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat10;
					vec2 u_xlat13;
					float u_xlat15;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat17) + _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.x = log2(u_xlat5.x);
					    u_xlat10 = _Gloss * 128.0;
					    u_xlat5.x = u_xlat5.x * u_xlat10;
					    u_xlat5.x = exp2(u_xlat5.x);
					    u_xlat10 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat1.w = u_xlat10 * u_xlat5.x;
					    u_xlat5.xy = vs_TEXCOORD6.yy * unity_WorldToLight[1].xy;
					    u_xlat5.xy = unity_WorldToLight[0].xy * vs_TEXCOORD6.xx + u_xlat5.xy;
					    u_xlat5.xy = unity_WorldToLight[2].xy * vs_TEXCOORD6.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + unity_WorldToLight[3].xy;
					    u_xlat3 = texture(_LightTexture0, u_xlat5.xy);
					    u_xlat5.x = u_xlat3.w + u_xlat3.w;
					    u_xlat1 = u_xlat5.xxxx * u_xlat1;
					    u_xlat5.x = u_xlat1.w * _Specular;
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat13.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat13.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat13.xy;
					    u_xlat4 = texture(_Texture2, u_xlat13.xy);
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat5.xyz;
					    u_xlat15 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    u_xlat0.xyz = u_xlat2.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat2.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat2.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
				SubProgram "d3d11 hw_tier02 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP2" }
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
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						float _MainTexSpeed;
						float _Bump1Speed;
						float _Texture2Speed;
						float _Bump2Speed;
						float _DistortionSpeed;
						float _DistortionPower;
						float _Specular;
						float _Gloss;
						float _Opacity;
						vec4 unused_0_14[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					uniform  sampler2D _DistortionMap;
					uniform  sampler2D _Texture1;
					uniform  sampler2D _Texture2;
					uniform  sampler2D _BumpMap1;
					uniform  sampler2D _BumpMap2;
					uniform  sampler2D _LightTexture0;
					in  vec4 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec2 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD6;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec3 u_xlat5;
					float u_xlat10;
					vec2 u_xlat13;
					float u_xlat15;
					float u_xlat17;
					void main()
					{
					    u_xlat0.xy = vec2(_DistortionSpeed) * _Time.xx + vs_TEXCOORD0.xy;
					    u_xlat0 = texture(_DistortionMap, u_xlat0.xy);
					    u_xlat0.x = u_xlat0.x + -0.5;
					    u_xlat5.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.zw;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump1Speed, _Bump1Speed)) + u_xlat5.xy;
					    u_xlat1 = texture(_BumpMap1, u_xlat5.xy);
					    u_xlat5.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD2.xy;
					    u_xlat5.xy = _Time.xx * vec2(vec2(_Bump2Speed, _Bump2Speed)) + u_xlat5.xy;
					    u_xlat2 = texture(_BumpMap2, u_xlat5.xy);
					    u_xlat1.yzw = u_xlat1.xyw + u_xlat2.xyw;
					    u_xlat5.xy = u_xlat1.yw * vec2(0.5, 0.5);
					    u_xlat1.x = u_xlat5.y * u_xlat5.x;
					    u_xlat1.xy = u_xlat1.xz * vec2(2.0, 1.0) + vec2(-1.0, -1.0);
					    u_xlat5.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat5.x = min(u_xlat5.x, 1.0);
					    u_xlat5.x = (-u_xlat5.x) + 1.0;
					    u_xlat1.z = sqrt(u_xlat5.x);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat1.y = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat1.z = dot(vs_TEXCOORD5.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat5.xyz);
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.xyz = u_xlat1.xxx * _LightColor0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD6.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat17 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = u_xlat2.xyz * vec3(u_xlat17) + _WorldSpaceLightPos0.xyz;
					    u_xlat2.xyz = vec3(u_xlat17) * u_xlat2.xyz;
					    u_xlat17 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat17 = inversesqrt(u_xlat17);
					    u_xlat3.xyz = vec3(u_xlat17) * u_xlat3.xyz;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat3.xyz);
					    u_xlat5.x = max(u_xlat5.x, 0.0);
					    u_xlat5.x = log2(u_xlat5.x);
					    u_xlat10 = _Gloss * 128.0;
					    u_xlat5.x = u_xlat5.x * u_xlat10;
					    u_xlat5.x = exp2(u_xlat5.x);
					    u_xlat10 = dot(_LightColor0.xyz, vec3(0.219999999, 0.707000017, 0.0710000023));
					    u_xlat1.w = u_xlat10 * u_xlat5.x;
					    u_xlat5.xy = vs_TEXCOORD6.yy * unity_WorldToLight[1].xy;
					    u_xlat5.xy = unity_WorldToLight[0].xy * vs_TEXCOORD6.xx + u_xlat5.xy;
					    u_xlat5.xy = unity_WorldToLight[2].xy * vs_TEXCOORD6.zz + u_xlat5.xy;
					    u_xlat5.xy = u_xlat5.xy + unity_WorldToLight[3].xy;
					    u_xlat3 = texture(_LightTexture0, u_xlat5.xy);
					    u_xlat5.x = u_xlat3.w + u_xlat3.w;
					    u_xlat1 = u_xlat5.xxxx * u_xlat1;
					    u_xlat5.x = u_xlat1.w * _Specular;
					    u_xlat5.xyz = u_xlat5.xxx * u_xlat1.xyz;
					    u_xlat3.xy = u_xlat0.xx * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD0.zw;
					    u_xlat13.xy = (-u_xlat0.xx) * vec2(vec2(_DistortionPower, _DistortionPower)) + vs_TEXCOORD1.xy;
					    u_xlat13.xy = _Time.xx * vec2(vec2(_Texture2Speed, _Texture2Speed)) + u_xlat13.xy;
					    u_xlat4 = texture(_Texture2, u_xlat13.xy);
					    u_xlat3.xy = _Time.xx * vec2(_MainTexSpeed) + u_xlat3.xy;
					    u_xlat3 = texture(_Texture1, u_xlat3.xy);
					    u_xlat3.xyz = u_xlat4.xyz * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat5.xyz;
					    u_xlat15 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat15 = (-u_xlat15) + 1.0;
					    u_xlat15 = u_xlat15 * _ProjectionParams.z;
					    u_xlat15 = max(u_xlat15, 0.0);
					    u_xlat15 = u_xlat15 * unity_FogParams.x;
					    u_xlat15 = u_xlat15 * (-u_xlat15);
					    u_xlat15 = exp2(u_xlat15);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    u_xlat0.xyz = u_xlat2.yyy * vs_TEXCOORD4.xyz;
					    u_xlat0.xyz = vs_TEXCOORD3.xyz * u_xlat2.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = vs_TEXCOORD5.xyz * u_xlat2.zzz + u_xlat0.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat5.x = _Opacity + _Opacity;
					    SV_Target0.w = (-u_xlat0.z) * u_xlat0.x + u_xlat5.x;
					    return;
					}"
				}
			}
		}
	}
	Fallback "JS Games/Diffuse"
}