Shader "Basics/World"
{
    SubShader
    {
        Pass
        {
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
                float4 position_in_world_space : TEXCOORD0;
            };

            vertexOutput vert (vertexInput input)
            {
                vertexOutput o;
                
                o.pos = mul(UNITY_MATRIX_MVP, input.vertex);
                o.position_in_world_space = mul(_Object2World, input.vertex);
                return o;
            }

            float4 frag (vertexOutput input) : COLOR
            {
                float dist = distance(input.position_in_world_space, float4(0.0, 0.0, 0.0, 1.0));
                if (dist < 5.0)
                {
                    return float4(0.0, 1.0, 0.0, 1.0); 
                }
                else
                {
                    return float4(0.1, 0.1, 0.1, 1.0);
                }
            }
            ENDCG
        }
    }
}
