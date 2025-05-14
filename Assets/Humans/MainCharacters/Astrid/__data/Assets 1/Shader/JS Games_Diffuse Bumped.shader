Shader "JS Games/Diffuse Bumped" {
	Properties {
		_Color ("Main Color", Vector) = (1,1,1,1)
		_MainTex ("Base (RGB)", 2D) = "white" {}
		[NoScaleOffset] _BumpMap ("Normalmap", 2D) = "bump" {}
		_BumpIntensity ("Bump Intensity", Range(0, 5)) = 1
	}
	//DummyShaderTextExporter
	SubShader{
		Tags { "RenderType"="Opaque" }
		LOD 200
		CGPROGRAM
#pragma surface surf Standard
#pragma target 3.0

		sampler2D _MainTex;
		fixed4 _Color;
		struct Input
		{
			float2 uv_MainTex;
		};
		
		void surf(Input IN, inout SurfaceOutputStandard o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = c.rgb;
			o.Alpha = c.a;
		}
		ENDCG
	}
	Fallback "JS Games/Diffuse"
}