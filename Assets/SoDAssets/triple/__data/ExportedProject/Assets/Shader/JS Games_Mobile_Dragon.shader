Shader "JS Games/Mobile/Dragon" {
	Properties {
		_PrimaryColor ("Primary Color", Vector) = (1,1,1,1)
		_SecondaryColor ("Secondary Color", Vector) = (1,1,1,1)
		_TertiaryColor ("Tertiary Color", Vector) = (1,1,1,1)
		_DetailTex ("Detail (RGB)", 2D) = "white" {}
		[NoScaleOffset] _ColorMask ("ColorMask", 2D) = "white" {}
		[NoScaleOffset] _EmissiveMap ("Emissive", 2D) = "white" {}
		[HDR] _EmissiveColor ("Emissive Color", Vector) = (0,0,0,1)
		_DecalMap ("Decal", 2D) = "white" {}
		_DecalOpacity ("Decal Opacity", Range(0, 1)) = 0
		_MKGlowColor ("Glow Color", Vector) = (1,1,1,1)
		_MKGlowPower ("Glow Power", Range(0, 2.5)) = 0
		_MKGlowTex ("Glow Texture", 2D) = "black" {}
		_MKGlowTexColor ("Glow Texture Color", Vector) = (1,1,1,1)
		_MKGlowTexStrength ("Glow Texture Strength ", Range(0, 10)) = 0
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
	Fallback "Legacy Shaders/Specular"
}