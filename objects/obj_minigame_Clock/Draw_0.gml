switch global.substate {
	case SUBSTATE.IN_MINIGAME:

	if (test_mode) {
		draw_text_scribble(128, 40, "[fnt_pc][c_yellow][scale,0.5]TEST MODE - level "
		+ string(global.level_number + 1) + " (press 1-5 on the intro to change)");
	}

	//---------------- clock light ----------------
	var _lx = 330, _ly = 300, _lr = 110;
	draw_set_alpha(1);
	draw_set_color(c_dkgray);
	draw_circle(_lx, _ly, _lr, false);
	if (flash > 0) {
		draw_set_alpha(flash);
		draw_set_color(flash_col);
		draw_circle(_lx, _ly, _lr - 10, false);
		draw_set_alpha(1);
	}
	draw_set_color(c_white);
	draw_circle(_lx, _ly, _lr, true);

	var _label = "CPU CLOCK";
	if (phase == "reference") _label = "[c_lime]REFERENCE";
	draw_text_scribble(_lx - 120, _ly + _lr + 30, "[fnt_pc][c_white][scale,0.6]" + _label);
	if (tap_msg_timer > 0) {
		draw_text_scribble(_lx - 120, _ly + _lr + 90, "[fnt_pc][scale,0.6]" + tap_msg);
	}

	//---------------- instructions / prompts ----------------
	var _msg = "";
	switch (phase) {
		case "intro":
			_msg = "The clock is the CPU's heartbeat. Every tick moves each instruction one step down the pipeline.\n\nFirst watch a HEALTHY clock. Then watch the CPU's clock and tap SPACE with it.\n\nPress SPACE to start.";
		break;
		case "reference":
			_msg = "[c_lime]This is what a healthy clock looks like.[c_white] Steady and even. Tap SPACE along!";
		break;
		case "cpu":
			_msg = "Now the CPU's clock. Tap SPACE on every tick and watch the pipeline.";
		break;
		case "diagnose":
			_msg = "Is the Clock faulty? Press Y or N\n\nTime: " + string(ceil(timer));
		break;
		case "result":
			_msg = (result_won ? "[c_lime]Correct![c_white]\n" : "[c_red]Wrong![c_white]\n") + fault_text[fault];
		break;
	}
	draw_text_scribble_ext(128, 620, "[fnt_pc][c_white][scale,0.6]" + _msg, 900);

	//---------------- scope (clock signal) ----------------
	var _sx0 = 700, _sx1 = 1820, _sy0 = 120, _sy1 = 330;
	var _hi = _sy0 + 40, _lo = _sy1 - 40;
	draw_set_color(make_color_rgb(10, 25, 15));
	draw_rectangle(_sx0, _sy0, _sx1, _sy1, false);
	draw_set_color(c_white);
	draw_rectangle(_sx0, _sy0, _sx1, _sy1, true);
	draw_text_scribble(_sx0, _sy0 - 60, "[fnt_pc][c_white][scale,0.5]Clock signal");

	if (phase == "reference" || phase == "cpu" || phase == "diagnose" || phase == "result") {
		var _win = 6;	//seconds visible on the scope
		var _now = phase_time;
		if (phase == "diagnose" || phase == "result") _now = cpu_end;
		var _t0 = max(0, _now - _win);
		var _w = _sx1 - _sx0;

		//guide marks: where a healthy clock's ticks would land
		if (phase != "reference" && show_guides) {
			draw_set_color(make_color_rgb(70, 110, 80));
			for (var i = 0; i < array_length(expected_times); i++) {
				var _et = expected_times[i];
				if (_et >= _t0 && _et <= _now) {
					var _gx = _sx0 + (_et - _t0) / _win * _w;
					for (var _yy = _sy0 + 8; _yy < _sy1 - 8; _yy += 16) {
						draw_line_width(_gx, _yy, _gx, _yy + 8, 2);
					}
				}
			}
		}

		//square wave
		draw_set_color(c_lime);
		var _px = _sx0;
		for (var i = 0; i < array_length(scope_ticks); i++) {
			var _ts = scope_ticks[i];
			var _te = min(_ts + pulse_length, _now);
			if (_te < _t0) continue;
			var _xs = _sx0 + (max(_ts, _t0) - _t0) / _win * _w;
			var _xe = _sx0 + (_te - _t0) / _win * _w;
			if (_xs > _px) draw_line_width(_px, _lo, _xs, _lo, 4);	//low until this pulse
			draw_line_width(_xs, _lo, _xs, _hi, 4);					//rising edge
			draw_line_width(_xs, _hi, _xe, _hi, 4);					//high
			if (_ts + pulse_length <= _now) draw_line_width(_xe, _hi, _xe, _lo, 4);	//falling edge
			_px = _xe;
		}
		var _nx = _sx0 + (_now - _t0) / _win * _w;
		if (_nx > _px) draw_line_width(_px, _lo, _nx, _lo, 4);

		//player taps
		draw_set_color(c_yellow);
		for (var i = 0; i < array_length(taps); i++) {
			var _tt = taps[i];
			if (_tt >= _t0 && _tt <= _now) {
				var _tx = _sx0 + (_tt - _t0) / _win * _w;
				draw_triangle(_tx, _sy1 + 6, _tx - 10, _sy1 + 24, _tx + 10, _sy1 + 24, false);
			}
		}
	}

	//---------------- pipeline ----------------
	if (phase == "cpu" || phase == "diagnose" || phase == "result") {
		var _bx = 1080, _by = 420, _bs = 90, _gap = 110;
		for (var s = 0; s < 4; s++) {
			var _y = _by + s * _gap;
			draw_text_scribble(700, _y + 20, "[fnt_pc][c_white][scale,0.5]" + stage_names[s]);
			draw_set_color(c_white);
			draw_rectangle(_bx, _y, _bx + _bs, _y + _bs, true);
			var _ins = stages[s];
			if (_ins != -1) {
				draw_set_color(instr_colors[_ins mod 4]);
				draw_rectangle(_bx + 6, _y + 6, _bx + _bs - 6, _y + _bs - 6, false);
			}
		}

		//completed instructions (red X = corrupted because a stage got cut short)
		var _cy = _by + 4 * _gap + 30, _cs = 48, _cstep = 60;
		draw_text_scribble(700, _cy + 4, "[fnt_pc][c_white][scale,0.5]Completed");
		for (var i = 0; i < array_length(completed); i++) {
			var _cins = completed[i];
			var _cx = _bx + i * _cstep;
			if (_cx + _cs > 1900) break;
			draw_set_color(instr_colors[_cins mod 4]);
			draw_rectangle(_cx, _cy, _cx + _cs, _cy + _cs, false);
			if (instr_bad[_cins]) {
				draw_set_color(c_black);
				draw_rectangle(_cx, _cy, _cx + _cs, _cy + _cs, false);
				draw_set_color(c_red);
				draw_line_width(_cx + 6, _cy + 6, _cx + _cs - 6, _cy + _cs - 6, 6);
				draw_line_width(_cx + _cs - 6, _cy + 6, _cx + 6, _cy + _cs - 6, 6);
			}
		}
	}

	draw_set_color(c_white);
	draw_set_alpha(1);
	break;
}
