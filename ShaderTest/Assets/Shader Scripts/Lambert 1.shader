Shader "Custom/LambertAmbient" 
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
	}

	SubShader
	{
		Pass
		{
			Tags {"LightMode" = "ForwardBase"}

			CGPROGRAM
			#pragma vertex vertFunc
			#pragma fragment fragFunc

			/*user defined variables*/
			uniform float4 _Color;

			/*Unity defined variables*/
			uniform float4 _LightColor0;

			struct vertexInput
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};
	
			struct vertexOutput
			{
				float4 pos : SV_POSITION;
				float4 color : COLOR;
			};
	
			vertexOutput vertFunc(vertexInput input)
			{
				vertexOutput output;
				/*Multiplying normals by _World2Object to get them into object space, getting xyz component, and normalizing.*/
				float3 normalDirection = normalize(mul(float4(input.normal, 0.0), _World2Object).xyz);
				float3 lightDirection;
				/*distance of the light from object*/
				float attenuation = 1.0;

				lightDirection = normalize(_WorldSpaceLightPos0.xyz);
				/*distance * color of light * color of object*/
				float3 diffuseReflection = attenuation * _LightColor0.xyz * max(0.0, dot(normalDirection, lightDirection));
				float3 lightFinal = diffuseReflection + UNITY_LIGHTMODEL_AMBIENT.xyz;

				output.color = float4(diffuseReflection * lightFinal, 1.0);
				output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
				return output;
			}

			float4 fragFunc(vertexOutput output) : COLOR
			{
				return output.color;
			}

			ENDCG
		}
	}

	FallBack "Diffuse"
}
