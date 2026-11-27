switch global.substate {
	case SUBSTATE.IN_MINIGAME:
	var _pc = instance_find(obj_pc, 0);
	var _dt = delta_time / 1000000;
	phase_time += _dt;
	flash = max(0, flash - _dt * 4);
	tap_msg_timer = max(0, tap_msg_timer - _dt);

	switch (phase) {
		case "intro":
			if (test_mode) {
				//test mode: keys 1-5 pick the level
				for (var _k = 0; _k < 5; _k++) {
					if (keyboard_check_pressed(ord(string(_k + 1)))) {
						global.level_number = _k;
						room_restart();
					}
				}
			}
			if (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter)) {
				phase = "reference";
				phase_time = 0;
				tick_index = 0;
				scope_ticks = [];
				taps = [];
			}
		break;

		case "reference":
			//healthy reference ticks, no pipeline
			while (tick_index < array_length(ref_times) && phase_time >= ref_times[tick_index]) {
				array_push(scope_ticks, ref_times[tick_index]);
				flash = 1;
				flash_col = c_lime;
				if (tick_sound != -1) audio_play_sound(tick_sound, 1, false);
				tick_index++;
			}
			if (keyboard_check_pressed(vk_space)) array_push(taps, phase_time);
			if (phase_time >= ref_end) {
				phase = "cpu";
				phase_time = 0;
				tick_index = 0;
				scope_ticks = [];
				taps = [];
			}
		break;

		case "cpu":
			while (tick_index < array_length(tick_times) && phase_time >= tick_times[tick_index]) {
				var _now = tick_times[tick_index];

				//tick came too soon: every instruction in the pipeline is cut short
				if (last_tick_time >= 0 && _now - last_tick_time < safe_interval) {
					for (var s = 0; s < 4; s++) {
						if (stages[s] != -1) instr_bad[stages[s]] = true;
					}
				}

				//move everything one stage forward
				if (stages[3] != -1) array_push(completed, stages[3]);
				for (var s = 3; s > 0; s--) stages[s] = stages[s - 1];
				if (next_instr < instr_total) {
					stages[0] = next_instr;
					next_instr++;
				} else stages[0] = -1;

				last_tick_time = _now;
				array_push(scope_ticks, _now);
				flash = 1;
				flash_col = c_yellow;
				if (tick_sound != -1) audio_play_sound(tick_sound, 1, false);
				tick_index++;
			}

			//tap feedback: how close was the player to the nearest tick?
			if (keyboard_check_pressed(vk_space)) {
				array_push(taps, phase_time);
				var _best = 999;
				for (var i = 0; i < array_length(tick_times); i++) {
					var _d = phase_time - tick_times[i];
					if (abs(_d) < abs(_best)) _best = _d;
				}
				if (abs(_best) <= 0.08) tap_msg = "[c_lime]On beat!";
				else if (abs(_best) > 0.35) tap_msg = "[c_red]No tick there!";
				else if (_best < 0) tap_msg = "[c_yellow]Early";
				else tap_msg = "[c_yellow]Late";
				tap_msg_timer = 0.6;
			}

			if (phase_time >= cpu_end) {
				phase = "diagnose";
				phase_time = 0;
			}
		break;

		case "diagnose":
			if (timer > 0) {
				timer -= _dt;
			} else {
				show_debug_message("FAILED (time)");
				result_won = false;
				phase = "result";
				phase_time = 0;
			}
			var _yes = keyboard_check_pressed(ord("Y"));
			var _no = keyboard_check_pressed(ord("N"));
			if (_yes || _no) {
				result_won = (_yes && faulty) || (_no && !faulty);
				show_debug_message(result_won ? "MINIGAME WON" : "FAILED");
				phase = "result";
				phase_time = 0;
			}
		break;

		case "result":
			//show what was wrong with the clock, then leave
			if (!finished && (phase_time >= 3.5
			|| (phase_time >= 0.5 && keyboard_check_pressed(vk_space)))) {
				finished = true;
				if (test_mode) {
					room_restart();	//test mode: play again with a new random clock
				} else if (result_won) {
					parent_part.broken = false;
					_pc.parts_fixed++;
					global.substate = SUBSTATE.IN_COMPUTER;
					transition_start(rm_pc, sq_fadeout, sq_fadein);
				} else {
					failed_minigame = true;
				}
			}
		break;
	}

	if (failed_minigame) {
		failed_minigame = false;
		parent_part.broken = false;
		parent_part.failed = true;
		_pc.parts_failed++;
		global.substate = SUBSTATE.IN_COMPUTER;
		transition_start(rm_pc, sq_fadeout, sq_fadein);
	}
	break;
}
