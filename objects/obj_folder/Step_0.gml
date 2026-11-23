switch global.game_state {
	case GAME_STATE.LEVEL:
		//dragging handler
		//global.dragging_id is mutually exclusive
		if (global.folder_open_id == noone && global.dragging_id == noone) {
			if (point_in_rectangle(mouse_x, mouse_y,
			x - sprite_get_width(closed_spr) / 2,
			y - sprite_get_height(closed_spr) / 2,
			x + sprite_get_width(closed_spr) / 2,
			y + sprite_get_height(closed_spr) / 2)) {
				hovering = true;
				if (mouse_check_button_pressed(mb_left)) {
					being_dragged = true;
					global.dragging_id = id;
				}
			} else hovering = false;
		}
		
		if (being_dragged && global.dragging_id == id) {
			show_debug_message("Dragging ID: "+string(global.dragging_id));
			x = mouse_x;
			y = mouse_y;
			
			if (point_in_rectangle(x, y, 660, 880,
			sprite_get_width(spr_folder_hover_boundary)+660,
			sprite_get_height(spr_folder_hover_boundary)+880)) {
				audio_play_sound(snd_folder_open, 1, false);
				global.folder_open_id = id;
				if (!stamp_spawned) {
					make_stamp(id);
					stamp_spawned = true;
				}
				being_dragged = false;
				global.dragging_id = noone;
			}
			
			if mouse_check_button_released(mb_left) {
				being_dragged = false;
				global.dragging_id = noone;
			}
			
		} else {
			if (y < 900) y = lerp(y, 900, lerp_factor);
		}
		
		if (global.folder_open_id == id) {
			open_spr_y = lerp(open_spr_y, 129, lerp_factor);
			if (keyboard_check_pressed(vk_space)) {
				x = 100;
				y = 300;
				audio_play_sound(snd_folder_close, 1, false);
				instance_destroy(obj_stamp);
				stamp_spawned = false;
				global.folder_open_id = noone;
			}
		} else {
			open_spr_y = lerp(open_spr_y, 1080, lerp_factor);
		}
		
	break;
}