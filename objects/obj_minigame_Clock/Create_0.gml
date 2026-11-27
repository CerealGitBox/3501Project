//CLOCK MINIGAME - "Keep the Beat"
//1. a REFERENCE clock ticks a few times at the correct speed
//2. the CPU's clock ticks; player taps SPACE along with it (for feel, not scored)
//3. every tick moves instructions one stage down the pipeline (Fetch > Decode > Execute > Write-back)
//   if a tick comes too soon, the stages can't finish in time and those instructions come out corrupted (red X)
//4. player decides: is the Clock faulty? Y/N (wrong answer or timeout = failed minigame)
//like the ALU minigame, the clock is faulty 50% of the time

parent_part = noone;
	//set to part id when spawned by a Clock

//TEST MODE: drop this object in an empty room to play it without the main game
//(no obj_game_controller running). It sets up the globals it needs, lets you
//pick the level with keys 1-5 on the intro screen, and restarts when finished
//instead of returning to the PC. Has no effect during the normal game.
test_mode = !instance_exists(obj_game_controller);
if (test_mode) {
	global.substate = SUBSTATE.IN_MINIGAME;
	if (!variable_global_exists("level_number")) global.level_number = 0;
	randomize();
}

enum CLOCK_FAULT {
	NONE,
	FAST,		//clock set too fast: stages never get time to finish, everything corrupts
	SLOW,		//clock set too slow: results are fine but everything crawls
	JITTER,		//ticks come at uneven times: some come too soon
	SKIP,		//a tick goes missing: the whole pipeline freezes for a beat
	DOUBLE		//an extra tick sneaks in: the stages get cut short
};

faulty = (choose(0, 1) == 1);
fault = CLOCK_FAULT.NONE;
if (faulty) fault = choose(CLOCK_FAULT.FAST, CLOCK_FAULT.SLOW, CLOCK_FAULT.JITTER,
	CLOCK_FAULT.SKIP, CLOCK_FAULT.DOUBLE);
show_debug_message(faulty ? "CLOCK FAULTY, fault #" + string(fault) : "CLOCK NOT FAULTY");

//---------------- difficulty scaling by level (faults get subtler) ----------------
var _lv = global.level_number;
var _fast_mults   = [1.5, 1.45, 1.4, 1.35, 1.3];	//how much faster a FAST clock ticks
var _slow_mults   = [1.7, 1.6, 1.5, 1.45, 1.4];	//how much longer a SLOW clock waits
var _jitter_amts  = [0.45, 0.4, 0.35, 0.3, 0.25];	//how uneven a JITTER clock is
var _glitch_count = [2, 2, 2, 1, 1];				//how many skipped/extra ticks
show_guides = (_lv <= 2);
	//levels 1-3 show faint marks where ticks SHOULD land

base_interval = 0.7;					//seconds between ticks on a healthy clock
safe_interval = base_interval * 0.8;	//a tick sooner than this doesn't give the stages time to finish
pulse_length = 0.12;					//how long each tick stays "high" on the scope

//---------------- reference clock (always correct) ----------------
ref_lead = 0.8;
ref_times = [];
for (var i = 0; i < 4; i++) array_push(ref_times, ref_lead + i * base_interval);
ref_end = ref_times[3] + base_interval + 0.4;

//---------------- CPU clock schedule ----------------
cpu_tick_count = 12;
cpu_lead = 0.8;
tick_times = [];
expected_times = [];
	//where a healthy clock's ticks would land (used for guide marks)

var _slots = [];
if (fault == CLOCK_FAULT.SKIP || fault == CLOCK_FAULT.DOUBLE) {
	while (array_length(_slots) < _glitch_count[_lv]) {
		var _s = irandom_range(3, cpu_tick_count - 2);
		if (!array_contains(_slots, _s) && !array_contains(_slots, _s - 1)
		&& !array_contains(_slots, _s + 1)) array_push(_slots, _s);
	}
}

var _t = cpu_lead;
for (var i = 0; i < cpu_tick_count; i++) {
	array_push(expected_times, cpu_lead + i * base_interval);
	if (i > 0) {
		var _iv = base_interval;
		switch (fault) {
			case CLOCK_FAULT.FAST:   _iv = base_interval / _fast_mults[_lv]; break;
			case CLOCK_FAULT.SLOW:   _iv = base_interval * _slow_mults[_lv]; break;
			case CLOCK_FAULT.JITTER:
				var _j = _jitter_amts[_lv];
				_iv = base_interval * (1 + choose(-1, 1) * random_range(_j * 0.5, _j));
			break;
		}
		_t += _iv;
	}
	if (fault == CLOCK_FAULT.SKIP && array_contains(_slots, i)) continue;
		//this tick never happens
	array_push(tick_times, _t);
	if (fault == CLOCK_FAULT.DOUBLE && array_contains(_slots, i)) {
		array_push(tick_times, _t + base_interval * 0.25);
			//an extra tick squeezed in right after
	}
}
cpu_end = max(_t, expected_times[cpu_tick_count - 1]) + base_interval + 0.6;

//---------------- pipeline ----------------
stage_names = ["Fetch", "Decode", "Execute", "Write-back"];
stages = [-1, -1, -1, -1];
	//instruction index in each stage, -1 = empty
instr_total = array_length(tick_times) + 4;
instr_colors = [c_red, make_color_rgb(40, 80, 200), make_color_rgb(130, 80, 160), c_lime];
	//same colors as the pipeline diagram
instr_bad = array_create(instr_total, false);
next_instr = 0;
completed = [];
last_tick_time = -1;

//---------------- state ----------------
phase = "intro";		//intro > reference > cpu > diagnose > result
phase_time = 0;			//seconds since the phase started
tick_index = 0;			//next tick in the current schedule
flash = 0;				//1 right after a tick, fades to 0
flash_col = c_white;
scope_ticks = [];		//tick times shown on the scope for this phase
taps = [];				//times the player pressed SPACE
tap_msg = "";
tap_msg_timer = 0;

level_timers = [10, 10, 8, 8, 5];
	//seconds to make the diagnosis
timer = level_timers[_lv];

result_won = false;
result_timer = 0;
finished = false;
failed_minigame = false;

//plain-language explanations shown after answering
fault_text = [
	"The clock was ticking steadily. Nothing wrong here!",
	"The clock was set too FAST. The stages never had time to finish, so results came out garbage.",
	"The clock was set too SLOW. Every result was right, but the whole CPU crawled.",
	"The clock was UNEVEN (jitter). Some ticks came too soon and cut stages short.",
	"The clock SKIPPED ticks. The whole pipeline froze until the next tick came.",
	"The clock sent EXTRA ticks. The stages got cut short and corrupted instructions."
];

//optional: add a sound asset named snd_clock_tick and it will play on every tick
tick_sound = asset_get_index("snd_clock_tick");
