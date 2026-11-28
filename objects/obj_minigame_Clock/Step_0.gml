var _dt = delta_time / 1000000;

if (!failed_minigame && !preview_done || checking_bpm) {
	tracer_x += tracer_speed * _dt;
	if (tracer_x > box_x + box_w) {
		tracer_x = box_w;
	}
}

//preview
if (!preview_done) {
	preview_timer += _dt;
	if (preview_timer >= beat_interval) {
		preview_timer -= beat_interval;
		preview_beat++;
		audio_play_sound(snd_beat, 1, false);
		
		tracer_jump_height_current = tracer_jump_height;
		tracer_jump_timer = tracer_jump_duration;
		
		if (preview_beat >= total_beats) {
			alarm_beat_count = 0;
			alarm_timer = beat_interval;
			alarm[0] = ceil(beat_interval * 60);
			preview_done = true;
		}
	}
}

if (checking_bpm && !failed_minigame) {
	elapsed_time += _dt;
	var _target_time = next_beat * beat_interval;
	if (keyboard_check_pressed(vk_space)) {
		audio_play_sound(snd_beat, 1, false);
		var _error = abs(elapsed_time - _target_time);
		
		if (_error <= tolerance) {
			beats_hit++;
			beats_completed++;
			if (_error <= perfect_tolerance) {
				show_debug_message("PERFECT");
				tracer_jump_height_current = tracer_jump_height;
				perfect_beats++;
			} else {
				show_debug_message("GOOD");
				tracer_jump_height_current = tracer_jump_height * 0.5;
			}
			tracer_jump_timer = tracer_jump_duration;
			next_beat++;
		}
	}
	_target_time = next_beat * beat_interval;
	if (elapsed_time > _target_time + tolerance) {
		show_debug_message("MISSED");
		beats_missed++;
		beats_completed++;
		next_beat++;
		tracer_jump_height_current = 0;
		if (beats_missed >= 2) {

			failed_minigame = true;
			checking_bpm = false;
		}
	}
	if (beats_completed >= total_beats && !failed_minigame) {
		checking_bpm = false;
		if (beats_missed < 2) {
			show_debug_message("WON");
		} else {
			failed_minigame = true;
		}
	}
}

if (tracer_jump_timer > 0) {
	tracer_jump_timer -= _dt;
} else {
	tracer_jump_height_current = 0;
}
var _target_y = tracer_base_y - tracer_jump_height_current;
tracer_y = lerp(tracer_y, _target_y, min(1, tracer_jump_speed * _dt));

if (failed_minigame) {
	show_debug_message("FAILED");
}