var _space = keyboard_check_pressed(vk_space);

if (txt_sound != noone) typist.sound_per_char([txt_sound], 0.8, 1.2, " .,!?");

if (_space) {
	typist.skip();
	if (typist.get_state() == 1) {
		text_i++
		if (text_i > text_end) instance_destroy();
		typist.reset();
	}
}

//textbox animation
if (box_subimg > sprite_get_number(box_sprite)) {
	box_subimg = 0;
} else box_subimg += sprite_get_speed(box_sprite)/60