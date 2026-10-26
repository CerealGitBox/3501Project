if (point_in_rectangle(
mouse_x, mouse_y, x, y,
x+sprite_get_width(spr_play_button),
y+sprite_get_height(spr_play_button))) {
	draw_self();
}