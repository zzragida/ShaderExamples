Shader "Basics/Position"
{
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0

            uniform float4 _Position;
            uniform float4 _Color;

            struct vertexInput 
            {
                float4 vertex : POSITION;
            };

            struct vertexOutput 
            {
                float4 pos : SV_POSITION;
                float4 col : TEXCOORD0;
            };

            vertexOutput vert (vertexInput i)
            {
                vertexOutput o;

                //o.pos = mul(UNITY_MATRIX_MVP, i.vertex);
                o.pos = _Position;
                o.col = _Color;
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
