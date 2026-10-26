global.mid_transition = false;
global.sequence_room_target = noone;

//makes a sequence in a room, sequence is determined by _type
function transition_place_sequence(_type) {
	if (layer_exists("Transition")) layer_destroy("Transition");
	var _layer = layer_create(-9999, "Transition");
	layer_sequence_create(_layer, 0, 0, _type);
}

//called when transitioning rooms
function transition_start(_target, _out, _in) {
	if (!global.mid_transition) {
		global.mid_transition = true;
		global.sequence_room_target = _target;
		transition_place_sequence(_out);
		layer_set_target_room(_target);
		transition_place_sequence(_in);
		layer_reset_target_room();
		return true;
	} else return false;
}

//called at the end of an Out sequence
function transition_change_room() {
	room_goto(global.sequence_room_target);
}

//called at the end of an In sequence
function transition_finished() {
	layer_sequence_destroy(self.elementID);
	global.mid_transition = false;
}