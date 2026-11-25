switch global.substate {
	case SUBSTATE.IN_MINIGAME:
		if (timer > 0) {
			timer -= delta_time / 1000000;
		} else failed_minigame = true;
		
		if (!answers_inputted) {
			player_text = keyboard_string;
			if (keyboard_check_pressed(vk_enter)) {
				if (string_length(player_text) > 0) {
					player_inputs[submitted_count] = player_text;
					submitted_count++;
					keyboard_string = "";
					player_text = "";
				}
			}
		}
		
		if (array_length(player_inputs) == missing_digits) answers_inputted = true;
		
		if (answers_inputted && !answers_compared) {
			for (var i = 0; i < missing_digits; i++) {
				if (omissions[i] != player_inputs[i]) {
					show_debug_message("FAILED");
					failed_minigame = true;
				}
			
			}
			answers_compared = true;
		}
		
		if (answers_compared && !failed_minigame) {
			show_debug_message("MINIGAME WON");
			parent_part.broken = false;
			global.substate = SUBSTATE.IN_COMPUTER;
			transition_start(rm_pc, sq_fadeout, sq_fadein);
		}
		
	break;
}