using UnityEditor;
using UnityEngine;

namespace MabelsShaders
{
    public class ShaderEditor : ShaderGUI
    {
		private enum Filter
		{
			Grayscale = 0,
			HueShift = 1,
			Invert = 2,
			Posterization = 3,
			SelectiveColor = 4,
			Pixelation = 5
		}

		public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] properties)
		{
			var filterProp = FindProperty("_Filter", properties, true);
			int filterIndex = Mathf.Clamp((int)filterProp.floatValue, 0, 5);
			Filter currentFilter = (Filter)filterIndex;

			materialEditor.ShaderProperty(filterProp, "Filter");

			DrawFilterSettings(materialEditor, properties, currentFilter);
		}

		private void DrawFilterSettings(MaterialEditor editor, MaterialProperty[] props, Filter filter)
		{
			switch (filter)
			{
				case Filter.Grayscale:
					DrawProp(editor, props, "_GrayscaleMode");
					break;

				case Filter.HueShift:
					DrawProp(editor, props, "_Hue");
					DrawProp(editor, props, "_Saturation");
					DrawProp(editor, props, "_Value");
					break;

				case Filter.Invert:
					break;

				case Filter.Posterization:
					DrawProp(editor, props, "_Steps");
					break;

				case Filter.SelectiveColor:
					DrawProp(editor, props, "_TargetColor");
					DrawProp(editor, props, "_Tolerance");
					DrawProp(editor, props, "_Invert");
					break;

				case Filter.Pixelation:
					DrawProp(editor, props, "_Scale");
					DrawProp(editor, props, "_UseCustom");
					DrawProp(editor, props, "_CustomScale");
					break;
			}
		}

		private void DrawProp(MaterialEditor editor, MaterialProperty[] props, string name)
		{
			var prop = FindProperty(name, props, false);
			if (prop != null)
				editor.ShaderProperty(prop, prop.displayName);
		}
	}
}
