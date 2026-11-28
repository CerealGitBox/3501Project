var _op = "";
if (operator) {
	_op = " + "
} else _op = " - ";
switch global.substate {
case SUBSTATE.IN_MINIGAME:
	
	switch icp_state {
		case ICP_STATE.FETCH:
			for (var i = 0; i < array_length(hex_list); i++) {
				draw_text_scribble(hex_x_pos[i], hex_y_pos[i], "[fnt_pc][c_white]"+hex_list[i]);
			}
			draw_text_scribble(750, 784, "[fnt_pc][c_white]"+hex_list[hex_index]);
		break;
		case ICP_STATE.DECODE:
			draw_text_scribble(340, 502, "[fnt_pc][c_white]"+binary_p1+_op+binary_p2+" = "+player_text);
		break;
		case ICP_STATE.EXECUTE:
			draw_text_scribble(340, 502, "[fnt_pc][c_white]"+string(dec_p1)+_op+string(dec_p2)+" = "+player_text);
		break;
		case ICP_STATE.WRITE:
			draw_text_scribble(560, 384, "[fnt_pc][c_white]"+rand_hex+" = "+final_bin_string);
			draw_text_scribble(560, 560, "[fnt_pc][c_white]Is the ICP faulty?");
			draw_sprite(spr_mg_button_yes, 0, yes_button_x, button_y);
			draw_sprite(spr_mg_button_no, 0, no_button_x, button_y);
		break;
	}
	
break;
}