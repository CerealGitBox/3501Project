for (var i = 0; i < question_count - 1; i++) {
	draw_text_scribble(128, 432, "[fnt_pc][c_white]"+"Input:");
	draw_text_scribble(368, 432, "[fnt_pc][c_lime]"+string(player_text));
	
	draw_text_scribble(equation_pos_x, text_y[i], "[fnt_pc][c_white]"+string(equations[i])+" =");
	//DO NOT TOUCH
	if (array_length(input_answers) > i)
		draw_text_scribble(answer_pos_x, text_y[i], "[fnt_pc][c_lime]"+string(input_answers[i]));
}