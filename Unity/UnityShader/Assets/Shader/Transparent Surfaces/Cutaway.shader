Shader "Transparent Surfaces/Cutaway"
{    
    SubShader
    {
		// First pass
        Pass
        {
            //Cull Off
            //Cull Back
            Cull Front

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0

            struct vertexInput
            {
                float4 vertex : POSITION;
            };

            struct vertexOutput
            {
                float4 pos : SV_POSITION;
                float4 posInObjectCoords : TEXCOORD0;
            };

            vertexOutput vert(vertexInput input)
            {
                vertexOutput o;

                o.pos = mul(UNITY_MATRIX_MVP, input.vertex);
                o.posInObjectCoords = input.vertex;
                return o;
            }

            float4 frag(vertexOutput input) : COLOR
            {
                if (input.posInObjectCoords.y > 0.3)
                {
                    discard;
                }
                return float4(0.0, 1.0, 0.0, 1.0);
            }
            ENDCG
        }

		// Second Pass
		Pass
		{
			Cull Back

			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

            struct vertexInput
            {
                float4 vertex : POSITION;
            };
            
            struct vertexOutput
            {
                float4 pos : SV_POSITION;
                float4 posInObjectCoords : TEXCOORD0;  
            };
            
            vertexOutput vert(vertexInput input)
            {
                vertexOutput o;
                
                o.pos = mul(UNITY_MATRIX_MVP, input.vertex);
                o.posInObjectCoords = input.vertex;
                return o;
            }
            
            float4 frag(vertexOutput input) : COLOR
            {
                if (input.posInObjectCoords.y > 0.0)
                {
                    discard;
                }
                return float4(0.0, 1.0, 0.0, 1.0);
            }
			ENDCG
		}
    }
}