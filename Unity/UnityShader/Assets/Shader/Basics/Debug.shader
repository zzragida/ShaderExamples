Shader "Basics/Debug"
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
                float4 tangent : TANGENT;  
                float3 normal : NORMAL;
                float4 texcoord : TEXCOORD0;  
                float4 texcoord1 : TEXCOORD1; 
                fixed4 color : COLOR; 
             };

             struct vertexOutput {
                float4 pos : SV_POSITION;
                float4 col : TEXCOORD0;
             };
 
             vertexOutput vert(vertexInput input) 
             {
                vertexOutput output;
 
                output.pos =  mul(UNITY_MATRIX_MVP, input.vertex);
                output.col = input.texcoord; // set the output color
                return output;
             }
 
             float4 frag(vertexOutput input) : COLOR 
             {
                return input.col; 
             }
            ENDCG
        }
    }
}
