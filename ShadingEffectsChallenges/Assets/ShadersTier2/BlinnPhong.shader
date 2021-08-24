Shader "Custom/HalfLambert"
{
    Properties
    {
        _Emissive("Emissivo", Color) = (1,1,1,1)
        _Ambient("Ambient", Color) = (1,1,1,1)
        _Slider("Value", Range(-1, 1)) = .5
        _Specular("Specular", Range (0, 100)) = 48
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf SimpleBlinnPhong

        float4 _Emissive;
        float4 _Ambient;
        float _Slider;
        float _Specular;

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
        half4 LightingSimpleBlinnPhong(SurfaceOutput s, half3 lightDir, half3 viewDir, half atten)
        {
            half3 h = normalize(lightDir + viewDir);
            half diff = max(0, dot(s.Normal, lightDir));
            float nh = max(0, dot(s.Normal, h));
            float spec = pow(nh, _Specular);
            half4 c = half4(s.Albedo, 1);
            half3 light = _LightColor0.rgb;
            c.rgb = (c * light * diff + light * spec) * atten;
            return c;
        }
        ENDCG
    }
    FallBack "Diffuse"
}