function make_textbox(_arr, _start, _end, _sound) {
	var _box = instance_create_layer(0, 0, "Instances", obj_textbox);
	_box.text_arr = _arr;
	_box.text_i = _start;
	_box.text_end = _end;
	_box.txt_sound = _sound;
}
scribble_typists_add_event("play_sound", function(element, params, char_index){
	var snd_name = string_trim(params[0]);
	var snd_asset = asset_get_index(snd_name);
	audio_play_sound(snd_asset, 1, false);
});