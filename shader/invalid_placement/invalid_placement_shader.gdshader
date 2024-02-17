shader_type canvas_item;

uniform bool can_place = true;

void fragment() {
    if (!can_place) {
        COLOR = mix(COLOR, vec4(1.0, 0.0, 0.0, 1.0), 0.5);
    }
}
