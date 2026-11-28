switch global.game_state {
	case GAME_STATE.LEVEL:
		var _total_seconds = ceil(global.death_timer);
		var _mins = _total_seconds div 60;
		var _secs = _total_seconds mod 60;
		var _sec_string = (_secs < 10) ? "0" + string(_secs) : string(_secs);
		draw_text_scribble(timer_x, timer_y,
		"[fnt_timer][c_white]"+string(_mins) + ":" + string(_secs));
	break;
}
