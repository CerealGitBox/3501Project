depth = -200;
if (broken) {
	draw_sprite_ext(part_sprite, 0, x, y,
	spr_scale, spr_scale, 0, c_red, 1);
} else {
	draw_sprite_ext(part_sprite, 0, x, y,
	spr_scale, spr_scale, 0, c_white, 1);
}