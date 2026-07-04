shader_type canvas_item;

uniform float threshold = 0.1;

void fragment() {
	vec4 color = texture(TEXTURE, UV); 
	
	if(color.r < threshold && color.g < threshold && color.b < threshold){
		color.a = 0.0;
		color.b = 0.0;
		color.g = 0.0;
	}
	COLOR = color;
}