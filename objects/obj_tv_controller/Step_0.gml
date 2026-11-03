if (global.game_state == GAME_STATE.LEVEL_1 ||
global.game_state == GAME_STATE.INTRO ||
global.game_state == GAME_STATE.LEVEL_2 ||
global.game_state == GAME_STATE.LEVEL_3 ||
global.game_state == GAME_STATE.LEVEL_4 ||
global.game_state == GAME_STATE.LEVEL_5) {
	if (point_in_rectangle(mouse_x, mouse_y, 1120, 0, 1920, 534)) {
		tv_y = lerp(tv_y, tv_targety, ease_v);
	} else tv_y = lerp(tv_y, -534, ease_v);
}

if (global.ticket_number > 0) {
	if (global.ticket_1_ref != noone) draw_sprite(spr_task_checkbox, 0, checkbox_x[0], checkbox_y);
	if (global.ticket_2_ref != noone) draw_sprite(spr_task_checkbox, 0, checkbox_x[1], checkbox_y);
	if (global.ticket_3_ref != noone) draw_sprite(spr_task_checkbox, 0, checkbox_x[2], checkbox_y);
}