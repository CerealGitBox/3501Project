switch global.substate {
	case SUBSTATE.IN_MINIGAME:
		var _pc = instance_find(obj_pc, 0);
		
		if (!answers_submitted) {
			if (timer > 0) {
				timer -= delta_time / 1000000;
			} else failed_minigame = true;
		}
		
		if (!answers_submitted) {
			//yes, current hex is in cache
			if (point_in_rectangle(mouse_x, mouse_y, yes_button_x, button_y,
			yes_button_x+sprite_get_width(spr_mg_button_yes),
			button_y+sprite_get_height(spr_mg_button_yes))) {
				if (mouse_check_button_pressed(mb_left)) {
					array_push(player_answers, questions[questions_answered]);
					questions_answered++;
				}
			}
			//no, current hex is not in cache
			if (point_in_rectangle(mouse_x, mouse_y, no_button_x, button_y,
			no_button_x+sprite_get_width(spr_mg_button_no),
			button_y+sprite_get_height(spr_mg_button_no))) {
				if (mouse_check_button_pressed(mb_left)) {
					array_push(player_answers, "NULL");
					questions_answered++;
				}
			}
		} else { //answers submitted
			for (var i = 0; i < questions_answered; i++) {
				if (correct_answers[i] != player_answers[i] && !failed_minigame) {
					show_debug_message("FAILED");
					failed_minigame = true;
				}
			}
			if (!failed_minigame) {
				show_debug_message("MINIGAME WON");
				parent_part.broken = false;
				_pc.parts_fixed++;
				global.substate = SUBSTATE.IN_COMPUTER;
				transition_start(rm_pc, sq_fadeout_white, sq_fadein_white);
			}
		}
		
		if (failed_minigame) {
			parent_part.broken = false;
			parent_part.failed = true;
			_pc.parts_failed++;
			global.substate = SUBSTATE.IN_COMPUTER;
			transition_start(rm_pc, sq_fadeout, sq_fadein);
		}
		
		if (questions_answered == array_length(questions)) answers_submitted = true;
		
	break;
}