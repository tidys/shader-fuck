
precision highp float;
uniform CCGlobal {
  mat4 cc_matView;
  mat4 cc_matViewInv;
  mat4 cc_matProj;
  mat4 cc_matProjInv;
  mat4 cc_matViewProj;
  mat4 cc_matViewProjInv;
  vec4 cc_cameraPos;
  vec4 cc_time;
  mediump vec4 cc_screenSize;
  mediump vec4 cc_screenScale;
};
uniform CCLocal {
  mat4 cc_matWorld;
  mat4 cc_matWorldIT;
};
in vec3 a_position;
in vec4 a_color;
out vec4 v_color;
#if USE_TEXTURE
in vec2 a_uv0;
out vec2 v_uv0;
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