Shader "Mabel/Stencils/Stencil Writer"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        [PerRendererData] _MainTex ("Sprite Texture", 2D) = "white" {}
    }
    SubShader
    {
        Tags { "Queue"="Overlay" "RenderType"="Transparent" }

        Stencil
        {
            Ref 1
            Comp always
            Pass replace
        }

        Cull Off
        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha

        Pass
        {
            HLSLPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile _ UNITY_SINGLE_PASS_STEREO STEREO_INSTANCING_ON STEREO_MULTIVIEW_ON
            #include "UnityCG.cginc"

            sampler2D _MainTex;
            fixed4 _Color;
            float4 _MainTex_ST;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;

                UNITY_VERTEX_INPUT_INSTANCE_ID // Support for instancing
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 pos : SV_POSITION;

                UNITY_VERTEX_OUTPUT_STEREO // Ensure stereo support
            };

            v2f vert(appdata v)
            {
                v2f o;

                // Setup instance data if required
                UNITY_SETUP_INSTANCE_ID(v);
                UNITY_INITIALIZE_OUTPUT(v2f, o);
                UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

                // Apply transformation for stereo rendering
                o.pos = UnityObjectToClipPos(v.vertex);

                o.uv = TRANSFORM_TEX(v.uv, _MainTex);

                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return tex2D(_MainTex, i.uv) * _Color;
            }

            ENDHLSL
        }
    }

    FallBack Off
}