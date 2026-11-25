switch global.substate {
	case SUBSTATE.IN_MINIGAME:
		var _op = "";
		if (operator == 0) {
			_op = " + ";
		} else _op = " - ";
		draw_text_scribble(520, 430,
		"[fnt_pc][c_white]"+bin_o_str1+_op+bin_o_str2+" = "+string(dec_ans));
	break;
}