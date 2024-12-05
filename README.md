# MabelsShaders
 Various shaders for SLZ URP.

# Shaders
## LitMAS+
* LitMAS+ Opaque
* LitMAS+ Alpha Clip
* LitMAS+ Transparent
* LitMAS+ Fade
* LitMAS Triplanar+ Opaque
* LitMAS Triplanar+ Alpha Clip
* LitMAS Triplanar+ Fade
* LitMAS Triplanar+ Transparent 
### Difference from LitMAS
* Bakery MonoSH Lightmap Support
* Parallax Occlusion Mapping
* Opacity Map Support
* Multiple MetallicGlossMap format support (MAS, MASK, RMA, ORM)

## Outline
* Outline Lit
* Outline Unlit
### Usage
* Create material with Outline shader
* Add a new material slot to your mesh renderer (YOUR MESHRENDERER MUST ONLY HAVE ONE MATERIAL FOR IT TO WORK RIGHT!)
* Put outline material in it
* Adjust outline material settings

## Vertex Blend
### Usage
* Create material with VertexBlend Shader
* Make sure your mesh has a Vertex Color attribute
* Set the texture fields
### Credits
* Bryan Bones, for the original shadergraph. They asked I port it to Amplify, and gave me permission to include it here.

## Fractal
* Fractal Opaque
* Fractal Transparent
* Fractal Fade
* Fractal Alpha Clip
### Function
* Attempts to hide obvious tiling in textures. Best used on terrain textures like dirt or rocks.
### Credits
* Coolkidstan, for the ASE port of Zulubo's Fractal UVs
* Zulubo, for the original Fractal UV shader