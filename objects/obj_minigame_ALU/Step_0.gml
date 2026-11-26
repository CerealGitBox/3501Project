switch global.substate {
	case SUBSTATE.IN_MINIGAME:
	var _pc = instance_find(obj_pc, 0);
	
	if (!equations_generated) {
		for (var i = 0; i < question_count; i++) {
			var _n1 = irandom_range(digit_range*-1, digit_range);
			var _n2 = irandom_range(digit_range*-1, digit_range);
			
			var _operator = choose(0, 1);
			var _ans = 0;
			var _strop = "";
			if (_operator == 0) {
				_ans = _n1 - _n2;
				_strop = " - ";
			} else {
				_ans = _n1 + _n2;
				_strop = " + ";
			}
			var _full_eq = string(_n1) + string(_strop) + string(_n2);
			show_debug_message("Equation: "+_full_eq);
			
			equations[i]  = string(_full_eq);
			correct_answers[i] = string(_ans);
		}
		equations_generated = true;
	}
	
	if (!answers_inputted) {
		if (timer > 0) {
				timer -= delta_time / 1000000;
			} else failed_minigame = true;
		
			player_text = keyboard_string;
			if (keyboard_check_pressed(vk_enter)) {
				if (string_length(player_text) > 0) {
					input_answers[submitted_count] = player_text;
					if (input_answers[submitted_count] != correct_answers[submitted_count]) {
						wrong_count++;
						if (wrong_count >= 2) failed_minigame = true;
					}
					submitted_count++;
					keyboard_string = "";
					player_text = "";
				}
			}
		}
	
		if (array_length(input_answers) == question_count) answers_inputted = true;
	
		if (answers_inputted && !bools_calculated) {
			for (var i = 0; i < question_count; i++) {
				if (input_answers[i] == correct_answers[i]) {
					if (!faulty) {
						bool_outputs[i] = "TRUE";
					} else bool_outputs[i] = "FALSE";
				} else {
					var _rand = choose(0, 1);
					if (_rand == 0) {
						bool_outputs[i] = "FALSE";
					} else bool_outputs[i] = "TRUE";
				}
			}
			keyboard_string = "";
			player_text = "";
			bools_calculated = true;
		}
	
		if (answers_inputted && bools_calculated) {
			player_text = keyboard_string;
			if (keyboard_check_pressed(vk_enter)) {
				if (string_length(player_text) == 1) {
					if ((faulty && (player_text == "Y" || player_text == "y")) 
					|| (!faulty && (player_text == "N" || player_text == "n"))) {
						show_debug_message("MINIGAME WON");
						parent_part.broken = false;
						_pc.parts_fixed++;
						global.substate = SUBSTATE.IN_COMPUTER;
						transition_start(rm_pc, sq_fadeout, sq_fadein);
					} else {
						show_debug_message("FAILED");
						failed_minigame = true;
					}
				}
			}
		}
	
		if (failed_minigame) {
			parent_part.broken = false;
			parent_part.failed = true;
			_pc.parts_failed++;
			global.substate = SUBSTATE.IN_COMPUTER;
			transition_start(rm_pc, sq_fadeout, sq_fadein);
		}
	break;
}