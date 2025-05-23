Shader "Hidden/MK/Glow/Composite" {
	Properties {
		_MainTex ("", 2D) = "Black" {}
		_MKGlowTexInner ("", 2D) = "Black" {}
		_MKGlowTexOuter ("", 2D) = "Black" {}
		_LensTex ("", 2D) = "White" {}
		_GlowTint ("", Vector) = (1,1,1,1)
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
}