switch global.substate {
	case SUBSTATE.IN_COMPUTER:
		spr_scale = lerp(spr_scale, 1, 0.1);
		if (point_in_rectangle(mouse_x, mouse_y,
		x-sprite_get_width(part_sprite), y-sprite_get_height(part_sprite),
		x+sprite_get_width(part_sprite), y+sprite_get_height(part_sprite))) {
			if (mouse_check_button_pressed(mb_left)) {
				if (broken) {
					global.active_part = id;
					global.substate = SUBSTATE.IN_MINIGAME;
					room_goto(rm_minigame);
				} else {
					show_debug_message("NOT BROKEN!!!!");
				}
			}
		}
	break;
}