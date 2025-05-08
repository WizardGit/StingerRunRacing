Shader "Shader Forge/FX_BlendAddDSMesh" {
	Properties {
		_USpeedTextureA ("U Speed Texture A", Float) = 0
		_VSpeedTextureA ("V Speed Texture A", Float) = 0
		_USpeedTextureB ("U Speed Texture B", Float) = 0
		_VSpeedTextureB ("V Speed Texture B", Float) = 0
		_Alpha ("Alpha", 2D) = "white" {}
		_TexA ("Tex A", 2D) = "white" {}
		_TexB ("Tex B", 2D) = "white" {}
		[HideInInspector] _Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType" = "Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			o.Albedo = 1;
		}
		ENDCG
	}
	Fallback "JS Games/Diffuse"
	//CustomEditor "ShaderForgeMaterialInspector"
}