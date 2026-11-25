switch global.substate {
	case SUBSTATE.IN_MINIGAME:
		if (timer > 0) {
			timer -= delta_time / 1000000;
		} else failed_minigame = true;
		
		if (!buttons_spawned) {
			var _yes = instance_create_layer(1200, 600, "Instances", obj_mg_SRAM_yes);
			_yes.parent_SRAM = id;
			_yes.hex = questions[question_number];
			var _no = instance_create_layer(1600, 600, "Instances", obj_mg_SRAM_no);
			_no.parent_SRAM = id;
			buttons_spawned = true;
		}
		
		if (question_number == array_length(questions)) {
			instance_destroy(obj_mg_SRAM_yes);
			instance_destroy(obj_mg_SRAM_no);
			for (var i = 0; i < array_length(questions); i++) {
				if (questions[i] != player_answers[i]) {
					show_debug_message("FAILED");
					failed_minigame = true;
				}
			}
			if (!failed_minigame) {
				show_debug_message("MINIGAME WON");
				parent_part.broken = false;
				global.substate = SUBSTATE.IN_COMPUTER;
				transition_start(rm_pc, sq_fadeout, sq_fadein);
			}
		}
	break;
}