x = parent_folder.open_spr_x + 700;
y = parent_folder.open_spr_y + 571;

if (point_in_rectangle(mouse_x, mouse_y, x, y,
sprite_get_width(spr_stamp)+x, sprite_get_height(spr_stamp)+y)) {
	hovering = true;
	if (mouse_check_button_pressed(mb_left)) {
		show_debug_message("Stamp parent: "+string(parent_folder));
		global.part_list = parent_folder.broken_list;
		global.substate = SUBSTATE.JOB_CHOSEN;
		show_debug_message("Global broken part array:");
		for (var i = 0; i < array_length(global.part_list); i++) {
			show_debug_message(string(global.part_list[i])+" ");
		}
		instance_destroy(global.folder_open_id);
		instance_destroy();
	}
} else hovering = false;