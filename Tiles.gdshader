shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() { 
    float distance_cut_off = 100.0; //px 
    vec2 at = screen_uv_to_sdf(SCREEN_UV); 
    COLOR.rgb = vec3(texture_sdf(at)/distance_cut_off); 
}
float distanceToLight(vec3 lightPos,vec4 fragPos){
	return clamp(10.f/distance(lightPos.xyz,fragPos.xyz),0.1f,1.f);
	
}
float attenuation(){
	return 1.f;
}
void light() {
	  LIGHT = vec4(COLOR.rgb , 1.f);
}
