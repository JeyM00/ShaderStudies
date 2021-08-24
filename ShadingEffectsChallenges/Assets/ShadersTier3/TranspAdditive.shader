Shader "Unlit/TranspAdditive"
{
    Properties
    {
        _MainTex1 ("Texture1", 2D) = "white" {}
        _MainTex2 ("Texture2", 2D) = "white" {}
    }
    SubShader
    {
        Pass
        {
            SetTexture[_MainTex2]
            {
                combine texture
            }
        }
        Pass
        {
            Blend One One
            SetTexture[_MainTex1]
            {
                combine texture
            }
        }
    }
}