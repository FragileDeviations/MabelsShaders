# MabelsShaders
 Various shaders for SLZ URP.

# Shaders
## LitMAS+
* LitMAS+ Opaque
* LitMAS+ Alpha Clip
* LitMAS+ Transparent
* LitMAS+ Fade
### Difference from LitMAS
* Bakery MonoSH Lightmap Support
* Parallax Occlusion Mapping
* Opacity Map Support
* Triplanar Option Without Needing Extra Shader

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