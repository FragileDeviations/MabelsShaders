using UnityEditor;
using UnityEngine;
using System;

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
			VoronoiDistort = 7
		}
		
		string[] filterKeywords = new string[]
		{
			"_FILTER_GRAYSCALE",
			"_FILTER_HUESHIFT",
			"_FILTER_INVERT",
			"_FILTER_POSTERIZATION",
			"_FILTER_SELECTIVECOLOR",
			"_FILTER_PIXELATION",
			"_FILTER_DITHERING",
			"_FILTER_VORONOIDISTORT"
		};

		public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
		{
			EditorGUILayout.Space();
			EditorGUILayout.HelpBox("This shader does not work at all on Quest!", MessageType.Warning);
			EditorGUILayout.Space();

			Material mat = materialEditor.target as Material;
			var filterProp = FindProperty("_Filter", properties, true);
			int filterValue = (int)filterProp.floatValue;

			EditorGUI.BeginChangeCheck();
			filterValue = EditorGUILayout.Popup("Filter", filterValue, Enum.GetNames(typeof(Filter)));
			if (EditorGUI.EndChangeCheck())
			{
				filterProp.floatValue = filterValue;

				foreach (Material m in materialEditor.targets)
				{
					foreach (string kw in filterKeywords)
						m.DisableKeyword(kw);

					m.EnableKeyword(filterKeywords[filterValue]);
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
