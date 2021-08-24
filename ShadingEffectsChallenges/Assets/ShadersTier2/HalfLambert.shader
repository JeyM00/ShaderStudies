Shader "Custom/HalfLambert"
{
    Properties
    {
        _Emissive("Emissivo", Color) = (1,1,1,1)
        _Ambient("Ambient", Color) = (1,1,1,1)
        _Slider("Value", Range(-1, 1)) = .5
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf SimpleLambert

        float4 _Emissive;
        float4 _Ambient;
        float _Slider;

        struct Input
        {
            float2 uv_MainTex;
        };
        void surf(Input IN, inout SurfaceOutput o)
        {
            float4 c;
            c = pow((_Emissive + _Ambient), _Slider);

            o.Albedo = c.rgb;
            o.Alpha = c.a;
        }
        half4 LightingSimpleLambert (SurfaceOutput s, half3 lighDir, half atten)
        {
            half4 c = half4(0,0,0,1);
            half NdotL = dot(s.Normal, lighDir);
            half halfLambert = NdotL * .5 + .5;
            c.rgb = s.Albedo * _LightColor0.rgb * (halfLambert * atten);
            c.a = s.Alpha;
            return c;
        }
        ENDCG
    }
    FallBack "Diffuse"
}