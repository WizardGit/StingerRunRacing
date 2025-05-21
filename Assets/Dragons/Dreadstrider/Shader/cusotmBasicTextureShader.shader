Shader "Custom/DecalWithMaskAndNormal"
{
    Properties
    {
        _DetailTex ("Base Texture", 2D) = "white" {}
        _DecalMap ("Decal Overlay", 2D) = "black" {}
        _DecalMask ("Decal Mask", 2D) = "black" {}
        _DecalOpacity ("Decal Opacity", Range(0,1)) = 1.0

        _BumpMap ("Normal Map", 2D) = "bump" {}
        _BumpStrength ("Bump Strength", Range(0,2)) = 1.0
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 300

        CGPROGRAM
        #pragma surface surf Standard fullforwardshadows

        sampler2D _DetailTex;
        sampler2D _DecalMap;
        sampler2D _DecalMask;
        float _DecalOpacity;

        sampler2D _BumpMap;
        float _BumpStrength;

        struct Input {
            float2 uv_DetailTex;
            float2 uv_DecalMap;
            float2 uv_DecalMask;
            float2 uv_BumpMap;
        };

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float4 baseColor = tex2D(_DetailTex, IN.uv_DetailTex);
            float4 decal = tex2D(_DecalMap, IN.uv_DecalMap);
            float mask = tex2D(_DecalMask, IN.uv_DecalMask).r;

            // Use mask and opacity to blend the decal
            float decalBlend = decal.a * _DecalOpacity * mask;
            float3 finalColor = lerp(baseColor.rgb, decal.rgb, decalBlend);

            o.Albedo = finalColor;

            // Normal mapping
            float3 normalTex = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
            o.Normal = normalize(lerp(float3(0, 0, 1), normalTex, _BumpStrength));
        }
        ENDCG
    }

    FallBack "Diffuse"
}
