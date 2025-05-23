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
	//CustomEditor "ShaderForgeMaterialInspector"
}