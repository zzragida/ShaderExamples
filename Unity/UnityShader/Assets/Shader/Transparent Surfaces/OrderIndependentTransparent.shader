Shader "Transparent Surfaces/Order-Independent Transparent"
{    
    SubShader
    {
        Tags { "Queue" = "Transparent" }

        Pass
        {
            Cull Off    // draw front and back faces
            ZWrite Off  // don't write to depth buffer 
            //Blend SrcAlpha One  // additive blending
            Blend Zero OneMinusSrcAlpha // multiplicative blending 

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
            Cull Off
            ZWrite Off
            Blend SrcAlpha One
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            float4 vert(float4 position : POSITION) : SV_POSITION
            {
                return mul(UNITY_MATRIX_MVP, position);
            }
            
            float4 frag(void) : COLOR
            {
                return float4(1.0, 0.0, 0.0, 0.3);
            }
            ENDCG
        }
    }
}