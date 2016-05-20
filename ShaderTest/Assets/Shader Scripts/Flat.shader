Shader "Custom/Flat" 
{
	Properties
	{
		/*Variables w/ '_' can be adjusted by Unity.*/
		_Color("Color", Color) = (1.0, 1.0, 1.0, 1.0)
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vertFunc
			#pragma fragment fragFunc

			/*user defined variables*/
			uniform float4 _Color;

			struct vertexInput 
			{
				float4 vertex : POSITION;
			};

			struct vertexOutput 
			{
				float4 pos : SV_POSITION;
			};

			vertexOutput vertFunc(vertexInput input)
			{
				vertexOutput output;
				output.pos = mul(UNITY_MATRIX_MVP, input.vertex);
				return output;
			}

			float4 fragFunc(vertexOutput output) : COLOR
			{
				return _Color;
			}

			ENDCG
		}
	}

	FallBack "Diffuse"
}
