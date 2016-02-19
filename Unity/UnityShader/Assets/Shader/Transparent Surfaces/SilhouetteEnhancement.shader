Shader "Transparent Surfaces/Silhouette Enhancement"
{    
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 0.5)
    }

    SubShader
    {
        Tags { "Queue" = "Transparent" }

        Pass
        {
            ZWrite Off
            Blend SrcAlpha OneMinusSrcAlpha

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0
            #include "UnityCG.cginc"

            uniform float4 _Color;

            struct vertexInput
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct vertexOutput
            {
                float4 pos : SV_POSITION;
                float3 normal : TEXCOORD0;
                float3 viewDir : TEXCOORD1;
            };

            vertexOutput vert(vertexInput input)
            {
                vertexOutput o;

                float4x4 modelMatrix = _Object2World;
                float4x4 modelMatrixInverse = _World2Object;

                o.normal = normalize(mul(float4(input.normal, 0.0), modelMatrixInverse).xyz);
                o.viewDir = normalize(_WorldSpaceCameraPos - mul(modelMatrix, input.vertex).xyz);
                
                o.pos = mul(UNITY_MATRIX_MVP, input.vertex);
                return o;
            }

            float4 frag(vertexOutput input) : COLOR
            {
                float3 normalDirection = normalize(input.normal);
                float3 viewDirection = normalize(input.viewDir);
                float newOpacity = min(1.0, _Color.a / abs(dot(viewDirection, normalDirection)));
                return float4(_Color.rgb, newOpacity);
            }
            ENDCG
        }
    }
}