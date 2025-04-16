Shader "Mabel/Stencils/Stencil Target"
{
    Properties
    {
        _BaseColor ("Base Color", Color) = (1,1,1,1)
        _MainTex ("Texture", 2D) = "white" {}
    }

    SubShader
    {
        Tags { "RenderType"="Transparent" "Queue"="Overlay+1" }

        Stencil
        {
            Ref 1
            Comp Equal
            Pass Keep
            Fail Keep
            ZFail Keep
        }

        ZTest LEqual
        ZWrite On
        Cull Off
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
			#pragma multi_compile _ UNITY_SINGLE_PASS_STEREO STEREO_INSTANCING_ON STEREO_MULTIVIEW_ON
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;

                UNITY_VERTEX_INPUT_INSTANCE_ID // For instance ID support
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;

                UNITY_VERTEX_OUTPUT_STEREO // For stereo rendering support
            };

            sampler2D _MainTex;
            float4 _BaseColor;

            // Vertex shader
            v2f vert(appdata v)
            {
                v2f o;

                // Handle instancing
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_OUTPUT(v2f, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                // Apply the correct transformation for stereo rendering
                o.vertex = UnityObjectToClipPos(v.vertex);

                o.uv = v.uv;

                return o;
            }

            // Fragment shader
            float4 frag(v2f i) : SV_Target
            {
                // Sample texture and apply color
                float4 texColor = tex2D(_MainTex, i.uv);
                return texColor * _BaseColor;
            }

            ENDHLSL
        }
    }

    FallBack Off
}
