Shader "Custom/WallPlane"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _Transparence("Transparence", Range(0, 1)) = 0.0
    }
    SubShader
    {
        Tags { "Queue"="Transparent" }

        Stencil
        {
            Ref 5
            Comp Always
            Pass replace
        }

        CGPROGRAM
        #pragma surface surf Standard alpha:blend

        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 _Color;
        half _Transparence;

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = c.rgb;
            o.Alpha = _Transparence;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
