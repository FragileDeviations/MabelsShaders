using UnityEditor;
using UnityEngine;
using System;
using System.Collections.Generic;

namespace MabelsShaders
{
    public class LocalFilterEditor : ShaderGUI
    {
		private enum Filter
		{
			Grayscale = 0,
			HueShift = 1,
			Invert = 2,
			Posterization = 3,
			SelectiveColor = 4,
			Pixelation = 5,
			Dithering = 6,
			VoronoiDistort = 7,
			DepthTexture = 8
		}
		
		static readonly Dictionary<Filter, string> FilterKeywords = new()
		{
			{ Filter.Grayscale, "_FILTER_GRAYSCALE" },
			{ Filter.HueShift, "_FILTER_HUESHIFT" },
			{ Filter.Invert, "_FILTER_INVERT" },
			{ Filter.Posterization, "_FILTER_POSTERIZATION" },
			{ Filter.SelectiveColor, "_FILTER_SELECTIVECOLOR" },
			{ Filter.Pixelation, "_FILTER_PIXELATION" },
			{ Filter.Dithering, "_FILTER_DITHERING" },
			{ Filter.VoronoiDistort, "_FILTER_VORONOIDISTORT" },
			{ Filter.DepthTexture, "_FILTER_DEPTHTEXTURE" }
		};

		public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
		{
			EditorGUILayout.Space();
			EditorGUILayout.HelpBox("This shader does not work at all on Quest!", MessageType.Warning);
			EditorGUILayout.Space();

			Material mat = materialEditor.target as Material;
			var filterProp = FindProperty("_Filter", properties, true);
			int filterValue = Mathf.Clamp(
				Mathf.RoundToInt(filterProp.floatValue),
				0,
				Enum.GetValues(typeof(Filter)).Length - 1
			);

			EditorGUI.BeginChangeCheck();
			filterValue = EditorGUILayout.Popup("Filter", filterValue, Enum.GetNames(typeof(Filter)));
			if (EditorGUI.EndChangeCheck())
			{
				filterProp.floatValue = filterValue;

				foreach (Material m in materialEditor.targets)
				{
					foreach (var kw in FilterKeywords.Values)
						m.DisableKeyword(kw);

					m.EnableKeyword(FilterKeywords[(Filter)filterValue]);
				}
			}
			
			Filter currentFilter = (Filter)filterValue;
			
			EditorGUILayout.Space();
			EditorGUILayout.LabelField("Filter Specific Settings", EditorStyles.boldLabel);

			DrawFilterSettings(materialEditor, properties, currentFilter);
		}

		private void DrawFilterSettings(MaterialEditor editor, MaterialProperty[] props, Filter filter)
		{
			switch (filter)
			{
				case Filter.Grayscale:
					DrawProp(editor, props, "_GrayscaleMode", "Determines how colors are tonemapped to be grayscale");
					break;

				case Filter.HueShift:
					DrawProp(editor, props, "_Hue");
					DrawProp(editor, props, "_Saturation");
					DrawProp(editor, props, "_Value");
					break;

				case Filter.Invert:
					EditorGUILayout.LabelField("No settings for this filter.", EditorStyles.helpBox);
					break;

				case Filter.Posterization:
					DrawProp(editor, props, "_Steps", "How many steps of colors to crunch.");
					break;

				case Filter.SelectiveColor:
					DrawProp(editor, props, "_TargetColor", "The color you want visible.");
					DrawProp(editor, props, "_Tolerance", "Similar to Chroma Key tolerance, the leeway given to similar colors.");
					DrawProp(editor, props, "_Invert", "If enabled, only the target color is greyscale and everything else is fine.");
					break;

				case Filter.Pixelation:
					var useCustom = FindProperty("_UseCustom", props, false);
					DrawProp(editor, props, "_UseCustom", "Uses the custom scale field instead.");
					if (useCustom.floatValue < 0.5f)
					{
						DrawProp(editor, props, "_Scale", "Pre-defined scales.");
					}
					else
					{
						DrawProp(editor, props, "_CustomScale", "Warning: Numbers that aren't even divisions of the screen resolution.");
					}
					break;
					
				case Filter.Dithering:
					DrawProp(editor, props, "_DitherScale", "How many colors to dither.");
					DrawProp(editor, props, "_ShadingMode", "Switches between showing less color and more color difference.");
					break;
					
				case Filter.VoronoiDistort:
					DrawProp(editor, props, "_VoronoiScale", "The scale of the Voronoi texture.");
					DrawProp(editor, props, "_VoronoiSpeed", "The speed of the Voronoi texture's scrolling.");
					break;
					
				case Filter.DepthTexture:
					DrawProp(editor, props, "_Brightness", "The brightness of the shown depth texture.");
					break;
			}
		}

		private void DrawProp(MaterialEditor editor, MaterialProperty[] props, string name, string tooltip = null)
		{
			var prop = FindProperty(name, props, false);
			if (prop != null)
			{
				GUIContent content = new GUIContent(prop.displayName, tooltip);
				editor.ShaderProperty(prop, content);
			}
		}
	}
}
