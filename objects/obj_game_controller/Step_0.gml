switch global.game_state {
	case GAME_STATE.TITLE:
		if (!instance_exists(obj_start_button)) {
			instance_create_layer(660, 512, "Instances", obj_start_button);
		}
	break;
	
	case GAME_STATE.INTRO:
		if (!global.mid_transition) {
			if (!intro_box_spawned) {
				make_textbox(global.intro_text, 0, 1, snd_bonzi_txt);
				intro_box_spawned = true;
			}
			if (!instance_exists(obj_textbox) && intro_box_spawned)
				global.game_state = GAME_STATE.LEVEL; //!!this should be TUTORIAL by default
		}
	break;
	
	case GAME_STATE.LEVEL:
		if (global.death_timer > 0) {
			global.death_timer -= delta_time / 1000000;
		} else {
			show_debug_message("GAME OVER");
			transition_start(rm_title, sq_fadeout, sq_fadein);
		}
		
		switch global.substate {
		case SUBSTATE.DEFAULT:
			if (!first_folder_spawned) {
				instance_create_layer(103, 798, "Instances", obj_folder);
				first_folder_spawned = true;
			}
		break;
		
		case SUBSTATE.JOB_CHOSEN:
			if (!pc_spawned) {
				instance_create_layer(720, 330, "Instances", obj_pc);
				pc_spawned = true;
			}
			if (room == rm_pc) {
				global.substate = SUBSTATE.IN_COMPUTER;
			}
		break;
		
		case SUBSTATE.IN_MINIGAME:
			if (room == rm_minigame) {
				if (!minigame_spawned) {
					var _mg = instance_create_layer(0, 0, "Instances",
					global.active_part.minigame);
					_mg.parent_part = global.active_part;
					minigame_spawned = true;
				}
			}
		break;
		
		}
	break;
}