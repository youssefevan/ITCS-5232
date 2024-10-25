shader_type canvas_item;

uniform vec4 inputColor;
uniform bool transparentBG;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 textureColor = texture(TEXTURE, UV);

	if (textureColor == vec4(1.0, 1.0, 1.0, 1.0)) {
		COLOR = inputColor;
	}

	if (transparentBG == true) {
		if (textureColor == vec4(0.0, 0.0, 0.0, 1.0)) {
			COLOR = vec4(0.0, 0.0, 0.0, 0.0);
		}
	}

}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
