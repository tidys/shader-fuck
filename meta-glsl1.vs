
precision highp float;
uniform mat4 cc_matViewProj;
uniform mat4 cc_matWorld;
attribute vec3 a_position;
attribute vec4 a_color;
varying vec4 v_color;
#if USE_TEXTURE
attribute vec2 a_uv0;
varying vec2 v_uv0;
#endif
void main () {
  vec4 pos = vec4(a_position, 1);
  #if CC_USE_MODEL
  pos = cc_matViewProj * cc_matWorld * pos;
  #else
  pos = cc_matViewProj * pos;
  #endif
  #if USE_TEXTURE
  v_uv0 = a_uv0;
  #endif
  v_color = a_color;
  gl_Position = pos;
}