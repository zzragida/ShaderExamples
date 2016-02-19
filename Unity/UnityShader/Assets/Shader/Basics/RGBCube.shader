Shader "Basics/RGB Cube"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            struct vertexInput 
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct vertexOutput 
            {
                float4 pos : SV_POSITION;
                float4 col : TEXCOORD0;
            };

            vertexOutput vert (vertexInput i)
            {
                vertexOutput o;

                o.pos = mul(UNITY_MATRIX_MVP, i.vertex);
                o.col = i.vertex + float4(0.0, 1.0, 1.0, 0.5);
                return o;
            }

            float4 frag (vertexOutput input) : COLOR
            {
                return input.col;
            }
            ENDCG
        }
    }
}
