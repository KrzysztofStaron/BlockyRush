shader_type canvas_item;

uniform vec4 color : hint_color = vec4(1);
uniform float blocker : hint_range(0.0, 1.0) = 0.0;

void fragment() {
	vec4 text = texture(TEXTURE, UV);
	
	float brightnes = (text.r + text.g + text.b) / 3.0;
	text.rgb = mix(vec3(0), color.rgb, brightnes);
	
	text.rgb = mix(text.rgb, texture(TEXTURE, UV).rgb, blocker);
	COLOR = text;
}