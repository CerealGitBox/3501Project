//generate a cache of hex values
//give random hex values to the player
//player must determine if they are already in the cache

parent_part = noone;

ranges = [6, 8, 10, 12, 15];
hex_range = ranges[global.level_number];
hex_count = irandom_range(ranges[0], ranges);

hex_list = [];
for (var i = 0; i < hex_count; i++) {
	var _hex_str = "0x";
	var _rstr1 = string(irandom_range(0, 999));
	var _rstr2 = string(irandom_range(0, 999));
	var _rstr3 = string(irandom_range(0, 999));
	_hex_str = _hex_str + _rstr1 + _rstr2 + _rstr3;
	array_push(hex_list, _hex_str);
}

questions = [];
for (var i = 0; i < 3; i++) {
	var _rand = choose(0, 1); //0 = not in mem, 1 = in mem
	if (_rand == 0) {
		array_push(questions, "NULL");
	} else {
		var _q = hex_list[irandom_range(0, array_length(hex_list))];
		if (array_length(questions) > 1) {
			for (var j = 0; j < array_length(questions); j++) {
				while (questions[j] == questions[j-1]) {
					questions[j] = hex_list[irandom_range(0, array_length(hex_list))];
				}
			}
		}
	}
}
question_number = 0;

player_answers = [];
buttons_spawned = false;

level_timers = [10, 10, 8, 8, 5];
	//timer per question
timer = level_timers[global.level_number];

minigame_failed = false;

//left here <-----
//make array of positions for cache elements then draw them
//test this minigame