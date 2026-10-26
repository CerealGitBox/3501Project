switch global.game_state {
	case GAME_STATE.TITLE:
		if (!instance_exists(obj_start_button)) {
			instance_create_layer(660, 512, "Instances", obj_start_button);
		}
	break;
	
	case GAME_STATE.INTRO:
	if (!instance_exists(obj_textbox) && !global.mid_transition) {
		make_textbox(global.test_text, 0, 5, noone);
	}
	break;
}