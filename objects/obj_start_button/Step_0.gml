if (point_in_rectangle(
mouse_x, mouse_y, x, y,
x+sprite_get_width(spr_play_button),
y+sprite_get_height(spr_play_button))) {
	if (mouse_check_button_pressed(mb_left)) {
		global.game_state = GAME_STATE.INTRO;
		transition_start(rm_main, sq_fadeout, sq_fadein);
		instance_destroy();
	}
}