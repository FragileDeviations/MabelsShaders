// Made with Amplify Shader Editor v1.9.6.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
// Force reimport: 2
Shader "Mabel/Fractal/Fractal Opaque"
{
	Properties
	{
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[HideInInspector] _EmissionColor("Emission Color", Color) = (1,1,1,1)
		[Header(Base Color)][Space(10)][MainTexture]_BaseMap("BaseMap", 2D) = "white" {}
		[MainColor]_BaseColor("BaseColor", Color) = (1,1,1,1)
		[Space(30)][Header(Fractal Settings)][Space(10)]_MinScl("Minimum Scale", Int) = 0
		_Scale("Scale", Int) = 25
		[Toggle][Space(30)][Header(PBR)][Space(10)][Toggle(_NORMALS_ON)] _Normals("Normal Map Enabled", Float) = 0
		[NoScaleOffset][Normal]_BumpMap("Normal Map", 2D) = "bump" {}
		_BumpScale("Normal Scale", Float) = 1
		[KeywordEnum(MAS,MASK,RMA,ORM)] _MapType("Map Type", Float) = 0
		[NoScaleOffset]_MetallicGlossMap("MAS", 2D) = "white" {}
		[Space(30)][Header(Mono SH)][Space(10)][Toggle(_MONOSHENABLED_ON)] _MonoSHEnabled("MonoSH Enabled", Float) = 0
		_MonoSHAdjustment("Mono SH Adjustment", Range( 0 , 10)) = 1
		[HideInInspector][Enum(UnityEngine.Rendering.CullMode)]_Cull("Cull Side", Float) = 0

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
		Cull Back
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
			#define ASE_NEEDS_VERT_TANGENT
			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local _NORMALS_ON
			#pragma shader_feature_local _MONOSHENABLED_ON
			#pragma shader_feature_local _MAPTYPE_MAS _MAPTYPE_MASK _MAPTYPE_RMA _MAPTYPE_ORM

					
			struct VertIn
			{
				float4 vertex   : POSITION;
				float3 normal    : NORMAL;
				float4 tangent   : TANGENT;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				
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
				float4 _BaseColor;
				float4 _BaseMap_ST;
				int _Scale;
				int _MinScl;
				float _BumpScale;
				float _MonoSHAdjustment;
				float _Cull;
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
			sampler2D _MetallicGlossMap;
			sampler2D _BaseMap;
			sampler2D _BumpMap;

			
						
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
			
				float3 ase_worldTangent = TransformObjectToWorldDir(v.tangent.xyz);
				o.ase_texcoord7.xyz = ase_worldTangent;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.normal);
				float ase_vertexTangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord8.xyz = ase_worldBitangent;
				o.ase_texcoord9.xyz = ase_worldNormal;
				
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
				float2 uv_BaseMap = i.uv0XY_bitZ_fog.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
				float2 temp_output_83_0 = ( uv_BaseMap * _Scale );
				float temp_output_125_0 = max( (float)_MinScl , log2( distance( i.wPos.xyz , _WorldSpaceCameraPos ) ) );
				float temp_output_79_0 = floor( temp_output_125_0 );
				float temp_output_2_0_g2 = temp_output_79_0;
				float temp_output_3_0_g2 = 2.0;
				float temp_output_127_0 = ( temp_output_2_0_g2 - ( temp_output_3_0_g2 * floor( ( temp_output_2_0_g2 / temp_output_3_0_g2 ) ) ) );
				float2 appendResult128 = (float2(temp_output_127_0 , temp_output_127_0));
				float2 temp_output_124_0 = abs( appendResult128 );
				float2 UV_A177 = ( temp_output_83_0 / exp2( ( temp_output_79_0 + temp_output_124_0 ) ) );
				float2 UV_B178 = ( temp_output_83_0 / exp2( ( temp_output_79_0 + ( 1.0 - temp_output_124_0 ) ) ) );
				float d116 = temp_output_125_0;
				float temp_output_129_0 = frac( d116 );
				float fac132 = ( temp_output_127_0 == 0.0 ? temp_output_129_0 : ( 1.0 - temp_output_129_0 ) );
				float4 lerpResult123 = lerp( tex2D( _BaseMap, UV_A177 ) , tex2D( _BaseMap, UV_B178 ) , fac132);
				float4 Albedo190 = ( _BaseColor * lerpResult123 );
				
				float4 lerpResult148 = lerp( tex2D( _BumpMap, UV_A177 ) , tex2D( _BumpMap, UV_B178 ) , fac132);
				float3 unpack142 = UnpackNormalScale( lerpResult148, _BumpScale );
				unpack142.z = lerp( 1, unpack142.z, saturate(_BumpScale) );
				float3 lerpResult214 = lerp( unpack142 , float3( 0,0,1 ) , step( 0.0 , 0.0 ));
				#ifdef _NORMALS_ON
				float3 staticSwitch211 = unpack142;
				#else
				float3 staticSwitch211 = lerpResult214;
				#endif
				float3 Normal189 = staticSwitch211;
				
				float3 temp_output_13_0_g4 = float3( 0,0,0 );
				float4 lerpResult155 = lerp( tex2D( _MetallicGlossMap, UV_A177 ) , tex2D( _MetallicGlossMap, UV_B178 ) , fac132);
				float4 temp_output_1_0_g3 = lerpResult155;
				float4 break15_g3 = temp_output_1_0_g3;
				float4 appendResult16_g3 = (float4(break15_g3.r , break15_g3.g , break15_g3.a , break15_g3.b));
				float4 break19_g3 = temp_output_1_0_g3;
				float4 appendResult18_g3 = (float4(break19_g3.g , break19_g3.b , ( 1.0 - break19_g3.r ) , 0.0));
				float4 break22_g3 = temp_output_1_0_g3;
				float4 appendResult23_g3 = (float4(break22_g3.b , break22_g3.r , ( 1.0 - break22_g3.g ) , 0.0));
				#if defined( _MAPTYPE_MAS )
				float4 staticSwitch3_g3 = temp_output_1_0_g3;
				#elif defined( _MAPTYPE_MASK )
				float4 staticSwitch3_g3 = appendResult16_g3;
				#elif defined( _MAPTYPE_RMA )
				float4 staticSwitch3_g3 = appendResult18_g3;
				#elif defined( _MAPTYPE_ORM )
				float4 staticSwitch3_g3 = appendResult23_g3;
				#else
				float4 staticSwitch3_g3 = temp_output_1_0_g3;
				#endif
				float4 break8_g3 = staticSwitch3_g3;
				float Ambient_Occlusion195 = break8_g3.g;
				float localBakerySpecMonoSHFull4_g198 = ( 0.0 );
				float3 ase_worldTangent = i.ase_texcoord7.xyz;
				float3 mapNormal16_g200 = Normal189;
				float3 ase_worldBitangent = i.ase_texcoord8.xyz;
				float3 ase_worldNormal = i.ase_texcoord9.xyz;
				float3 normalizeResult18_g200 = normalize( ( ( ase_worldTangent * mapNormal16_g200.x ) + ( ase_worldBitangent * mapNormal16_g200.y ) + ( ase_worldNormal * mapNormal16_g200.z ) ) );
				float3 normalWorld4_g198 = normalizeResult18_g200;
				float2 lightmapUV4_g198 = (i.ase_texcoord10.xy*(unity_LightmapST).xy + (unity_LightmapST).zw);
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - i.wPos.xyz );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 normalizeResult2_g198 = normalize( ase_worldViewDir );
				float3 viewDir4_g198 = normalizeResult2_g198;
				float Smoothness188 = saturate( ( ( unpack142.z + break8_g3.b ) - 1.0 ) );
				float smoothness4_g198 = Smoothness188;
				float3 temp_output_9_0_g4 = Albedo190.rgb;
				float3 albedo4_g198 = temp_output_9_0_g4;
				float Metallic194 = break8_g3.r;
				float metalness4_g198 = Metallic194;
				float3 diffuseSH4_g198 = float3( 0,0,0 );
				float3 specularSH4_g198 = float3( 0,0,0 );
				BakerySpecMonoSHFull_float( normalWorld4_g198 , lightmapUV4_g198 , viewDir4_g198 , smoothness4_g198 , albedo4_g198 , metalness4_g198 , diffuseSH4_g198 , specularSH4_g198 );
				#ifdef _MONOSHENABLED_ON
				float3 staticSwitch30_g4 = ( ( temp_output_13_0_g4 + ( Ambient_Occlusion195 * ( diffuseSH4_g198 * temp_output_9_0_g4 ) ) ) + ( specularSH4_g198 * _MonoSHAdjustment ) );
				#else
				float3 staticSwitch30_g4 = temp_output_13_0_g4;
				#endif
				
			
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
			
				half3 albedo3 = Albedo190.rgb;
				half3 normalTS = Normal189;
				half3 emission = staticSwitch30_g4;
				half3 emissionbaked = half3(0,0,0);
			
			// Begin Injection NORMAL_MAP from Injection_NormalMaps.hlsl ----------------------------------------------------------
				//normalMap = SAMPLE_TEXTURE2D(_BumpMap, sampler_BaseMap, uv_main);
				//normalTS = UnpackNormal(normalMap);
				//normalTS = _Normals ? normalTS : half3(0, 0, 1);
				//geoSmooth = _Normals ? normalMap.b : 1.0;
				//smoothness = saturate(smoothness + geoSmooth - 1.0);
			// End Injection NORMAL_MAP from Injection_NormalMaps.hlsl ----------------------------------------------------------
				half metallic = Metallic194;
				half3 specular = half3(0.5, 0.5, 0.5);
				half smoothness = Smoothness188;
				half ao = Ambient_Occlusion195;
				half alpha = half(1);
				half alphaclip = ( _Cull * 0.0 );
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
			sampler2D _MetallicGlossMap;
			CBUFFER_START( UnityPerMaterial )
			float4 _BaseColor;
			float4 _BaseMap_ST;
			int _Scale;
			int _MinScl;
			float _BumpScale;
			float _MonoSHAdjustment;
			float _Cull;
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
				half alphaclip = ( _Cull * 0.0 );
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
					
			#pragma shader_feature_local _NORMALS_ON

					
			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			// Begin Injection VERTEX_IN from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				float4 tangent : TANGENT;
				float2 uv0 : TEXCOORD0;
			// End Injection VERTEX_IN from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				
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
				float4 ase_texcoord3 : TEXCOORD3;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			
			// Begin Injection UNIFORMS from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				//TEXTURE2D(_BumpMap);
				//SAMPLER(sampler_BumpMap);
			// End Injection UNIFORMS from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
			
			CBUFFER_START(UnityPerMaterial)
				float4 _BaseColor;
				float4 _BaseMap_ST;
				int _Scale;
				int _MinScl;
				float _BumpScale;
				float _MonoSHAdjustment;
				float _Cull;
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
			sampler2D _MetallicGlossMap;
			sampler2D _BumpMap;
			sampler2D _BaseMap;

				
						
			v2f vert(appdata v  )
			{
			
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
			
			
				float3 ase_worldPos = TransformObjectToWorld( (v.vertex).xyz );
				o.ase_texcoord3.xyz = ase_worldPos;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.w = 0;
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
			   float2 uv_BaseMap = i.uv0.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
			   float2 temp_output_83_0 = ( uv_BaseMap * _Scale );
			   float3 ase_worldPos = i.ase_texcoord3.xyz;
			   float temp_output_125_0 = max( (float)_MinScl , log2( distance( ase_worldPos , _WorldSpaceCameraPos ) ) );
			   float temp_output_79_0 = floor( temp_output_125_0 );
			   float temp_output_2_0_g2 = temp_output_79_0;
			   float temp_output_3_0_g2 = 2.0;
			   float temp_output_127_0 = ( temp_output_2_0_g2 - ( temp_output_3_0_g2 * floor( ( temp_output_2_0_g2 / temp_output_3_0_g2 ) ) ) );
			   float2 appendResult128 = (float2(temp_output_127_0 , temp_output_127_0));
			   float2 temp_output_124_0 = abs( appendResult128 );
			   float2 UV_A177 = ( temp_output_83_0 / exp2( ( temp_output_79_0 + temp_output_124_0 ) ) );
			   float2 UV_B178 = ( temp_output_83_0 / exp2( ( temp_output_79_0 + ( 1.0 - temp_output_124_0 ) ) ) );
			   float d116 = temp_output_125_0;
			   float temp_output_129_0 = frac( d116 );
			   float fac132 = ( temp_output_127_0 == 0.0 ? temp_output_129_0 : ( 1.0 - temp_output_129_0 ) );
			   float4 lerpResult148 = lerp( tex2D( _BumpMap, UV_A177 ) , tex2D( _BumpMap, UV_B178 ) , fac132);
			   float3 unpack142 = UnpackNormalScale( lerpResult148, _BumpScale );
			   unpack142.z = lerp( 1, unpack142.z, saturate(_BumpScale) );
			   float3 lerpResult214 = lerp( unpack142 , float3( 0,0,1 ) , step( 0.0 , 0.0 ));
			   #ifdef _NORMALS_ON
			   float3 staticSwitch211 = unpack142;
			   #else
			   float3 staticSwitch211 = lerpResult214;
			   #endif
			   float3 Normal189 = staticSwitch211;
			   
			
			
			   half4 normals = half4(0, 0, 0, 1);
			   half3 normalTS = Normal189;
			
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
				half alphaclip = ( _Cull * 0.0 );
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

			sampler2D _MetallicGlossMap;
			CBUFFER_START( UnityPerMaterial )
			float4 _BaseColor;
			float4 _BaseMap_ST;
			int _Scale;
			int _MinScl;
			float _BumpScale;
			float _MonoSHAdjustment;
			float _Cull;
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
				half alphaclip = ( _Cull * 0.0 );
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
			#pragma shader_feature_local _MONOSHENABLED_ON
			#pragma shader_feature_local _MAPTYPE_MAS _MAPTYPE_MASK _MAPTYPE_RMA _MAPTYPE_ORM
			#pragma shader_feature_local _NORMALS_ON


			//TEXTURE2D(_BaseMap);
			//SAMPLER(sampler_BaseMap);

			// Begin Injection UNIFORMS from Injection_Emission_Meta.hlsl ----------------------------------------------------------
			//TEXTURE2D(_EmissionMap);
			// End Injection UNIFORMS from Injection_Emission_Meta.hlsl ----------------------------------------------------------

			CBUFFER_START(UnityPerMaterial)
				float4 _BaseColor;
				float4 _BaseMap_ST;
				int _Scale;
				int _MinScl;
				float _BumpScale;
				float _MonoSHAdjustment;
				float _Cull;
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
			sampler2D _MetallicGlossMap;
			sampler2D _BaseMap;
			sampler2D _BumpMap;


			struct appdata
			{
				float4 vertex : POSITION;
				float4 uv0 : TEXCOORD0;
				float4 uv1 : TEXCOORD1;
				float4 uv2 : TEXCOORD2;
				float4 uv3 : TEXCOORD3;
				float4 ase_tangent : TANGENT;
				float3 ase_normal : NORMAL;
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
			
			
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				float4 ase_texcoord7 : TEXCOORD7;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};

			
			v2f vert(appdata v  )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				float3 ase_worldPos = TransformObjectToWorld( (v.vertex).xyz );
				o.ase_texcoord3.xyz = ase_worldPos;
				
				float3 ase_worldTangent = TransformObjectToWorldDir(v.ase_tangent.xyz);
				o.ase_texcoord4.xyz = ase_worldTangent;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				float ase_vertexTangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord5.xyz = ase_worldBitangent;
				o.ase_texcoord6.xyz = ase_worldNormal;
				
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
				float2 uv_BaseMap = i.uv * _BaseMap_ST.xy + _BaseMap_ST.zw;
				float2 temp_output_83_0 = ( uv_BaseMap * _Scale );
				float3 ase_worldPos = i.ase_texcoord3.xyz;
				float temp_output_125_0 = max( (float)_MinScl , log2( distance( ase_worldPos , _WorldSpaceCameraPos ) ) );
				float temp_output_79_0 = floor( temp_output_125_0 );
				float temp_output_2_0_g2 = temp_output_79_0;
				float temp_output_3_0_g2 = 2.0;
				float temp_output_127_0 = ( temp_output_2_0_g2 - ( temp_output_3_0_g2 * floor( ( temp_output_2_0_g2 / temp_output_3_0_g2 ) ) ) );
				float2 appendResult128 = (float2(temp_output_127_0 , temp_output_127_0));
				float2 temp_output_124_0 = abs( appendResult128 );
				float2 UV_A177 = ( temp_output_83_0 / exp2( ( temp_output_79_0 + temp_output_124_0 ) ) );
				float2 UV_B178 = ( temp_output_83_0 / exp2( ( temp_output_79_0 + ( 1.0 - temp_output_124_0 ) ) ) );
				float d116 = temp_output_125_0;
				float temp_output_129_0 = frac( d116 );
				float fac132 = ( temp_output_127_0 == 0.0 ? temp_output_129_0 : ( 1.0 - temp_output_129_0 ) );
				float4 lerpResult123 = lerp( tex2D( _BaseMap, UV_A177 ) , tex2D( _BaseMap, UV_B178 ) , fac132);
				float4 Albedo190 = ( _BaseColor * lerpResult123 );
				
				float3 temp_output_13_0_g4 = float3( 0,0,0 );
				float4 lerpResult155 = lerp( tex2D( _MetallicGlossMap, UV_A177 ) , tex2D( _MetallicGlossMap, UV_B178 ) , fac132);
				float4 temp_output_1_0_g3 = lerpResult155;
				float4 break15_g3 = temp_output_1_0_g3;
				float4 appendResult16_g3 = (float4(break15_g3.r , break15_g3.g , break15_g3.a , break15_g3.b));
				float4 break19_g3 = temp_output_1_0_g3;
				float4 appendResult18_g3 = (float4(break19_g3.g , break19_g3.b , ( 1.0 - break19_g3.r ) , 0.0));
				float4 break22_g3 = temp_output_1_0_g3;
				float4 appendResult23_g3 = (float4(break22_g3.b , break22_g3.r , ( 1.0 - break22_g3.g ) , 0.0));
				#if defined( _MAPTYPE_MAS )
				float4 staticSwitch3_g3 = temp_output_1_0_g3;
				#elif defined( _MAPTYPE_MASK )
				float4 staticSwitch3_g3 = appendResult16_g3;
				#elif defined( _MAPTYPE_RMA )
				float4 staticSwitch3_g3 = appendResult18_g3;
				#elif defined( _MAPTYPE_ORM )
				float4 staticSwitch3_g3 = appendResult23_g3;
				#else
				float4 staticSwitch3_g3 = temp_output_1_0_g3;
				#endif
				float4 break8_g3 = staticSwitch3_g3;
				float Ambient_Occlusion195 = break8_g3.g;
				float localBakerySpecMonoSHFull4_g198 = ( 0.0 );
				float3 ase_worldTangent = i.ase_texcoord4.xyz;
				float4 lerpResult148 = lerp( tex2D( _BumpMap, UV_A177 ) , tex2D( _BumpMap, UV_B178 ) , fac132);
				float3 unpack142 = UnpackNormalScale( lerpResult148, _BumpScale );
				unpack142.z = lerp( 1, unpack142.z, saturate(_BumpScale) );
				float3 lerpResult214 = lerp( unpack142 , float3( 0,0,1 ) , step( 0.0 , 0.0 ));
				#ifdef _NORMALS_ON
				float3 staticSwitch211 = unpack142;
				#else
				float3 staticSwitch211 = lerpResult214;
				#endif
				float3 Normal189 = staticSwitch211;
				float3 mapNormal16_g200 = Normal189;
				float3 ase_worldBitangent = i.ase_texcoord5.xyz;
				float3 ase_worldNormal = i.ase_texcoord6.xyz;
				float3 normalizeResult18_g200 = normalize( ( ( ase_worldTangent * mapNormal16_g200.x ) + ( ase_worldBitangent * mapNormal16_g200.y ) + ( ase_worldNormal * mapNormal16_g200.z ) ) );
				float3 normalWorld4_g198 = normalizeResult18_g200;
				float2 lightmapUV4_g198 = (i.ase_texcoord7.xy*(unity_LightmapST).xy + (unity_LightmapST).zw);
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 normalizeResult2_g198 = normalize( ase_worldViewDir );
				float3 viewDir4_g198 = normalizeResult2_g198;
				float Smoothness188 = saturate( ( ( unpack142.z + break8_g3.b ) - 1.0 ) );
				float smoothness4_g198 = Smoothness188;
				float3 temp_output_9_0_g4 = Albedo190.rgb;
				float3 albedo4_g198 = temp_output_9_0_g4;
				float Metallic194 = break8_g3.r;
				float metalness4_g198 = Metallic194;
				float3 diffuseSH4_g198 = float3( 0,0,0 );
				float3 specularSH4_g198 = float3( 0,0,0 );
				BakerySpecMonoSHFull_float( normalWorld4_g198 , lightmapUV4_g198 , viewDir4_g198 , smoothness4_g198 , albedo4_g198 , metalness4_g198 , diffuseSH4_g198 , specularSH4_g198 );
				#ifdef _MONOSHENABLED_ON
				float3 staticSwitch30_g4 = ( ( temp_output_13_0_g4 + ( Ambient_Occlusion195 * ( diffuseSH4_g198 * temp_output_9_0_g4 ) ) ) + ( specularSH4_g198 * _MonoSHAdjustment ) );
				#else
				float3 staticSwitch30_g4 = temp_output_13_0_g4;
				#endif
				

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
			
				metaInput.Albedo = Albedo190.rgb;
				half3 emission = staticSwitch30_g4;
				half3 bakedemission = emission;
				metaInput.Emission = bakedemission.rgb;
				#ifdef EDITOR_VISUALIZATION
					metaInput.VizUV = i.VizUV.xy;
					metaInput.LightCoord = i.LightCoord;
				#endif
			
				half alpha = half(1);
				half alphaclip = ( _Cull * 0.0 );
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
Version=19603
Node;AmplifyShaderEditor.CommentaryNode;192;-2640,-2464;Inherit;False;3012;976;;22;87;88;83;122;72;186;79;37;124;125;116;127;128;117;131;129;130;75;77;76;132;74;Fractal UVs;1,1,1,1;0;0
Node;AmplifyShaderEditor.WorldSpaceCameraPos;75;-2592,-2224;Inherit;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.WorldPosInputsNode;74;-2592,-2416;Inherit;True;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.DistanceOpNode;76;-2272,-2240;Inherit;True;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Log2OpNode;77;-2032,-2240;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;37;-1584,-2016;Inherit;False;Property;_MinScl;Minimum Scale;2;0;Create;False;0;0;0;False;3;Space(30);Header(Fractal Settings);Space(10);False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.SimpleMaxOpNode;125;-1856,-2224;Inherit;False;2;0;INT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FloorOpNode;79;-1760,-2240;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;127;-1616,-2144;Inherit;False;Modulo;-1;;2;80e2807460d59004b8a3da8c416ddae5;0;2;2;FLOAT;0;False;3;FLOAT;2;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;171;-2656,-1424;Inherit;False;584;697;;5;150;144;121;7;185;Textures;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;128;-1440,-2144;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;121;-2624,-1376;Inherit;True;Property;_BaseMap;BaseMap;0;0;Create;True;0;0;0;False;3;Header(Base Color);Space(10);MainTexture;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.CommentaryNode;88;-752,-1952;Inherit;False;808.6868;410.0504;UV B;5;90;92;134;91;178;;1,1,1,1;0;0
Node;AmplifyShaderEditor.AbsOpNode;124;-1440,-2240;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;185;-2320,-1392;Inherit;False;AlbedoTextureObj;-1;True;1;0;SAMPLER2D;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.CommentaryNode;87;-768,-2416;Inherit;False;808.6868;410.0504;UV A;4;85;86;84;177;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;116;-1776,-1952;Inherit;False;d;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;134;-720,-1760;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;186;-1424,-2032;Inherit;False;185;AlbedoTextureObj;1;0;OBJECT;;False;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;122;-1216,-2032;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.IntNode;72;-1136,-1904;Inherit;False;Property;_Scale;Scale;3;0;Create;True;0;0;0;False;0;False;25;1;False;0;1;INT;0
Node;AmplifyShaderEditor.GetLocalVarNode;117;-1952,-1760;Inherit;False;116;d;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;90;-608,-1856;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT2;1,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;86;-736,-2352;Inherit;True;2;2;0;FLOAT;0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;83;-976,-1984;Inherit;False;2;2;0;FLOAT2;0,0;False;1;INT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FractNode;129;-1760,-1776;Inherit;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Exp2OpNode;92;-448,-1856;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.Exp2OpNode;85;-496,-2320;Inherit;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.OneMinusNode;131;-1568,-1680;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;91;-256,-1856;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;84;-304,-2304;Inherit;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;193;-2224,-448;Inherit;False;1668;1093;;26;146;147;148;145;149;160;182;181;155;154;156;157;183;184;158;159;143;142;188;189;194;195;211;212;213;214;MAS + Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.Compare;130;-1568,-1904;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;178;-144,-1616;Inherit;False;UV B;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;177;-32,-2304;Inherit;False;UV A;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;132;-1408,-1904;Inherit;True;fac;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;183;-2176,96;Inherit;False;177;UV A;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;184;-2176,272;Inherit;False;178;UV B;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;182;-1936,-192;Inherit;False;178;UV B;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;181;-1936,-368;Inherit;False;177;UV A;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;154;-2016,64;Inherit;True;Property;_MetallicGlossMap1;MAS;9;1;[NoScaleOffset];Create;False;0;0;0;True;0;False;-1;b3fef5a69ddf537449c845898d49a749;b3fef5a69ddf537449c845898d49a749;True;0;False;white;Auto;False;Instance;150;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;156;-2016,240;Inherit;True;Property;_MetallicGlossMap2;MAS;9;1;[NoScaleOffset];Create;False;0;0;0;True;0;False;-1;b3fef5a69ddf537449c845898d49a749;b3fef5a69ddf537449c845898d49a749;True;0;False;white;Auto;False;Instance;150;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.GetLocalVarNode;157;-1936,416;Inherit;True;132;fac;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;146;-1776,-400;Inherit;True;Property;_BumpMap1;Normal;5;1;[Normal];Create;False;0;0;0;False;2;NoScaleOffset;SingleLineTexture;False;-1;None;None;True;0;False;bump;Auto;False;Instance;144;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;147;-1776,-224;Inherit;True;Property;_BumpMap2;Normal;5;1;[Normal];Create;False;0;0;0;False;2;NoScaleOffset;SingleLineTexture;False;-1;None;None;True;0;False;bump;Auto;False;Instance;144;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.GetLocalVarNode;149;-1696,-48;Inherit;True;132;fac;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;191;-1968,-1392;Inherit;False;1316;715;;9;123;136;137;133;179;180;24;190;6;Base Color;1,1,1,1;0;0
Node;AmplifyShaderEditor.LerpOp;155;-1648,240;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;148;-1440,-320;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;143;-1392,-96;Inherit;False;Property;_BumpScale;Normal Scale;6;0;Create;False;0;0;0;False;0;False;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;179;-1920,-1312;Inherit;False;177;UV A;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;212;-1360,-400;Inherit;False;Constant;_ZeroConst;ZeroConst;25;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;145;-1472,240;Inherit;False;MASFormatSwap;7;;3;d4aacd9e61651b0429135e5c3f7db7f9;0;1;1;COLOR;0,0,0,0;False;5;COLOR;0;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7
Node;AmplifyShaderEditor.UnpackScaleNormalNode;142;-1200,-240;Inherit;False;Tangent;2;0;FLOAT4;0,0,0,0;False;1;FLOAT;1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.GetLocalVarNode;180;-1920,-1136;Inherit;False;178;UV B;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;133;-1680,-976;Inherit;True;132;fac;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;158;-1184,304;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;136;-1760,-1344;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;1;MainTexture;False;-1;None;None;True;0;False;white;Auto;False;Instance;7;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;137;-1760,-1168;Inherit;True;Property;_TextureSample1;Texture Sample 0;1;0;Create;True;0;0;0;False;1;MainTexture;False;-1;None;None;True;0;False;white;Auto;False;Instance;7;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.StepOpNode;213;-1184,-368;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;123;-1392,-1120;Inherit;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;159;-1072,304;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;214;-1072,-368;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,1;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;6;-1392,-912;Inherit;False;Property;_BaseColor;BaseColor;1;0;Create;True;0;0;0;False;1;MainColor;False;1,1,1,1;0.5773503,0.5773503,0.5773503,1;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;-1056,-1008;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;160;-944,304;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;211;-944,-176;Inherit;False;Property;_Normals;Normal Map Enabled;4;0;Create;False;0;0;0;False;4;Toggle;Space(30);Header(PBR);Space(10);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;208;-320,-512;Inherit;False;564.4475;280.7469;It's set up this way because otherwise, these properties get ignored.;2;210;209;Surface Properties;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;207;-610,-1010;Inherit;False;756;419;;6;196;203;202;205;204;206;MonoSH;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;190;-896,-1008;Inherit;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;188;-800,304;Inherit;False;Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;195;-832,224;Inherit;False;Ambient Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;194;-848,144;Inherit;False;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;189;-768,-128;Inherit;False;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;209;-256,-416;Inherit;False;Property;_Cull;Cull Side;16;2;[HideInInspector];[Enum];Create;False;0;0;1;UnityEngine.Rendering.CullMode;False;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;203;-496,-960;Inherit;False;189;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;202;-496,-896;Inherit;False;190;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;205;-496,-832;Inherit;False;188;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;204;-496,-768;Inherit;False;194;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;206;-560,-704;Inherit;False;195;Ambient Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;197;304,-1056;Inherit;False;190;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;198;304,-976;Inherit;False;189;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;199;304,-880;Inherit;False;194;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;200;304,-800;Inherit;False;188;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;201;240,-720;Inherit;False;195;Ambient Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;210;-64,-432;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;196;-224,-944;Inherit;False;BakeryMonoSH;10;;4;29c9468cd28079b448a58bef1fb32cb5;0;6;8;FLOAT3;0,0,0;False;9;FLOAT3;0,0,0;False;10;FLOAT;0;False;11;FLOAT;0;False;12;FLOAT;0;False;13;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;7;-2384,-1312;Inherit;True;Property;_MainTex;Albedo (RGB);1;0;Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;150;-2384,-1120;Inherit;True;Property;_MetallicGlossMap;MAS;9;1;[NoScaleOffset];Create;False;0;0;0;True;0;False;-1;75f1fbacfa73385419ec8d7700a107ea;b3fef5a69ddf537449c845898d49a749;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;144;-2384,-928;Inherit;True;Property;_BumpMap;Normal Map;5;2;[NoScaleOffset];[Normal];Create;False;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;225;512,-992;Float;False;True;-1;2;UnityEditor.ShaderGraphLitGUI;0;14;Mabel/Fractal/Fractal Opaque;623634af11bd9ab448550ee777f3493e;True;Forward;0;0;Forward;14;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;1;Lightmode=UniversalForward;True;7;False;0;Hidden/InternalErrorShader;0;0;Standard;24;Workflow;1;0;Surface;0;0;Two Sided;1;0;Cast Shadows;1;0;  Use Shadow Threshold;0;0;GPU Instancing;0;0;Built-in Fog;1;0;Lightmaps;1;0;Volumetrics;1;0;Decals;0;0;Write Depth;0;0;  Early Z (broken);0;0;Vertex Position,InvertActionOnDeselection;1;0;Emission;1;0;PC Reflection Probe;3;0;PC Receive Shadows;1;0;PC Vertex Lights;0;0;PC SSAO;1;0;Q Reflection Probe;0;0;Q Receive Shadows;0;0;Q Vertex Lights;1;0;Q SSAO;0;0;Environment Reflections;1;0;Meta Pass;1;0;0;5;True;True;True;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;226;512,-992;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;623634af11bd9ab448550ee777f3493e;True;DepthOnly;0;1;DepthOnly;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;1;Lightmode=DepthOnly;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;227;512,-992;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;623634af11bd9ab448550ee777f3493e;True;DepthNormals;0;2;DepthNormals;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;Lightmode=DepthNormals;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;228;512,-992;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;623634af11bd9ab448550ee777f3493e;True;ShadowCaster;0;3;ShadowCaster;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ShadowCaster;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;229;512,-992;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;623634af11bd9ab448550ee777f3493e;True;Meta;0;4;Meta;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
WireConnection;76;0;74;0
WireConnection;76;1;75;0
WireConnection;77;0;76;0
WireConnection;125;0;37;0
WireConnection;125;1;77;0
WireConnection;79;0;125;0
WireConnection;127;2;79;0
WireConnection;128;0;127;0
WireConnection;128;1;127;0
WireConnection;124;0;128;0
WireConnection;185;0;121;0
WireConnection;116;0;125;0
WireConnection;134;0;124;0
WireConnection;122;2;186;0
WireConnection;90;0;79;0
WireConnection;90;1;134;0
WireConnection;86;0;79;0
WireConnection;86;1;124;0
WireConnection;83;0;122;0
WireConnection;83;1;72;0
WireConnection;129;0;117;0
WireConnection;92;0;90;0
WireConnection;85;0;86;0
WireConnection;131;0;129;0
WireConnection;91;0;83;0
WireConnection;91;1;92;0
WireConnection;84;0;83;0
WireConnection;84;1;85;0
WireConnection;130;0;127;0
WireConnection;130;2;129;0
WireConnection;130;3;131;0
WireConnection;178;0;91;0
WireConnection;177;0;84;0
WireConnection;132;0;130;0
WireConnection;154;1;183;0
WireConnection;156;1;184;0
WireConnection;146;1;181;0
WireConnection;147;1;182;0
WireConnection;155;0;154;0
WireConnection;155;1;156;0
WireConnection;155;2;157;0
WireConnection;148;0;146;0
WireConnection;148;1;147;0
WireConnection;148;2;149;0
WireConnection;145;1;155;0
WireConnection;142;0;148;0
WireConnection;142;1;143;0
WireConnection;158;0;142;3
WireConnection;158;1;145;6
WireConnection;136;1;179;0
WireConnection;137;1;180;0
WireConnection;213;0;212;0
WireConnection;123;0;136;0
WireConnection;123;1;137;0
WireConnection;123;2;133;0
WireConnection;159;0;158;0
WireConnection;214;0;142;0
WireConnection;214;2;213;0
WireConnection;24;0;6;0
WireConnection;24;1;123;0
WireConnection;160;0;159;0
WireConnection;211;1;214;0
WireConnection;211;0;142;0
WireConnection;190;0;24;0
WireConnection;188;0;160;0
WireConnection;195;0;145;5
WireConnection;194;0;145;4
WireConnection;189;0;211;0
WireConnection;210;0;209;0
WireConnection;196;8;203;0
WireConnection;196;9;202;0
WireConnection;196;10;205;0
WireConnection;196;11;204;0
WireConnection;196;12;206;0
WireConnection;7;0;121;0
WireConnection;225;0;197;0
WireConnection;225;1;198;0
WireConnection;225;2;196;0
WireConnection;225;4;199;0
WireConnection;225;6;200;0
WireConnection;225;7;201;0
WireConnection;225;9;210;0
ASEEND*/
//CHKSM=1D53061DD5A09ED94E61E5E9991B966B4698F884