Shader "Custom/Sphere"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
    }
    SubShader
    {
        Tags {"Queue"="Geometry" "RenderType"="Opaque" "IgnoreProjection"="True"}
        Stencil // bloco de Stencil para ser comparado com o Shader do plano
        {
            Ref 2
            Comp Equal
        }

        CGPROGRAM
        #pragma surface surf Lambert
        sampler2D _MainTex;

        struct Input
        {
            float2 uv_MainTex;
        };

        fixed4 _Color;

        void surf (Input IN, inout SurfaceOutput o)
        {
            fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			o.Albedo = _Color;//half3(1, 0, 0); //c.rgb;
            o.Alpha = c.a;
        }
        ENDCG        
    }
}