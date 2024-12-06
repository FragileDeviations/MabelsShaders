// Made with Amplify Shader Editor v1.9.6.3
// Available at the Unity Asset Store - http://u3d.as/y3X 
// Force reimport: 2
Shader "Mabel/LitMAS Plus/LitMAS+ Alpha Clip"
{
	Properties
	{
		[HideInInspector] _AlphaCutoff("Alpha Cutoff ", Range(0, 1)) = 0.5
		[MainColor]_BaseColor("BaseColor", Color) = (1,1,1,1)
		[Header(Base Color)][Space(10)][MainTexture]_BaseMap("Base Map", 2D) = "white" {}
		_Cutoff("Alpha Clip Threshold", Range( 0 , 1)) = 0.5
		[Toggle][Space(30)][Header(PBR)][Space(10)][Toggle(_NORMALS_ON)] _Normals("Normal Map Enabled", Float) = 0
		[NoScaleOffset][Normal]_BumpMap("Normal Map", 2D) = "bump" {}
		[KeywordEnum(MAS,MASK,RMA,ORM)] _MapType("Map Type", Float) = 0
		[NoScaleOffset]_MetallicGlossMap("MAS", 2D) = "white" {}
		[Space(30)][Header(Emissions)][Space(10)][Toggle][Toggle(_EMISSION_ON)] _Emission("Emission Enable", Float) = 0
		[HDR]_EmissionColor("Emission Color", Color) = (1,1,1,1)
		_EmissionFalloff("Emission Falloff", Float) = 1
		[NoScaleOffset]_EmissionMap("Emission Map", 2D) = "white" {}
		_BakedMutiplier("Emission Baked Mutiplier", Float) = 1
		[Space(30)][Header(Details)][Space(10)][Toggle(_DETAILS_ON)] _Details("Details enabled", Float) = 0
		_DetailMap("DetailMap", 2D) = "white" {}
		[Space(30)][Header(Mono SH)][Space(10)][Toggle(_MONOSHENABLED_ON)] _MonoSHEnabled("MonoSH Enabled", Float) = 0
		_MonoSHAdjustment("Mono SH Adjustment", Range( 0 , 10)) = 1
		[Toggle(_USEFALLOFFINBAKE_ON)] _UseFalloffInBake("Use Falloff In Bake", Float) = 1
		[Space(30)][Header(Parallax Occlusion Mapping)][Space(10)][Toggle][Toggle(_HEIGHTMAPENABLED_ON)] _HeightmapEnabled("Parallax Enabled", Float) = 0
		[Toggle(_QUESTPARALLAXENABLED_ON)] _QuestParallaxEnabled("Quest Parallax Enabled", Float) = 0
		_ParallaxScale("Scale", Range( 0 , 1)) = 0.02
		[NoScaleOffset]_HeightMap("Height Map", 2D) = "white" {}
		_MinSamples("Min Samples", Range( 1 , 128)) = 8
		_MaxSamples("Max Samples", Range( 1 , 128)) = 16
		_SidewallSteps("Sidewall Steps", Range( 0 , 10)) = 2
		_RefPlane("Ref Plane", Range( 0 , 1)) = 0
		[HideInInspector][Enum(UnityEngine.Rendering.CullMode)]_Cull("Cull Side", Float) = 0

		[Space(30)][Header(Screen Space Reflections)][Space(10)][Toggle(_NO_SSR)] _SSROff("Disable SSR", Float) = 0
		[Header(This should be 0 for skinned meshes)]
		_SSRTemporalMul("Temporal Accumulation Factor", Range(0, 2)) = 1.0
		//[Toggle(_SM6_QUAD)] _SM6_Quad("Quad-avg SSR", Float) = 0


	}
	SubShader
	{
		LOD 0

		
		Tags { "RenderPipeline"="UniversalPipeline" "RenderType"="TransparentCutout" "Queue"="Geometry" }
		
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
			#pragma multi_compile_fog
			#define LITMAS_FEATURE_LIGHTMAPPING
			#pragma multi_compile_fragment _ _VOLUMETRICS_ENABLED
			#define LITMAS_FEATURE_EMISSION
			#define PC_REFLECTION_PROBE_BLENDING
			#define PC_REFLECTION_PROBE_BOX_PROJECTION
			#define PC_RECEIVE_SHADOWS
			#define PC_SSAO
			#define MOBILE_LIGHTS_VERTEX
			#define _SurfaceOpaque
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
			#pragma shader_feature_local_fragment _DETAILS_ON
			#pragma shader_feature_local _HEIGHTMAPENABLED_ON
			#pragma shader_feature_local _QUESTPARALLAXENABLED_ON
			#pragma shader_feature_local _NORMALS_ON
			#pragma shader_feature_local _MONOSHENABLED_ON
			#pragma shader_feature_local _EMISSION_ON
			#pragma shader_feature_local _MAPTYPE_MAS _MAPTYPE_MASK _MAPTYPE_RMA _MAPTYPE_ORM
			#pragma shader_feature_local _USEFALLOFFINBAKE_ON

					
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
				float4 _BaseMap_ST;
				float4 _HeightMap_ST;
				float4 _BaseColor;
				float4 _DetailMap_ST;
				float4 _EmissionColor;
				float _ParallaxScale;
				float _MinSamples;
				float _MaxSamples;
				float _SidewallSteps;
				float _RefPlane;
				float _EmissionFalloff;
				float _MonoSHAdjustment;
				float _BakedMutiplier;
				float _Cutoff;
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
			sampler2D _BaseMap;
			sampler2D _HeightMap;
			sampler2D _DetailMap;
			sampler2D _BumpMap;
			sampler2D _EmissionMap;
			sampler2D _MetallicGlossMap;

			
			inline float2 POM( sampler2D heightMap, float2 uvs, float2 dx, float2 dy, float3 normalWorld, float3 viewWorld, float3 viewDirTan, int minSamples, int maxSamples, int sidewallSteps, float parallax, float refPlane, float2 tilling, float2 curv, int index )
			{
				float3 result = 0;
				int stepIndex = 0;
				int numSteps = ( int )lerp( (float)maxSamples, (float)minSamples, saturate( dot( normalWorld, viewWorld ) ) );
				float layerHeight = 1.0 / numSteps;
				float2 plane = parallax * ( viewDirTan.xy / viewDirTan.z );
				uvs.xy += refPlane * plane;
				float2 deltaTex = -plane * layerHeight;
				float2 prevTexOffset = 0;
				float prevRayZ = 1.0f;
				float prevHeight = 0.0f;
				float2 currTexOffset = deltaTex;
				float currRayZ = 1.0f - layerHeight;
				float currHeight = 0.0f;
				float intersection = 0;
				float2 finalTexOffset = 0;
				while ( stepIndex < numSteps + 1 )
				{
				 	currHeight = tex2Dgrad( heightMap, uvs + currTexOffset, dx, dy ).r;
				 	if ( currHeight > currRayZ )
				 	{
				 	 	stepIndex = numSteps + 1;
				 	}
				 	else
				 	{
				 	 	stepIndex++;
				 	 	prevTexOffset = currTexOffset;
				 	 	prevRayZ = currRayZ;
				 	 	prevHeight = currHeight;
				 	 	currTexOffset += deltaTex;
				 	 	currRayZ -= layerHeight;
				 	}
				}
				int sectionSteps = sidewallSteps;
				int sectionIndex = 0;
				float newZ = 0;
				float newHeight = 0;
				while ( sectionIndex < sectionSteps )
				{
				 	intersection = ( prevHeight - prevRayZ ) / ( prevHeight - currHeight + currRayZ - prevRayZ );
				 	finalTexOffset = prevTexOffset + intersection * deltaTex;
				 	newZ = prevRayZ - intersection * layerHeight;
				 	newHeight = tex2Dgrad( heightMap, uvs + finalTexOffset, dx, dy ).r;
				 	if ( newHeight > newZ )
				 	{
				 	 	currTexOffset = finalTexOffset;
				 	 	currHeight = newHeight;
				 	 	currRayZ = newZ;
				 	 	deltaTex = intersection * deltaTex;
				 	 	layerHeight = intersection * layerHeight;
				 	}
				 	else
				 	{
				 	 	prevTexOffset = finalTexOffset;
				 	 	prevHeight = newHeight;
				 	 	prevRayZ = newZ;
				 	 	deltaTex = ( 1 - intersection ) * deltaTex;
				 	 	layerHeight = ( 1 - intersection ) * layerHeight;
				 	}
				 	sectionIndex++;
				}
				return uvs.xy + finalTexOffset;
			}
			
			inline float3 MyCustomExpression( half4 In0 )
			{
				return UnpackNormal(In0);;
			}
			
			inline float MyCustomExpression217_g255( float detailSmooth, float smoothness )
			{
				return smoothness * (2.0 * detailSmooth);
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
			
				float3 ase_worldTangent = TransformObjectToWorldDir(v.tangent.xyz);
				o.ase_texcoord7.xyz = ase_worldTangent;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.normal);
				o.ase_texcoord8.xyz = ase_worldNormal;
				float ase_vertexTangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord9.xyz = ase_worldBitangent;
				
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
				float4 uvs4_BaseMap = float4(i.uv0XY_bitZ_fog.xy,0,0);
				uvs4_BaseMap.xy = float4(i.uv0XY_bitZ_fog.xy,0,0).xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
				#ifdef SHADER_API_MOBILE
				float staticSwitch322 = 0.0;
				#else
				float staticSwitch322 = _ParallaxScale;
				#endif
				#ifdef _QUESTPARALLAXENABLED_ON
				float staticSwitch325 = _ParallaxScale;
				#else
				float staticSwitch325 = staticSwitch322;
				#endif
				float3 ase_worldTangent = i.ase_texcoord7.xyz;
				float3 ase_worldNormal = i.ase_texcoord8.xyz;
				float3 ase_worldBitangent = i.ase_texcoord9.xyz;
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - i.wPos.xyz );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
				ase_tanViewDir = normalize(ase_tanViewDir);
				#ifdef SHADER_API_MOBILE
				float staticSwitch321 = 0.0;
				#else
				float staticSwitch321 = _MinSamples;
				#endif
				#ifdef _QUESTPARALLAXENABLED_ON
				float staticSwitch326 = _MinSamples;
				#else
				float staticSwitch326 = staticSwitch321;
				#endif
				#ifdef SHADER_API_MOBILE
				float staticSwitch320 = 0.0;
				#else
				float staticSwitch320 = _MaxSamples;
				#endif
				#ifdef _QUESTPARALLAXENABLED_ON
				float staticSwitch327 = _MaxSamples;
				#else
				float staticSwitch327 = staticSwitch320;
				#endif
				#ifdef SHADER_API_MOBILE
				float staticSwitch319 = 0.0;
				#else
				float staticSwitch319 = _SidewallSteps;
				#endif
				#ifdef _QUESTPARALLAXENABLED_ON
				float staticSwitch328 = _SidewallSteps;
				#else
				float staticSwitch328 = staticSwitch319;
				#endif
				#ifdef SHADER_API_MOBILE
				float staticSwitch323 = 0.0;
				#else
				float staticSwitch323 = _RefPlane;
				#endif
				#ifdef _QUESTPARALLAXENABLED_ON
				float staticSwitch329 = _RefPlane;
				#else
				float staticSwitch329 = staticSwitch323;
				#endif
				float2 OffsetPOM111 = POM( _HeightMap, uvs4_BaseMap.xy, ddx(uvs4_BaseMap.xy), ddy(uvs4_BaseMap.xy), ase_worldNormal, ase_worldViewDir, ase_tanViewDir, (int)staticSwitch326, (int)staticSwitch327, (int)staticSwitch328, staticSwitch325, staticSwitch329, _HeightMap_ST.xy, float2(0,0), 0 );
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch317 = uvs4_BaseMap;
				#else
				float4 staticSwitch317 = float4( OffsetPOM111, 0.0 , 0.0 );
				#endif
				#ifdef _QUESTPARALLAXENABLED_ON
				float4 staticSwitch318 = float4( OffsetPOM111, 0.0 , 0.0 );
				#else
				float4 staticSwitch318 = staticSwitch317;
				#endif
				#ifdef _HEIGHTMAPENABLED_ON
				float4 staticSwitch112 = staticSwitch318;
				#else
				float4 staticSwitch112 = uvs4_BaseMap;
				#endif
				float4 Texture_Coordinates149 = staticSwitch112;
				float4 temp_output_17_0 = ( tex2D( _BaseMap, Texture_Coordinates149.xy ) * _BaseColor );
				float4 temp_output_21_0_g255 = temp_output_17_0;
				float4 temp_output_109_0_g256 = round( temp_output_21_0_g255 );
				float2 texCoord203 = i.uv0XY_bitZ_fog.xy * float2( 1,1 ) + float2( 0,0 );
				#ifdef _HEIGHTMAPENABLED_ON
				float4 staticSwitch204 = Texture_Coordinates149;
				#else
				float4 staticSwitch204 = float4( texCoord203, 0.0 , 0.0 );
				#endif
				float2 temp_output_218_0_g255 = staticSwitch204.xy;
				float4 tex2DNode1_g255 = tex2D( _DetailMap, ( ( temp_output_218_0_g255 * _DetailMap_ST.xy ) + _DetailMap_ST.zw ) );
				#ifdef _DETAILS_ON
				float4 staticSwitch16_g255 = ( ( temp_output_109_0_g256 * ( 1.0 - ( ( 1.0 - temp_output_21_0_g255 ) * ( 1.0 - (tex2DNode1_g255.r).xxxx ) * 2.0 ) ) ) + ( ( 1.0 - temp_output_109_0_g256 ) * ( temp_output_21_0_g255 * (tex2DNode1_g255.r).xxxx * 2.0 ) ) );
				#else
				float4 staticSwitch16_g255 = temp_output_21_0_g255;
				#endif
				float4 Albedo138 = staticSwitch16_g255;
				
				float4 tex2DNode8 = tex2D( _BumpMap, Texture_Coordinates149.xy );
				float4 In02_g219 = tex2DNode8;
				float3 localMyCustomExpression2_g219 = MyCustomExpression( In02_g219 );
				float3 temp_output_160_0 = localMyCustomExpression2_g219;
				float3 lerpResult217 = lerp( temp_output_160_0 , float3( 0,0,1 ) , step( 0.0 , 0.0 ));
				#ifdef _NORMALS_ON
				float3 staticSwitch99 = temp_output_160_0;
				#else
				float3 staticSwitch99 = lerpResult217;
				#endif
				float4 temp_output_22_0_g255 = float4( staticSwitch99 , 0.0 );
				float2 temp_output_57_0_g255 = (tex2DNode1_g255).ga;
				float2 break79_g255 = temp_output_57_0_g255;
				float3 appendResult56_g255 = (float3(break79_g255.y , break79_g255.x , 1.0));
				float3 temp_cast_20 = (1.0).xxx;
				#ifdef _DETAILS_ON
				float4 staticSwitch26_g255 = float4( BlendNormal( temp_output_22_0_g255.rgb , ( ( appendResult56_g255 * 2.0 ) - temp_cast_20 ) ) , 0.0 );
				#else
				float4 staticSwitch26_g255 = temp_output_22_0_g255;
				#endif
				float4 Normal139 = staticSwitch26_g255;
				
				#ifdef _MONOSHENABLED_ON
				float staticSwitch32_g263 = (float)1;
				#else
				float staticSwitch32_g263 = (float)0;
				#endif
				float4 color104 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
				float4 tex2DNode11 = tex2D( _EmissionMap, Texture_Coordinates149.xy );
				float dotResult45 = dot( ase_worldViewDir , ase_worldNormal );
				float4 temp_output_29_0 = ( tex2DNode11 * _EmissionColor * saturate( pow( abs( dotResult45 ) , _EmissionFalloff ) ) );
				#ifdef _EMISSION_ON
				float4 staticSwitch103 = temp_output_29_0;
				#else
				float4 staticSwitch103 = color104;
				#endif
				float4 Emission355 = staticSwitch103;
				float3 temp_output_13_0_g263 = Emission355.rgb;
				float4 tex2DNode9 = tex2D( _MetallicGlossMap, Texture_Coordinates149.xy );
				float4 appendResult338 = (float4(tex2DNode9.r , tex2DNode9.g , tex2DNode9.a , 1.0));
				float4 appendResult341 = (float4(tex2DNode9.g , tex2DNode9.b , ( 1.0 - tex2DNode9.r ) , 1.0));
				float4 appendResult342 = (float4(tex2DNode9.b , tex2DNode9.r , ( 1.0 - tex2DNode9.g ) , 1.0));
				#if defined( _MAPTYPE_MAS )
				float4 staticSwitch330 = tex2DNode9;
				#elif defined( _MAPTYPE_MASK )
				float4 staticSwitch330 = appendResult338;
				#elif defined( _MAPTYPE_RMA )
				float4 staticSwitch330 = appendResult341;
				#elif defined( _MAPTYPE_ORM )
				float4 staticSwitch330 = appendResult342;
				#else
				float4 staticSwitch330 = tex2DNode9;
				#endif
				float4 break332 = staticSwitch330;
				float Ambient_Occlusion133 = break332.g;
				float localBakerySpecMonoSHFull4_g264 = ( 0.0 );
				float3 mapNormal16_g266 = Normal139.rgb;
				float3 normalizeResult18_g266 = normalize( ( ( ase_worldTangent * mapNormal16_g266.x ) + ( ase_worldBitangent * mapNormal16_g266.y ) + ( ase_worldNormal * mapNormal16_g266.z ) ) );
				float3 normalWorld4_g264 = normalizeResult18_g266;
				float2 lightmapUV4_g264 = (i.ase_texcoord10.xy*(unity_LightmapST).xy + (unity_LightmapST).zw);
				float3 normalizeResult2_g264 = normalize( ase_worldViewDir );
				float3 viewDir4_g264 = normalizeResult2_g264;
				float temp_output_23_0_g255 = saturate( ( ( tex2DNode8.b + break332.b ) - 1.0 ) );
				float detailSmooth217_g255 = tex2DNode1_g255.b;
				float smoothness217_g255 = temp_output_23_0_g255;
				float localMyCustomExpression217_g255 = MyCustomExpression217_g255( detailSmooth217_g255 , smoothness217_g255 );
				#ifdef _DETAILS_ON
				float staticSwitch17_g255 = localMyCustomExpression217_g255;
				#else
				float staticSwitch17_g255 = temp_output_23_0_g255;
				#endif
				float Smoothness134 = staticSwitch17_g255;
				float smoothness4_g264 = Smoothness134;
				float3 temp_output_9_0_g263 = Albedo138.rgb;
				float3 albedo4_g264 = temp_output_9_0_g263;
				float Metallic132 = break332.r;
				float metalness4_g264 = Metallic132;
				float3 diffuseSH4_g264 = float3( 0,0,0 );
				float3 specularSH4_g264 = float3( 0,0,0 );
				BakerySpecMonoSHFull_float( normalWorld4_g264 , lightmapUV4_g264 , viewDir4_g264 , smoothness4_g264 , albedo4_g264 , metalness4_g264 , diffuseSH4_g264 , specularSH4_g264 );
				#ifdef _MONOSHENABLED_ON
				float3 staticSwitch30_g263 = ( ( temp_output_13_0_g263 + ( Ambient_Occlusion133 * ( diffuseSH4_g264 * temp_output_9_0_g263 ) ) ) + ( specularSH4_g264 * _MonoSHAdjustment ) );
				#else
				float3 staticSwitch30_g263 = temp_output_13_0_g263;
				#endif
				float localNonLinearLightProbe4_g279 = ( 0.0 );
				float3 mapNormal16_g280 = Normal139.rgb;
				float3 normalizeResult18_g280 = normalize( ( ( ase_worldTangent * mapNormal16_g280.x ) + ( ase_worldBitangent * mapNormal16_g280.y ) + ( ase_worldNormal * mapNormal16_g280.z ) ) );
				float3 normalWorld4_g279 = normalizeResult18_g280;
				float3 color4_g279 = float3( 0,0,0 );
				NonLinearLightProbe_float( normalWorld4_g279 , color4_g279 );
				
				#ifdef _USEFALLOFFINBAKE_ON
				float4 staticSwitch351 = ( temp_output_29_0 * _BakedMutiplier );
				#else
				float4 staticSwitch351 = ( ( tex2DNode11 * _EmissionColor ) * _BakedMutiplier );
				#endif
				
				float4 temp_output_2_0_g259 = temp_output_17_0;
				float Alpha147 = (temp_output_2_0_g259).a;
				
			
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
			
				half3 albedo3 = Albedo138.rgb;
				half3 normalTS = Normal139.rgb;
				half3 emission = ( staticSwitch32_g263 == 1.0 ? staticSwitch30_g263 : ( Emission355.rgb + ( Ambient_Occlusion133 * ( Albedo138.rgb * color4_g279 ) ) ) );
				half3 emissionbaked = staticSwitch351.rgb;
			
			// Begin Injection NORMAL_MAP from Injection_NormalMaps.hlsl ----------------------------------------------------------
				//normalMap = SAMPLE_TEXTURE2D(_BumpMap, sampler_BaseMap, uv_main);
				//normalTS = UnpackNormal(normalMap);
				//normalTS = _Normals ? normalTS : half3(0, 0, 1);
				//geoSmooth = _Normals ? normalMap.b : 1.0;
				//smoothness = saturate(smoothness + geoSmooth - 1.0);
			// End Injection NORMAL_MAP from Injection_NormalMaps.hlsl ----------------------------------------------------------
				half metallic = Metallic132;
				half3 specular = half3(0.5, 0.5, 0.5);
				half smoothness = Smoothness134;
				half ao = Ambient_Occlusion133;
				half alpha = Alpha147;
				half alphaclip = ( _Cutoff + ( _Cull * 0.0 ) );
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
			#pragma multi_compile_fog
			#define LITMAS_FEATURE_LIGHTMAPPING
			#pragma multi_compile_fragment _ _VOLUMETRICS_ENABLED
			#define LITMAS_FEATURE_EMISSION
			#define PC_REFLECTION_PROBE_BLENDING
			#define PC_REFLECTION_PROBE_BOX_PROJECTION
			#define PC_RECEIVE_SHADOWS
			#define PC_SSAO
			#define MOBILE_LIGHTS_VERTEX
			#define _SurfaceOpaque
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

			#pragma shader_feature_local _HEIGHTMAPENABLED_ON
			#pragma shader_feature_local _QUESTPARALLAXENABLED_ON


			struct appdata
			{
			    float4 vertex : POSITION;
			
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_tangent : TANGENT;
				float3 ase_normal : NORMAL;
			    UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct v2f
			{
			    float4 vertex : SV_POSITION;
			
				float4 ase_texcoord : TEXCOORD0;
				float4 ase_texcoord1 : TEXCOORD1;
				float4 ase_texcoord2 : TEXCOORD2;
				float4 ase_texcoord3 : TEXCOORD3;
				float4 ase_texcoord4 : TEXCOORD4;
			    UNITY_VERTEX_INPUT_INSTANCE_ID
			    UNITY_VERTEX_OUTPUT_STEREO
			};
			sampler2D _BaseMap;
			sampler2D _HeightMap;
			CBUFFER_START( UnityPerMaterial )
			float4 _BaseMap_ST;
			float4 _HeightMap_ST;
			float4 _BaseColor;
			float4 _DetailMap_ST;
			float4 _EmissionColor;
			float _ParallaxScale;
			float _MinSamples;
			float _MaxSamples;
			float _SidewallSteps;
			float _RefPlane;
			float _EmissionFalloff;
			float _MonoSHAdjustment;
			float _BakedMutiplier;
			float _Cutoff;
			float _Cull;
			CBUFFER_END


			inline float2 POM( sampler2D heightMap, float2 uvs, float2 dx, float2 dy, float3 normalWorld, float3 viewWorld, float3 viewDirTan, int minSamples, int maxSamples, int sidewallSteps, float parallax, float refPlane, float2 tilling, float2 curv, int index )
			{
				float3 result = 0;
				int stepIndex = 0;
				int numSteps = ( int )lerp( (float)maxSamples, (float)minSamples, saturate( dot( normalWorld, viewWorld ) ) );
				float layerHeight = 1.0 / numSteps;
				float2 plane = parallax * ( viewDirTan.xy / viewDirTan.z );
				uvs.xy += refPlane * plane;
				float2 deltaTex = -plane * layerHeight;
				float2 prevTexOffset = 0;
				float prevRayZ = 1.0f;
				float prevHeight = 0.0f;
				float2 currTexOffset = deltaTex;
				float currRayZ = 1.0f - layerHeight;
				float currHeight = 0.0f;
				float intersection = 0;
				float2 finalTexOffset = 0;
				while ( stepIndex < numSteps + 1 )
				{
				 	currHeight = tex2Dgrad( heightMap, uvs + currTexOffset, dx, dy ).r;
				 	if ( currHeight > currRayZ )
				 	{
				 	 	stepIndex = numSteps + 1;
				 	}
				 	else
				 	{
				 	 	stepIndex++;
				 	 	prevTexOffset = currTexOffset;
				 	 	prevRayZ = currRayZ;
				 	 	prevHeight = currHeight;
				 	 	currTexOffset += deltaTex;
				 	 	currRayZ -= layerHeight;
				 	}
				}
				int sectionSteps = sidewallSteps;
				int sectionIndex = 0;
				float newZ = 0;
				float newHeight = 0;
				while ( sectionIndex < sectionSteps )
				{
				 	intersection = ( prevHeight - prevRayZ ) / ( prevHeight - currHeight + currRayZ - prevRayZ );
				 	finalTexOffset = prevTexOffset + intersection * deltaTex;
				 	newZ = prevRayZ - intersection * layerHeight;
				 	newHeight = tex2Dgrad( heightMap, uvs + finalTexOffset, dx, dy ).r;
				 	if ( newHeight > newZ )
				 	{
				 	 	currTexOffset = finalTexOffset;
				 	 	currHeight = newHeight;
				 	 	currRayZ = newZ;
				 	 	deltaTex = intersection * deltaTex;
				 	 	layerHeight = intersection * layerHeight;
				 	}
				 	else
				 	{
				 	 	prevTexOffset = finalTexOffset;
				 	 	prevHeight = newHeight;
				 	 	prevRayZ = newZ;
				 	 	deltaTex = ( 1 - intersection ) * deltaTex;
				 	 	layerHeight = ( 1 - intersection ) * layerHeight;
				 	}
				 	sectionIndex++;
				}
				return uvs.xy + finalTexOffset;
			}
			

			v2f vert(appdata v )
			{
			    v2f o;
			    UNITY_SETUP_INSTANCE_ID(v);
			    UNITY_TRANSFER_INSTANCE_ID(v, o);
			    UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);

			    float3 ase_worldTangent = TransformObjectToWorldDir(v.ase_tangent.xyz);
			    o.ase_texcoord1.xyz = ase_worldTangent;
			    float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
			    o.ase_texcoord2.xyz = ase_worldNormal;
			    float ase_vertexTangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
			    float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
			    o.ase_texcoord3.xyz = ase_worldBitangent;
			    float3 ase_worldPos = TransformObjectToWorld( (v.vertex).xyz );
			    o.ase_texcoord4.xyz = ase_worldPos;
			    
			    o.ase_texcoord = v.ase_texcoord;
			    
			    //setting value to unused interpolator channels and avoid initialization warnings
			    o.ase_texcoord1.w = 0;
			    o.ase_texcoord2.w = 0;
			    o.ase_texcoord3.w = 0;
			    o.ase_texcoord4.w = 0;
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
			    float4 uvs4_BaseMap = i.ase_texcoord;
			    uvs4_BaseMap.xy = i.ase_texcoord.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
			    #ifdef SHADER_API_MOBILE
			    float staticSwitch322 = 0.0;
			    #else
			    float staticSwitch322 = _ParallaxScale;
			    #endif
			    #ifdef _QUESTPARALLAXENABLED_ON
			    float staticSwitch325 = _ParallaxScale;
			    #else
			    float staticSwitch325 = staticSwitch322;
			    #endif
			    float3 ase_worldTangent = i.ase_texcoord1.xyz;
			    float3 ase_worldNormal = i.ase_texcoord2.xyz;
			    float3 ase_worldBitangent = i.ase_texcoord3.xyz;
			    float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
			    float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
			    float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
			    float3 ase_worldPos = i.ase_texcoord4.xyz;
			    float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
			    ase_worldViewDir = normalize(ase_worldViewDir);
			    float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
			    ase_tanViewDir = normalize(ase_tanViewDir);
			    #ifdef SHADER_API_MOBILE
			    float staticSwitch321 = 0.0;
			    #else
			    float staticSwitch321 = _MinSamples;
			    #endif
			    #ifdef _QUESTPARALLAXENABLED_ON
			    float staticSwitch326 = _MinSamples;
			    #else
			    float staticSwitch326 = staticSwitch321;
			    #endif
			    #ifdef SHADER_API_MOBILE
			    float staticSwitch320 = 0.0;
			    #else
			    float staticSwitch320 = _MaxSamples;
			    #endif
			    #ifdef _QUESTPARALLAXENABLED_ON
			    float staticSwitch327 = _MaxSamples;
			    #else
			    float staticSwitch327 = staticSwitch320;
			    #endif
			    #ifdef SHADER_API_MOBILE
			    float staticSwitch319 = 0.0;
			    #else
			    float staticSwitch319 = _SidewallSteps;
			    #endif
			    #ifdef _QUESTPARALLAXENABLED_ON
			    float staticSwitch328 = _SidewallSteps;
			    #else
			    float staticSwitch328 = staticSwitch319;
			    #endif
			    #ifdef SHADER_API_MOBILE
			    float staticSwitch323 = 0.0;
			    #else
			    float staticSwitch323 = _RefPlane;
			    #endif
			    #ifdef _QUESTPARALLAXENABLED_ON
			    float staticSwitch329 = _RefPlane;
			    #else
			    float staticSwitch329 = staticSwitch323;
			    #endif
			    float2 OffsetPOM111 = POM( _HeightMap, uvs4_BaseMap.xy, ddx(uvs4_BaseMap.xy), ddy(uvs4_BaseMap.xy), ase_worldNormal, ase_worldViewDir, ase_tanViewDir, (int)staticSwitch326, (int)staticSwitch327, (int)staticSwitch328, staticSwitch325, staticSwitch329, _HeightMap_ST.xy, float2(0,0), 0 );
			    #ifdef SHADER_API_MOBILE
			    float4 staticSwitch317 = uvs4_BaseMap;
			    #else
			    float4 staticSwitch317 = float4( OffsetPOM111, 0.0 , 0.0 );
			    #endif
			    #ifdef _QUESTPARALLAXENABLED_ON
			    float4 staticSwitch318 = float4( OffsetPOM111, 0.0 , 0.0 );
			    #else
			    float4 staticSwitch318 = staticSwitch317;
			    #endif
			    #ifdef _HEIGHTMAPENABLED_ON
			    float4 staticSwitch112 = staticSwitch318;
			    #else
			    float4 staticSwitch112 = uvs4_BaseMap;
			    #endif
			    float4 Texture_Coordinates149 = staticSwitch112;
			    float4 temp_output_17_0 = ( tex2D( _BaseMap, Texture_Coordinates149.xy ) * _BaseColor );
			    float4 temp_output_2_0_g259 = temp_output_17_0;
			    float Alpha147 = (temp_output_2_0_g259).a;
			    
			
				half alpha = Alpha147;
				half alphaclip = ( _Cutoff + ( _Cull * 0.0 ) );
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
			#pragma multi_compile_fog
			#define LITMAS_FEATURE_LIGHTMAPPING
			#pragma multi_compile_fragment _ _VOLUMETRICS_ENABLED
			#define LITMAS_FEATURE_EMISSION
			#define PC_REFLECTION_PROBE_BLENDING
			#define PC_REFLECTION_PROBE_BOX_PROJECTION
			#define PC_RECEIVE_SHADOWS
			#define PC_SSAO
			#define MOBILE_LIGHTS_VERTEX
			#define _SurfaceOpaque
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
					
			#define ASE_NEEDS_VERT_TANGENT
			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local_fragment _DETAILS_ON
			#pragma shader_feature_local _NORMALS_ON
			#pragma shader_feature_local _HEIGHTMAPENABLED_ON
			#pragma shader_feature_local _QUESTPARALLAXENABLED_ON

					
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
				float4 ase_texcoord4 : TEXCOORD4;
				float4 ase_texcoord5 : TEXCOORD5;
				float4 ase_texcoord6 : TEXCOORD6;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
			};
			
			// Begin Injection UNIFORMS from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
				//TEXTURE2D(_BumpMap);
				//SAMPLER(sampler_BumpMap);
			// End Injection UNIFORMS from Injection_NormalMap_DepthNormals.hlsl ----------------------------------------------------------
			
			CBUFFER_START(UnityPerMaterial)
				float4 _BaseMap_ST;
				float4 _HeightMap_ST;
				float4 _BaseColor;
				float4 _DetailMap_ST;
				float4 _EmissionColor;
				float _ParallaxScale;
				float _MinSamples;
				float _MaxSamples;
				float _SidewallSteps;
				float _RefPlane;
				float _EmissionFalloff;
				float _MonoSHAdjustment;
				float _BakedMutiplier;
				float _Cutoff;
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
			sampler2D _BumpMap;
			sampler2D _BaseMap;
			sampler2D _HeightMap;
			sampler2D _DetailMap;

				
			inline float2 POM( sampler2D heightMap, float2 uvs, float2 dx, float2 dy, float3 normalWorld, float3 viewWorld, float3 viewDirTan, int minSamples, int maxSamples, int sidewallSteps, float parallax, float refPlane, float2 tilling, float2 curv, int index )
			{
				float3 result = 0;
				int stepIndex = 0;
				int numSteps = ( int )lerp( (float)maxSamples, (float)minSamples, saturate( dot( normalWorld, viewWorld ) ) );
				float layerHeight = 1.0 / numSteps;
				float2 plane = parallax * ( viewDirTan.xy / viewDirTan.z );
				uvs.xy += refPlane * plane;
				float2 deltaTex = -plane * layerHeight;
				float2 prevTexOffset = 0;
				float prevRayZ = 1.0f;
				float prevHeight = 0.0f;
				float2 currTexOffset = deltaTex;
				float currRayZ = 1.0f - layerHeight;
				float currHeight = 0.0f;
				float intersection = 0;
				float2 finalTexOffset = 0;
				while ( stepIndex < numSteps + 1 )
				{
				 	currHeight = tex2Dgrad( heightMap, uvs + currTexOffset, dx, dy ).r;
				 	if ( currHeight > currRayZ )
				 	{
				 	 	stepIndex = numSteps + 1;
				 	}
				 	else
				 	{
				 	 	stepIndex++;
				 	 	prevTexOffset = currTexOffset;
				 	 	prevRayZ = currRayZ;
				 	 	prevHeight = currHeight;
				 	 	currTexOffset += deltaTex;
				 	 	currRayZ -= layerHeight;
				 	}
				}
				int sectionSteps = sidewallSteps;
				int sectionIndex = 0;
				float newZ = 0;
				float newHeight = 0;
				while ( sectionIndex < sectionSteps )
				{
				 	intersection = ( prevHeight - prevRayZ ) / ( prevHeight - currHeight + currRayZ - prevRayZ );
				 	finalTexOffset = prevTexOffset + intersection * deltaTex;
				 	newZ = prevRayZ - intersection * layerHeight;
				 	newHeight = tex2Dgrad( heightMap, uvs + finalTexOffset, dx, dy ).r;
				 	if ( newHeight > newZ )
				 	{
				 	 	currTexOffset = finalTexOffset;
				 	 	currHeight = newHeight;
				 	 	currRayZ = newZ;
				 	 	deltaTex = intersection * deltaTex;
				 	 	layerHeight = intersection * layerHeight;
				 	}
				 	else
				 	{
				 	 	prevTexOffset = finalTexOffset;
				 	 	prevHeight = newHeight;
				 	 	prevRayZ = newZ;
				 	 	deltaTex = ( 1 - intersection ) * deltaTex;
				 	 	layerHeight = ( 1 - intersection ) * layerHeight;
				 	}
				 	sectionIndex++;
				}
				return uvs.xy + finalTexOffset;
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
			
			
				float3 ase_worldTangent = TransformObjectToWorldDir(v.tangent.xyz);
				o.ase_texcoord3.xyz = ase_worldTangent;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.normal);
				o.ase_texcoord4.xyz = ase_worldNormal;
				float ase_vertexTangentSign = v.tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord5.xyz = ase_worldBitangent;
				float3 ase_worldPos = TransformObjectToWorld( (v.vertex).xyz );
				o.ase_texcoord6.xyz = ase_worldPos;
				
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord3.w = 0;
				o.ase_texcoord4.w = 0;
				o.ase_texcoord5.w = 0;
				o.ase_texcoord6.w = 0;
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
			   float4 uvs4_BaseMap = float4(i.uv0.xy,0,0);
			   uvs4_BaseMap.xy = float4(i.uv0.xy,0,0).xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
			   #ifdef SHADER_API_MOBILE
			   float staticSwitch322 = 0.0;
			   #else
			   float staticSwitch322 = _ParallaxScale;
			   #endif
			   #ifdef _QUESTPARALLAXENABLED_ON
			   float staticSwitch325 = _ParallaxScale;
			   #else
			   float staticSwitch325 = staticSwitch322;
			   #endif
			   float3 ase_worldTangent = i.ase_texcoord3.xyz;
			   float3 ase_worldNormal = i.ase_texcoord4.xyz;
			   float3 ase_worldBitangent = i.ase_texcoord5.xyz;
			   float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
			   float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
			   float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
			   float3 ase_worldPos = i.ase_texcoord6.xyz;
			   float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
			   ase_worldViewDir = normalize(ase_worldViewDir);
			   float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
			   ase_tanViewDir = normalize(ase_tanViewDir);
			   #ifdef SHADER_API_MOBILE
			   float staticSwitch321 = 0.0;
			   #else
			   float staticSwitch321 = _MinSamples;
			   #endif
			   #ifdef _QUESTPARALLAXENABLED_ON
			   float staticSwitch326 = _MinSamples;
			   #else
			   float staticSwitch326 = staticSwitch321;
			   #endif
			   #ifdef SHADER_API_MOBILE
			   float staticSwitch320 = 0.0;
			   #else
			   float staticSwitch320 = _MaxSamples;
			   #endif
			   #ifdef _QUESTPARALLAXENABLED_ON
			   float staticSwitch327 = _MaxSamples;
			   #else
			   float staticSwitch327 = staticSwitch320;
			   #endif
			   #ifdef SHADER_API_MOBILE
			   float staticSwitch319 = 0.0;
			   #else
			   float staticSwitch319 = _SidewallSteps;
			   #endif
			   #ifdef _QUESTPARALLAXENABLED_ON
			   float staticSwitch328 = _SidewallSteps;
			   #else
			   float staticSwitch328 = staticSwitch319;
			   #endif
			   #ifdef SHADER_API_MOBILE
			   float staticSwitch323 = 0.0;
			   #else
			   float staticSwitch323 = _RefPlane;
			   #endif
			   #ifdef _QUESTPARALLAXENABLED_ON
			   float staticSwitch329 = _RefPlane;
			   #else
			   float staticSwitch329 = staticSwitch323;
			   #endif
			   float2 OffsetPOM111 = POM( _HeightMap, uvs4_BaseMap.xy, ddx(uvs4_BaseMap.xy), ddy(uvs4_BaseMap.xy), ase_worldNormal, ase_worldViewDir, ase_tanViewDir, (int)staticSwitch326, (int)staticSwitch327, (int)staticSwitch328, staticSwitch325, staticSwitch329, _HeightMap_ST.xy, float2(0,0), 0 );
			   #ifdef SHADER_API_MOBILE
			   float4 staticSwitch317 = uvs4_BaseMap;
			   #else
			   float4 staticSwitch317 = float4( OffsetPOM111, 0.0 , 0.0 );
			   #endif
			   #ifdef _QUESTPARALLAXENABLED_ON
			   float4 staticSwitch318 = float4( OffsetPOM111, 0.0 , 0.0 );
			   #else
			   float4 staticSwitch318 = staticSwitch317;
			   #endif
			   #ifdef _HEIGHTMAPENABLED_ON
			   float4 staticSwitch112 = staticSwitch318;
			   #else
			   float4 staticSwitch112 = uvs4_BaseMap;
			   #endif
			   float4 Texture_Coordinates149 = staticSwitch112;
			   float4 tex2DNode8 = tex2D( _BumpMap, Texture_Coordinates149.xy );
			   float4 In02_g219 = tex2DNode8;
			   float3 localMyCustomExpression2_g219 = MyCustomExpression( In02_g219 );
			   float3 temp_output_160_0 = localMyCustomExpression2_g219;
			   float3 lerpResult217 = lerp( temp_output_160_0 , float3( 0,0,1 ) , step( 0.0 , 0.0 ));
			   #ifdef _NORMALS_ON
			   float3 staticSwitch99 = temp_output_160_0;
			   #else
			   float3 staticSwitch99 = lerpResult217;
			   #endif
			   float4 temp_output_22_0_g255 = float4( staticSwitch99 , 0.0 );
			   float2 texCoord203 = i.uv0.xy * float2( 1,1 ) + float2( 0,0 );
			   #ifdef _HEIGHTMAPENABLED_ON
			   float4 staticSwitch204 = Texture_Coordinates149;
			   #else
			   float4 staticSwitch204 = float4( texCoord203, 0.0 , 0.0 );
			   #endif
			   float2 temp_output_218_0_g255 = staticSwitch204.xy;
			   float4 tex2DNode1_g255 = tex2D( _DetailMap, ( ( temp_output_218_0_g255 * _DetailMap_ST.xy ) + _DetailMap_ST.zw ) );
			   float2 temp_output_57_0_g255 = (tex2DNode1_g255).ga;
			   float2 break79_g255 = temp_output_57_0_g255;
			   float3 appendResult56_g255 = (float3(break79_g255.y , break79_g255.x , 1.0));
			   float3 temp_cast_16 = (1.0).xxx;
			   #ifdef _DETAILS_ON
			   float4 staticSwitch26_g255 = float4( BlendNormal( temp_output_22_0_g255.rgb , ( ( appendResult56_g255 * 2.0 ) - temp_cast_16 ) ) , 0.0 );
			   #else
			   float4 staticSwitch26_g255 = temp_output_22_0_g255;
			   #endif
			   float4 Normal139 = staticSwitch26_g255;
			   
			   float4 temp_output_17_0 = ( tex2D( _BaseMap, Texture_Coordinates149.xy ) * _BaseColor );
			   float4 temp_output_2_0_g259 = temp_output_17_0;
			   float Alpha147 = (temp_output_2_0_g259).a;
			   
			
			
			   half4 normals = half4(0, 0, 0, 1);
			   half3 normalTS = Normal139.rgb;
			
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
				half alpha = Alpha147;
				half alphaclip = ( _Cutoff + ( _Cull * 0.0 ) );
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
			#pragma multi_compile_fog
			#define LITMAS_FEATURE_LIGHTMAPPING
			#pragma multi_compile_fragment _ _VOLUMETRICS_ENABLED
			#define LITMAS_FEATURE_EMISSION
			#define PC_REFLECTION_PROBE_BLENDING
			#define PC_REFLECTION_PROBE_BOX_PROJECTION
			#define PC_RECEIVE_SHADOWS
			#define PC_SSAO
			#define MOBILE_LIGHTS_VERTEX
			#define _SurfaceOpaque
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

			#define ASE_NEEDS_VERT_NORMAL
			#pragma shader_feature_local _HEIGHTMAPENABLED_ON
			#pragma shader_feature_local _QUESTPARALLAXENABLED_ON

			// Shadow Casting Light geometric parameters. These variables are used when applying the shadow Normal Bias and are set by UnityEngine.Rendering.Universal.ShadowUtils.SetupShadowCasterConstantBuffer in com.unity.render-pipelines.universal/Runtime/ShadowUtils.cs
			// For Directional lights, _LightDirection is used when applying shadow Normal Bias.
			// For Spot lights and Point lights, _LightPosition is used to compute the actual light direction because it is different at each shadow caster geometry vertex.
			float3 _LightDirection;
			float3 _LightPosition;

			struct Attributes
			{
			    float4 positionOS   : POSITION;
			    float3 normalOS     : NORMAL;
			    float4 ase_texcoord : TEXCOORD0;
			    float4 ase_tangent : TANGENT;
			    UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			struct Varyings
			{
			    float4 positionCS   : SV_POSITION;
			    float4 ase_texcoord1 : TEXCOORD1;
			    float4 ase_texcoord2 : TEXCOORD2;
			    float4 ase_texcoord3 : TEXCOORD3;
			    float4 ase_texcoord4 : TEXCOORD4;
			    float4 ase_texcoord5 : TEXCOORD5;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};

			sampler2D _BaseMap;
			sampler2D _HeightMap;
			CBUFFER_START( UnityPerMaterial )
			float4 _BaseMap_ST;
			float4 _HeightMap_ST;
			float4 _BaseColor;
			float4 _DetailMap_ST;
			float4 _EmissionColor;
			float _ParallaxScale;
			float _MinSamples;
			float _MaxSamples;
			float _SidewallSteps;
			float _RefPlane;
			float _EmissionFalloff;
			float _MonoSHAdjustment;
			float _BakedMutiplier;
			float _Cutoff;
			float _Cull;
			CBUFFER_END


			inline float2 POM( sampler2D heightMap, float2 uvs, float2 dx, float2 dy, float3 normalWorld, float3 viewWorld, float3 viewDirTan, int minSamples, int maxSamples, int sidewallSteps, float parallax, float refPlane, float2 tilling, float2 curv, int index )
			{
				float3 result = 0;
				int stepIndex = 0;
				int numSteps = ( int )lerp( (float)maxSamples, (float)minSamples, saturate( dot( normalWorld, viewWorld ) ) );
				float layerHeight = 1.0 / numSteps;
				float2 plane = parallax * ( viewDirTan.xy / viewDirTan.z );
				uvs.xy += refPlane * plane;
				float2 deltaTex = -plane * layerHeight;
				float2 prevTexOffset = 0;
				float prevRayZ = 1.0f;
				float prevHeight = 0.0f;
				float2 currTexOffset = deltaTex;
				float currRayZ = 1.0f - layerHeight;
				float currHeight = 0.0f;
				float intersection = 0;
				float2 finalTexOffset = 0;
				while ( stepIndex < numSteps + 1 )
				{
				 	currHeight = tex2Dgrad( heightMap, uvs + currTexOffset, dx, dy ).r;
				 	if ( currHeight > currRayZ )
				 	{
				 	 	stepIndex = numSteps + 1;
				 	}
				 	else
				 	{
				 	 	stepIndex++;
				 	 	prevTexOffset = currTexOffset;
				 	 	prevRayZ = currRayZ;
				 	 	prevHeight = currHeight;
				 	 	currTexOffset += deltaTex;
				 	 	currRayZ -= layerHeight;
				 	}
				}
				int sectionSteps = sidewallSteps;
				int sectionIndex = 0;
				float newZ = 0;
				float newHeight = 0;
				while ( sectionIndex < sectionSteps )
				{
				 	intersection = ( prevHeight - prevRayZ ) / ( prevHeight - currHeight + currRayZ - prevRayZ );
				 	finalTexOffset = prevTexOffset + intersection * deltaTex;
				 	newZ = prevRayZ - intersection * layerHeight;
				 	newHeight = tex2Dgrad( heightMap, uvs + finalTexOffset, dx, dy ).r;
				 	if ( newHeight > newZ )
				 	{
				 	 	currTexOffset = finalTexOffset;
				 	 	currHeight = newHeight;
				 	 	currRayZ = newZ;
				 	 	deltaTex = intersection * deltaTex;
				 	 	layerHeight = intersection * layerHeight;
				 	}
				 	else
				 	{
				 	 	prevTexOffset = finalTexOffset;
				 	 	prevHeight = newHeight;
				 	 	prevRayZ = newZ;
				 	 	deltaTex = ( 1 - intersection ) * deltaTex;
				 	 	layerHeight = ( 1 - intersection ) * layerHeight;
				 	}
				 	sectionIndex++;
				}
				return uvs.xy + finalTexOffset;
			}
			

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
			    float3 ase_worldTangent = TransformObjectToWorldDir(input.ase_tangent.xyz);
			    output.ase_texcoord2.xyz = ase_worldTangent;
			    float3 ase_worldNormal = TransformObjectToWorldNormal(input.normalOS);
			    output.ase_texcoord3.xyz = ase_worldNormal;
			    float ase_vertexTangentSign = input.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
			    float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
			    output.ase_texcoord4.xyz = ase_worldBitangent;
			    float3 ase_worldPos = TransformObjectToWorld( (input.positionOS).xyz );
			    output.ase_texcoord5.xyz = ase_worldPos;
			    
			    output.ase_texcoord1 = input.ase_texcoord;
			    
			    //setting value to unused interpolator channels and avoid initialization warnings
			    output.ase_texcoord2.w = 0;
			    output.ase_texcoord3.w = 0;
			    output.ase_texcoord4.w = 0;
			    output.ase_texcoord5.w = 0;
			
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
			    float4 uvs4_BaseMap = input.ase_texcoord1;
			    uvs4_BaseMap.xy = input.ase_texcoord1.xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
			    #ifdef SHADER_API_MOBILE
			    float staticSwitch322 = 0.0;
			    #else
			    float staticSwitch322 = _ParallaxScale;
			    #endif
			    #ifdef _QUESTPARALLAXENABLED_ON
			    float staticSwitch325 = _ParallaxScale;
			    #else
			    float staticSwitch325 = staticSwitch322;
			    #endif
			    float3 ase_worldTangent = input.ase_texcoord2.xyz;
			    float3 ase_worldNormal = input.ase_texcoord3.xyz;
			    float3 ase_worldBitangent = input.ase_texcoord4.xyz;
			    float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
			    float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
			    float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
			    float3 ase_worldPos = input.ase_texcoord5.xyz;
			    float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
			    ase_worldViewDir = normalize(ase_worldViewDir);
			    float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
			    ase_tanViewDir = normalize(ase_tanViewDir);
			    #ifdef SHADER_API_MOBILE
			    float staticSwitch321 = 0.0;
			    #else
			    float staticSwitch321 = _MinSamples;
			    #endif
			    #ifdef _QUESTPARALLAXENABLED_ON
			    float staticSwitch326 = _MinSamples;
			    #else
			    float staticSwitch326 = staticSwitch321;
			    #endif
			    #ifdef SHADER_API_MOBILE
			    float staticSwitch320 = 0.0;
			    #else
			    float staticSwitch320 = _MaxSamples;
			    #endif
			    #ifdef _QUESTPARALLAXENABLED_ON
			    float staticSwitch327 = _MaxSamples;
			    #else
			    float staticSwitch327 = staticSwitch320;
			    #endif
			    #ifdef SHADER_API_MOBILE
			    float staticSwitch319 = 0.0;
			    #else
			    float staticSwitch319 = _SidewallSteps;
			    #endif
			    #ifdef _QUESTPARALLAXENABLED_ON
			    float staticSwitch328 = _SidewallSteps;
			    #else
			    float staticSwitch328 = staticSwitch319;
			    #endif
			    #ifdef SHADER_API_MOBILE
			    float staticSwitch323 = 0.0;
			    #else
			    float staticSwitch323 = _RefPlane;
			    #endif
			    #ifdef _QUESTPARALLAXENABLED_ON
			    float staticSwitch329 = _RefPlane;
			    #else
			    float staticSwitch329 = staticSwitch323;
			    #endif
			    float2 OffsetPOM111 = POM( _HeightMap, uvs4_BaseMap.xy, ddx(uvs4_BaseMap.xy), ddy(uvs4_BaseMap.xy), ase_worldNormal, ase_worldViewDir, ase_tanViewDir, (int)staticSwitch326, (int)staticSwitch327, (int)staticSwitch328, staticSwitch325, staticSwitch329, _HeightMap_ST.xy, float2(0,0), 0 );
			    #ifdef SHADER_API_MOBILE
			    float4 staticSwitch317 = uvs4_BaseMap;
			    #else
			    float4 staticSwitch317 = float4( OffsetPOM111, 0.0 , 0.0 );
			    #endif
			    #ifdef _QUESTPARALLAXENABLED_ON
			    float4 staticSwitch318 = float4( OffsetPOM111, 0.0 , 0.0 );
			    #else
			    float4 staticSwitch318 = staticSwitch317;
			    #endif
			    #ifdef _HEIGHTMAPENABLED_ON
			    float4 staticSwitch112 = staticSwitch318;
			    #else
			    float4 staticSwitch112 = uvs4_BaseMap;
			    #endif
			    float4 Texture_Coordinates149 = staticSwitch112;
			    float4 temp_output_17_0 = ( tex2D( _BaseMap, Texture_Coordinates149.xy ) * _BaseColor );
			    float4 temp_output_2_0_g259 = temp_output_17_0;
			    float Alpha147 = (temp_output_2_0_g259).a;
			    

				half alpha = Alpha147;
				half alphaclip = ( _Cutoff + ( _Cull * 0.0 ) );
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
			#pragma multi_compile_fog
			#define LITMAS_FEATURE_LIGHTMAPPING
			#pragma multi_compile_fragment _ _VOLUMETRICS_ENABLED
			#define LITMAS_FEATURE_EMISSION
			#define PC_REFLECTION_PROBE_BLENDING
			#define PC_REFLECTION_PROBE_BOX_PROJECTION
			#define PC_RECEIVE_SHADOWS
			#define PC_SSAO
			#define MOBILE_LIGHTS_VERTEX
			#define _SurfaceOpaque
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
			#pragma shader_feature_local_fragment _DETAILS_ON
			#pragma shader_feature_local _HEIGHTMAPENABLED_ON
			#pragma shader_feature_local _QUESTPARALLAXENABLED_ON
			#pragma shader_feature_local _MONOSHENABLED_ON
			#pragma shader_feature_local _EMISSION_ON
			#pragma shader_feature_local _MAPTYPE_MAS _MAPTYPE_MASK _MAPTYPE_RMA _MAPTYPE_ORM
			#pragma shader_feature_local _NORMALS_ON
			#pragma shader_feature_local _USEFALLOFFINBAKE_ON


			//TEXTURE2D(_BaseMap);
			//SAMPLER(sampler_BaseMap);

			// Begin Injection UNIFORMS from Injection_Emission_Meta.hlsl ----------------------------------------------------------
			//TEXTURE2D(_EmissionMap);
			// End Injection UNIFORMS from Injection_Emission_Meta.hlsl ----------------------------------------------------------

			CBUFFER_START(UnityPerMaterial)
				float4 _BaseMap_ST;
				float4 _HeightMap_ST;
				float4 _BaseColor;
				float4 _DetailMap_ST;
				float4 _EmissionColor;
				float _ParallaxScale;
				float _MinSamples;
				float _MaxSamples;
				float _SidewallSteps;
				float _RefPlane;
				float _EmissionFalloff;
				float _MonoSHAdjustment;
				float _BakedMutiplier;
				float _Cutoff;
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
			sampler2D _BaseMap;
			sampler2D _HeightMap;
			sampler2D _DetailMap;
			sampler2D _EmissionMap;
			sampler2D _MetallicGlossMap;
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

			inline float2 POM( sampler2D heightMap, float2 uvs, float2 dx, float2 dy, float3 normalWorld, float3 viewWorld, float3 viewDirTan, int minSamples, int maxSamples, int sidewallSteps, float parallax, float refPlane, float2 tilling, float2 curv, int index )
			{
				float3 result = 0;
				int stepIndex = 0;
				int numSteps = ( int )lerp( (float)maxSamples, (float)minSamples, saturate( dot( normalWorld, viewWorld ) ) );
				float layerHeight = 1.0 / numSteps;
				float2 plane = parallax * ( viewDirTan.xy / viewDirTan.z );
				uvs.xy += refPlane * plane;
				float2 deltaTex = -plane * layerHeight;
				float2 prevTexOffset = 0;
				float prevRayZ = 1.0f;
				float prevHeight = 0.0f;
				float2 currTexOffset = deltaTex;
				float currRayZ = 1.0f - layerHeight;
				float currHeight = 0.0f;
				float intersection = 0;
				float2 finalTexOffset = 0;
				while ( stepIndex < numSteps + 1 )
				{
				 	currHeight = tex2Dgrad( heightMap, uvs + currTexOffset, dx, dy ).r;
				 	if ( currHeight > currRayZ )
				 	{
				 	 	stepIndex = numSteps + 1;
				 	}
				 	else
				 	{
				 	 	stepIndex++;
				 	 	prevTexOffset = currTexOffset;
				 	 	prevRayZ = currRayZ;
				 	 	prevHeight = currHeight;
				 	 	currTexOffset += deltaTex;
				 	 	currRayZ -= layerHeight;
				 	}
				}
				int sectionSteps = sidewallSteps;
				int sectionIndex = 0;
				float newZ = 0;
				float newHeight = 0;
				while ( sectionIndex < sectionSteps )
				{
				 	intersection = ( prevHeight - prevRayZ ) / ( prevHeight - currHeight + currRayZ - prevRayZ );
				 	finalTexOffset = prevTexOffset + intersection * deltaTex;
				 	newZ = prevRayZ - intersection * layerHeight;
				 	newHeight = tex2Dgrad( heightMap, uvs + finalTexOffset, dx, dy ).r;
				 	if ( newHeight > newZ )
				 	{
				 	 	currTexOffset = finalTexOffset;
				 	 	currHeight = newHeight;
				 	 	currRayZ = newZ;
				 	 	deltaTex = intersection * deltaTex;
				 	 	layerHeight = intersection * layerHeight;
				 	}
				 	else
				 	{
				 	 	prevTexOffset = finalTexOffset;
				 	 	prevHeight = newHeight;
				 	 	prevRayZ = newZ;
				 	 	deltaTex = ( 1 - intersection ) * deltaTex;
				 	 	layerHeight = ( 1 - intersection ) * layerHeight;
				 	}
				 	sectionIndex++;
				}
				return uvs.xy + finalTexOffset;
			}
			
			inline float3 MyCustomExpression( half4 In0 )
			{
				return UnpackNormal(In0);;
			}
			
			inline float MyCustomExpression217_g255( float detailSmooth, float smoothness )
			{
				return smoothness * (2.0 * detailSmooth);
			}
			

			v2f vert(appdata v  )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_TRANSFER_INSTANCE_ID(v, o);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				float3 ase_worldTangent = TransformObjectToWorldDir(v.ase_tangent.xyz);
				o.ase_texcoord3.xyz = ase_worldTangent;
				float3 ase_worldNormal = TransformObjectToWorldNormal(v.ase_normal);
				o.ase_texcoord4.xyz = ase_worldNormal;
				float ase_vertexTangentSign = v.ase_tangent.w * ( unity_WorldTransformParams.w >= 0.0 ? 1.0 : -1.0 );
				float3 ase_worldBitangent = cross( ase_worldNormal, ase_worldTangent ) * ase_vertexTangentSign;
				o.ase_texcoord5.xyz = ase_worldBitangent;
				float3 ase_worldPos = TransformObjectToWorld( (v.vertex).xyz );
				o.ase_texcoord6.xyz = ase_worldPos;
				
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
				float4 uvs4_BaseMap = float4(i.uv,0,0);
				uvs4_BaseMap.xy = float4(i.uv,0,0).xy * _BaseMap_ST.xy + _BaseMap_ST.zw;
				#ifdef SHADER_API_MOBILE
				float staticSwitch322 = 0.0;
				#else
				float staticSwitch322 = _ParallaxScale;
				#endif
				#ifdef _QUESTPARALLAXENABLED_ON
				float staticSwitch325 = _ParallaxScale;
				#else
				float staticSwitch325 = staticSwitch322;
				#endif
				float3 ase_worldTangent = i.ase_texcoord3.xyz;
				float3 ase_worldNormal = i.ase_texcoord4.xyz;
				float3 ase_worldBitangent = i.ase_texcoord5.xyz;
				float3 tanToWorld0 = float3( ase_worldTangent.x, ase_worldBitangent.x, ase_worldNormal.x );
				float3 tanToWorld1 = float3( ase_worldTangent.y, ase_worldBitangent.y, ase_worldNormal.y );
				float3 tanToWorld2 = float3( ase_worldTangent.z, ase_worldBitangent.z, ase_worldNormal.z );
				float3 ase_worldPos = i.ase_texcoord6.xyz;
				float3 ase_worldViewDir = ( _WorldSpaceCameraPos.xyz - ase_worldPos );
				ase_worldViewDir = normalize(ase_worldViewDir);
				float3 ase_tanViewDir =  tanToWorld0 * ase_worldViewDir.x + tanToWorld1 * ase_worldViewDir.y  + tanToWorld2 * ase_worldViewDir.z;
				ase_tanViewDir = normalize(ase_tanViewDir);
				#ifdef SHADER_API_MOBILE
				float staticSwitch321 = 0.0;
				#else
				float staticSwitch321 = _MinSamples;
				#endif
				#ifdef _QUESTPARALLAXENABLED_ON
				float staticSwitch326 = _MinSamples;
				#else
				float staticSwitch326 = staticSwitch321;
				#endif
				#ifdef SHADER_API_MOBILE
				float staticSwitch320 = 0.0;
				#else
				float staticSwitch320 = _MaxSamples;
				#endif
				#ifdef _QUESTPARALLAXENABLED_ON
				float staticSwitch327 = _MaxSamples;
				#else
				float staticSwitch327 = staticSwitch320;
				#endif
				#ifdef SHADER_API_MOBILE
				float staticSwitch319 = 0.0;
				#else
				float staticSwitch319 = _SidewallSteps;
				#endif
				#ifdef _QUESTPARALLAXENABLED_ON
				float staticSwitch328 = _SidewallSteps;
				#else
				float staticSwitch328 = staticSwitch319;
				#endif
				#ifdef SHADER_API_MOBILE
				float staticSwitch323 = 0.0;
				#else
				float staticSwitch323 = _RefPlane;
				#endif
				#ifdef _QUESTPARALLAXENABLED_ON
				float staticSwitch329 = _RefPlane;
				#else
				float staticSwitch329 = staticSwitch323;
				#endif
				float2 OffsetPOM111 = POM( _HeightMap, uvs4_BaseMap.xy, ddx(uvs4_BaseMap.xy), ddy(uvs4_BaseMap.xy), ase_worldNormal, ase_worldViewDir, ase_tanViewDir, (int)staticSwitch326, (int)staticSwitch327, (int)staticSwitch328, staticSwitch325, staticSwitch329, _HeightMap_ST.xy, float2(0,0), 0 );
				#ifdef SHADER_API_MOBILE
				float4 staticSwitch317 = uvs4_BaseMap;
				#else
				float4 staticSwitch317 = float4( OffsetPOM111, 0.0 , 0.0 );
				#endif
				#ifdef _QUESTPARALLAXENABLED_ON
				float4 staticSwitch318 = float4( OffsetPOM111, 0.0 , 0.0 );
				#else
				float4 staticSwitch318 = staticSwitch317;
				#endif
				#ifdef _HEIGHTMAPENABLED_ON
				float4 staticSwitch112 = staticSwitch318;
				#else
				float4 staticSwitch112 = uvs4_BaseMap;
				#endif
				float4 Texture_Coordinates149 = staticSwitch112;
				float4 temp_output_17_0 = ( tex2D( _BaseMap, Texture_Coordinates149.xy ) * _BaseColor );
				float4 temp_output_21_0_g255 = temp_output_17_0;
				float4 temp_output_109_0_g256 = round( temp_output_21_0_g255 );
				float2 texCoord203 = i.uv * float2( 1,1 ) + float2( 0,0 );
				#ifdef _HEIGHTMAPENABLED_ON
				float4 staticSwitch204 = Texture_Coordinates149;
				#else
				float4 staticSwitch204 = float4( texCoord203, 0.0 , 0.0 );
				#endif
				float2 temp_output_218_0_g255 = staticSwitch204.xy;
				float4 tex2DNode1_g255 = tex2D( _DetailMap, ( ( temp_output_218_0_g255 * _DetailMap_ST.xy ) + _DetailMap_ST.zw ) );
				#ifdef _DETAILS_ON
				float4 staticSwitch16_g255 = ( ( temp_output_109_0_g256 * ( 1.0 - ( ( 1.0 - temp_output_21_0_g255 ) * ( 1.0 - (tex2DNode1_g255.r).xxxx ) * 2.0 ) ) ) + ( ( 1.0 - temp_output_109_0_g256 ) * ( temp_output_21_0_g255 * (tex2DNode1_g255.r).xxxx * 2.0 ) ) );
				#else
				float4 staticSwitch16_g255 = temp_output_21_0_g255;
				#endif
				float4 Albedo138 = staticSwitch16_g255;
				
				#ifdef _MONOSHENABLED_ON
				float staticSwitch32_g263 = (float)1;
				#else
				float staticSwitch32_g263 = (float)0;
				#endif
				float4 color104 = IsGammaSpace() ? float4(0,0,0,0) : float4(0,0,0,0);
				float4 tex2DNode11 = tex2D( _EmissionMap, Texture_Coordinates149.xy );
				float dotResult45 = dot( ase_worldViewDir , ase_worldNormal );
				float4 temp_output_29_0 = ( tex2DNode11 * _EmissionColor * saturate( pow( abs( dotResult45 ) , _EmissionFalloff ) ) );
				#ifdef _EMISSION_ON
				float4 staticSwitch103 = temp_output_29_0;
				#else
				float4 staticSwitch103 = color104;
				#endif
				float4 Emission355 = staticSwitch103;
				float3 temp_output_13_0_g263 = Emission355.rgb;
				float4 tex2DNode9 = tex2D( _MetallicGlossMap, Texture_Coordinates149.xy );
				float4 appendResult338 = (float4(tex2DNode9.r , tex2DNode9.g , tex2DNode9.a , 1.0));
				float4 appendResult341 = (float4(tex2DNode9.g , tex2DNode9.b , ( 1.0 - tex2DNode9.r ) , 1.0));
				float4 appendResult342 = (float4(tex2DNode9.b , tex2DNode9.r , ( 1.0 - tex2DNode9.g ) , 1.0));
				#if defined( _MAPTYPE_MAS )
				float4 staticSwitch330 = tex2DNode9;
				#elif defined( _MAPTYPE_MASK )
				float4 staticSwitch330 = appendResult338;
				#elif defined( _MAPTYPE_RMA )
				float4 staticSwitch330 = appendResult341;
				#elif defined( _MAPTYPE_ORM )
				float4 staticSwitch330 = appendResult342;
				#else
				float4 staticSwitch330 = tex2DNode9;
				#endif
				float4 break332 = staticSwitch330;
				float Ambient_Occlusion133 = break332.g;
				float localBakerySpecMonoSHFull4_g264 = ( 0.0 );
				float4 tex2DNode8 = tex2D( _BumpMap, Texture_Coordinates149.xy );
				float4 In02_g219 = tex2DNode8;
				float3 localMyCustomExpression2_g219 = MyCustomExpression( In02_g219 );
				float3 temp_output_160_0 = localMyCustomExpression2_g219;
				float3 lerpResult217 = lerp( temp_output_160_0 , float3( 0,0,1 ) , step( 0.0 , 0.0 ));
				#ifdef _NORMALS_ON
				float3 staticSwitch99 = temp_output_160_0;
				#else
				float3 staticSwitch99 = lerpResult217;
				#endif
				float4 temp_output_22_0_g255 = float4( staticSwitch99 , 0.0 );
				float2 temp_output_57_0_g255 = (tex2DNode1_g255).ga;
				float2 break79_g255 = temp_output_57_0_g255;
				float3 appendResult56_g255 = (float3(break79_g255.y , break79_g255.x , 1.0));
				float3 temp_cast_28 = (1.0).xxx;
				#ifdef _DETAILS_ON
				float4 staticSwitch26_g255 = float4( BlendNormal( temp_output_22_0_g255.rgb , ( ( appendResult56_g255 * 2.0 ) - temp_cast_28 ) ) , 0.0 );
				#else
				float4 staticSwitch26_g255 = temp_output_22_0_g255;
				#endif
				float4 Normal139 = staticSwitch26_g255;
				float3 mapNormal16_g266 = Normal139.rgb;
				float3 normalizeResult18_g266 = normalize( ( ( ase_worldTangent * mapNormal16_g266.x ) + ( ase_worldBitangent * mapNormal16_g266.y ) + ( ase_worldNormal * mapNormal16_g266.z ) ) );
				float3 normalWorld4_g264 = normalizeResult18_g266;
				float2 lightmapUV4_g264 = (i.ase_texcoord7.xy*(unity_LightmapST).xy + (unity_LightmapST).zw);
				float3 normalizeResult2_g264 = normalize( ase_worldViewDir );
				float3 viewDir4_g264 = normalizeResult2_g264;
				float temp_output_23_0_g255 = saturate( ( ( tex2DNode8.b + break332.b ) - 1.0 ) );
				float detailSmooth217_g255 = tex2DNode1_g255.b;
				float smoothness217_g255 = temp_output_23_0_g255;
				float localMyCustomExpression217_g255 = MyCustomExpression217_g255( detailSmooth217_g255 , smoothness217_g255 );
				#ifdef _DETAILS_ON
				float staticSwitch17_g255 = localMyCustomExpression217_g255;
				#else
				float staticSwitch17_g255 = temp_output_23_0_g255;
				#endif
				float Smoothness134 = staticSwitch17_g255;
				float smoothness4_g264 = Smoothness134;
				float3 temp_output_9_0_g263 = Albedo138.rgb;
				float3 albedo4_g264 = temp_output_9_0_g263;
				float Metallic132 = break332.r;
				float metalness4_g264 = Metallic132;
				float3 diffuseSH4_g264 = float3( 0,0,0 );
				float3 specularSH4_g264 = float3( 0,0,0 );
				BakerySpecMonoSHFull_float( normalWorld4_g264 , lightmapUV4_g264 , viewDir4_g264 , smoothness4_g264 , albedo4_g264 , metalness4_g264 , diffuseSH4_g264 , specularSH4_g264 );
				#ifdef _MONOSHENABLED_ON
				float3 staticSwitch30_g263 = ( ( temp_output_13_0_g263 + ( Ambient_Occlusion133 * ( diffuseSH4_g264 * temp_output_9_0_g263 ) ) ) + ( specularSH4_g264 * _MonoSHAdjustment ) );
				#else
				float3 staticSwitch30_g263 = temp_output_13_0_g263;
				#endif
				float localNonLinearLightProbe4_g279 = ( 0.0 );
				float3 mapNormal16_g280 = Normal139.rgb;
				float3 normalizeResult18_g280 = normalize( ( ( ase_worldTangent * mapNormal16_g280.x ) + ( ase_worldBitangent * mapNormal16_g280.y ) + ( ase_worldNormal * mapNormal16_g280.z ) ) );
				float3 normalWorld4_g279 = normalizeResult18_g280;
				float3 color4_g279 = float3( 0,0,0 );
				NonLinearLightProbe_float( normalWorld4_g279 , color4_g279 );
				
				#ifdef _USEFALLOFFINBAKE_ON
				float4 staticSwitch351 = ( temp_output_29_0 * _BakedMutiplier );
				#else
				float4 staticSwitch351 = ( ( tex2DNode11 * _EmissionColor ) * _BakedMutiplier );
				#endif
				
				float4 temp_output_2_0_g259 = temp_output_17_0;
				float Alpha147 = (temp_output_2_0_g259).a;
				

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
			
				metaInput.Albedo = Albedo138.rgb;
				half3 emission = ( staticSwitch32_g263 == 1.0 ? staticSwitch30_g263 : ( Emission355.rgb + ( Ambient_Occlusion133 * ( Albedo138.rgb * color4_g279 ) ) ) );
				half3 bakedemission = staticSwitch351.rgb;
				metaInput.Emission = bakedemission.rgb;
				#ifdef EDITOR_VISUALIZATION
					metaInput.VizUV = i.VizUV.xy;
					metaInput.LightCoord = i.LightCoord;
				#endif
			
				half alpha = Alpha147;
				half alphaclip = ( _Cutoff + ( _Cull * 0.0 ) );
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
Node;AmplifyShaderEditor.CommentaryNode;115;-720,-816;Inherit;False;1868.141;824.6599;;23;111;149;112;318;317;113;323;322;321;320;319;108;324;110;105;109;106;107;325;326;327;328;329;Parallax Mapping;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;107;-672,-336;Inherit;False;Property;_RefPlane;Ref Plane;35;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;106;-672,-592;Inherit;False;Property;_ParallaxScale;Scale;30;0;Create;False;0;0;0;False;0;False;0.02;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;109;-672,-528;Inherit;False;Property;_MinSamples;Min Samples;32;0;Create;True;0;0;0;False;0;False;8;0;1;128;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;105;-672,-400;Inherit;False;Property;_SidewallSteps;Sidewall Steps;34;0;Create;True;0;0;0;False;0;False;2;2;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;110;-672,-464;Inherit;False;Property;_MaxSamples;Max Samples;33;0;Create;True;0;0;0;False;0;False;16;16;1;128;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;324;-576,-272;Inherit;False;Constant;_ZeroConstLol;ZeroConstLol;27;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;319;-304,-432;Inherit;False;Property;_SHADER_API_MOBILE2;SHADER_API_MOBILE;33;0;Create;True;0;0;0;False;0;False;0;0;0;False;SHADER_API_MOBILE;Toggle;2;Key0;Key1;Fetch;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;320;-304,-528;Inherit;False;Property;_SHADER_API_MOBILE3;SHADER_API_MOBILE;33;0;Create;True;0;0;0;False;0;False;0;0;0;False;SHADER_API_MOBILE;Toggle;2;Key0;Key1;Fetch;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;321;-304,-624;Inherit;False;Property;_SHADER_API_MOBILE4;SHADER_API_MOBILE;33;0;Create;True;0;0;0;False;0;False;0;0;0;False;SHADER_API_MOBILE;Toggle;2;Key0;Key1;Fetch;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;322;-304,-720;Inherit;False;Property;_SHADER_API_MOBILE5;SHADER_API_MOBILE;33;0;Create;True;0;0;0;False;0;False;0;0;0;False;SHADER_API_MOBILE;Toggle;2;Key0;Key1;Fetch;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;323;-304,-336;Inherit;False;Property;_SHADER_API_MOBILE1;SHADER_API_MOBILE;33;0;Create;True;0;0;0;False;0;False;0;0;0;False;SHADER_API_MOBILE;Toggle;2;Key0;Key1;Fetch;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;325;16,-720;Inherit;False;Property;_Keyword10;Keyword 10;29;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;318;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;326;16,-624;Inherit;False;Property;_Keyword11;Keyword 10;29;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;318;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;327;16,-528;Inherit;False;Property;_Keyword12;Keyword 10;29;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;318;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;328;16,-432;Inherit;False;Property;_Keyword13;Keyword 10;29;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;318;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;329;16,-336;Inherit;False;Property;_Keyword14;Keyword 10;29;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;318;True;True;All;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;108;-624,-768;Inherit;True;Property;_HeightMap;Height Map;31;1;[NoScaleOffset];Create;True;1;Parallax Occlusion Mapping;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TextureCoordinatesNode;113;-560,-192;Inherit;False;0;5;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ParallaxOcclusionMappingNode;111;400,-704;Inherit;False;0;8;False;;16;False;;2;0.022;0;False;1,1;False;0,0;11;0;FLOAT2;0,0;False;1;SAMPLER2D;;False;7;SAMPLERSTATE;;False;2;FLOAT;0.02;False;3;FLOAT3;0,0,0;False;8;INT;0;False;9;INT;0;False;10;INT;0;False;4;FLOAT;0;False;5;FLOAT2;0,0;False;6;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;317;752,-672;Inherit;False;Property;_SHADER_API_MOBILE;SHADER_API_MOBILE;33;0;Create;True;0;0;0;False;0;False;0;0;0;False;SHADER_API_MOBILE;Toggle;2;Key0;Key1;Fetch;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;318;432,-384;Inherit;False;Property;_QuestParallaxEnabled;Quest Parallax Enabled;29;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StaticSwitch;112;240,-192;Inherit;False;Property;_HeightmapEnabled;Parallax Enabled;28;0;Create;False;0;0;0;False;4;Space(30);Header(Parallax Occlusion Mapping);Space(10);Toggle;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CommentaryNode;49;-2224,384;Inherit;False;1237.2;711.9001;;20;42;40;41;99;9;8;151;160;217;218;219;330;332;338;339;342;340;341;132;133;Normal;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;149;576,-176;Inherit;False;Texture Coordinates;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;151;-2208,688;Inherit;False;149;Texture Coordinates;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;9;-2192,832;Inherit;True;Property;_MetallicGlossMap;MAS;9;1;[NoScaleOffset];Create;False;0;0;0;True;0;False;8;75f1fbacfa73385419ec8d7700a107ea;75f1fbacfa73385419ec8d7700a107ea;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.OneMinusNode;340;-1872,992;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;339;-2048,1024;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;52;-528,512;Inherit;False;1472.8;1054.2;;19;35;103;14;104;29;11;12;48;47;13;46;45;44;43;153;351;353;354;355;Emission Standard;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;341;-1712,960;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;342;-1696,832;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.DynamicAppendNode;338;-1824,832;Inherit;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;1;False;1;FLOAT4;0
Node;AmplifyShaderEditor.WorldNormalVector;43;-240,1232;Inherit;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;44;-240,1088;Inherit;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.StaticSwitch;330;-1552,832;Inherit;False;Property;_MapType;Map Type;8;0;Create;True;0;0;0;False;0;False;0;0;0;True;;KeywordEnum;4;MAS;MASK;RMA;ORM;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DotProductOpNode;45;-48,1088;Inherit;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;50;-1968,-272;Inherit;False;987.9999;522.3;;6;159;5;17;6;206;147;BaseMap;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;219;-1936,512;Inherit;False;Constant;_ZeroConst;ZeroConst;25;0;Create;True;0;0;0;False;0;False;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;332;-1344,832;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SamplerNode;8;-1952,640;Inherit;True;Property;_BumpMap;Normal Map;7;2;[NoScaleOffset];[Normal];Create;False;0;0;0;True;0;False;8;None;None;True;0;False;bump;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.AbsOpNode;46;80,1088;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;13;32,1184;Inherit;False;Property;_EmissionFalloff;Emission Falloff;12;0;Create;False;0;0;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;208;-736,64;Inherit;False;1206;374;;7;204;139;134;138;202;203;207;Detail Map;1,1,1,1;0;0
Node;AmplifyShaderEditor.GetLocalVarNode;206;-1920,-192;Inherit;False;149;Texture Coordinates;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;160;-1648,640;Inherit;False;UnpackNormal;-1;;219;d579cc33c6fa60b4ea9cee9e184b62e3;0;1;1;FLOAT4;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StepOpNode;218;-1792,512;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;41;-1296,640;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;47;224,1088;Inherit;False;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;153;-496,704;Inherit;False;149;Texture Coordinates;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;207;-704,304;Inherit;False;149;Texture Coordinates;1;0;OBJECT;;False;1;FLOAT4;0
Node;AmplifyShaderEditor.LerpOp;217;-1632,480;Inherit;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,1;False;2;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;42;-1184,672;Inherit;False;2;0;FLOAT;0;False;1;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;6;-1680,-32;Inherit;False;Property;_BaseColor;BaseColor;0;0;Create;False;0;0;0;True;1;MainColor;False;1,1,1,1;1,1,1,1;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;5;-1680,-224;Inherit;True;Property;_BaseMap;Base Map;4;0;Create;False;1;Base Color;0;0;False;3;Header(Base Color);Space(10);MainTexture;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.TextureCoordinatesNode;203;-672,160;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;48;400,1088;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;12;-176,880;Inherit;False;Property;_EmissionColor;Emission Color;11;1;[HDR];Create;False;0;0;0;True;0;False;1,1,1,1;0,0,0,1;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SamplerNode;11;-240,688;Inherit;True;Property;_EmissionMap;Emission Map;13;1;[NoScaleOffset];Create;False;0;0;0;True;0;False;5;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.StaticSwitch;204;-448,176;Inherit;False;Property;_Keyword0;Keyword 0;28;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Reference;112;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;17;-1232,-208;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;99;-1344,496;Inherit;False;Property;_Normals;Normal Map Enabled;6;0;Create;False;0;0;0;False;4;Toggle;Space(30);Header(PBR);Space(10);False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SaturateNode;40;-1152,832;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;104;48,608;Inherit;False;Constant;_EmptyEmissive;EmptyEmissive;19;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;True;0;6;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT3;5
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;512,720;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.FunctionNode;202;-80,160;Inherit;False;Detail Map;15;;255;7eb669e8a4269ac43a3c284ddafaf020;0;4;21;COLOR;1,1,1,1;False;22;COLOR;0,0,1,0;False;23;FLOAT;0.5;False;218;FLOAT2;0,0;False;3;COLOR;0;COLOR;25;FLOAT;24
Node;AmplifyShaderEditor.StaticSwitch;103;672,624;Inherit;False;Property;_Emission;Emission Enable;10;0;Create;False;0;0;0;False;4;Space(30);Header(Emissions);Space(10);Toggle;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;96;1328,-160;Inherit;False;564.4475;280.7469;It's set up this way because otherwise, these properties get ignored.;4;69;67;77;350;Surface Properties;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;98;1088,240;Inherit;False;622;370;;6;136;135;137;140;141;356;Mono SH;1,1,1,1;0;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;138;240,144;Inherit;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;134;240,304;Inherit;False;Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;139;272,224;Inherit;False;Normal;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;133;-1232,992;Inherit;False;Ambient Occlusion;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;132;-1216,912;Inherit;False;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;355;704,784;Inherit;False;Emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.CommentaryNode;357;1168,816;Inherit;False;708;355;;5;362;361;360;359;358;Non-Linear Probe;1,1,1,1;0;0
Node;AmplifyShaderEditor.FunctionNode;159;-1248,-16;Inherit;False;Alpha Split;-1;;259;07dab7960105b86429ac8eebd729ed6d;0;1;2;COLOR;0,0,0,0;False;2;FLOAT3;0;FLOAT;6
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;353;272,896;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;14;320,1280;Inherit;False;Property;_BakedMutiplier;Emission Baked Mutiplier;14;0;Create;False;0;0;0;True;0;False;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;67;1392,-64;Inherit;False;Property;_Cull;Cull Side;36;2;[HideInInspector];[Enum];Create;False;0;0;1;UnityEngine.Rendering.CullMode;False;0;False;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;135;1104,400;Inherit;False;134;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;136;1104,464;Inherit;False;132;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;137;1104,528;Inherit;False;133;Ambient Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;140;1104,272;Inherit;False;138;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;141;1104,336;Inherit;False;139;Normal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;356;1376,512;Inherit;False;355;Emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;358;1280,864;Inherit;False;138;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;359;1280,928;Inherit;False;139;Normal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;360;1216,992;Inherit;False;133;Ambient Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;361;1280,1056;Inherit;False;355;Emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;354;448,928;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;640,1280;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;69;1584,-96;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;147;-1200,128;Inherit;False;Alpha;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;350;1344,32;Inherit;False;Property;_Cutoff;Alpha Clip Threshold;5;0;Create;False;0;0;0;False;0;False;0.5;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;306;1344,304;Inherit;False;BakeryMonoSH;21;;263;29c9468cd28079b448a58bef1fb32cb5;0;6;8;FLOAT3;0,0,0;False;9;FLOAT3;0,0,0;False;10;FLOAT;0;False;11;FLOAT;0;False;12;FLOAT;0;False;13;FLOAT3;0,0,0;False;2;FLOAT3;0;FLOAT;31
Node;AmplifyShaderEditor.FunctionNode;362;1504,928;Inherit;False;BakeryNonLinearLightProbe;1;;279;c510387f01015ab478517ff0d72607db;0;4;5;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;10;FLOAT;0;False;9;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;351;656,1008;Inherit;False;Property;_UseFalloffInBake;Use Falloff In Bake;27;0;Create;True;0;0;0;False;0;False;0;1;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;142;1968,144;Inherit;False;138;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;143;1968,208;Inherit;False;139;Normal;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;144;1968,336;Inherit;False;134;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;145;1968,272;Inherit;False;132;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;146;1904,400;Inherit;False;133;Ambient Occlusion;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;77;1776,0;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;148;1968,464;Inherit;False;147;Alpha;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.Compare;363;2128,672;Inherit;False;0;4;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;312;2272,208;Float;False;True;-1;2;UnityEditor.ShaderGraphLitGUI;0;14;Mabel/LitMAS Plus/LitMAS+ Alpha Clip;623634af11bd9ab448550ee777f3493e;True;Forward;0;0;Forward;14;False;True;1;1;False;_BlendSrc;0;False;_BlendDst;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;True;True;0;True;_Cull;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;_ZWrite;True;3;False;;True;True;0;False;;0;False;;True;3;RenderPipeline=UniversalPipeline;RenderType=TransparentCutout=RenderType;Queue=Geometry=Queue=0;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;False;False;False;True;1;Lightmode=UniversalForward;True;7;False;0;Hidden/InternalErrorShader;0;0;Standard;24;Workflow;1;0;Surface;0;638667039710979079;Two Sided;1;0;Cast Shadows;1;0;  Use Shadow Threshold;0;0;GPU Instancing;0;0;Built-in Fog;1;0;Lightmaps;1;0;Volumetrics;1;0;Decals;0;0;Write Depth;0;0;  Early Z (broken);0;0;Vertex Position,InvertActionOnDeselection;1;0;Emission;1;0;PC Reflection Probe;3;0;PC Receive Shadows;1;0;PC Vertex Lights;0;0;PC SSAO;1;0;Q Reflection Probe;0;0;Q Receive Shadows;0;0;Q Vertex Lights;1;0;Q SSAO;0;0;Environment Reflections;1;0;Meta Pass;1;0;0;5;True;True;True;True;True;False;;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;313;2272,208;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;623634af11bd9ab448550ee777f3493e;True;DepthOnly;0;1;DepthOnly;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;1;Lightmode=DepthOnly;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;314;2272,208;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;623634af11bd9ab448550ee777f3493e;True;DepthNormals;0;2;DepthNormals;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;Lightmode=DepthNormals;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;315;2272,208;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;623634af11bd9ab448550ee777f3493e;True;ShadowCaster;0;3;ShadowCaster;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=ShadowCaster;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;316;2272,208;Float;False;False;-1;2;UnityEditor.ShaderGraphLitGUI;0;1;New Amplify Shader;623634af11bd9ab448550ee777f3493e;True;Meta;0;4;Meta;0;False;True;1;1;False;;0;False;;0;1;False;;0;False;;False;False;False;False;False;False;False;False;False;False;False;False;True;0;False;;False;True;True;True;True;True;0;False;;False;False;False;False;False;False;False;True;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;True;1;False;;True;3;False;;True;True;0;False;;0;False;;True;3;RenderPipeline=UniversalPipeline;RenderType=Opaque=RenderType;Queue=Geometry=Queue=0;False;False;0;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;2;False;;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;1;LightMode=Meta;False;False;0;Hidden/InternalErrorShader;0;0;Standard;0;False;0
WireConnection;319;1;105;0
WireConnection;319;0;324;0
WireConnection;320;1;110;0
WireConnection;320;0;324;0
WireConnection;321;1;109;0
WireConnection;321;0;324;0
WireConnection;322;1;106;0
WireConnection;322;0;324;0
WireConnection;323;1;107;0
WireConnection;323;0;324;0
WireConnection;325;1;322;0
WireConnection;325;0;106;0
WireConnection;326;1;321;0
WireConnection;326;0;109;0
WireConnection;327;1;320;0
WireConnection;327;0;110;0
WireConnection;328;1;319;0
WireConnection;328;0;105;0
WireConnection;329;1;323;0
WireConnection;329;0;107;0
WireConnection;111;0;113;0
WireConnection;111;1;108;0
WireConnection;111;7;108;1
WireConnection;111;2;325;0
WireConnection;111;8;326;0
WireConnection;111;9;327;0
WireConnection;111;10;328;0
WireConnection;111;4;329;0
WireConnection;317;1;111;0
WireConnection;317;0;113;0
WireConnection;318;1;317;0
WireConnection;318;0;111;0
WireConnection;112;1;113;0
WireConnection;112;0;318;0
WireConnection;149;0;112;0
WireConnection;9;1;151;0
WireConnection;340;0;9;2
WireConnection;339;0;9;1
WireConnection;341;0;9;2
WireConnection;341;1;9;3
WireConnection;341;2;339;0
WireConnection;342;0;9;3
WireConnection;342;1;9;1
WireConnection;342;2;340;0
WireConnection;338;0;9;1
WireConnection;338;1;9;2
WireConnection;338;2;9;4
WireConnection;330;1;9;0
WireConnection;330;0;338;0
WireConnection;330;2;341;0
WireConnection;330;3;342;0
WireConnection;45;0;44;0
WireConnection;45;1;43;0
WireConnection;332;0;330;0
WireConnection;8;1;151;0
WireConnection;46;0;45;0
WireConnection;160;1;8;0
WireConnection;218;0;219;0
WireConnection;41;0;8;3
WireConnection;41;1;332;2
WireConnection;47;0;46;0
WireConnection;47;1;13;0
WireConnection;217;0;160;0
WireConnection;217;2;218;0
WireConnection;42;0;41;0
WireConnection;5;1;206;0
WireConnection;48;0;47;0
WireConnection;11;1;153;0
WireConnection;204;1;203;0
WireConnection;204;0;207;0
WireConnection;17;0;5;0
WireConnection;17;1;6;0
WireConnection;99;1;217;0
WireConnection;99;0;160;0
WireConnection;40;0;42;0
WireConnection;29;0;11;0
WireConnection;29;1;12;0
WireConnection;29;2;48;0
WireConnection;202;21;17;0
WireConnection;202;22;99;0
WireConnection;202;23;40;0
WireConnection;202;218;204;0
WireConnection;103;1;104;0
WireConnection;103;0;29;0
WireConnection;138;0;202;0
WireConnection;134;0;202;24
WireConnection;139;0;202;25
WireConnection;133;0;332;1
WireConnection;132;0;332;0
WireConnection;355;0;103;0
WireConnection;159;2;17;0
WireConnection;353;0;11;0
WireConnection;353;1;12;0
WireConnection;354;0;353;0
WireConnection;354;1;14;0
WireConnection;35;0;29;0
WireConnection;35;1;14;0
WireConnection;69;0;67;0
WireConnection;147;0;159;6
WireConnection;306;8;141;0
WireConnection;306;9;140;0
WireConnection;306;10;135;0
WireConnection;306;11;136;0
WireConnection;306;12;137;0
WireConnection;306;13;356;0
WireConnection;362;5;358;0
WireConnection;362;1;359;0
WireConnection;362;10;360;0
WireConnection;362;9;361;0
WireConnection;351;1;354;0
WireConnection;351;0;35;0
WireConnection;77;0;350;0
WireConnection;77;1;69;0
WireConnection;363;0;306;31
WireConnection;363;2;306;0
WireConnection;363;3;362;0
WireConnection;312;0;142;0
WireConnection;312;1;143;0
WireConnection;312;2;363;0
WireConnection;312;3;351;0
WireConnection;312;4;145;0
WireConnection;312;6;144;0
WireConnection;312;7;146;0
WireConnection;312;8;148;0
WireConnection;312;9;77;0
ASEEND*/
//CHKSM=E757DDD80F1C27CC92C15BD1CAB35426C1108F67