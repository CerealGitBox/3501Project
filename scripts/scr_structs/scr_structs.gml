//this constructor makes CPU structs
//it takes 3 arguments:
//	_rand_override (bool): allows user to override the random
//		part generation and select their own parts to be broken
//	_layout (int): determines the physical layout of the CPU,
//		ranges from 0 to 6
//	_parts (int): the number of parts that will be randomly
//		chosen to be broken, if _rand_override is false
//	_parts (array): the array of parts that will be broken, if
//		_rand_override is true

function make_CPU(_rand_override, _layout, _parts) constructor {
	layout = _layout;
	part_list = [
	"CU",		//control unit
	"ALU",		//arithmetic logic unit
	"MMU",		//memory management unit
	"Regs",		//registers
	"Cache",	//caches
	"BIU",		//bus interface unit
	"MemCon",	//memory controller
	"Clock"		//clock (nss)
	];
	broken_parts = [];
	
	if (!_rand_override) {		//rand_override is false
		if (typeof(_parts) == typeof(1)) {
			var temp_parts = part_list;
			for (var i = 0; i < _parts; i++) {
				var rand = random_range(0, array_length(temp_parts)-1);
				array_push(broken_parts, temp_parts[rand]);
				array_delete(temp_parts, rand, 1);
			}
		} else show_debug_message("ERROR: _parts must be real if _rand_override is disabled!");
		
	} else {					//rand_override is true
		if (typeof(_parts) == typeof(["1"])) {
			broken_parts = _parts;
		} else show_debug_message("ERROR: _parts must be array if _rand_override is enabled!");
	}
	
	show_debug_message("CPU generated, broken parts listed below.");
	for (var i = 0; i < array_length(broken_parts); i++) {
		show_debug_message(broken_parts[i]);
	}
}

//DS map, converts strings into objects
global.part_str_to_obj = ds_map_create();
ds_map_add(global.part_str_to_obj,"CU", obj_part_CU);
ds_map_add(global.part_str_to_obj,"ALU", obj_part_ALU);
ds_map_add(global.part_str_to_obj,"MMU", obj_part_MMU);
ds_map_add(global.part_str_to_obj,"Regs", obj_part_Regs);
ds_map_add(global.part_str_to_obj,"Cache", obj_part_Cache);
ds_map_add(global.part_str_to_obj,"BIU", obj_part_BIU);
ds_map_add(global.part_str_to_obj,"MemCon", obj_part_MemCon);
ds_map_add(global.part_str_to_obj,"Clock", obj_part_Clock);