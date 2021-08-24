Shader "Custom/HalfLambertRamp"
{
    Properties
    {
        _Ramp("Tex", 2D) = "white" {}
        _Slider("Value", Range(-1, 1)) = .5
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf Ramp

        float _Slider;
        sampler2D _Ramp;

        struct Input
        {
            float2 uv_MainTex;
        };
        void surf(Input IN, inout SurfaceOutput o)
        {
            o.Albedo = tex2D(_Ramp, IN.uv_MainTex).rgb;
        }
        half4 LightingRamp(SurfaceOutput s, half3 lighDir, half atten)
        {
            half NdotL = saturate(dot(s.Normal, lighDir));
            half halfLambert = NdotL * .5 + .5;
            half diff = halfLambert * _Slider + _Slider;
            half3 ramp = tex2D(_Ramp, float2(diff, 0)).rgb;
            return half4(ramp, s.Alpha);
        }
        ENDCG
    }
    FallBack "Diffuse"
}