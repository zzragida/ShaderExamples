﻿Shader "Basics Lighting/Specular Lighting"
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
            //Tags { "LightMode" = "ForwardAdd" }
            //Blend One One

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
                float4 col : COLOR;
            };

            vertexOutput vert(vertexInput input)
            {
                vertexOutput o;

                float4x4 modelMatrix = _Object2World;
                float4x4 modelMatrixInverse = _World2Object;

                float3 normalDirection = normalize(mul(float4(input.normal, 0.0), modelMatrixInverse).xyz);
                float3 viewDirection = normalize(_WorldSpaceCameraPos - mul(modelMatrix, input.vertex).xyz);
                float3 lightDirection;
                float attenuation;

                if (0.0 == _WorldSpaceLightPos0.w) // direction light
                {
                    attenuation = 1.0;
                    lightDirection = normalize(_WorldSpaceLightPos0.xyz);
                }
                else    // point or spot light
                {
                    float3 vertexToLightSource = _WorldSpaceLightPos0.xyz - mul(modelMatrix, input.vertex).xyz;
                    float distance = length(vertexToLightSource);
                    attenuation = 1.0 / distance;
                    lightDirection = normalize(vertexToLightSource);
                }

                float3 ambientLighting = UNITY_LIGHTMODEL_AMBIENT.rgb * _Color.rgb;
                float3 diffuseReflection = attenuation * _LightColor0.rgb * _Color.rgb * max(0.0, dot(normalDirection, lightDirection));

                float3 specularReflection;
                if (dot(normalDirection, lightDirection) < 0.0)
                {
                    specularReflection = float3(0.0, 0.0, 0.0);
                }
                else
                {
                    specularReflection = attenuation * _LightColor0.rgb * _SpecColor.rgb * pow(max(0.0, dot(reflect(-lightDirection, normalDirection), viewDirection)), _Shininess);
                }

                o.col = float4(ambientLighting + diffuseReflection + specularReflection, 1.0);
                o.pos = mul(UNITY_MATRIX_MVP, input.vertex);
                return o;
            }

            float4 frag(vertexOutput input) : SV_Target
            {
                return input.col;
            }
            ENDCG
        }
    }
}
