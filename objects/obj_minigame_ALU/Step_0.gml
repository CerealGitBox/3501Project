switch global.substate {
	case SUBSTATE.IN_MINIGAME:
	//equation generation
	if (!equations_generated) {
		for (var i = 1; i <= question_count; i++) {
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
			
			equations[i-1]  = string(_full_eq);
			array_push(correct_answers, real(_ans));
		}
		equations_generated = true;
	}
	//player input
	player_text = keyboard_string;
	if (keyboard_check_pressed(vk_enter)) {
		if (array_length(input_answers) < question_count) {
			input_answers[array_length(input_answers)] = player_text;
			keyboard_string = "";
		}
		for(var agh = 0; agh < array_length(input_answers); agh++) {
			show_debug_message(input_answers[agh]);
		}
	}
	break;
}