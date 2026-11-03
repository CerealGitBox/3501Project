switch global.game_state {
	case GAME_STATE.TITLE:
		if (!instance_exists(obj_start_button)) {
			instance_create_layer(660, 512, "Instances", obj_start_button);
		}
	break;
	
	case GAME_STATE.INTRO:
	if (!global.mid_transition) {
		if (!intro_box_spawned) {
			make_textbox(global.intro_text, 0, 14, snd_bonzi_txt);
			instance_create_layer(0, 0, "Instances", obj_tv_controller);
			intro_box_spawned = true;
		}
		if (!instance_exists(obj_textbox) && intro_box_spawned) global.game_state = GAME_STATE.TUTORIAL;
	}
	break;
}