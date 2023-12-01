
precision highp float;
#if USE_ALPHA_TEST
  uniform float alphaThreshold;
#endif
void ALPHA_TEST (in vec4 color) {
  #if USE_ALPHA_TEST
      if (color.a < alphaThreshold) discard;
  #endif
}
void ALPHA_TEST (in float alpha) {
  #if USE_ALPHA_TEST
      if (alpha < alphaThreshold) discard;
  #endif
}
varying vec4 v_color;
#if USE_TEXTURE
varying vec2 v_uv0;
uniform sampler2D texture;
#endif
void main () {
  vec4 o = vec4(1, 1, 1, 1);
  #if USE_TEXTURE
  vec4 texture_tmp = texture2D(texture, v_uv0);
  #if CC_USE_ALPHA_ATLAS_texture
      texture_tmp.a *= texture2D(texture, v_uv0 + vec2(0, 0.5)).r;
  #endif
  #if INPUT_IS_GAMMA
    o.rgb *= (texture_tmp.rgb * texture_tmp.rgb);
    o.a *= texture_tmp.a;
  #else
    o *= texture_tmp;
  #endif
  #endif
  o *= v_color;
  ALPHA_TEST(o);
  #if USE_BGRA
    gl_FragColor = o.bgra;
  #else
    gl_FragColor = o.rgba;
  #endif
}