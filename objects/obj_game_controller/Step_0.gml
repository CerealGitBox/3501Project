switch global.game_state {
	case GAME_STATE.TITLE:
		if (!instance_exists(obj_start_button)) {
			instance_create_layer(960, 688, "Instances", obj_start_button);
		}
	break;
}