# pathfinding



### Fixing imgui-SFML Build Errors

Building imgui-SFML generates two errors that have simple fixes.

1) 

imgui-sfml-src/imgui-SFML.cpp: In function ‘void {anonymous}::RenderDrawLists(ImDrawData*)’:
../imgui-sfml-src/imgui-SFML.cpp:956:28: error: no match for ‘operator!=’ (operand types are ‘ImTextureRef’ and ‘ImTextureID’ {aka ‘long long unsigned int’})
  956 |     assert(io.Fonts->TexID != (ImTextureID) nullptr); // You forgot to create and set font texture


Replace 
assert(io.Fonts->TexID != (ImTextureID) nullptr); // You forgot to create and set font texture

with
assert(io.Fonts->TexRef._TexData != nullptr); // You forgot to create and set font texture



2) 

imgui-sfml-src/imgui-SFML.cpp:1043:92: error: ‘const struct ImDrawCmd’ has no member named ‘TextureId’
 1043 |                     const GLuint textureHandle = convertImTextureIDToGLTextureHandle(pcmd->TextureId);
 
 
 Replace pcmd->TextureId with pcmd->GetTexID()
 
 const GLuint textureHandle = convertImTextureIDToGLTextureHandle(pcmd->TextureId);
 
 with 
 const GLuint textureHandle = convertImTextureIDToGLTextureHandle(pcmd->GetTexID());