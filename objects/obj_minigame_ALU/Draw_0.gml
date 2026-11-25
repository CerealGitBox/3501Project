if (!answers_inputted) {
	draw_text_scribble(128, 432, "[fnt_pc][c_white]"+"Input:");
	draw_text_scribble(368, 432, "[fnt_pc][c_lime]"+string(player_text));
}

for (var i = 0; i < question_count; i++) {
	//equations
	draw_text_scribble(equation_pos_x, text_y[i], "[fnt_pc][c_white]"+string(equations[i])+" =");
	
	//player answers
	if (submitted_count > i) {
		draw_text_scribble(answer_pos_x, text_y[i], "[fnt_pc][c_white]"+string(input_answers[i]));
	}
	
	//CPU responses
	if (bools_calculated) {
		var _col = "";
		if (string(bool_outputs[i]) == "TRUE") {
			_col = "[c_lime]";
		} else _col = "[c_red]";
		draw_text_scribble(bool_pos_x, text_y[i], "[fnt_pc]"+_col+string(bool_outputs[i]));
		
		draw_text_scribble_ext(128, 432, "[fnt_pc][c_white]Is the ALU faulty? Y/N", 500);
		draw_text_scribble(368, 532, "[fnt_pc][c_lime]"+string(player_text));
	}
}