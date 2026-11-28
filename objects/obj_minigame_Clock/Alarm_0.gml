if (!checking_bpm) {
	alarm_beat_count++;
	audio_play_sound(snd_beat, 1, false);
	switch(alarm_beat_count) {
		case 2:
			alarm_text = "3";
		break;
		case 4:
			alarm_text = "2";
		break;
		case 6:
			alarm_text = "1";
		break;
		case 8:
			alarm_text = "GO!";
		break;
	}
	show_debug_message(alarm_text);
	
	if (alarm_beat_count >= total_beats) {
		checking_bpm = true;
		elapsed_time = 0;
		next_beat = 1;
		alarm_text = "";
	} else {
		alarm[0] = ceil(alarm_timer * 60);
	}
}