// Upgrade NOTE: upgraded instancing buffer 'Props' to new syntax.

Shader "Custom/InterpolatingTextures" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_SecondAlbedo ("Second Albedo (RGB)", 2D) = "white" {}
		_AlbedoLerp ("Albedo Lerp", Range(0,1)) = 0.5
		_Glossiness ("Smoothness", Range(0,1)) = 0.5
		_Metallic ("Metallic", Range(0,1)) = 0.0
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Standard fullforwardshadows
		#pragma target 3.0

		sampler2D _MainTex;

		struct Input {
			float2 uv_MainTex;
		};

		sampler2D _SecondAlbedo;
		half _AlbedoLerp;

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		UNITY_INSTANCING_BUFFER_START(Props)
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {
			half someValueThatShouldntBeHere = 0.3;
			fixed4 firstAlbedo = tex2D (_MainTex, IN.uv_MainTex);
			fixed4 secondAlbedo = tex2D (_SecondAlbedo, IN.uv_MainTex);
			o.Albedo = lerp(firstAlbedo, secondAlbedo, someValueThatShouldntBeHere) * _Color;

			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = firstAlbedo.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
