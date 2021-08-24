Shader "Custom/CutOut2"
{
    Properties
    {
        _TexAlpha("AlphaTex", 2D) = "white" {}
        _MainTex ("Wall", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }

        CGPROGRAM
        #pragma surface surf Lambert alpha:blend

        sampler2D _TexAlpha;
        sampler2D _MainTex;
        half _Alpha;

        struct Input
        {
            float2 uv_TexAlpha;
            float2 uv_MainTex;
        };

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed3 c = tex2D(_MainTex, IN.uv_MainTex).rgb;
            o.Albedo = c.rgb;
            fixed a = tex2D(_TexAlpha, IN.uv_TexAlpha).r;
            o.Alpha = a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}