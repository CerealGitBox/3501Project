global.all_parts = [
"ALU",			//arithmetic logic unit
"Clock",		//CPU clock
"FlashMem",		//flash memory
"ICP",			//instruction control pipeline
"SRAM"			//data SRAM
];

//this constructor makes folder structs
//it takes 1 argument:
	//_text (string): the text displayed on the folder, cast as noone for random selections
function make_folder(_text) constructor {
	text = "";
	broken_list = [];
	
	if (_text != noone && typeof(_text) == typeof("gabagool")) {
		text = _text;
		
	} else {
		//temp array of parts
		var _part_list = [
		"ALU",			//arithmetic logic unit
		"Clock",		//CPU clock
		"FlashMem",		//flash memory
		"ICP",			//instruction control pipeline
		"SRAM"			//data SRAM
		];
		
		//string bools
		var _has_ALU = false;
		var _has_Clock = false;
		var _has_FlashMem = false;
		var _has_ICP = false;
		var _has_SRAM = false;
		
		//chance to add a broken part scales with levels
		var _level = global.level_number;
		var _add_chance = (_level * 0.1) + 0.1;
		
		//guarantee every CPU has at least 1 broken part
		var _rfirst = irandom_range(0, array_length(_part_list) - 1);
		array_push(broken_list, _part_list[_rfirst]);
		array_delete(_part_list, _rfirst, 1);
		
		//add more broken parts by chance
		for (var i = 0; i < global.max_parts[_level] - 1; i++) {
			var _roll = random_range(0, 1);
			if (_roll <= _add_chance) {
				var _rpart = irandom_range(0, array_length(_part_list) - 1);
				array_push(broken_list, _part_list[_rpart]);
				array_delete(_part_list, _rpart, 1);
			}
		}
		
		//correct bools
		for (var i = 0; i < array_length(broken_list); i++) {
			show_debug_message(string(broken_list[i]));
			switch broken_list[i] {
				case "ALU":
					_has_ALU = true;
				break;
				case "Clock":
					_has_Clock = true;
				break;
				case "FlashMem":
					_has_FlashMem = true;
				break;
				case "ICP":
					_has_ICP = true;
				break;
				case "SRAM":
					_has_SRAM = true;
				break;
			}
		}
		
		//concat strings based on bools
		if (_has_ALU) {
			var _rstring = irandom_range(0, array_length(global.ALU_text) - 1);
			text += global.ALU_text[_rstring];
		}
		if (_has_Clock) {
			var _rstring = irandom_range(0, array_length(global.Clock_text) - 1);
			text += global.Clock_text[_rstring];
		}
		if (_has_FlashMem) {
			var _rstring = irandom_range(0, array_length(global.FlashMem_text) - 1);
			text += global.FlashMem_text[_rstring];
		}
		if (_has_ICP) {
			var _rstring = irandom_range(0, array_length(global.ICP_text) - 1);
			text += global.ICP_text[_rstring];
		}
		if (_has_SRAM) {
			var _rstring = irandom_range(0, array_length(global.SRAM_text) - 1);
			text += global.SRAM_text[_rstring];
		}
		
		show_debug_message("Final paper text: " + text);
	}
}
global.folder_open_id = noone;
	//id of the folder currently being viewed
global.dragging_id = noone;
	//id of the folder currently being dragged