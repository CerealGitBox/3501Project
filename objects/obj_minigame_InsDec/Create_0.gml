//generate 4 bit binary numbers to be added or subtracted
//omit digits of the binary operation
//set operation equal to a decimal number
//player must choose what digit(s) were omitted

parent_part = noone;

ranges = [2, 2, 3, 3, 4];
missing_range = ranges[global.level_number];
missing_digits = irandom_range(1, missing_range);
	//sets number of digits player must input
	//there will always be at least 1 missing

bin_str1 = "";
bin_str2 = "";
for (var i = 0; i < 4; i++) {
	var _rand1 = choose(0, 1);
	bin_str1 += string(_rand1);
	var _rand2 = choose(0, 1);
	bin_str2 += string(_rand2);
}

operator = choose(0, 1); //0 = +, 1 = -
dec_ans = 0;
dec_rl1 = bin_to_dec(real(bin_str1));
dec_rl2 = bin_to_dec(real(bin_str2));

if (operator == 0) {
	dec_ans = dec_rl1 + dec_rl2;
} else dec_ans = dec_rl1 - dec_rl2;

show_debug_message(bin_str1 + ", " + bin_str2 + ", " + string(dec_ans));

//even digits: evenly distributed
//odd digits: 50/50 chance for one side to receive more omissions
bin_o_str1 = bin_str1;
bin_o_str2 = bin_str2;
omissions = [];
switch missing_digits {
	case 1:
		var _1o = choose(bin_str1, bin_str2); //1 omission
		var _temp_1o = _1o;
		
		var _rpos = irandom_range(1, string_length(_1o));
		
		array_push(omissions, string_char_at(_1o, _rpos));
		_1o = string_delete(_1o, _rpos, 1);
		_1o = string_insert("_", _1o, _rpos);
		
		if (_temp_1o == bin_str1) bin_o_str1 = _1o;
		if (_temp_1o == bin_str2) bin_o_str2 = _1o;
	break;
	case 2:
		var _1or2 = choose(1, 2);
		//1 = both strings have 1 omission
		//2 = one string has 2 omissions
		switch _1or2 {
			case 1:
				var _1o_1 = choose(bin_str1, bin_str2);
				var _1o_2 = "";
				if (_1o_1 == bin_str1) _1o_2 = bin_str2;
				if (_1o_1 == bin_str2) _1o_2 = bin_str1;
				var _temp_1o_1 = _1o_1;
				var _temp_1o_2 = _1o_2;
				
				var _rpos_1o_1 = irandom_range(1, string_length(_1o_1));
				var _rpos_1o_2 = irandom_range(1, string_length(_1o_2));
				
				array_push(omissions, string_char_at(_1o_1, _rpos_1o_1));
				_1o_1 = string_delete(_1o_1, _rpos_1o_1, 1);
				_1o_1 = string_insert("_", _1o_1, _rpos_1o_1);
				array_push(omissions, string_char_at(_1o_2, _rpos_1o_2));
				_1o_2 = string_delete(_1o_2, _rpos_1o_2, 1);
				_1o_2 = string_insert("_", _1o_2, _rpos_1o_2);
				
				if (_temp_1o_1 == bin_str1) {
					bin_o_str1 = _1o_1;
					bin_o_str2 = _1o_2;
				}
				if (_temp_1o_1 == bin_str2) {
					bin_o_str2 = _1o_1;
					bin_o_str1 = _1o_2;
				}
			break;
			case 2:
				var _1o = choose(bin_str1, bin_str2);
				var _temp_1o = _1o;
				
				var _rpos = irandom_range(1, string_length(_1o));
				
				array_push(omissions, string_char_at(_1o, _rpos));
				_1o = string_delete(_1o, _rpos, 1);
				_1o = string_insert("_", _1o, _rpos);
		
				if (_temp_1o == bin_str1) bin_o_str1 = _1o;
				if (_temp_1o == bin_str2) bin_o_str2 = _1o;
			break;
		}
	break;
	case 3:
		var _2o = choose(bin_str1, bin_str2);
		var _1o = "";
		if (_2o == bin_str1) _1o = bin_str2;
		if (_2o == bin_str2) _1o = bin_str2;
		var _temp_1o = _1o;
		var _temp_2o = _2o;
		
		var _rpos1_2o = irandom_range(1, string_length(_2o));
		var _rpos2_2o = irandom_range(1, string_length(_2o));
		while (_rpos1_2o == _rpos2_2o) _rpos2_2o = irandom_range(1, string_length(_2o));
		var _rpos_1o = irandom_range(1, string_length(_1o));
		
		array_push(omissions, string_char_at(_2o, _rpos1_2o));
		_2o = string_delete(_2o, _rpos1_2o, 1);
		_2o = string_insert("_", _2o, _rpos1_2o);
		array_push(omissions, string_char_at(_2o, _rpos2_2o));
		_2o = string_delete(_2o, _rpos2_2o, 1);
		_2o = string_insert("_", _2o, _rpos2_2o);
		array_push(omissions, string_char_at(_1o, _rpos_1o));
		_1o = string_delete(_1o, _rpos_1o, 1);
		_1o = string_insert("_", _1o, _rpos_1o);
		
		if (_temp_2o == bin_str1) {
			bin_o_str1 = _2o;
			bin_o_str2 = _1o;
		}
		if (_temp_2o == bin_str2) {
			bin_o_str2 = _2o;
			bin_o_str1 = _1o;
		}
	break;
	case 4:
		var _2o_1 = choose(bin_str1, bin_str2);
		var _2o_2 = "";
		if (_2o_1 == bin_str1) _2o_2 = bin_str2;
		if (_2o_1 == bin_str2) _2o_2 = bin_str1;
		var _temp_2o_1 = _2o_1;
		var _temp_2o_2 = _2o_2;
		
		var _rpos1_2o_1 = irandom_range(1, string_length(_2o_1));
		var _rpos2_2o_1 = irandom_range(1, string_length(_2o_1));
		while (_rpos1_2o_1 == _rpos2_2o_1) _rpos2_2o_1 = irandom_range(1, string_length(_2o_2));
		var _rpos1_2o_2 = irandom_range(1, string_length(_2o_2));
		var _rpos2_2o_2 = irandom_range(1, string_length(_2o_2));
		while (_rpos1_2o_2 == _rpos2_2o_2) _rpos2_2o_2 = irandom_range(1, string_length(_2o_2));
		
		array_push(omissions, string_char_at(_2o_1, _rpos1_2o_1));
		_2o_1 = string_delete(_2o_1, _rpos1_2o_1, 1);
		_2o_1 = string_insert("_", _2o_1, _rpos1_2o_1);
		array_push(omissions, string_char_at(_2o_1, _rpos2_2o_1));
		_2o_1 = string_delete(_2o_1, _rpos2_2o_1, 1);
		_2o_1 = string_insert("_", _2o_1, _rpos2_2o_1);
		array_push(omissions, string_char_at(_2o_2, _rpos1_2o_2));
		_2o_2 = string_delete(_2o_2, _rpos1_2o_2, 1);
		_2o_2 = string_insert("_", _2o_2, _rpos1_2o_2);
		array_push(omissions, string_char_at(_2o_2, _rpos2_2o_2));
		_2o_2 = string_delete(_2o_2, _rpos2_2o_2, 1);
		_2o_2 = string_insert("_", _2o_2, _rpos2_2o_2);
		
		if (_temp_2o_1 == bin_str1) {
			bin_o_str1 = _2o_1;
			bin_o_str2 = _2o_2;
		}
		if (_temp_2o_1 == bin_str2) {
			bin_o_str2 = _2o_1;
			bin_o_str1 = _2o_2;
		}
	break;
}

show_debug_message("Bin1: "+bin_str1+" ("+string(dec_rl1)+")");
show_debug_message("Bin2: "+bin_str2+ " ("+string(dec_rl2)+")");
show_debug_message("Omits: "+string(missing_digits));
show_debug_message("BinO1: "+bin_o_str1);
show_debug_message("BinO2: "+bin_o_str2);
show_debug_message("Answer: "+string(dec_ans));

level_timers = [40, 35, 30, 25, 20];
	//timer per sequence input
timer = level_timers[global.level_number];
if (missing_digits > 2) timer += 10;

keyboard_string = "";
player_text = "";
player_inputs = [];
answers_inputted = false;
submitted_count = 0;
answers_compared = false;

failed_minigame = false;