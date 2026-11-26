//this object's main function is to reset important global vars

if (point_in_rectangle(mouse_x, mouse_y, x, y,
x+sprite_get_width(sprite_index), y+sprite_get_height(sprite_index))) {
	if (mouse_check_button_pressed(mb_left)) {
		layer_destroy_instances("CPU_parts");
		transition_start(rm_main, sq_fadeout_white, sq_fadein_white);
		
		global.substate = SUBSTATE.DEFAULT;
		global.folder_open_id = noone;
		global.dragging_id = noone;
		global.part_list = [];
		global.part_instances = [];
		
		var _pc = instance_find(obj_pc, 0);
		_pc.wraps = true;
		instance_destroy();
	}
}