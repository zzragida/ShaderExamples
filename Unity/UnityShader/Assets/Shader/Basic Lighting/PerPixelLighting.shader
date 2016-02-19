Shader "Basics Lighting/Per-Pixel Lighting"
{
    Properties
    {
        _Color ("Diffuse Material Color", Color) = (1,1,1,1)
        _SpecColor ("Specular Material Color", Color) = (1,1,1,1)
        _Shininess ("Shininess", Float) = 10
    }
    SubShader
    {
        Pass
        {
            Tags { "LightMode" = "ForwardBase" }

            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0

            #include "UnityCG.cginc"

            uniform float4 _LightColor0;

            uniform float4 _Color;
            uniform float4 _SpecColor;
            uniform float _Shininess;


            struct vertexInput
            {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };

            struct vertexOutput
            {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
            };

            vertexOutput vert(vertexInput input)
            {
                vertexOutput o;

                float4x4 modelMatrix = _Object2World;
                float4x4 modelMatrixInverse = _World2Object;

                o.posWorld = mul(modelMatrix, input.vertex);
                o.normalDir = normalize(mul(float4(input.normal, 0.0), modelMatrixInverse).xyz);
                o.pos = mul(UNITY_MATRIX_MVP, input.vertex);
                return o;
            }

            // 레스터라이저(보간기)

            float4 frag(vertexOutput input) : SV_Target
            {
                float3 normalDirection = normalize(input.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos - input.posWorld.xyz);
                
                float3 lightDirection;
                float attenuation;
                if (0.0 == _WorldSpaceLightPos0.w) // direction light?
                {
                    attenuation = 1.0;
                    lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                }
                else // point or spot light
                {
                    float3 vertexToLightSource = _WorldSpaceLightPos0.xyz - input.posWorld.xyz;
                    float distance = length(vertexToLightSource);
                    attenuation = 1.0 / distance;
                    lightDirection = normalize(vertexToLightSource);
                }

                float3 ambientLighting = UNITY_LIGHTMODEL_AMBIENT.rgb * _Color.rgb;
                float3 diffuseReflection = attenuation * _LightColor0.rgb * _Color.rgb * max(0.0, dot(normalDirection, viewDirection));

                float3 specularReflection;
                if (dot(normalDirection, viewDirection) < 0.0)
                {
                    specularReflection = float3(0.0, 0.0, 0.0); 
                }
                else
                {
                    specularReflection = attenuation * _LightColor0.rgb * _SpecColor.rgb * pow(max(0.0, dot(reflect(-lightDirection, normalDirection), viewDirection)), _Shininess);
                }

                return float4(ambientLighting + diffuseReflection + specularReflection, 1.0);
            }
            ENDCG
        }        
    }
    Fallback "Specular"
}
