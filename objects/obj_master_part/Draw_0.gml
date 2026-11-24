if (room == rm_pc) {
	depth = -200;
	if (broken) {
		draw_sprite_ext(part_sprite, 0, x, y,
		spr_scale, spr_scale, 0, c_red, 1);
	} else {
		draw_sprite_ext(part_sprite, 0, x, y,
		spr_scale, spr_scale, 0, c_white, 1);
	}
	if (point_in_rectangle(mouse_x, mouse_y,
	x-sprite_get_width(part_sprite)/2, y-sprite_get_height(part_sprite)/2,
	x+sprite_get_width(part_sprite)/2, y+sprite_get_height(part_sprite)/2)) {
		draw_sprite(border_sprite, 0, x, y);
	}
}