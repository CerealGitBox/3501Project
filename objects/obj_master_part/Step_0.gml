switch global.substate {
	case SUBSTATE.DEFAULT:
		instance_destroy();
	break;
	
	case SUBSTATE.IN_COMPUTER:
		spr_scale = obj_pc.cpu_scale;
		if (point_in_rectangle(mouse_x, mouse_y,
		(x-sprite_get_width(coll_sprite)/2)+x_off, y-sprite_get_height(coll_sprite)/2,
		(x+sprite_get_width(coll_sprite)/2)+x_off, y+sprite_get_height(coll_sprite)/2)) {
			show_debug_message("TOUCHING: "+str_name);
			if (mouse_check_button_pressed(mb_left)) {
				if (broken) {
					global.active_part = id;
					global.substate = SUBSTATE.IN_MINIGAME;
					obj_pc.cpu_scale = 0;
					transition_start(rm_minigame, sq_fadeout_white, sq_fadein);
				} else {
					show_debug_message("NOT BROKEN!!!!");
				}
			}
		}
	break;
}