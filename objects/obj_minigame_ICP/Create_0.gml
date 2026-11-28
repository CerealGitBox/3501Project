//simulation of the ICP loop
//go through each step of fetch-decode-execute-write
//fetch:
//	spawn list of hex values, force player to find correct one
//decode:
//	player must decode the hex instruction into binary
//execute:
//	player must find the correct answer to the expression
//write:
//	player must determine if the written answer is correct

parent_part = noone;

level_timers = [10, 10, 8, 8, 5];
var _fps = game_get_speed(gamespeed_fps);
timer = _fps * level_timers[global.level_number];

hex_list = [];
for (var i = 0; i < 8; i++) {
	var _hex = make_hex();
	array_push(hex_list, _hex);
}

hex_index = irandom_range(0, array_length(hex_list)-1);

hex_x_pos = [512, 960, 512, 960, 512, 960, 512, 960];
hex_y_pos = [160, 160, 288, 288, 416, 416, 544, 544];

hex_w = 384;
hex_h = 64;

hex_rect_x1 = hex_x_pos[0];
hex_rect_y1 = hex_y_pos[0];
hex_rect_x2 = hex_x_pos[7];
hex_rect_y2 = hex_y_pos[7];

equation_ranges = [10, 22, 31, 36, 49];
equation_range = equation_ranges[global.level_number];

dec_answers = [];
player_answers = [];
answers_submitted = 0;
dec_p1 = irandom_range(0, equation_range);
dec_p2 = irandom_range(0, equation_range);
while (dec_p1 == dec_p2) dec_p2 = irandom_range(equation_range*-1, equation_range);
array_push(dec_answers, dec_p1, dec_p2);
show_debug_message("Dec1: "+string(dec_p1)+", Dec2: "+string(dec_p2));

dec_ans = 0;
operator = choose(true, false);
if (operator) {
	dec_ans = dec_p1 + dec_p2;
} else dec_ans = dec_p1 - dec_p2;

binary_p1 = dec_to_bin(dec_p1, 8);
binary_p2 = dec_to_bin(dec_p2, 8);

faulty = choose(true, false);

enum ICP_STATE {
	FETCH,
	DECODE,
	EXECUTE,
	WRITE,
	OTHER
}
icp_state = ICP_STATE.FETCH;

player_text = "";
keyboard_string = "";

rand_hex = make_hex();

final_bin_string = ""
if (faulty) {
	var _rn = irandom_range(0, 49);
	final_bin_string = dec_to_bin(_rn, 8);
} else final_bin_string = (dec_to_bin(dec_ans, 8));

yes_button_x = 560;
no_button_x = 990;
button_y = 670;

failed_minigame = false;