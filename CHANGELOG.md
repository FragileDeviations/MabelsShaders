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