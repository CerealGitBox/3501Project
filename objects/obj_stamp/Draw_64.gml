depth = -500;
if (!hovering) {
	draw_self();
} else {
	draw_sprite_ext(spr_stamp, 0, x, y, 1, 1, 0, c_black, 1);
}