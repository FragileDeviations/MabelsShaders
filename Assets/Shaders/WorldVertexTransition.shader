// Made with Amplify Shader Editor v1.9.9.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
// Force reimport: 2
Shader "Mabel/Source/WorldVertexTransition"
{
	Properties
	{
		[Header(Global Settings)][Space(5)] _TilingOffset( "Tiling & Offset", Vector ) = ( 1, 1, 0, 0 )
		[NoScaleOffset] _BlendModulateMap( "Blend Modulate Map", 2D ) = "black" {}
		_BlendModulateContrast( "BlendModulateContrast", Range( 0, 4 ) ) = 1
		_VertexBlendStrength( "Vertex Blend Strength", Range( 0, 1 ) ) = 1
		[Toggle] _UseVertexAlpha( "Use Vertex Alpha", Range( 0, 1 ) ) = 0
		_BlendFactor( "Blend Factor", Range( 0, 1 ) ) = 0
		[NoScaleOffset][Header(Texture Set 1)][Space(5)] _BaseMap( "Base Map", 2D ) = "white" {}
		_BaseColor( "Base Color", Color ) = ( 1, 1, 1, 1 )
		[NoScaleOffset][Normal][Space(20)] _BumpMap( "Normal Map", 2D ) = "bump" {}
		[NoScaleOffset][Space(20)] _MetallicGlossMap( "MAS", 2D ) = "white" {}
		[NoScaleOffset][Space(20)] _EmissionMap( "Emission Map", 2D ) = "white" {}
		[HDR] _EmissionColor( "Emission Color", Color ) = ( 0, 0, 0, 1 )
		_EmissionFalloff( "Emission Falloff", Float ) = 1
		_BakedMutiplier( "Emission Baked Mutiplier", Float ) = 1
		[NoScaleOffset][Space(10)][Header(Texture Set 2)][Space(5)] _BaseMap2( "Base Map", 2D ) = "white" {}
		_BaseColor2( "Base Color", Color ) = ( 1, 1, 1, 1 )
		[NoScaleOffset][Normal][Space(20)] _BumpMap2( "Normal Map", 2D ) = "bump" {}
		[NoScaleOffset][Space(20)] _MetallicGlossMap2( "MAS", 2D ) = "white" {}
		[NoScaleOffset][Space(20)] _EmissionMap2( "Emission Map", 2D ) = "white" {}
		[HDR] _EmissionColor2( "Emission Color", Color ) = ( 0, 0, 0, 1 )
		_EmissionFalloff2( "Emission Falloff", Float ) = 1
		_BakedMutiplier2( "Emission Baked Mutiplier", Float ) = 1
		[Space(30)][Header(Mono SH)][Space(10)][Toggle( _MONOSHENABLED_ON )] _MonoSHEnabled( "MonoSH Enabled", Float ) = 0
		_MonoSHAdjustment( "Mono SH Adjustment", Range( 0, 10 ) ) = 1
		_Cull( "Cull Mode", Int ) = 2

		[Space(30)][Header(Screen Space Reflections)][Space(10)][Toggle(_NO_SSR)] _SSROff("Disable SSR", Float) = 0
		[Header(This should be 0 for skinned meshes)]
		_SSRTemporalMul("Temporal Accumulation Factor", Range(0, 2)) = 1.0
		//[Toggle(_SM6_QUAD)] _SM6_Quad("Quad-avg SSR", Float) = 0


	}
	SubShader
	{
		LOD 0

		
		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="Opaque" "Queue"="Geometry" }
		
		Blend One Zero
		ZWrite On
		Cull [_Cull]
		ZTest LEqual
		Offset 0 , 0
		ColorMask RGBA
		//LOD 100
		

		
		Pass
		{

			

			Name "Forward"
			Tags { "Lightmode"="UniversalForward" }
			
			HLSLPROGRAM
			#define _SurfaceOpaque
			#pragma multi_compile_fog
			#define LITMAS_FEATURE_LIGHTMAPPING
			#pragma multi_compile_fragment _ _VOLUMETRICS_ENABLED
			#define LITMAS_FEATURE_EMISSION
			#define PC_REFLECTION_PROBE_BLENDING
			#define PC_REFLECTION_PROBE_BOX_PROJECTION
			#define PC_RECEIVE_SHADOWS
			#define PC_SSAO
			#define MOBILE_LIGHTS_VERTEX
			#define _ALPHATEST_ON 1
			#define ASE_VERSION 19908
			#define ASE_SRP_VERSION -1

			#pragma vertex vert
			#pragma fragment frag
			#pragma target 5.0

			
			#define LITMAS_FEATURE_TS_NORMALS
			
			#define LITMAS_FEATURE_SSR
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/PlatformCompiler.hlsl"
			#if defined(SHADER_API_DESKTOP)
			
			
			
			
			#endif

			//StandardForward------------------------------------------------------------------------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
			//
			//
			//-----------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
					
					
			#define SHADERPASS SHADERPASS_FORWARD
			#define _NORMAL_DROPOFF_TS 1
			#define _EMISSION
			#define _NORMALMAP 1
					
			#if defined(SHADER_API_MOBILE)
			#if defined(MOBILE_LIGHTS_VERTEX)
				#define _ADDITIONAL_LIGHTS_VERTEX
			#endif
					
			#if defined(MOBILE_RECEIVE_SHADOWS)
				#undef _RECEIVE_SHADOWS_OFF
				#define _MAIN_LIGHT_SHADOWS
				#define _ADDITIONAL_LIGHT_SHADOWS
				#pragma multi_compile_fragment  _  _MAIN_LIGHT_SHADOWS_CASCADE
				#pragma multi_compile_fragment _ _ADDITIONAL_LIGHTS
				#pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
				#define _SHADOWS_SOFT 1
			#else
				#define _RECEIVE_SHADOWS_OFF 1
			#endif
					
			#if defined(MOBILE_SSAO)
				#pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
			#endif
					
			#if defined(MOBILE_REFLECTION_PROBE_BLENDING)
				#define _REFLECTION_PROBE_BLENDING
			#endif
					
			#if defined(MOBILE_REFLECTION_PROBE_BOX_PROJECTION)
				#define _REFLECTION_PROBE_BOX_PROJECTION 
			#endif
						
			#else
					
			//#define DYNAMIC_SCREEN_SPACE_OCCLUSION
			#if defined(PC_SSAO)
			#pragma multi_compile_fragment _ _SCREEN_SPACE_OCCLUSION
			#endif
					
			//#define DYNAMIC_ADDITIONAL_LIGHTS
			#if defined(PC_RECEIVE_SHADOWS)
				#undef _RECEIVE_SHADOWS_OFF
				#pragma multi_compile_fragment  _  _MAIN_LIGHT_SHADOWS_CASCADE
			#pragma multi_compile_fragment _ _ADDITIONAL_LIGHTS
					
					
			//#define DYNAMIC_ADDITIONAL_LIGHT_SHADOWS
			#pragma multi_compile_fragment _ _ADDITIONAL_LIGHT_SHADOWS
					
				#define _SHADOWS_SOFT 1
			#else
				#define _RECEIVE_SHADOWS_OFF 1
			#endif
					
			#if defined(PC_REFLECTION_PROBE_BLENDING)
				#define _REFLECTION_PROBE_BLENDING
			#endif
				//#pragma shader_feature_fragment _REFLECTION_PROBE_BOX_PROJECTION
				// We don't need a keyword for this! the w component of the probe position already branches box vs non-box, & so little cost on pc it doesn't matter
			#if defined(PC_REFLECTION_PROBE_BOX_PROJECTION)
				#define _REFLECTION_PROBE_BOX_PROJECTION 
			#endif
					
			// Begin Injection STANDALONE_DEFINES from Injection_SSR.hlsl ----------------------------------------------------------
			#pragma multi_compile _ _SLZ_SSR_ENABLED
			#pragma shader_feature_local _ _NO_SSR
			#if defined(_SLZ_SSR_ENABLED) && !defined(_NO_SSR) && !defined(SHADER_API_MOBILE)
				#define _SSR_ENABLED
			#endif
			// End Injection STANDALONE_DEFINES from Injection_SSR.hlsl ----------------------------------------------------------
					
			#endif
					
			#pragma multi_compile_fragment _ _LIGHT_COOKIES
			#pragma multi_compile _ SHADOWS_SHADOWMASK
			//#pragma multi_compile_fragment _ _VOLUMETRICS_ENABLED
			//#pragma multi_compile_fog
			//#pragma skip_variants FOG_LINEAR FOG_EXP
			//#pragma multi_compile_fragment _ DEBUG_DISPLAY
			//#pragma multi_compile_fragment _ _DETAILS_ON
			//#pragma multi_compile_fragment _ _EMISSION_ON
					
					
			#if defined(LITMAS_FEATURE_LIGHTMAPPING)
				#pragma multi_compile _ LIGHTMAP_ON
				#pragma multi_compile _ DYNAMICLIGHTMAP_ON
				#pragma multi_compile _ DIRLIGHTMAP_COMBINED
				#pragma multi_compile _ LIGHTMAP_SHADOW_MIXING
			#endif
					
					
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/DBuffer.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Packing.hlsl"
			#undef UNITY_DECLARE_DEPTH_TEXTURE_INCLUDED
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SLZLighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SLZBlueNoise.hlsl"
					
			// Begin Injection INCLUDES from Injection_SSR.hlsl ----------------------------------------------------------
			#if !defined(SHADER_API_MOBILE)
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SLZLightingSSR.hlsl"
			#endif
			// End Injection INCLUDES from Injection_SSR.hlsl ----------------------------------------------------------
					
					
			#include "Packages/com.fragiledeviations.mabelsshaders/Assets/Shaders/Include/DecodeMonoSH.hlsl"
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_WORLD_POSITION
			#define ASE_NEEDS_FRAG_WORLD_POSITION
			#define ASE_NEEDS_VERT_NORMAL
			#define ASE_NEEDS_VERT_TANGENT
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#pragma shader_feature_local _MONOSHENABLED_ON

					
			struct VertIn
			{
				float4 vertex   : POSITION;
				float3 normal    : NORMAL;
				float4 tangent   : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_color : COLOR;
			};
			
			struct VertOut
			{
				float4 vertex       : SV_POSITION;
				float4 uv0XY_bitZ_fog : TEXCOORD0;
			#if defined(LIGHTMAP_ON) || defined(DYNAMICLIGHTMAP_ON)
				float4 uv1 : TEXCOORD1;
			#endif
				half4 SHVertLights : TEXCOORD2;
				half4 normXYZ_tanX : TEXCOORD3;
				float3 wPos : TEXCOORD4;
			
			// Begin Injection INTERPOLATORS from Injection_SSR.hlsl ----------------------------------------------------------
				float4 lastVertex : TEXCOORD5;
			// End Injection INTERPOLATORS from Injection_SSR.hlsl ----------------------------------------------------------
			// Begin Injection INTERPOLATORS from Injection_NormalMaps.hlsl ----------------------------------------------------------
				half4 tanYZ_bitXY : TEXCOORD6;
			// End Injection INTERPOLATORS from Injection_NormalMaps.hlsl ----------------------------------------------------------
			
				float4 ase_color : COLOR;
				float4 ase_texcoord7 : TEXCOORD7;
				float4 ase_texcoord8 : TEXCOORD8;
				float4 ase_texcoord9 : TEXCOORD9;
				float4 ase_texcoord10 : TEXCOORD10;
				UNITY_VERTEX_INPUT_INSTANCE_ID
					UNITY_VERTEX_OUTPUT_STEREO
			};
			
			//TEXTURE2D(_BaseMap);
			//SAMPLER(sampler_BaseMap);
			
			//TEXTURE2D(_BumpMap);
			//TEXTURE2D(_MetallicGlossMap);
			
			//TEXTURE2D(_DetailMap);
			//SAMPLER(sampler_DetailMap);
			
			// Begin Injection UNIFORMS from Injection_Emission.hlsl ----------------------------------------------------------
			//TEXTURE2D(_EmissionMap);
			// End Injection UNIFORMS from Injection_Emission.hlsl ----------------------------------------------------------
			
			CBUFFER_START(UnityPerMaterial)
				float4 _TilingOffset;
				float4 _BaseColor;
				float4 _BaseColor2;
				float4 _BlendModulateMap_ST;
				float4 _EmissionColor;
				float4 _EmissionColor2;
				float _VertexBlendStrength;
				float _BlendFactor;
				float _UseVertexAlpha;
				float _BlendModulateContrast;
				float _EmissionFalloff;
				float _EmissionFalloff2;
				float _MonoSHAdjustment;
				float _BakedMutiplier;
				float _BakedMutiplier2;
				int _Cull;
				//float4 _BaseMap_ST;
				//half4 _BaseColor;
			// Begin Injection MATERIAL_CBUFFER from Injection_NormalMap_CBuffer.hlsl ----------------------------------------------------------
			//float4 _DetailMap_ST;
			//half  _Details;
			//half  _Normals;
			// End Injection MATERIAL_CBUFFER from Injection_NormalMap_CBuffer.hlsl ----------------------------------------------------------
			// Begin Injection MATERIAL_CBUFFER from Injection_SSR_CBuffer.hlsl ----------------------------------------------------------
				float _SSRTemporalMul;
			// End Injection MATERIAL_CBUFFER from Injection_SSR_CBuffer.hlsl ----------------------------------------------------------
			// Begin Injection MATERIAL_CBUFFER from Injection_Emission.hlsl ----------------------------------------------------------
				//half  _Emission;
				//half4 _EmissionColor;
				//half  _EmissionFalloff;
				//half  _BakedMutiplier;
			// End Injection MATERIAL_CBUFFER from Injection_Emission.hlsl ----------------------------------------------------------
				//int _Surface;
			CBUFFER_END
			sampler2D _BaseMap;
			sampler2D _BaseMap2;
			sampler2D _BlendModulateMap;
			sampler2D _BumpMap;
			sampler2D _BumpMap2;
			sampler2D _EmissionMap;
			sampler2D _EmissionMap2;
			sampler2D _MetallicGlossMap;
			sampler2D _MetallicGlossMap2;

			
			float SourceBlendModulateFactor158( float2 uv, float vertexAlpha, float _VertexBlendStrength, float _BlendFactor, float _BlendUseVertexAlpha, float4 _BlendModulateMap_ST, float3 _BlendModulateMap, float2 blendModUV, float2 blendModRG, float _BlendModulateContrast )
			{
				float scaledVertexAlpha = vertexAlpha * _VertexBlendStrength;
				float blendInput = saturate( _BlendFactor + ( scaledVertexAlpha * _BlendUseVertexAlpha ) );
				float halfWidth = max( blendModRG.r * _BlendModulateContrast * 0.5, 0.001 );
				float biasCenter = blendModRG.g;
				return smoothstep( biasCenter - halfWidth, biasCenter + halfWidth, blendInput );
			}
			
			inline float3 MyCustomExpression( half4 In0 )
			{
				return UnpackNormal(In0);;
			}
			
			
			half3 OverlayBlendDetail(half source, half3 destination)
			{
				half3 switch0 = round(destination); // if destination >= 0.5 then 1, else 0 assuming 0-1 input
				half3 blendGreater = mad(mad(2.0, destination, -2.0), 1.0 - source, 1.0); // (2.0 * destination - 2.0) * ( 1.0 - source) + 1.0
				half3 blendLesser = (2.0 * source) * destination;
				return mad(switch0, blendGreater, mad(-switch0, blendLesser, blendLesser)); // switch0 * blendGreater + (1 - switch0) * blendLesser 
				//return half3(destination.r > 0.5 ? blendGreater.r : blendLesser.r,
				//             destination.g > 0.5 ? blendGreater.g : blendLesser.g,
				//             destination.b > 0.5 ? blendGreater.b : blendLesser.b
				//            );
			}
			
			
			VertOut vert(VertIn v  )
			{
				VertOut o = (VertOut)0;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
			
				float3 ase_normalWS = TransformObjectToWorldNormal( v.normal );
				o.ase_texcoord7.xyz = ase_normalWS;
				float3 ase_tangentWS = TransformObjectToWorldDir( v.tangent.xyz );
				o.ase_texcoord8.xyz = ase_tangentWS;
				float ase_tangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
				o.ase_texcoord9.xyz = ase_bitangentWS;
				
				o.ase_color = v.ase_color;
				o.ase_texcoord10.xy = v.uv1.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord7.w = 0;
				o.ase_texcoord8.w = 0;
				o.ase_texcoord9.w = 0;
				o.ase_texcoord10.zw = 0;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				v.normal = v.normal;
			
				o.wPos = TransformObjectToWorld(v.vertex.xyz);
				o.vertex = TransformWorldToHClip(o.wPos);
				o.uv0XY_bitZ_fog.xy = v.uv0.xy;
			
			#if defined(LIGHTMAP_ON) || defined(DIRLIGHTMAP_COMBINED)
				OUTPUT_LIGHTMAP_UV(v.uv1.xy, unity_LightmapST, o.uv1.xy);
			#endif
			
			#ifdef DYNAMICLIGHTMAP_ON
				OUTPUT_LIGHTMAP_UV(v.uv2.xy, unity_DynamicLightmapST, o.uv1.zw);
			#endif
			
				// Exp2 fog
				half clipZ_0Far = UNITY_Z_0_FAR_FROM_CLIPSPACE(o.vertex.z);
				o.uv0XY_bitZ_fog.w = unity_FogParams.x * clipZ_0Far;
			
			// Begin Injection VERTEX_NORMALS from Injection_NormalMaps.hlsl ----------------------------------------------------------
				VertexNormalInputs ntb = GetVertexNormalInputs(v.normal, v.tangent);
				o.normXYZ_tanX = half4(ntb.normalWS, ntb.tangentWS.x);
				o.tanYZ_bitXY = half4(ntb.tangentWS.yz, ntb.bitangentWS.xy);
				o.uv0XY_bitZ_fog.z = ntb.bitangentWS.z;
			// End Injection VERTEX_NORMALS from Injection_NormalMaps.hlsl ----------------------------------------------------------
			
				o.SHVertLights = 0;
				// Calculate vertex lights and L2 probe lighting on quest 
				o.SHVertLights.xyz = VertexLighting(o.wPos, o.normXYZ_tanX.xyz);
			#if !defined(LIGHTMAP_ON) && !defined(DYNAMICLIGHTMAP_ON) && defined(SHADER_API_MOBILE)
				o.SHVertLights.xyz += SampleSHVertex(o.normXYZ_tanX.xyz);
			#endif
			
			// Begin Injection VERTEX_END from Injection_SSR.hlsl ----------------------------------------------------------
				#if defined(_SSR_ENABLED)
					float4 lastWPos = mul(GetPrevObjectToWorldMatrix(), v.vertex);
					o.lastVertex = mul(prevVP, lastWPos);
				#endif
			// End Injection VERTEX_END from Injection_SSR.hlsl ----------------------------------------------------------
				return o;
			}
			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE)
				#define ASE_SV_DEPTH SV_DepthLessEqual  
			#else
				#define ASE_SV_DEPTH SV_Depth
			#endif
			
			half4 frag(VertOut i 
				#ifdef ASE_DEPTH_WRITE_ON
				, out float outputDepth : ASE_SV_DEPTH
				#endif
				) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				float2 appendResult132 = (float2(_TilingOffset.x , _TilingOffset.y));
				float2 appendResult133 = (float2(_TilingOffset.z , _TilingOffset.w));
				float2 texCoord27 = i.uv0XY_bitZ_fog.xy * appendResult132 + appendResult133;
				float2 TextureCoordinates32 = texCoord27;
				float2 texCoord148 = i.uv0XY_bitZ_fog.xy * appendResult132 + appendResult133;
				float2 uv158 = texCoord148;
				float vertexAlpha158 = i.ase_color.r;
				float _VertexBlendStrength158 = _VertexBlendStrength;
				float _BlendFactor158 = _BlendFactor;
				float _BlendUseVertexAlpha158 = _UseVertexAlpha;
				float4 uvs4_BlendModulateMap = float4(i.uv0XY_bitZ_fog.xy,0,0);
				uvs4_BlendModulateMap.xy = float4(i.uv0XY_bitZ_fog.xy,0,0).xy * _BlendModulateMap_ST.xy + _BlendModulateMap_ST.zw;
				float4 _BlendModulateMap_ST158 = uvs4_BlendModulateMap;
				float4 tex2DNode154 = tex2D( _BlendModulateMap, texCoord27 );
				float3 _BlendModulateMap158 = tex2DNode154.rgb;
				float2 appendResult146 = (float2(uvs4_BlendModulateMap.x , uvs4_BlendModulateMap.y));
				float2 appendResult147 = (float2(uvs4_BlendModulateMap.z , uvs4_BlendModulateMap.w));
				float2 blendModUV158 = ( texCoord148 * ( appendResult146 + appendResult147 ) );
				float2 appendResult156 = (float2(tex2DNode154.r , tex2DNode154.g));
				float2 blendModRG158 = appendResult156;
				float _BlendModulateContrast158 = _BlendModulateContrast;
				float localSourceBlendModulateFactor158 = SourceBlendModulateFactor158( uv158 , vertexAlpha158 , _VertexBlendStrength158 , _BlendFactor158 , _BlendUseVertexAlpha158 , _BlendModulateMap_ST158 , _BlendModulateMap158 , blendModUV158 , blendModRG158 , _BlendModulateContrast158 );
				float VertexColor42 = localSourceBlendModulateFactor158;
				float4 lerpResult38 = lerp( ( tex2D( _BaseMap, TextureCoordinates32 ) * _BaseColor ) , ( tex2D( _BaseMap2, TextureCoordinates32 ) * _BaseColor2 ) , VertexColor42);
				float4 Albedo52 = lerpResult38;
				
				float4 tex2DNode8 = tex2D( _BumpMap, TextureCoordinates32 );
				float4 In02_g202 = tex2DNode8;
				float3 localMyCustomExpression2_g202 = MyCustomExpression( In02_g202 );
				float4 tex2DNode67 = tex2D( _BumpMap2, TextureCoordinates32 );
				float4 In02_g203 = tex2DNode67;
				float3 localMyCustomExpression2_g203 = MyCustomExpression( In02_g203 );
				float3 lerpResult69 = lerp( localMyCustomExpression2_g202 , localMyCustomExpression2_g203 , VertexColor42);
				float3 NormalMap72 = lerpResult69;
				
				#ifdef _MONOSHENABLED_ON
				int staticSwitch32_g204 = 1;
				#else
				int staticSwitch32_g204 = 0;
				#endif
				float3 ase_viewVectorWS = ( ( unity_OrthoParams.w == 0 ) ? _WorldSpaceCameraPos - i.wPos.xyz : UNITY_MATRIX_V[ 2 ].xyz );
				float3 ase_viewDirWS = normalize( ase_viewVectorWS );
				float3 ase_normalWS = i.ase_texcoord7.xyz;
				float dotResult97 = dot( ase_viewDirWS , ase_normalWS );
				float4 temp_output_76_0 = ( tex2D( _EmissionMap, TextureCoordinates32 ) * _EmissionColor * saturate( pow( abs( dotResult97 ) , _EmissionFalloff ) ) );
				float dotResult108 = dot( ase_viewDirWS , ase_normalWS );
				float4 temp_output_79_0 = ( tex2D( _EmissionMap2, TextureCoordinates32 ) * _EmissionColor2 * saturate( pow( abs( dotResult108 ) , _EmissionFalloff2 ) ) );
				float4 lerpResult80 = lerp( temp_output_76_0 , temp_output_79_0 , VertexColor42);
				float4 Emission83 = lerpResult80;
				float3 temp_output_13_0_g204 = Emission83.rgb;
				float4 tex2DNode6 = tex2D( _MetallicGlossMap, TextureCoordinates32 );
				float4 appendResult121 = (float4(tex2DNode6.r , tex2DNode6.g , saturate( ( ( tex2DNode8.b + tex2DNode6.b ) - 1.0 ) ) , 0.0));
				float4 tex2DNode47 = tex2D( _MetallicGlossMap2, TextureCoordinates32 );
				float4 appendResult122 = (float4(tex2DNode47.r , tex2DNode47.g , saturate( ( ( tex2DNode67.b + tex2DNode47.b ) - 1.0 ) ) , 0.0));
				float4 lerpResult49 = lerp( appendResult121 , appendResult122 , VertexColor42);
				float4 break51 = lerpResult49;
				float AmbientOcclusion57 = break51.y;
				float localBakerySpecMonoSHFull4_g205 = ( 0.0 );
				float3 ase_tangentWS = i.ase_texcoord8.xyz;
				float3 mapNormal16_g207 = NormalMap72;
				float3 ase_bitangentWS = i.ase_texcoord9.xyz;
				float3 normalizeResult18_g207 = normalize( ( ( ase_tangentWS * mapNormal16_g207.x ) + ( ase_bitangentWS * mapNormal16_g207.y ) + ( ase_normalWS * mapNormal16_g207.z ) ) );
				float3 normalWorld4_g205 = normalizeResult18_g207;
				float2 lightmapUV4_g205 = (i.ase_texcoord10.xy*(unity_LightmapST).xy + (unity_LightmapST).zw);
				float3 normalizeResult2_g205 = normalize( ase_viewDirWS );
				float3 viewDir4_g205 = normalizeResult2_g205;
				float Smoothness58 = break51.z;
				float smoothness4_g205 = Smoothness58;
				float3 temp_output_9_0_g204 = Albedo52.rgb;
				float3 albedo4_g205 = temp_output_9_0_g204;
				float Metallic55 = break51.x;
				float metalness4_g205 = Metallic55;
				float3 diffuseSH4_g205 = float3( 0,0,0 );
				float3 specularSH4_g205 = float3( 0,0,0 );
				BakerySpecMonoSHFull_float( normalWorld4_g205 , lightmapUV4_g205 , viewDir4_g205 , smoothness4_g205 , albedo4_g205 , metalness4_g205 , diffuseSH4_g205 , specularSH4_g205 );
				#ifdef _MONOSHENABLED_ON
				float3 staticSwitch30_g204 = ( ( temp_output_13_0_g204 + ( AmbientOcclusion57 * ( diffuseSH4_g205 * temp_output_9_0_g204 ) ) ) + ( specularSH4_g205 * _MonoSHAdjustment ) );
				#else
				float3 staticSwitch30_g204 = temp_output_13_0_g204;
				#endif
				float localNonLinearLightProbe4_g279 = ( 0.0 );
				float3 mapNormal16_g280 = NormalMap72;
				float3 normalizeResult18_g280 = normalize( ( ( ase_tangentWS * mapNormal16_g280.x ) + ( ase_bitangentWS * mapNormal16_g280.y ) + ( ase_normalWS * mapNormal16_g280.z ) ) );
				float3 normalWorld4_g279 = normalizeResult18_g280;
				float3 color4_g279 = float3( 0,0,0 );
				NonLinearLightProbe_float( normalWorld4_g279 , color4_g279 );
				
				float4 lerpResult114 = lerp( ( temp_output_76_0 * _BakedMutiplier ) , ( temp_output_79_0 * _BakedMutiplier2 ) , VertexColor42);
				float4 BakedEmission115 = lerpResult114;
				
			
			//--------------------------------------------------------------------------------------------------------------------------
			//--Read Input Data---------------------------------------------------------------------------------------------------------
			//--------------------------------------------------------------------------------------------------------------------------
			
				//float2 uv_main = mad(float2(i.uv0XY_bitZ_fog.xy), _BaseMap_ST.xy, _BaseMap_ST.zw);
				//float2 uv_detail = mad(float2(i.uv0XY_bitZ_fog.xy), _DetailMap_ST.xy, _DetailMap_ST.zw);
				//half4 albedo = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, uv_main);
				//half4 mas = SAMPLE_TEXTURE2D(_MetallicGlossMap, sampler_BaseMap, uv_main);
			
			
			
				//albedo *= _BaseColor;
				//half metallic = mas.r;
				//half ao = mas.g;
				//half smoothness = mas.b;
			
			
			//---------------------------------------------------------------------------------------------------------------------------
			//---Sample Normal Map-------------------------------------------------------------------------------------------------------
			//---------------------------------------------------------------------------------------------------------------------------
			
				//half3 normalTS = half3(0, 0, 1);
				//half  geoSmooth = 1;
				//half4 normalMap = half4(0, 0, 1, 0);
			
				half3 albedo3 = Albedo52.rgb;
				half3 normalTS = NormalMap72;
				half3 emission = ( (float)staticSwitch32_g204 == 1.0 ? staticSwitch30_g204 : ( Emission83.rgb + ( AmbientOcclusion57 * ( Albedo52.rgb * color4_g279 ) ) ) );
				half3 emissionbaked = BakedEmission115.rgb;
			
			// Begin Injection NORMAL_MAP from Injection_NormalMaps.hlsl ----------------------------------------------------------
				//normalMap = SAMPLE_TEXTURE2D(_BumpMap, sampler_BaseMap, uv_main);
				//normalTS = UnpackNormal(normalMap);
				//normalTS = _Normals ? normalTS : half3(0, 0, 1);
				//geoSmooth = _Normals ? normalMap.b : 1.0;
				//smoothness = saturate(smoothness + geoSmooth - 1.0);
			// End Injection NORMAL_MAP from Injection_NormalMaps.hlsl ----------------------------------------------------------
				half metallic = Metallic55;
				half3 specular = half3(0.5, 0.5, 0.5);
				half smoothness = Smoothness58;
				half ao = AmbientOcclusion57;
				half alpha = half(1);
				half alphaclip = (float)( _Cull * 0 );
				half alphaclipthresholdshadow = half(0);
				#ifdef ASE_DEPTH_WRITE_ON
				float DepthValue = 0;
				#endif
			
				#if defined(_ALPHATEST_ON)
					clip(alpha - alphaclip);
				#endif
			
				#if defined(_ISTRANSPARENT)
					_SSRTemporalMul = 0.0;
				#endif
				half4 albedo = half4(albedo3.rgb, alpha);
			
			//---------------------------------------------------------------------------------------------------------------------------
			//---Read Detail Map---------------------------------------------------------------------------------------------------------
			//---------------------------------------------------------------------------------------------------------------------------
			
				//#if defined(_DETAILS_ON) 
			
			// Begin Injection DETAIL_MAP from Injection_NormalMaps.hlsl ----------------------------------------------------------
					//half4 detailMap = SAMPLE_TEXTURE2D(_DetailMap, sampler_DetailMap, uv_detail);
					//half3 detailTS = half3(2.0 * detailMap.ag - 1.0, 1.0);
					//normalTS = BlendNormal(normalTS, detailTS);
			// End Injection DETAIL_MAP from Injection_NormalMaps.hlsl ----------------------------------------------------------
				   
					//smoothness = saturate(2.0 * detailMap.b * smoothness);
					//albedo.rgb = OverlayBlendDetail(detailMap.r, albedo.rgb);
			
				//#endif
			
			
			//---------------------------------------------------------------------------------------------------------------------------
			//---Transform Normals To Worldspace-----------------------------------------------------------------------------------------
			//---------------------------------------------------------------------------------------------------------------------------
			
			// Begin Injection NORMAL_TRANSFORM from Injection_NormalMaps.hlsl ----------------------------------------------------------
				half3 normalWS = i.normXYZ_tanX.xyz;
				half3x3 TStoWS = half3x3(
					i.normXYZ_tanX.w, i.tanYZ_bitXY.z, normalWS.x,
					i.tanYZ_bitXY.x, i.tanYZ_bitXY.w, normalWS.y,
					i.tanYZ_bitXY.y, i.uv0XY_bitZ_fog.z, normalWS.z
					);
				normalWS = mul(TStoWS, normalTS);
				normalWS = normalize(normalWS);
			// End Injection NORMAL_TRANSFORM from Injection_NormalMaps.hlsl ----------------------------------------------------------
				
				
			//---------------------------------------------------------------------------------------------------------------------------//
			//---Lighting Calculations---------------------------------------------------------------------------------------------------//
			//---------------------------------------------------------------------------------------------------------------------------//
				
			// Begin Injection SPEC_AA from Injection_NormalMaps.hlsl ----------------------------------------------------------
				#if !defined(SHADER_API_MOBILE) && !defined(LITMAS_FEATURE_TP) // Specular antialiasing based on normal derivatives. Only on PC to avoid cost of derivatives on Quest
					smoothness = min(smoothness, SLZGeometricSpecularAA(normalWS));
				#endif
			// End Injection SPEC_AA from Injection_NormalMaps.hlsl ----------------------------------------------------------
				
				
				#if defined(LIGHTMAP_ON)
					SLZFragData fragData = SLZGetFragData(i.vertex, i.wPos, normalWS, i.uv1.xy, i.uv1.zw, i.SHVertLights.xyz);
				#else
					SLZFragData fragData = SLZGetFragData(i.vertex, i.wPos, normalWS, float2(0, 0), float2(0, 0), i.SHVertLights.xyz);
				#endif
				
				//half4 emission = half4(0,0,0,0);
				
			// Begin Injection EMISSION from Injection_Emission.hlsl ----------------------------------------------------------
				//UNITY_BRANCH if (_Emission)
				//{
					//emission += SAMPLE_TEXTURE2D(_EmissionMap, sampler_BaseMap, uv_main) * _EmissionColor;
					//emission.rgb *= lerp(albedo.rgb, half3(1, 1, 1), emission.a);
					//emission.rgb *= pow(abs(fragData.NoV), _EmissionFalloff);
				//}
			// End Injection EMISSION from Injection_Emission.hlsl ----------------------------------------------------------
				
				
				#if !defined(_SLZ_SPECULAR_SETUP)
				SLZSurfData surfData = SLZGetSurfDataMetallicGloss(albedo.rgb, saturate(metallic), saturate(smoothness), ao, emission.rgb, albedo.a);
				#else
				SLZSurfData surfData;
			    surfData.albedo = albedo.rgb;
			    surfData.specular = specular.rgb;
			    surfData.perceptualRoughness = half(1.0) - saturate(smoothness);
			    surfData.reflectivity = (specular.r + specular.g + specular.b) / half(3.0);
			    surfData.roughness = max(surfData.perceptualRoughness * surfData.perceptualRoughness, 1.0e-3h);
			    surfData.emission = emission.rgb;
			    surfData.occlusion = ao;
			    surfData.alpha = alpha;
				#endif
				
				half4 color = half4(1, 1, 1, 1);
				
				#if defined(_SurfaceOpaque)
				int _Surface = 0;
				#elif defined(_SurfaceTransparent)
				int _Surface = 1;
				#elif defined(_SurfaceFade)
				int _Surface = 2;
				#else
				int _Surface = 0;
				#endif
				
			// Begin Injection LIGHTING_CALC from Injection_SSR.hlsl ----------------------------------------------------------
				#if defined(_SSR_ENABLED)
					half4 noiseRGBA = GetScreenNoiseRGBA(fragData.screenUV);
				
					SSRExtraData ssrExtra;
					ssrExtra.meshNormal = i.normXYZ_tanX.xyz;
					ssrExtra.lastClipPos = i.lastVertex;
					ssrExtra.temporalWeight = _SSRTemporalMul;
					ssrExtra.depthDerivativeSum = 0;
					ssrExtra.noise = noiseRGBA;
					ssrExtra.fogFactor = i.uv0XY_bitZ_fog.w;
				
					color = SLZPBRFragmentSSR(fragData, surfData, ssrExtra, _Surface);
					color.rgb = max(0, color.rgb);
				#else
					color = SLZPBRFragment(fragData, surfData, _Surface);
				#endif
			// End Injection LIGHTING_CALC from Injection_SSR.hlsl ----------------------------------------------------------
				
				
			// Begin Injection VOLUMETRIC_FOG from Injection_SSR.hlsl ----------------------------------------------------------
				#if !defined(_SSR_ENABLED)
					color = MixFogSurf(color, -fragData.viewDir, i.uv0XY_bitZ_fog.w, _Surface);
					
					color = VolumetricsSurf(color, fragData.position, _Surface);
				#endif
			// End Injection VOLUMETRIC_FOG from Injection_SSR.hlsl ----------------------------------------------------------
				#ifdef ASE_DEPTH_WRITE_ON
				outputDepth = DepthValue;
				#endif
				
				return color;
			}
			//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

			ENDHLSL
		}

		
		Pass
		{
			

			Name "DepthOnly"
			Tags { "Lightmode"="DepthOnly" }
			
			
			ColorMask 0

			HLSLPROGRAM
			#define _SurfaceOpaque
			#pragma multi_compile_fog
			#define LITMAS_FEATURE_LIGHTMAPPING
			#pragma multi_compile_fragment _ _VOLUMETRICS_ENABLED
			#define LITMAS_FEATURE_EMISSION
			#define PC_REFLECTION_PROBE_BLENDING
			#define PC_REFLECTION_PROBE_BOX_PROJECTION
			#define PC_RECEIVE_SHADOWS
			#define PC_SSAO
			#define MOBILE_LIGHTS_VERTEX
			#define _ALPHATEST_ON 1
			#define ASE_VERSION 19908
			#define ASE_SRP_VERSION -1

			#pragma vertex vert
			#pragma fragment frag
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/PlatformCompiler.hlsl"
			//DepthOnly------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			#define SHADERPASS SHADERPASS_DEPTHONLY

			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Packing.hlsl"

			

			struct appdata
			{
			    float4 vertex : POSITION;
			
				
			    UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f
			{
			    float4 vertex : SV_POSITION;
			
				
			    UNITY_VERTEX_INPUT_INSTANCE_ID
			    UNITY_VERTEX_OUTPUT_STEREO
			};
			CBUFFER_START( UnityPerMaterial )
			float4 _TilingOffset;
			float4 _BaseColor;
			float4 _BaseColor2;
			float4 _BlendModulateMap_ST;
			float4 _EmissionColor;
			float4 _EmissionColor2;
			float _VertexBlendStrength;
			float _BlendFactor;
			float _UseVertexAlpha;
			float _BlendModulateContrast;
			float _EmissionFalloff;
			float _EmissionFalloff2;
			float _MonoSHAdjustment;
			float _BakedMutiplier;
			float _BakedMutiplier2;
			int _Cull;
			CBUFFER_END


			
			v2f vert(appdata v )
			{
			    v2f o;
			    UNITY_SETUP_INSTANCE_ID(v);
			    UNITY_TRANSFER_INSTANCE_ID(v, o);
			    UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

			    
			    #ifdef ASE_ABSOLUTE_VERTEX_POS
			        float3 defaultVertexValue = v.vertex.xyz;
			    #else
			        float3 defaultVertexValue = float3(0, 0, 0);
			    #endif
			    float3 vertexValue = defaultVertexValue;
			    #ifdef ASE_ABSOLUTE_VERTEX_POS
			        v.vertex.xyz = vertexValue;
			    #else
			        v.vertex.xyz += vertexValue;
			    #endif
			
			    o.vertex = TransformObjectToHClip(v.vertex.xyz);
			    return o;
			}
			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE)
			    #define ASE_SV_DEPTH SV_DepthLessEqual  
			#else
			    #define ASE_SV_DEPTH SV_Depth
			#endif

			half4 frag(v2f i 
			    #ifdef ASE_DEPTH_WRITE_ON
			    , out float outputDepth : ASE_SV_DEPTH
			    #endif
			     ) : SV_Target
			{
			    UNITY_SETUP_INSTANCE_ID(i);
			    UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
			    
			
				half alpha = half(1);
				half alphaclip = (float)( _Cull * 0 );
				half alphaclipthresholdshadow = half(0);
				#ifdef ASE_DEPTH_WRITE_ON
				float DepthValue = 0;
				#endif
				#if defined(_ALPHATEST_ON)
					clip(alpha - alphaclip);
				#endif
				#ifdef ASE_DEPTH_WRITE_ON
				outputDepth = DepthValue;
				#endif
			
			    return 0;
			}
			//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			ENDHLSL
		}

		
		Pass
		{
			
			Name "DepthNormals"
			Tags { "Lightmode"="DepthNormals" }
			
			
			
			

			HLSLPROGRAM
			#define _SurfaceOpaque
			#pragma multi_compile_fog
			#define LITMAS_FEATURE_LIGHTMAPPING
			#pragma multi_compile_fragment _ _VOLUMETRICS_ENABLED
			#define LITMAS_FEATURE_EMISSION
			#define PC_REFLECTION_PROBE_BLENDING
			#define PC_REFLECTION_PROBE_BOX_PROJECTION
			#define PC_RECEIVE_SHADOWS
			#define PC_SSAO
			#define MOBILE_LIGHTS_VERTEX
			#define _ALPHATEST_ON 1
			#define ASE_VERSION 19908
			#define ASE_SRP_VERSION -1

			#pragma vertex vert
			#pragma fragment frag
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/PlatformCompiler.hlsl"
			//StandardDepthNormals-------------------------------------------------------------------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
			//
			//
			//-----------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
					
			#define SHADERPASS SHADERPASS_DEPTHNORMALS
					
			#if defined(SHADER_API_MOBILE)
			#else
			#endif
					
					
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Packing.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/EncodeNormalsTexture.hlsl"
					
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0

					
			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			// Begin Injection VERTEX_IN from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				float4 tangent : TANGENT;
				float2 uv0 : TEXCOORD0;
			// End Injection VERTEX_IN from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				float4 normalWS : NORMAL;
				float2 uv0 : TEXCOORD0;
			// Begin Injection INTERPOLATORS from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				float4 tanYZ_bitXY : TEXCOORD1;
				float4 uv0XY_bitZ_fog : TEXCOORD2;
			// End Injection INTERPOLATORS from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				float4 ase_color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			
			// Begin Injection UNIFORMS from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				//TEXTURE2D(_BumpMap);
				//SAMPLER(sampler_BumpMap);
			// End Injection UNIFORMS from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
			
			CBUFFER_START(UnityPerMaterial)
				float4 _TilingOffset;
				float4 _BaseColor;
				float4 _BaseColor2;
				float4 _BlendModulateMap_ST;
				float4 _EmissionColor;
				float4 _EmissionColor2;
				float _VertexBlendStrength;
				float _BlendFactor;
				float _UseVertexAlpha;
				float _BlendModulateContrast;
				float _EmissionFalloff;
				float _EmissionFalloff2;
				float _MonoSHAdjustment;
				float _BakedMutiplier;
				float _BakedMutiplier2;
				int _Cull;
				//float4 _BaseMap_ST;
				//half4 _BaseColor;
			// Begin Injection MATERIAL_CBUFFER from Injection_NormalMap_CBuffer.hlsl ----------------------------------------------------------
			//float4 _DetailMap_ST;
			//half  _Details;
			//half  _Normals;
			// End Injection MATERIAL_CBUFFER from Injection_NormalMap_CBuffer.hlsl ----------------------------------------------------------
			// Begin Injection MATERIAL_CBUFFER from Injection_SSR_CBuffer.hlsl ----------------------------------------------------------
				float _SSRTemporalMul;
			// End Injection MATERIAL_CBUFFER from Injection_SSR_CBuffer.hlsl ----------------------------------------------------------
			// Begin Injection MATERIAL_CBUFFER from Injection_Emission_CBuffer.hlsl ----------------------------------------------------------
				//half  _Emission;
				//half4 _EmissionColor;
				//half  _EmissionFalloff;
				//half  _BakedMutiplier;
			// End Injection MATERIAL_CBUFFER from Injection_Emission_CBuffer.hlsl ----------------------------------------------------------
				//int _Surface;
			CBUFFER_END
			sampler2D _BumpMap;
			sampler2D _BumpMap2;
			sampler2D _BlendModulateMap;

				
			inline float3 MyCustomExpression( half4 In0 )
			{
				return UnpackNormal(In0);;
			}
			
			float SourceBlendModulateFactor158( float2 uv, float vertexAlpha, float _VertexBlendStrength, float _BlendFactor, float _BlendUseVertexAlpha, float4 _BlendModulateMap_ST, float3 _BlendModulateMap, float2 blendModUV, float2 blendModRG, float _BlendModulateContrast )
			{
				float scaledVertexAlpha = vertexAlpha * _VertexBlendStrength;
				float blendInput = saturate( _BlendFactor + ( scaledVertexAlpha * _BlendUseVertexAlpha ) );
				float halfWidth = max( blendModRG.r * _BlendModulateContrast * 0.5, 0.001 );
				float biasCenter = blendModRG.g;
				return smoothstep( biasCenter - halfWidth, biasCenter + halfWidth, blendInput );
			}
			
			
			v2f vert(appdata v  )
			{
			
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
			
			
				o.ase_color = v.ase_color;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = v.vertex.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					v.vertex.xyz = vertexValue;
				#else
					v.vertex.xyz += vertexValue;
				#endif
				o.vertex = TransformObjectToHClip(v.vertex.xyz);
				v.normal = v.normal;
			
			// Begin Injection VERTEX_NORMAL from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				VertexNormalInputs ntb = GetVertexNormalInputs(v.normal, v.tangent);
				o.normalWS = float4(ntb.normalWS, ntb.tangentWS.x);
				o.tanYZ_bitXY = float4(ntb.tangentWS.yz, ntb.bitangentWS.xy);
				o.uv0XY_bitZ_fog.zw = ntb.bitangentWS.zz;
				o.uv0XY_bitZ_fog.xy = v.uv0.xy;
			// End Injection VERTEX_NORMAL from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				o.uv0 = v.uv0;
			
				return o;
			}
			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE)
				#define ASE_SV_DEPTH SV_DepthLessEqual  
			#else
				#define ASE_SV_DEPTH SV_Depth
			#endif
			
			half4 frag(v2f i
				#ifdef ASE_DEPTH_WRITE_ON
				, out float outputDepth : ASE_SV_DEPTH
				#endif
				) : SV_Target
			{
			   UNITY_SETUP_INSTANCE_ID(i);
			   UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
			   float2 appendResult132 = (float2(_TilingOffset.x , _TilingOffset.y));
			   float2 appendResult133 = (float2(_TilingOffset.z , _TilingOffset.w));
			   float2 texCoord27 = i.uv0.xy * appendResult132 + appendResult133;
			   float2 TextureCoordinates32 = texCoord27;
			   float4 tex2DNode8 = tex2D( _BumpMap, TextureCoordinates32 );
			   float4 In02_g202 = tex2DNode8;
			   float3 localMyCustomExpression2_g202 = MyCustomExpression( In02_g202 );
			   float4 tex2DNode67 = tex2D( _BumpMap2, TextureCoordinates32 );
			   float4 In02_g203 = tex2DNode67;
			   float3 localMyCustomExpression2_g203 = MyCustomExpression( In02_g203 );
			   float2 texCoord148 = i.uv0.xy * appendResult132 + appendResult133;
			   float2 uv158 = texCoord148;
			   float vertexAlpha158 = i.ase_color.r;
			   float _VertexBlendStrength158 = _VertexBlendStrength;
			   float _BlendFactor158 = _BlendFactor;
			   float _BlendUseVertexAlpha158 = _UseVertexAlpha;
			   float4 uvs4_BlendModulateMap = float4(i.uv0.xy,0,0);
			   uvs4_BlendModulateMap.xy = float4(i.uv0.xy,0,0).xy * _BlendModulateMap_ST.xy + _BlendModulateMap_ST.zw;
			   float4 _BlendModulateMap_ST158 = uvs4_BlendModulateMap;
			   float4 tex2DNode154 = tex2D( _BlendModulateMap, texCoord27 );
			   float3 _BlendModulateMap158 = tex2DNode154.rgb;
			   float2 appendResult146 = (float2(uvs4_BlendModulateMap.x , uvs4_BlendModulateMap.y));
			   float2 appendResult147 = (float2(uvs4_BlendModulateMap.z , uvs4_BlendModulateMap.w));
			   float2 blendModUV158 = ( texCoord148 * ( appendResult146 + appendResult147 ) );
			   float2 appendResult156 = (float2(tex2DNode154.r , tex2DNode154.g));
			   float2 blendModRG158 = appendResult156;
			   float _BlendModulateContrast158 = _BlendModulateContrast;
			   float localSourceBlendModulateFactor158 = SourceBlendModulateFactor158( uv158 , vertexAlpha158 , _VertexBlendStrength158 , _BlendFactor158 , _BlendUseVertexAlpha158 , _BlendModulateMap_ST158 , _BlendModulateMap158 , blendModUV158 , blendModRG158 , _BlendModulateContrast158 );
			   float VertexColor42 = localSourceBlendModulateFactor158;
			   float3 lerpResult69 = lerp( localMyCustomExpression2_g202 , localMyCustomExpression2_g203 , VertexColor42);
			   float3 NormalMap72 = lerpResult69;
			   
			
			
			   half4 normals = half4(0, 0, 0, 1);
			   half3 normalTS = NormalMap72;
			
			// Begin Injection FRAG_NORMALS from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				//half4 normalMap = SAMPLE_TEXTURE2D(_BumpMap, sampler_BumpMap, i.uv0XY_bitZ_fog.xy);
				//half3 normalTS = UnpackNormal(normalMap);
				//normalTS = _Normals ? normalTS : half3(0, 0, 1);
			
			
				half3x3 TStoWS = half3x3(
					i.normalWS.w, i.tanYZ_bitXY.z, i.normalWS.x,
					i.tanYZ_bitXY.x, i.tanYZ_bitXY.w, i.normalWS.y,
					i.tanYZ_bitXY.y, i.uv0XY_bitZ_fog.z, i.normalWS.z
					);
				half3 normalWS = mul(TStoWS, normalTS);
				normalWS = normalize(normalWS);
				
				normals = half4(EncodeWSNormalForNormalsTex(normalWS),0);
			// End Injection FRAG_NORMALS from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				half alpha = half(1);
				half alphaclip = (float)( _Cull * 0 );
				half alphaclipthresholdshadow = half(0);
				#ifdef ASE_DEPTH_WRITE_ON
				float DepthValue = 0;
				#endif
				
				#if defined(_ALPHATEST_ON)
					clip(alpha - alphaclip);
				#endif
				
				#ifdef ASE_DEPTH_WRITE_ON
				outputDepth = DepthValue;
				#endif
				
				return normals;
			}
			//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			ENDHLSL
		}

		
		Pass
		{
			
			
			Name "ShadowCaster"
			Tags { "LightMode"="ShadowCaster" }

			
			
			
			
			ColorMask 0

			HLSLPROGRAM
			#define _SurfaceOpaque
			#pragma multi_compile_fog
			#define LITMAS_FEATURE_LIGHTMAPPING
			#pragma multi_compile_fragment _ _VOLUMETRICS_ENABLED
			#define LITMAS_FEATURE_EMISSION
			#define PC_REFLECTION_PROBE_BLENDING
			#define PC_REFLECTION_PROBE_BOX_PROJECTION
			#define PC_RECEIVE_SHADOWS
			#define PC_SSAO
			#define MOBILE_LIGHTS_VERTEX
			#define _ALPHATEST_ON 1
			#define ASE_VERSION 19908
			#define ASE_SRP_VERSION -1

			#pragma vertex vert
			#pragma fragment frag

			#pragma multi_compile _ _CASTING_PUNCTUAL_LIGHT_SHADOW

			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/PlatformCompiler.hlsl"
			//ShadowCaster---------------------------------------------------------------------------------------------------------------------------------------------------------------------
			#define SHADERPASS SHADERPASS_SHADOWCASTER


			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Shadows.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			//#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/SLZExtentions.hlsl"

			
			// Shadow Casting Light geometric parameters. These variables are used when applying the shadow Normal Bias and are set by UnityEngine.Rendering.Universal.ShadowUtils.SetupShadowCasterConstantBuffer in com.unity.render-pipelines.universal/Runtime/ShadowUtils.cs
			// For Directional lights, _LightDirection is used when applying shadow Normal Bias.
			// For Spot lights and Point lights, _LightPosition is used to compute the actual light direction because it is different at each shadow caster geometry vertex.
			float3 _LightDirection;
			float3 _LightPosition;

			struct Attributes
			{
			    float4 positionOS   : POSITION;
			    float3 normalOS     : NORMAL;
			    
			    UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct Varyings
			{
			    float4 positionCS   : SV_POSITION;
			    
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			CBUFFER_START( UnityPerMaterial )
			float4 _TilingOffset;
			float4 _BaseColor;
			float4 _BaseColor2;
			float4 _BlendModulateMap_ST;
			float4 _EmissionColor;
			float4 _EmissionColor2;
			float _VertexBlendStrength;
			float _BlendFactor;
			float _UseVertexAlpha;
			float _BlendModulateContrast;
			float _EmissionFalloff;
			float _EmissionFalloff2;
			float _MonoSHAdjustment;
			float _BakedMutiplier;
			float _BakedMutiplier2;
			int _Cull;
			CBUFFER_END


			
			float4 GetShadowPositionHClip(Attributes input)
			{
			    float3 positionWS = TransformObjectToWorld(input.positionOS.xyz);
			    float3 normalWS = TransformObjectToWorldNormal(input.normalOS);
			
			#if _CASTING_PUNCTUAL_LIGHT_SHADOW
			    float3 lightDirectionWS = normalize(_LightPosition - positionWS);
			#else
			    float3 lightDirectionWS = _LightDirection;
			#endif
			    float2 vShadowOffsets = GetShadowOffsets(normalWS, lightDirectionWS);
			    //positionWS.xyz -= vShadowOffsets.x * normalWS.xyz * .01;
			    positionWS.xyz -= vShadowOffsets.y * lightDirectionWS.xyz * .01;
			    float4 positionCS = TransformObjectToHClip(float4(mul(unity_WorldToObject, float4(positionWS.xyz, 1.0)).xyz, 1.0));
			    //float4 positionCS = TransformWorldToHClip(ApplyShadowBias(positionWS, normalWS, lightDirectionWS));
			
			#if UNITY_REVERSED_Z
			    positionCS.z = min(positionCS.z, UNITY_NEAR_CLIP_VALUE);
			#else
			    positionCS.z = max(positionCS.z, UNITY_NEAR_CLIP_VALUE);
			#endif
			
			    return positionCS;
			}

			Varyings vert(Attributes input )
			{
			    Varyings output;
			    UNITY_SETUP_INSTANCE_ID(input);
			    
			
			    input.normalOS.xyz = input.normalOS.xyz;
			    #ifdef ASE_ABSOLUTE_VERTEX_POS
					float3 defaultVertexValue = input.positionOS.xyz;
				#else
					float3 defaultVertexValue = float3(0, 0, 0);
				#endif
				float3 vertexValue = defaultVertexValue;
				#ifdef ASE_ABSOLUTE_VERTEX_POS
					input.positionOS.xyz = vertexValue;
				#else
					input.positionOS.xyz += vertexValue;
				#endif
			
			    output.positionCS = GetShadowPositionHClip(input);
			
			    return output;
			}
			#if defined(ASE_EARLY_Z_DEPTH_OPTIMIZE)
				#define ASE_SV_DEPTH SV_DepthLessEqual  
			#else
				#define ASE_SV_DEPTH SV_Depth
			#endif

			half4 frag(Varyings input 
			    #ifdef ASE_DEPTH_WRITE_ON
			    , out float outputDepth : ASE_SV_DEPTH
			    #endif
			    ) : SV_TARGET
			{
			    UNITY_SETUP_INSTANCE_ID( input );
			    

				half alpha = half(1);
				half alphaclip = (float)( _Cull * 0 );
				half alphaclipthresholdshadow = half(0);
				#ifdef ASE_DEPTH_WRITE_ON
				float DepthValue = 0;
				#endif
				#if defined(_ALPHATEST_ON)
					#ifdef _ALPHATEST_SHADOW_ON
						clip(alpha - alphaclipthresholdshadow);
					#else
						clip(alpha - alphaclip);
					#endif
				#endif
			
			    #ifdef ASE_DEPTH_WRITE_ON
			        outputDepth = DepthValue;
			    #endif
			
			    return 0;
			}

			//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			ENDHLSL
		}

		
		Pass
		{
			
			Name "Meta"
			Tags { "LightMode"="Meta" }
			
			
			Cull Off

			HLSLPROGRAM
			#define _SurfaceOpaque
			#pragma multi_compile_fog
			#define LITMAS_FEATURE_LIGHTMAPPING
			#pragma multi_compile_fragment _ _VOLUMETRICS_ENABLED
			#define LITMAS_FEATURE_EMISSION
			#define PC_REFLECTION_PROBE_BLENDING
			#define PC_REFLECTION_PROBE_BOX_PROJECTION
			#define PC_RECEIVE_SHADOWS
			#define PC_SSAO
			#define MOBILE_LIGHTS_VERTEX
			#define _ALPHATEST_ON 1
			#define ASE_VERSION 19908
			#define ASE_SRP_VERSION -1

			#define _NORMAL_DROPOFF_TS 1
			#define _EMISSION
			#define _NORMALMAP 1

			#pragma vertex vert
			#pragma fragment frag

			#define SHADERPASS SHADERPASS_META
			#include_with_pragmas "Packages/com.unity.render-pipelines.universal/ShaderLibrary/PlatformCompiler.hlsl"
			//StandardMeta.hlsl---------------------------------------------------------------------------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
			//
			//
			//-----------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------

			#define SHADERPASS SHADERPASS_META
			#define PASS_META

			#if defined(SHADER_API_MOBILE)


			#else


			#endif

			//#pragma shader_feature _ EDITOR_VISUALIZATION


			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Texture.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Core.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/Lighting.hlsl"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/TextureStack.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/ShaderGraphFunctions.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/ShaderLibrary/MetaInput.hlsl"
			#include "Packages/com.unity.render-pipelines.universal/Editor/ShaderGraph/Includes/ShaderPass.hlsl"

			#include "Packages/com.fragiledeviations.mabelsshaders/Assets/Shaders/Include/DecodeMonoSH.hlsl"
			#define ASE_NEEDS_TEXTURE_COORDINATES0
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES0
			#define ASE_NEEDS_TEXTURE_COORDINATES1
			#define ASE_NEEDS_FRAG_TEXTURE_COORDINATES1
			#pragma shader_feature_local _MONOSHENABLED_ON


			//TEXTURE2D(_BaseMap);
			//SAMPLER(sampler_BaseMap);

			// Begin Injection UNIFORMS from Injection_Emission_Meta.hlsl ----------------------------------------------------------
			//TEXTURE2D(_EmissionMap);
			// End Injection UNIFORMS from Injection_Emission_Meta.hlsl ----------------------------------------------------------

			CBUFFER_START(UnityPerMaterial)
				float4 _TilingOffset;
				float4 _BaseColor;
				float4 _BaseColor2;
				float4 _BlendModulateMap_ST;
				float4 _EmissionColor;
				float4 _EmissionColor2;
				float _VertexBlendStrength;
				float _BlendFactor;
				float _UseVertexAlpha;
				float _BlendModulateContrast;
				float _EmissionFalloff;
				float _EmissionFalloff2;
				float _MonoSHAdjustment;
				float _BakedMutiplier;
				float _BakedMutiplier2;
				int _Cull;
				//float4 _BaseMap_ST;
				//half4 _BaseColor;
			// Begin Injection MATERIAL_CBUFFER from Injection_NormalMap_CBuffer.hlsl ----------------------------------------------------------
			//float4 _DetailMap_ST;
			//half  _Details;
			//half  _Normals;
			// End Injection MATERIAL_CBUFFER from Injection_NormalMap_CBuffer.hlsl ----------------------------------------------------------
			// Begin Injection MATERIAL_CBUFFER from Injection_SSR_CBuffer.hlsl ----------------------------------------------------------
				float _SSRTemporalMul;
			// End Injection MATERIAL_CBUFFER from Injection_SSR_CBuffer.hlsl ----------------------------------------------------------
			// Begin Injection MATERIAL_CBUFFER from Injection_Emission_CBuffer.hlsl ----------------------------------------------------------
				//half  _Emission;
				//half4 _EmissionColor;
				//half  _EmissionFalloff;
				//half  _BakedMutiplier;
			// End Injection MATERIAL_CBUFFER from Injection_Emission_CBuffer.hlsl ----------------------------------------------------------
				//int _Surface;
			CBUFFER_END
			sampler2D _BaseMap;
			sampler2D _BaseMap2;
			sampler2D _BlendModulateMap;
			sampler2D _EmissionMap;
			sampler2D _EmissionMap2;
			sampler2D _MetallicGlossMap;
			sampler2D _BumpMap;
			sampler2D _MetallicGlossMap2;
			sampler2D _BumpMap2;


			struct appdata
			{
				float4 vertex : POSITION;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 uv3 : TEXCOORD3;
				float4 ase_color : COLOR;
				float3 ase_normal : NORMAL;
				float4 ase_tangent : TANGENT;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f
			{
				float4 vertex : SV_POSITION;
				float2 uv : TEXCOORD0;
			
				#ifdef EDITOR_VISUALIZATION
				float4 VizUV : TEXCOORD1;
				float4 LightCoord : TEXCOORD2;
				#endif
			
			
				float4 ase_color : COLOR;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			float SourceBlendModulateFactor158( float2 uv, float vertexAlpha, float _VertexBlendStrength, float _BlendFactor, float _BlendUseVertexAlpha, float4 _BlendModulateMap_ST, float3 _BlendModulateMap, float2 blendModUV, float2 blendModRG, float _BlendModulateContrast )
			{
				float scaledVertexAlpha = vertexAlpha * _VertexBlendStrength;
				float blendInput = saturate( _BlendFactor + ( scaledVertexAlpha * _BlendUseVertexAlpha ) );
				float halfWidth = max( blendModRG.r * _BlendModulateContrast * 0.5, 0.001 );
				float biasCenter = blendModRG.g;
				return smoothstep( biasCenter - halfWidth, biasCenter + halfWidth, blendInput );
			}
			
			inline float3 MyCustomExpression( half4 In0 )
			{
				return UnpackNormal(In0);;
			}
			

			v2f vert(appdata v  )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				float3 ase_positionWS = TransformObjectToWorld( ( v.vertex ).xyz );
				o.ase_texcoord3.xyz = ase_positionWS;
				float3 ase_normalWS = TransformObjectToWorldNormal( v.ase_normal );
				o.ase_texcoord4.xyz = ase_normalWS;
				float3 ase_tangentWS = TransformObjectToWorldDir( v.ase_tangent.xyz );
				o.ase_texcoord5.xyz = ase_tangentWS;
				float ase_tangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_bitangentWS = cross( ase_normalWS, ase_tangentWS ) * ase_tangentSign;
				o.ase_texcoord6.xyz = ase_bitangentWS;
				
				o.ase_color = v.ase_color;
				o.ase_texcoord7.xy = v.uv1.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.w = 0;
				o.ase_texcoord4.w = 0;
				o.ase_texcoord5.w = 0;
				o.ase_texcoord6.w = 0;
				o.ase_texcoord7.zw = 0;
				float3 vertexValue = float3(0,0,0);
				v.vertex.xyz += vertexValue;
			
				o.vertex = UnityMetaVertexPosition(v.vertex.xyz, v.uv1.xy, v.uv2.xy);
				//o.uv = TRANSFORM_TEX(v.uv0.xy, _BaseMap);
			
				o.uv = v.uv0.xy;
				#ifdef EDITOR_VISUALIZATION
					float2 vizUV = 0;
					float4 lightCoord = 0;
					UnityEditorVizData(v.vertex.xyz, v.uv0.xy, v.uv1.xy, v.uv2.xy, vizUV, lightCoord);
					o.VizUV = float4(vizUV, 0, 0);
					o.LightCoord = lightCoord;
				#endif
			
			
				return o;
			}

			half4 frag(v2f i  ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				UNITY_SETUP_STEREO_EYE_INDEX_POST_VERTEX(i);
				float2 appendResult132 = (float2(_TilingOffset.x , _TilingOffset.y));
				float2 appendResult133 = (float2(_TilingOffset.z , _TilingOffset.w));
				float2 texCoord27 = i.uv * appendResult132 + appendResult133;
				float2 TextureCoordinates32 = texCoord27;
				float2 texCoord148 = i.uv * appendResult132 + appendResult133;
				float2 uv158 = texCoord148;
				float vertexAlpha158 = i.ase_color.r;
				float _VertexBlendStrength158 = _VertexBlendStrength;
				float _BlendFactor158 = _BlendFactor;
				float _BlendUseVertexAlpha158 = _UseVertexAlpha;
				float4 uvs4_BlendModulateMap = float4(i.uv,0,0);
				uvs4_BlendModulateMap.xy = float4(i.uv,0,0).xy * _BlendModulateMap_ST.xy + _BlendModulateMap_ST.zw;
				float4 _BlendModulateMap_ST158 = uvs4_BlendModulateMap;
				float4 tex2DNode154 = tex2D( _BlendModulateMap, texCoord27 );
				float3 _BlendModulateMap158 = tex2DNode154.rgb;
				float2 appendResult146 = (float2(uvs4_BlendModulateMap.x , uvs4_BlendModulateMap.y));
				float2 appendResult147 = (float2(uvs4_BlendModulateMap.z , uvs4_BlendModulateMap.w));
				float2 blendModUV158 = ( texCoord148 * ( appendResult146 + appendResult147 ) );
				float2 appendResult156 = (float2(tex2DNode154.r , tex2DNode154.g));
				float2 blendModRG158 = appendResult156;
				float _BlendModulateContrast158 = _BlendModulateContrast;
				float localSourceBlendModulateFactor158 = SourceBlendModulateFactor158( uv158 , vertexAlpha158 , _VertexBlendStrength158 , _BlendFactor158 , _BlendUseVertexAlpha158 , _BlendModulateMap_ST158 , _BlendModulateMap158 , blendModUV158 , blendModRG158 , _BlendModulateContrast158 );
				float VertexColor42 = localSourceBlendModulateFactor158;
				float4 lerpResult38 = lerp( ( tex2D( _BaseMap, TextureCoordinates32 ) * _BaseColor ) , ( tex2D( _BaseMap2, TextureCoordinates32 ) * _BaseColor2 ) , VertexColor42);
				float4 Albedo52 = lerpResult38;
				
				#ifdef _MONOSHENABLED_ON
				int staticSwitch32_g204 = 1;
				#else
				int staticSwitch32_g204 = 0;
				#endif
				float3 ase_positionWS = i.ase_texcoord3.xyz;
				float3 ase_viewVectorWS = ( ( unity_OrthoParams.w == 0 ) ? _WorldSpaceCameraPos - ase_positionWS : UNITY_MATRIX_V[ 2 ].xyz );
				float3 ase_viewDirWS = normalize( ase_viewVectorWS );
				float3 ase_normalWS = i.ase_texcoord4.xyz;
				float dotResult97 = dot( ase_viewDirWS , ase_normalWS );
				float4 temp_output_76_0 = ( tex2D( _EmissionMap, TextureCoordinates32 ) * _EmissionColor * saturate( pow( abs( dotResult97 ) , _EmissionFalloff ) ) );
				float dotResult108 = dot( ase_viewDirWS , ase_normalWS );
				float4 temp_output_79_0 = ( tex2D( _EmissionMap2, TextureCoordinates32 ) * _EmissionColor2 * saturate( pow( abs( dotResult108 ) , _EmissionFalloff2 ) ) );
				float4 lerpResult80 = lerp( temp_output_76_0 , temp_output_79_0 , VertexColor42);
				float4 Emission83 = lerpResult80;
				float3 temp_output_13_0_g204 = Emission83.rgb;
				float4 tex2DNode6 = tex2D( _MetallicGlossMap, TextureCoordinates32 );
				float4 tex2DNode8 = tex2D( _BumpMap, TextureCoordinates32 );
				float4 appendResult121 = (float4(tex2DNode6.r , tex2DNode6.g , saturate( ( ( tex2DNode8.b + tex2DNode6.b ) - 1.0 ) ) , 0.0));
				float4 tex2DNode47 = tex2D( _MetallicGlossMap2, TextureCoordinates32 );
				float4 tex2DNode67 = tex2D( _BumpMap2, TextureCoordinates32 );
				float4 appendResult122 = (float4(tex2DNode47.r , tex2DNode47.g , saturate( ( ( tex2DNode67.b + tex2DNode47.b ) - 1.0 ) ) , 0.0));
				float4 lerpResult49 = lerp( appendResult121 , appendResult122 , VertexColor42);
				float4 break51 = lerpResult49;
				float AmbientOcclusion57 = break51.y;
				float localBakerySpecMonoSHFull4_g205 = ( 0.0 );
				float3 ase_tangentWS = i.ase_texcoord5.xyz;
				float4 In02_g202 = tex2DNode8;
				float3 localMyCustomExpression2_g202 = MyCustomExpression( In02_g202 );
				float4 In02_g203 = tex2DNode67;
				float3 localMyCustomExpression2_g203 = MyCustomExpression( In02_g203 );
				float3 lerpResult69 = lerp( localMyCustomExpression2_g202 , localMyCustomExpression2_g203 , VertexColor42);
				float3 NormalMap72 = lerpResult69;
				float3 mapNormal16_g207 = NormalMap72;
				float3 ase_bitangentWS = i.ase_texcoord6.xyz;
				float3 normalizeResult18_g207 = normalize( ( ( ase_tangentWS * mapNormal16_g207.x ) + ( ase_bitangentWS * mapNormal16_g207.y ) + ( ase_normalWS * mapNormal16_g207.z ) ) );
				float3 normalWorld4_g205 = normalizeResult18_g207;
				float2 lightmapUV4_g205 = (i.ase_texcoord7.xy*(unity_LightmapST).xy + (unity_LightmapST).zw);
				float3 normalizeResult2_g205 = normalize( ase_viewDirWS );
				float3 viewDir4_g205 = normalizeResult2_g205;
				float Smoothness58 = break51.z;
				float smoothness4_g205 = Smoothness58;
				float3 temp_output_9_0_g204 = Albedo52.rgb;
				float3 albedo4_g205 = temp_output_9_0_g204;
				float Metallic55 = break51.x;
				float metalness4_g205 = Metallic55;
				float3 diffuseSH4_g205 = float3( 0,0,0 );
				float3 specularSH4_g205 = float3( 0,0,0 );
				BakerySpecMonoSHFull_float( normalWorld4_g205 , lightmapUV4_g205 , viewDir4_g205 , smoothness4_g205 , albedo4_g205 , metalness4_g205 , diffuseSH4_g205 , specularSH4_g205 );
				#ifdef _MONOSHENABLED_ON
				float3 staticSwitch30_g204 = ( ( temp_output_13_0_g204 + ( AmbientOcclusion57 * ( diffuseSH4_g205 * temp_output_9_0_g204 ) ) ) + ( specularSH4_g205 * _MonoSHAdjustment ) );
				#else
				float3 staticSwitch30_g204 = temp_output_13_0_g204;
				#endif
				float localNonLinearLightProbe4_g279 = ( 0.0 );
				float3 mapNormal16_g280 = NormalMap72;
				float3 normalizeResult18_g280 = normalize( ( ( ase_tangentWS * mapNormal16_g280.x ) + ( ase_bitangentWS * mapNormal16_g280.y ) + ( ase_normalWS * mapNormal16_g280.z ) ) );
				float3 normalWorld4_g279 = normalizeResult18_g280;
				float3 color4_g279 = float3( 0,0,0 );
				NonLinearLightProbe_float( normalWorld4_g279 , color4_g279 );
				
				float4 lerpResult114 = lerp( ( temp_output_76_0 * _BakedMutiplier ) , ( temp_output_79_0 * _BakedMutiplier2 ) , VertexColor42);
				float4 BakedEmission115 = lerpResult114;
				

				MetaInput metaInput = (MetaInput)0;
			
				float2 uv_main = i.uv;
			
				//half4 albedo = SAMPLE_TEXTURE2D(_BaseMap, sampler_BaseMap, i.uv) * _BaseColor;
				//metaInput.Albedo = albedo.rgb;
			
			
				///half4 emission = half4(0, 0, 0, 0);
			
			// Begin Injection EMISSION from Injection_Emission_Meta.hlsl ----------------------------------------------------------
				//if (_Emission)
				//{
					//half4 emissionDefault = _EmissionColor * SAMPLE_TEXTURE2D(_EmissionMap, sampler_BaseMap, i.uv);
					//emissionDefault.rgb *= _BakedMutiplier * _Emission;
					//emissionDefault.rgb *= lerp(albedo.rgb, half3(1, 1, 1), emissionDefault.a);
					//emission += emissionDefault;
				//}
			// End Injection EMISSION from Injection_Emission_Meta.hlsl ----------------------------------------------------------
			
				//metaInput.Emission = emission.rgb;
			
				metaInput.Albedo = Albedo52.rgb;
				half3 emission = ( (float)staticSwitch32_g204 == 1.0 ? staticSwitch30_g204 : ( Emission83.rgb + ( AmbientOcclusion57 * ( Albedo52.rgb * color4_g279 ) ) ) );
				half3 bakedemission = BakedEmission115.rgb;
				metaInput.Emission = bakedemission.rgb;
				#ifdef EDITOR_VISUALIZATION
					metaInput.VizUV = i.VizUV.xy;
					metaInput.LightCoord = i.LightCoord;
				#endif
			
				half alpha = half(1);
				half alphaclip = (float)( _Cull * 0 );
				half alphaclipthresholdshadow = half(0);
				#if defined(_ALPHATEST_ON)
					clip(alpha - alphaclip);
				#endif
				return MetaFragment(metaInput);
			}
			//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
			ENDHLSL
		}

		/*ase_pass*/
		Pass
		{
			
			
			Name "BakedRaytrace"
			Tags{ "LightMode" = "BakedRaytrace" }
			HLSLPROGRAM
			/*ase_pragma_before*/
			#pragma multi_compile _ _EMISSION_ON
			//StandardBakedRT------------------------------------------------------------------------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
			//
			//
			//-----------------------------------------------------------------------------------------------------
			//-----------------------------------------------------------------------------------------------------
					
					
			#define SHADERPASS SHADERPASS_RAYTRACE
					
			#include "UnityRaytracingMeshUtils.cginc"
			#include "Packages/com.unity.render-pipelines.core/ShaderLibrary/Color.hlsl"
					
			/*ase_pragma*/
					
			#pragma raytracing BakeHit
					
			struct RayPayload
			{
			    float4 color;
				float3 dir;
			};
			
			struct AttributeData
			{
			    float2 barycentrics;
			};
			
			struct Vertex
			{
			    float2 texcoord;
			    float3 normal;
			};
			
			// Begin Injection UNIFORMS from Injection_Emission_BakedRT.hlsl ----------------------------------------------------------
			//Texture2D<float4> _BaseMap;
			//SamplerState sampler_BaseMap;
			//Texture2D<float4> _EmissionMap;
			//SamplerState sampler_EmissionMap;
			// End Injection UNIFORMS from Injection_Emission_BakedRT.hlsl ----------------------------------------------------------
			
			CBUFFER_START( UnityPerMaterial )
				/*ase_srp_batcher*/
				//float4 _BaseMap_ST;
				//half4 _BaseColor;
			// Begin Injection MATERIAL_CBUFFER from Injection_NormalMap_CBuffer.hlsl ----------------------------------------------------------
			//float4 _DetailMap_ST;
			//half  _Details;
			//half  _Normals;
			// End Injection MATERIAL_CBUFFER from Injection_NormalMap_CBuffer.hlsl ----------------------------------------------------------
			// Begin Injection MATERIAL_CBUFFER from Injection_SSR_CBuffer.hlsl ----------------------------------------------------------
				float _SSRTemporalMul;
			// End Injection MATERIAL_CBUFFER from Injection_SSR_CBuffer.hlsl ----------------------------------------------------------
			// Begin Injection MATERIAL_CBUFFER from Injection_Emission_CBuffer.hlsl ----------------------------------------------------------
				//half  _Emission;
				//half4 _EmissionColor;
				//half  _EmissionFalloff;
				//half  _BakedMutiplier;
			// End Injection MATERIAL_CBUFFER from Injection_Emission_CBuffer.hlsl ----------------------------------------------------------
				//int _AlphaPreMult;
			CBUFFER_END
			/*ase_globals*/
			
			/*ase_funcs*/
			
			
			//https://coty.tips/raytracing-in-unity/
			[shader("closesthit")]
			void MyClosestHit(inout RayPayload payload, AttributeData attributes : SV_IntersectionAttributes) {
			
				payload.color = float4(0,0,0,1); //Intializing
				payload.dir = float3(1,0,0);
			
			// Begin Injection CLOSEST_HIT from Injection_Emission_BakedRT.hlsl ----------------------------------------------------------
			uint2 launchIdx = DispatchRaysIndex();
			
			uint primitiveIndex = PrimitiveIndex();
			uint3 triangleIndicies = UnityRayTracingFetchTriangleIndices(primitiveIndex);
			Vertex v0, v1, v2;
			
			v0.texcoord = UnityRayTracingFetchVertexAttribute2(triangleIndicies.x, kVertexAttributeTexCoord0);
			v1.texcoord = UnityRayTracingFetchVertexAttribute2(triangleIndicies.y, kVertexAttributeTexCoord0);
			v2.texcoord = UnityRayTracingFetchVertexAttribute2(triangleIndicies.z, kVertexAttributeTexCoord0);
			
			// v0.normal = UnityRayTracingFetchVertexAttribute3(triangleIndicies.x, kVertexAttributeNormal);
			// v1.normal = UnityRayTracingFetchVertexAttribute3(triangleIndicies.y, kVertexAttributeNormal);
			// v2.normal = UnityRayTracingFetchVertexAttribute3(triangleIndicies.z, kVertexAttributeNormal);
			
			float3 barycentrics = float3(1.0 - attributes.barycentrics.x - attributes.barycentrics.y, attributes.barycentrics.x, attributes.barycentrics.y);
			
			Vertex vInterpolated;
			vInterpolated.texcoord = v0.texcoord * barycentrics.x + v1.texcoord * barycentrics.y + v2.texcoord * barycentrics.z;
			//TODO: Extract normal direction to ignore the backside of emissive objects
			//vInterpolated.normal = v0.normal * barycentrics.x + v1.normal * barycentrics.y + v2.normal * barycentrics.z;
			// if ( dot(vInterpolated.normal, float3(1,0,0) < 0) ) payload.color =  float4(0,10,0,1) ;
			// else payload.color =  float4(10,0,0,1) ;
			
			
			//float4 albedo = float4(_BaseMap.SampleLevel(sampler_BaseMap, vInterpolated.texcoord.xy * _BaseMap_ST.xy + _BaseMap_ST.zw, 0).rgb, 1) * _BaseColor;
			
			//float4 emission = _Emission * _EmissionMap.SampleLevel(sampler_EmissionMap, vInterpolated.texcoord * _BaseMap_ST.xy + _BaseMap_ST.zw, 0) * _EmissionColor;
			
			half3 albedo = /*ase_frag_out:Albedo;Float3;_Albedo*/half3(0.5, 0.5, 0.5)/*end*/;
			half3 emission = /*ase_frag_out:Emission;Float3;_Emission*/half3(0,0,0)/*end*/;
			half3 baked_emission = /*ase_frag_out:Baked Emission;Float3;_EmissionBaked*/emission/*end*/;
			//emission.rgb *= lerp(albedo.rgb, 1, emission.a);
			
			//payload.color.rgb = emission.rgb * _BakedMutiplier;
			// End Injection CLOSEST_HIT from Injection_Emission_BakedRT.hlsl ----------------------------------------------------------
			payload.color.rgb = baked_emission.rgb;
			}
			//--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

			ENDHLSL
		}
		
	}
	

	CustomEditor "UnityEditor.ShaderGraphLitGUI"
	Fallback "Hidden/InternalErrorShader"
	
}
/*ASEBEGIN
Version=19908
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;84;-1618,814;Inherit;False;1570.494;1533.225;;29;83;80;81;79;76;78;12;10;77;89;102;99;95;96;97;98;100;101;112;113;104;114;106;108;109;110;105;107;115;Emission;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;159;-4658,-706;Inherit;False;964;483;;5;133;132;27;32;131;Tiling and Offset;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;46;-6176,-96;Inherit;False;1998.695;1192.509;;15;42;158;157;156;155;154;153;152;151;150;149;148;147;146;145;Source Blend Modulate Factor;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;59;-3805.511,882;Inherit;False;2029.494;1125.286;;23;122;124;125;123;120;119;118;121;69;72;68;88;67;47;8;6;9;49;50;58;57;55;51;MAS + Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;96;-1568,1312;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;95;-1568,1456;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;106;-1552,1984;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldNormalVector, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;107;-1552,2144;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;145;-6128,256;Inherit;False;0;154;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DotProductOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;97;-1376,1312;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;108;-1360,1984;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;118;-3088,1088;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;123;-3072,1664;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;131;-4608,-656;Inherit;False;Property;_TilingOffset;Tiling & Offset;3;0;Create;True;0;0;0;False;2;Header(Global Settings);Space(5);False;1,1,0,0;1,1,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;146;-5792,272;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;147;-5792,384;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;99;-1296,1408;Inherit;False;Property;_EmissionFalloff;Emission Falloff;15;0;Create;False;0;0;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;98;-1248,1312;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;109;-1232,1984;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;105;-1216,2080;Inherit;False;Property;_EmissionFalloff2;Emission Falloff;23;0;Create;False;0;0;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;119;-2976,1104;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;124;-2960,1680;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;133;-4384,-544;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;132;-4384,-656;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;148;-5616,-16;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;149;-5568,304;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;88;-3760,1488;Inherit;False;32;TextureCoordinates;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;6;-3392,1152;Inherit;True;Property;_MetallicGlossMap;MAS;12;1;[NoScaleOffset];Create;False;0;0;0;False;1;Space(20);False;-1;75f1fbacfa73385419ec8d7700a107ea;75f1fbacfa73385419ec8d7700a107ea;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;47;-3392,1728;Inherit;True;Property;_MetallicGlossMap2;MAS;20;1;[NoScaleOffset];Create;False;0;0;0;False;1;Space(20);False;-1;75f1fbacfa73385419ec8d7700a107ea;75f1fbacfa73385419ec8d7700a107ea;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.PowerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;100;-1104,1312;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;89;-1488,1168;Inherit;False;32;TextureCoordinates;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PowerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;110;-1088,1984;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;120;-2832,1120;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;125;-2816,1696;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;27;-4272,-384;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;152;-5696,832;Inherit;False;Property;_UseVertexAlpha;Use Vertex Alpha;7;1;[Toggle];Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;153;-5712,496;Inherit;False;Property;_BlendFactor;Blend Factor;8;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;155;-5152,288;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;157;-5456,272;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;150;-5296,528;Inherit;False;Property;_VertexBlendStrength;Vertex Blend Strength;6;0;Create;True;0;0;0;False;0;False;1;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;151;-5248,816;Inherit;False;Property;_BlendModulateContrast;BlendModulateContrast;5;0;Create;True;0;0;0;False;0;False;1;0;0;4;0;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;156;-5312,640;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;154;-5888,592;Inherit;True;Property;_BlendModulateMap;Blend Modulate Map;4;1;[NoScaleOffset];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;8;-3392,960;Inherit;True;Property;_BumpMap;Normal Map;11;2;[NoScaleOffset];[Normal];Create;False;0;0;0;False;1;Space(20);False;-1;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;67;-3392,1552;Inherit;True;Property;_BumpMap2;Normal Map;19;2;[NoScaleOffset];[Normal];Create;False;0;0;0;False;1;Space(20);False;-1;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;40;-2222.299,-944;Inherit;False;1577.299;945.0139;;10;44;38;36;37;7;5;35;34;41;52;Base Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;101;-928,1312;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;12;-1104,1104;Inherit;False;Property;_EmissionColor;Emission Color;14;1;[HDR];Create;False;0;0;0;False;0;False;0,0,0,1;0,0,0,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;10;-1168,912;Inherit;True;Property;_EmissionMap;Emission Map;13;1;[NoScaleOffset];Create;False;0;0;0;False;1;Space(20);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;77;-1200,1648;Inherit;True;Property;_EmissionMap2;Emission Map;21;1;[NoScaleOffset];Create;False;0;0;0;False;1;Space(20);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SaturateNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;111;-912,1984;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;78;-1456,1776;Inherit;False;Property;_EmissionColor2;Emission Color;22;1;[HDR];Create;False;0;0;0;False;0;False;0,0,0,1;0,0,0,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;121;-2688,1072;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;122;-2688,1424;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;32;-3968,-368;Inherit;False;TextureCoordinates;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CustomExpressionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;158;-4896,448;Inherit;False;float scaledVertexAlpha = vertexAlpha * _VertexBlendStrength@$float blendInput = saturate( _BlendFactor + ( scaledVertexAlpha * _BlendUseVertexAlpha ) )@$$float halfWidth = max( blendModRG.r * _BlendModulateContrast * 0.5, 0.001 )@$float biasCenter = blendModRG.g@$$return smoothstep( biasCenter - halfWidth, biasCenter + halfWidth, blendInput )@;1;Create;10;True;uv;FLOAT2;0,0;In;;Inherit;False;True;vertexAlpha;FLOAT;0;In;;Inherit;False;True;_VertexBlendStrength;FLOAT;0;In;;Inherit;False;True;_BlendFactor;FLOAT;0;In;;Inherit;False;True;_BlendUseVertexAlpha;FLOAT;0;In;;Inherit;False;True;_BlendModulateMap_ST;FLOAT4;0,0,0,0;In;;Inherit;False;True;_BlendModulateMap;FLOAT3;0,0,0;In;;Inherit;False;True;blendModUV;FLOAT2;0,0;In;;Inherit;False;True;blendModRG;FLOAT2;0,0;In;;Inherit;False;True;_BlendModulateContrast;FLOAT;0;In;;Inherit;False;SourceBlendModulateFactor;True;False;0;;False;10;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;9;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;41;-2144,-496;Inherit;False;32;TextureCoordinates;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;50;-3680,1392;Inherit;False;42;VertexColor;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;76;-800,1136;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;79;-768,1808;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;81;-1104,1504;Inherit;False;42;VertexColor;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;49;-2480,1040;Inherit;False;3;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0,0,0,0;False;2;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;9;-3072,992;Inherit;False;UnpackNormal;-1;;202;d579cc33c6fa60b4ea9cee9e184b62e3;0;1;1;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;68;-3104,1552;Inherit;False;UnpackNormal;-1;;203;d579cc33c6fa60b4ea9cee9e184b62e3;0;1;1;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;42;-4480,496;Inherit;False;VertexColor;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;7;-1728,-672;Inherit;False;Property;_BaseColor;Base Color;10;0;Create;True;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.ColorNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;35;-1744,-256;Inherit;False;Property;_BaseColor2;Base Color;18;0;Create;False;0;0;0;False;0;False;1,1,1,1;1,1,1,1;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;34;-1808,-464;Inherit;True;Property;_BaseMap2;Base Map;17;1;[NoScaleOffset];Create;False;0;0;0;False;3;Space(10);Header(Texture Set 2);Space(5);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;102;-848,1456;Inherit;False;Property;_BakedMutiplier;Emission Baked Mutiplier;16;0;Create;False;0;0;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;104;-864,1600;Inherit;False;Property;_BakedMutiplier2;Emission Baked Mutiplier;24;0;Create;False;0;0;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;51;-2192,1074;Inherit;False;FLOAT4;1;0;FLOAT4;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;80;-592,1136;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;69;-2320,1552;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;5;-1808,-896;Inherit;True;Property;_BaseMap;Base Map;9;1;[NoScaleOffset];Create;True;0;0;0;False;2;Header(Texture Set 1);Space(5);False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;False;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;37;-1360,-800;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;36;-1376,-384;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;44;-1312,-624;Inherit;False;42;VertexColor;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;112;-608,1424;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;113;-608,1568;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;86;-896,144;Inherit;False;724;483;;7;61;62;60;54;74;85;39;Mono SH;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;83;-368,1120;Inherit;False;Emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;55;-2064,1362;Inherit;False;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;57;-2064,1426;Inherit;False;AmbientOcclusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;58;-2064,1490;Inherit;False;Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;72;-2064,1552;Inherit;False;NormalMap;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;138;48,544;Inherit;False;708;355;;5;143;142;141;140;139;Non-Linear Probe;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;38;-1056,-720;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;136;304,272;Inherit;False;436.3167;195.4484;;2;135;137;Surface Properties;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;114;-416,1504;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;61;-800,320;Inherit;False;58;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;62;-800,384;Inherit;False;55;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;60;-832,448;Inherit;False;57;AmbientOcclusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;54;-800,256;Inherit;False;52;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;74;-800,192;Inherit;False;72;NormalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;85;-800,512;Inherit;False;83;Emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;139;160,608;Inherit;False;52;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;142;160,800;Inherit;False;83;Emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;140;160,672;Inherit;False;72;NormalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;141;128,736;Inherit;False;57;AmbientOcclusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;52;-896,-720;Inherit;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;117;32,-336;Inherit;False;292;547;;7;65;64;66;53;75;87;116;Textures;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;115;-288,1616;Inherit;False;BakedEmission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.IntNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;137;352,352;Inherit;False;Property;_Cull;Cull Mode;31;0;Create;False;0;0;0;False;0;False;2;2;False;0;0;0;1;INT;0
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;39;-560,272;Inherit;False;BakeryMonoSH;25;;204;29c9468cd28079b448a58bef1fb32cb5;0;6;8;FLOAT3;0,0,0;False;9;FLOAT3;0,0,0;False;10;FLOAT;0;False;11;FLOAT;0;False;12;FLOAT;0;False;13;FLOAT3;0,0,0;False;2;FLOAT3;0;INT;31
Node;AmplifyShaderEditor.FunctionNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;143;384,672;Inherit;False;BakeryNonLinearLightProbe;0;;279;c510387f01015ab478517ff0d72607db;0;4;5;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;10;FLOAT;0;False;9;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;65;112,-160;Inherit;False;55;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;64;112,-96;Inherit;False;58;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;66;80,-32;Inherit;False;57;AmbientOcclusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;53;112,-288;Inherit;False;52;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;75;112,-224;Inherit;False;72;NormalMap;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;87;112,32;Inherit;False;83;Emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;116;80,96;Inherit;False;115;BakedEmission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;135;560,336;Inherit;False;2;2;0;INT;0;False;1;INT;0;False;1;INT;0
Node;AmplifyShaderEditor.Compare, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;144;80,272;Inherit;False;0;4;0;INT;0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;1;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;623634af11bd9ab448550ee777f3493e;True;DepthOnly;0;1;DepthOnly;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;Lightmode=DepthOnly;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;2;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;623634af11bd9ab448550ee777f3493e;True;DepthNormals;0;2;DepthNormals;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;Lightmode=DepthNormals;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;3;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;623634af11bd9ab448550ee777f3493e;True;ShadowCaster;0;3;ShadowCaster;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ShadowCaster;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;4;0,0;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;623634af11bd9ab448550ee777f3493e;True;Meta;0;4;Meta;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode, AmplifyShaderEditor, Version=0.0.0.0, Culture=neutral, PublicKeyToken=null;0;496,-160;Float;False;True;-1;2;UnityEditor.ShaderGraphLitGUI;0;12;Mabel/Source/WorldVertexTransition;623634af11bd9ab448550ee777f3493e;True;Forward;0;0;Forward;14;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;True;True;0;True;_Cull;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;False;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;False;True;1;Lightmode=UniversalForward;True;7;False;0;Hidden/InternalErrorShader;0;0;Standard;24;Workflow;1;0;Surface;0;0;Two Sided;1;0;Cast Shadows;1;0;  Use Shadow Threshold;0;0;GPU Instancing;0;0;Built-in Fog;1;0;Lightmaps;1;0;Volumetrics;1;0;Decals;0;0;Write Depth;0;0;  Early Z (broken);0;0;Vertex Position;1;0;Emission;1;0;PC Reflection Probe;3;0;PC Receive Shadows;1;0;PC Vertex Lights;0;0;PC SSAO;1;0;Q Reflection Probe;0;0;Q Receive Shadows;0;0;Q Vertex Lights;1;0;Q SSAO;0;0;Environment Reflections;1;0;Meta Pass;1;0;0;5;True;True;True;True;True;False;;False;0
WireConnection;97;0;96;0
WireConnection;97;1;95;0
WireConnection;108;0;106;0
WireConnection;108;1;107;0
WireConnection;118;0;8;3
WireConnection;118;1;6;3
WireConnection;123;0;67;3
WireConnection;123;1;47;3
WireConnection;146;0;145;1
WireConnection;146;1;145;2
WireConnection;147;0;145;3
WireConnection;147;1;145;4
WireConnection;98;0;97;0
WireConnection;109;0;108;0
WireConnection;119;0;118;0
WireConnection;124;0;123;0
WireConnection;133;0;131;3
WireConnection;133;1;131;4
WireConnection;132;0;131;1
WireConnection;132;1;131;2
WireConnection;148;0;132;0
WireConnection;148;1;133;0
WireConnection;149;0;146;0
WireConnection;149;1;147;0
WireConnection;6;1;88;0
WireConnection;47;1;88;0
WireConnection;100;0;98;0
WireConnection;100;1;99;0
WireConnection;110;0;109;0
WireConnection;110;1;105;0
WireConnection;120;0;119;0
WireConnection;125;0;124;0
WireConnection;27;0;132;0
WireConnection;27;1;133;0
WireConnection;157;0;148;0
WireConnection;157;1;149;0
WireConnection;156;0;154;1
WireConnection;156;1;154;2
WireConnection;154;1;27;0
WireConnection;8;1;88;0
WireConnection;67;1;88;0
WireConnection;101;0;100;0
WireConnection;10;1;89;0
WireConnection;77;1;89;0
WireConnection;111;0;110;0
WireConnection;121;0;6;1
WireConnection;121;1;6;2
WireConnection;121;2;120;0
WireConnection;122;0;47;1
WireConnection;122;1;47;2
WireConnection;122;2;125;0
WireConnection;32;0;27;0
WireConnection;158;0;148;0
WireConnection;158;1;155;1
WireConnection;158;2;150;0
WireConnection;158;3;153;0
WireConnection;158;4;152;0
WireConnection;158;5;145;0
WireConnection;158;6;154;5
WireConnection;158;7;157;0
WireConnection;158;8;156;0
WireConnection;158;9;151;0
WireConnection;76;0;10;0
WireConnection;76;1;12;0
WireConnection;76;2;101;0
WireConnection;79;0;77;0
WireConnection;79;1;78;0
WireConnection;79;2;111;0
WireConnection;49;0;121;0
WireConnection;49;1;122;0
WireConnection;49;2;50;0
WireConnection;9;1;8;0
WireConnection;68;1;67;0
WireConnection;42;0;158;0
WireConnection;34;1;41;0
WireConnection;51;0;49;0
WireConnection;80;0;76;0
WireConnection;80;1;79;0
WireConnection;80;2;81;0
WireConnection;69;0;9;0
WireConnection;69;1;68;0
WireConnection;69;2;50;0
WireConnection;5;1;41;0
WireConnection;37;0;5;0
WireConnection;37;1;7;0
WireConnection;36;0;34;0
WireConnection;36;1;35;0
WireConnection;112;0;76;0
WireConnection;112;1;102;0
WireConnection;113;0;79;0
WireConnection;113;1;104;0
WireConnection;83;0;80;0
WireConnection;55;0;51;0
WireConnection;57;0;51;1
WireConnection;58;0;51;2
WireConnection;72;0;69;0
WireConnection;38;0;37;0
WireConnection;38;1;36;0
WireConnection;38;2;44;0
WireConnection;114;0;112;0
WireConnection;114;1;113;0
WireConnection;114;2;81;0
WireConnection;52;0;38;0
WireConnection;115;0;114;0
WireConnection;39;8;74;0
WireConnection;39;9;54;0
WireConnection;39;10;61;0
WireConnection;39;11;62;0
WireConnection;39;12;60;0
WireConnection;39;13;85;0
WireConnection;143;5;139;0
WireConnection;143;1;140;0
WireConnection;143;10;141;0
WireConnection;143;9;142;0
WireConnection;135;0;137;0
WireConnection;144;0;39;31
WireConnection;144;2;39;0
WireConnection;144;3;143;0
WireConnection;0;0;53;0
WireConnection;0;1;75;0
WireConnection;0;2;144;0
WireConnection;0;3;116;0
WireConnection;0;4;65;0
WireConnection;0;6;64;0
WireConnection;0;7;66;0
WireConnection;0;9;135;0
ASEEND*/
//CHKSM=7CCE9417A22A01914AF772E0E03A18E87376EED0