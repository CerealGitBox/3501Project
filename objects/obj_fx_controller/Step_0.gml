intensity = lerp(intensity, 0, 0.09);
if (has_fx) {
	fx_set_parameter(fx, "g_ZoomBlurIntensity", intensity);
}

