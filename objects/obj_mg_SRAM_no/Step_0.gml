if (point_in_rectangle(mouse_x, mouse_y, x, y,
x+sprite_get_width(sprite_index), y+sprite_get_height(sprite_index))) {
	if (mouse_check_button_pressed(mb_left)) {
		array_push(parent_SRAM.player_answers, hex);
		parent_SRAM.question_number++;
	}
}