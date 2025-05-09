# v1.12.0
## Added Shaders
### Stencil Target Lit
* LitPBR version of Stencil Target
## Changed Shaders
### Stencil Writer
* Ported to ASE, cleaner inspector window
### Stencil Target Unlit
* Previously Stencil Target
* Ported to ASE, cleaner inspector window

# v1.11.2
## Changed Shaders
### Stencils
* Added ability to set stencil layer

# v1.11.1
## Changed Shaders
### Stencil Writer
* Added texture input

# v1.11.0
## Added Shaders
### Stencil Writer
* Only objects with the Stencil Target shader will be visible through this shader
### Stencil Target
* Only visible through Stencil Writers

# v1.10.1
## Changed Shaders
### SLZ Toon
* Set default hitramp color
* Set default hitramp
* Set default BRDF map

# v1.10.0
## Added Shaders
### Motion Vector Alpha Clip
* Almost identical to SLZ's Motion Vector Opaque, but with Alpha Clipping
## Changed Shaders
### LitMAS+ Fade
* Fixed property order
### LitMAS+ Alpha Clip
* Fixed property order

# v1.9.3 - Outline Thickness Fix
## Changed Shaders
### Outline Lit/Unlit
* Fixed outline thickness handling to not just be black and white, grey values are now allowed

# v1.9.2 - Posespace Fix
## Changed Shaders
### SLZ Toon
* Made specular input take posespace impacts into account, only impacts will be reflective

# v1.9.1 - Shader Name Fix
## Changed Shaders
### Fractal Fade
* Fixed name, used to be set to Fractal Transparent by mistake

# v1.9.0 - SLZ Toon
## Added Shaders
### SLZ Toon
* Modified version of SLZ Anime with Emission map and no specular reflections

# v1.8.1 - Non-Linear Probe Toggle
## Changed Shaders
### LitMAS+
* Added option to disable non-linear light probe SH

# v1.8.0 - SLZDecal, Non-Linear Probes
## Added Shaders
### SLZ Decal
* SLZ's Mod2x, but with Parallax mapping
## Changed Shaders
### LitMAS+
* Added Non-Linear Probe SH to fix bad light probes
### VertexBlend
* Added Non-Linear Probe SH to fix bad light probes

# v1.7.0 - Fractal UVs
## Added Shaders
### Fractal
* Original shader done by Coolkidstan, original original shader done by Zulubo.

# v1.6.1 - Transparency Bake Fix
## Changed Shaders
### LitMAS+
* Removed Opacity Map feature, it causes issue with baking
* Fixed transparent baking not working properly
## Known Issue
### LitMAS+
* Transparency does not bake properly still if you don't have a base texture. It uses the base texture's alpha. Use either the included dummy transparent textures, or make your own, rather than using the base color's alpha.

# v1.6.0 - LitMAS+ Optimizations
## Changed Shaders
### LitMAS+
* Removed triplanar properties from LitMAS+, helping reduce amount of variants and, well, properties
* Made Triplanar its own shader
## Added Shaders
### LitMAS Triplanar+
* LitMAS+, but triplanar.
* No heightmap support due to the way triplanar works.

# v1.5.0 - Emission Falloff Bake Toggle
## Changed Shaders
### LitMAS+
* Added ability to disable using emission falloff in the bake

# v1.4.0 - VertexBlend
## Added Shaders
* VertexBlend - Credit to Bryan Bones for the original shader, I ported it to Amplify and cleaned it up by their request, and they allowed me to include it in this package.

# v1.3.0 - MAS Type Swapping
## Changed Shaders
### LitMAS+
* Added ability to change what packed format to use for the MAS map.
* This includes: MAS support, HDRP MASK support, RMA support, and ORM support.

# v1.2.0 - Bright Spots In MonoSH Fix
## Changed Shaders
### LitMAS+
* Changed MonoSH normal handling to fix bright Spots
* Fixed LitMAS+ Alpha Clip being pitch black

# v1.1.1 - Parallax Platform Switch Fix
## Changed Shaders
### LitMAS+
* Made parallax samples be forced to 0 on Quest because it apparently still calculates POM and thats not avoidable due to Amplify limits

# v1.1.0 - Parallax Platform Switch
## Changed Shaders
### LitMAS+
* Added platform check in parallax mapping, parallax will not be enabled on Quest unless specifically enabled in a seperate. PC remains how it was before. Basically: if parallax is enabled but Quest parallax isn't, PC will have parallax while Quest won't.

# v1.0.0 - Initial Release
## Added Shaders
* LitMAS+
* Outline