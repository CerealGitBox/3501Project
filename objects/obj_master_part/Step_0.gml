if (point_in_rectangle(mouse_x, mouse_y,
x, y, x+sprite_get_width(sprite), y+sprite_get_height(sprite))) {
	if (name_alpha < 1) name_alpha += fade_factor;
	if (name_scale < 1) name_scale += fade_factor;
} else {
	if (name_alpha > 0) name_alpha -= fade_factor;
	if (name_scale > 0) name_scale -= fade_factor;
	
	if (mouse_check_button_pressed(mb_left)) {
		if (global.active_part == noone) global.active_part = id;
	}
}