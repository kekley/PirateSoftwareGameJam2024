shader_type canvas_item;

const float C1 = .1;
const float C2 = .01;
const vec4 AMBIENT = vec4(0.f);

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	COLOR = vec4(.2,0,.2,1);
}


float distanceToLight(vec3 lightPos,vec4 fragPos){
	return clamp(10.f/distance(lightPos.xyz,fragPos.xyz),0.1f,1.f);
	
}


void light() {
	  LIGHT = AMBIENT+ vec4(COLOR.rgb , 1.f);
}

