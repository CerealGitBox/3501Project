switch global.substate {
case SUBSTATE.IN_MINIGAME:
	var _pc = instance_find(obj_pc, 0);
	if (icp_state != ICP_STATE.OTHER) timer -= delta_time / 1000000
		
	switch icp_state {
		case ICP_STATE.FETCH:
			if (point_in_rectangle(mouse_x, mouse_y,
			hex_rect_x1, hex_rect_y1, hex_rect_x2+hex_w, hex_rect_y2+hex_h)) {
				if (mouse_check_button_pressed(mb_left)) {
					if (point_in_rectangle(mouse_x, mouse_y,
					hex_x_pos[hex_index], hex_y_pos[hex_index],
					hex_x_pos[hex_index]+hex_w, hex_y_pos[hex_index]+hex_h)) {
						timer = game_get_speed(gamespeed_fps) * level_timers[global.level_number];
						icp_state = ICP_STATE.DECODE;
					} else {
						icp_state = ICP_STATE.OTHER;
						failed_minigame = true;
					}
				}
			}
		break;
		case ICP_STATE.DECODE:
			player_text = keyboard_string;
			if (keyboard_check_pressed(vk_enter) && string_length(player_text > 0)) {
				if (real(player_text) == dec_answers[answers_submitted]) {
					answers_submitted++;
					player_text = "";
					keyboard_string = "";
					if (answers_submitted >= array_length(dec_answers)) {
						timer = game_get_speed(gamespeed_fps) * level_timers[global.level_number];
						icp_state = ICP_STATE.EXECUTE;
					}
				} else {
					icp_state = ICP_STATE.OTHER;
					failed_minigame = true;
				}
			}
		break;
		case ICP_STATE.EXECUTE:
			player_text = keyboard_string;
			if (keyboard_check_pressed(vk_enter) && string_length(player_text > 0)) {
				if (player_text == string(dec_ans)) {
					player_text = "";
					keyboard_string = "";
					timer = game_get_speed(gamespeed_fps) * level_timers[global.level_number];
					icp_state = ICP_STATE.WRITE;
				} else {
					icp_state = ICP_STATE.OTHER;
					failed_minigame = true;
				}
			}
		break;
		case ICP_STATE.WRITE:
			if (point_in_rectangle(mouse_x, mouse_y, yes_button_x, button_y,
			yes_button_x+sprite_get_width(spr_mg_button_yes),
			button_y+sprite_get_height(spr_mg_button_yes))) {
				if (mouse_check_button_pressed(mb_left)) {
					if (faulty) {
						show_debug_message("WON")
						icp_state = ICP_STATE.OTHER;
					} else {
						icp_state = ICP_STATE.OTHER;
						failed_minigame = true;
					}
				}
			}
			if (point_in_rectangle(mouse_x, mouse_y, no_button_x, button_y,
			no_button_x+sprite_get_width(spr_mg_button_no),
			button_y+sprite_get_height(spr_mg_button_no))) {
				if (mouse_check_button_pressed(mb_left)) {
					if (!faulty) {
						show_debug_message("WON")
						icp_state = ICP_STATE.OTHER;
					} else {
						icp_state = ICP_STATE.OTHER;
						failed_minigame = true;
					}
				}
			}
		break;
		case ICP_STATE.OTHER:
			if (!failed_minigame) {
				parent_part.broken = false;
				_pc.parts_fixed++;
				global.substate = SUBSTATE.IN_COMPUTER;
				transition_start(rm_pc, sq_fadeout_white, sq_fadein_white);
			} else {
				show_debug_message("FAILED");
				parent_part.broken = false;
				parent_part.failed = true;
				_pc.parts_failed++;
				global.substate = SUBSTATE.IN_COMPUTER;
				transition_start(rm_pc, sq_fadeout, sq_fadein);
			}
		break;
	}
		
break;
}