Shader "Transparent Surfaces/Transparent"
{    
    SubShader
    {
        Tags { "Queue" = "Transparent" }

        Pass
        {
            Cull Back
            ZWrite Off // don't write to depth buffer
            Blend SrcAlpha OneMinusSrcAlpha // Alpha Blending

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0

            float4 vert(float4 position : POSITION) : SV_POSITION
            {
                return mul(UNITY_MATRIX_MVP, position);
            }

            float4 frag(void) : COLOR
            {
                return float4(0.0, 1.0, 0.0, 0.3);
            }
            ENDCG
        }
        
        Pass
        {
            Cull Back
            ZWrite off
            Blend SrcAlpha OneMinusSrcAlpha
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            float4 vert(float4 position : POSITION) : SV_POSITION
            {
                return mul(UNITY_MATRIX_MVP, position);
            }
            
            float4 frag(void) : COLOR
            {
                return float4(0.0, 1.0, 0.0, 0.3);
            }
            ENDCG
        }
    }
}