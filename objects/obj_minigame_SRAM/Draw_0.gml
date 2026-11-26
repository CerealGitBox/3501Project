switch global.substate {
	case SUBSTATE.IN_MINIGAME:
		draw_sprite(spr_mg_SRAM_yes, 0, yes_button_x, button_y);
		draw_sprite(spr_mg_SRAM_no, 0, no_button_x, button_y);
		
		for (var i = 0; i < array_length(hex_list); i++) {
			draw_text_scribble(cache_xpos, cache_ypos[i],
			"[fnt_pc][c_white]"+hex_list[i]);
		}
		
		if (!answers_submitted) {
			draw_text_scribble_ext(940, 780,
			"[fnt_pc][c_white]Is this data already stored in SRAM?", 500);
			draw_text_scribble(980, 160,
			"[fnt_pc][c_white]"+questions[questions_answered]);
		}
	break;
}