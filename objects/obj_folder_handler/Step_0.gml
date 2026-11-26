switch global.substate {
	case SUBSTATE.DEFAULT:
		if (spawn_timer > 0) {
			spawn_timer--;
		} else {
			on_cooldown = false;
		}
		
		if (!on_cooldown) {
			var _rand = irandom_range(0, spawn_chance);
			if (_rand == spawn_chance && !global.mid_transition) {
				instance_create_layer(103, 798, "Instances", obj_folder);
				spawn_timer = spawn_intervals[global.level_number];
				on_cooldown = true;
			}
		}
		
	break;
}