if (point_in_rectangle(
mouse_x, mouse_y, x, y,
x+sprite_get_width(spr_play_button),
y+sprite_get_height(spr_play_button))) {
	if (mouse_check_button_pressed(mb_left)) {
		global.game_state = GAME_STATE.INTRO;
		room_goto(rm_main);
		instance_destroy();
	}
}