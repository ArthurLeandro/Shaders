Shader "Custom/UnlitLambert"
{
	Properties
	{
		_Color ("Color", Color) = (1, 1, 1, 1)
	}
	SubShader
	{
		Pass
		{
			Tags { "LightMode"="ForwardBase" }
			LOD 100

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_forwardbase
			
			#include "UnityCG.cginc"
			#include "UnityLightingCommon.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float3 worldNormal : TEXCOORD0;
			};
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				float3 worldNormal = UnityObjectToWorldNormal(v.normal);
				o.worldNormal = worldNormal;
				return o;
			}

			fixed4 _Color;
			
			fixed4 frag (v2f i) : SV_Target
			{
				float NdotL = max(0, dot(i.worldNormal, _WorldSpaceLightPos0.xyz));
				float4 diff = NdotL * _LightColor0;
				float4 col = _Color * diff;
				return col;
			}
			ENDCG
		}

		Pass
		{
			Tags { "LightMode"="ForwardAdd" }
			LOD 100
			Blend One One

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_forwardadd
			
			#include "UnityCG.cginc"
			#include "UnityLightingCommon.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float3 worldNormal : TEXCOORD0;
			};
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				float3 worldNormal = UnityObjectToWorldNormal(v.normal);
				o.worldNormal = worldNormal;
				return o;
			}

			fixed4 _Color;
			
			fixed4 frag (v2f i) : SV_Target
			{
				float NdotL = max(0, dot(i.worldNormal, _WorldSpaceLightPos0.xyz));
				float4 diff = NdotL * _LightColor0;
				float4 col = _Color * diff;
				return col;
			}
			ENDCG
		}
	}
}
