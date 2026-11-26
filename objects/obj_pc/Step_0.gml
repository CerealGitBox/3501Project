switch global.substate {
	case SUBSTATE.DEFAULT:
		if (!global.mid_transition && wraps && !alarms_set) {
			if (parts_fixed >= parts_failed) {
				alarm[0] = 40;
			} else alarm[1] = 40;
			alarms_set = true;
		}
	break;
	
	case SUBSTATE.JOB_CHOSEN:
		if (point_in_rectangle(mouse_x, mouse_y, x, y,
		sprite_get_width(pc_sprite)+x,
		sprite_get_height(pc_sprite)+y)) {
			if (mouse_check_button_pressed(mb_left)) {
				transition_start(rm_pc, sq_fadeout_white, sq_fadein_white);
				zooming = true;
				
				cam_target_w = 240;
				cam_target_h = 135;
				
				cam_target_x = x + sprite_get_width(pc_sprite) / 2;
				cam_target_y = y + sprite_get_height(pc_sprite) / 2;
			}
		}
		
		if (zooming) {
			var _w = camera_get_view_width(cam);
			var _h = camera_get_view_height(cam);
			
			_w = lerp(_w, cam_target_w, 0.1);
			_h = lerp(_h, cam_target_h, 0.1);
			camera_set_view_size(cam, _w, _h);
			
			var _x = cam_target_x - _w / 2;
			var _y = cam_target_y - _h / 2;
			camera_set_view_pos(cam, _x, _y);
		}
		
	break;
	
	case SUBSTATE.IN_COMPUTER:
		if (!parts_spawned) {
			for (var i = 0; i < array_length(global.all_parts); i++) {
				var _part = instance_create_layer(part_x_pos[i], part_y_pos[i],
				"CPU_parts", str_to_obj[? global.all_parts[i]]);
				if (array_contains(global.part_list, global.all_parts[i])) {
					_part.broken = true;
				}
				array_push(global.part_instances, _part);
			}
			parts_spawned = true;
		}
		if (!global.mid_transition) cpu_scale = lerp(cpu_scale, 1, 0.1);
	break;
}