//generate a cache of hex values
//give random hex values to the player
//player must determine if they are already in the cache

parent_part = noone;

hex_ranges = [8, 10, 12, 14, 15];
hex_range = hex_ranges[global.level_number];
hex_count = irandom_range(hex_ranges[0], hex_range);

hex_list = [];
for (var i = 0; i < hex_range; i++) {
	var _hex = make_hex();
	array_push(hex_list, _hex);
}

questions = [];
correct_answers = [];
player_answers = [];

for (var i = 0; i < 3; i++) {
	var _torf = choose(0, 1); //0 = not in cache, 1 = in cache
	if (_torf == 0) {
		var _hex = make_hex();
		while (array_contains(questions, _hex)) _hex = make_hex();
		//prevent duplicates (literally a 0.000006% chance but whatever)
		array_push(questions, _hex);
		array_push(correct_answers, "NULL");
	} else {
		var _hex = hex_list[irandom_range(0, array_length(hex_list)-1)];
		array_push(questions, _hex);
		array_push(correct_answers, _hex);
	}
}

for (var i = 0; i < array_length(hex_list); i++) {
	show_debug_message(hex_list[i]);
}
for (var i = 0; i < 3; i++) {
	show_debug_message("Question "+string(i+1)+": "+questions[i]);
	show_debug_message("Answer "+string(i+1)+": "+correct_answers[i]);
}
question_count = array_length(questions);

questions_answered = 0;
answers_submitted = false;

yes_button_x = 880;
no_button_x = 1380;
button_y = 400;

level_timers = [10, 10, 8, 8, 5];
	//timer per question
timer = level_timers[global.level_number];

cache_xpos = 416;
cache_ypos = [64, 64*2, 64*3, 64*4, 64*5, 64*6, 64*7, 64*8,
64*9, 64*10, 64*11, 64*12, 64*13, 64*14, 64*15,];

failed_minigame = false;