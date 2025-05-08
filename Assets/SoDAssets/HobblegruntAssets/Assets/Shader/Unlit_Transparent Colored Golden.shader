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
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		sampler2D _MainTex;
		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	//CustomEditor "ShaderForgeMaterialInspector"
}