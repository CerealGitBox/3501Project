if (global.substate == SUBSTATE.DEFAULT ||
global.substate == SUBSTATE.JOB_CHOSEN) {
	draw_sprite(pc_sprite, 0, x, y);
}

if (global.substate == SUBSTATE.IN_COMPUTER) {
	draw_sprite_ext(spr_cpu_back, 0, cpu_pos_x, cpu_pos_y,
	cpu_scale, cpu_scale, 0, c_white, 1);
}