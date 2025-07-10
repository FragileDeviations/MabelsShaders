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
* Alpha Clip Support
* Multiple MetallicGlossMap format support (MAS, MASK, RMA, ORM)
* Non-Linear Light Probe SH, fixing blue spots on light probes

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

## SLZ Decal
### Function
* Literally just Mod2x but with Parallax mapping

## SLZ Toon
### Difference from SLZ Anime
* Emissive map support
* No specular highlights, a real toon shader wouldn't be reflective

## Stencils
* Stencil Writer
* Stencil Target Lit
* Stencil Target Unlit
### Function
* Stencil Targets are only visible through Stencil Writers that match the same Stencil Layer. They cannot be seen otherwise.

## Local Filters
### Function
* Various color filters that apply to whatever objects are behind the mesh that has this shader
### Filters
* Grayscale
* Hue Shift
* Invert
* Posterization
* Selective Color
* Pixelation