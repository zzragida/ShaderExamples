﻿Shader "Basics/Minimal"
{
    SubShader
    {
        Pass 
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            float4 vert(float4 vertexPos : POSITION) : SV_POSITION
            {
                vertexPos.y += _Time.y;
                return mul(UNITY_MATRIX_MVP, vertexPos);
            }

            float4 frag(void) : COLOR
            {
                return float4(0.0, 1.0, 1.0, 0.5);
            }
            ENDCG
        }
    }
}
