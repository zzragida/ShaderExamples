Shader "Basics/Basic"
{
    Properties
    {
        _Color ("Fog Color", Color) = (0.1, 0.1, 0.1, 1.0)
    }

    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0

            float4 vert(fixed4 position : POSITION) : SV_POSITION
            {
                float4 pos = mul(UNITY_MATRIX_MVP, position);
                return pos;
            }

            float4 _Color;

            float4 frag() : COLOR
            {
                return _Color + unity_FogColor;
            }
            ENDCG
        }
    }
}