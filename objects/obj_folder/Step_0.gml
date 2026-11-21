switch global.game_state {
	case GAME_STATE.LEVEL:
		//dragging handler
		if (point_in_rectangle(mouse_x, mouse_y, x, y,
		x+sprite_get_width(closed_spr),
		y+sprite_get_height(closed_spr))) {
			if (mouse_check_button_pressed(mb_left)) {
				being_dragged = true;
				x = mouse_x;
				y = mouse_y;
			}
		}
		if (mouse_check_button_released(mb_left)) being_dragged = false;
		
	break;
}