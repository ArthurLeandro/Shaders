// Upgrade NOTE: upgraded instancing buffer 'Props' to new syntax.

Shader "Custom/ScrollingUvs" {
	Properties {
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_XSpeed ("X Scrolling Speed", Range(0,15)) = 3
		_YSpeed ("Y Scrolling Speed", Range(0,15)) = 3
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

		half _Glossiness;
		half _Metallic;
		fixed4 _Color;

		half _XSpeed;
		half _YSpeed;

		UNITY_INSTANCING_BUFFER_START(Props)
		UNITY_INSTANCING_BUFFER_END(Props)

		void surf (Input IN, inout SurfaceOutputStandard o) {
		    fixed2 texUVs = IN.uv_MainTex;

		    half scrolledX = _XSpeed * _Time;
		    half scrolledY = _YSpeed * _Time;

		    texUVs += half2(scrolledX, scrolledY);

			fixed4 c = tex2D (_MainTex, texUVs) * _Color;

			o.Albedo = c.rgb;
			o.Metallic = _Metallic;
			o.Smoothness = _Glossiness;
			o.Alpha = c.a;
		}
		ENDCG
	}
	FallBack "Diffuse"
}
