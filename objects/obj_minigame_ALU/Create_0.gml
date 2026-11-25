//generate 3-7 random math questions
//have player answer questions, CPU will say if they were correct or wrong
//if player answers correctly, CPU will always repsond true (if fine) or false (if faulty)
//if player answers incorrectly, CPU has 50/50 chance to respond true or false
//if player chooses wrong state of CPU, time penalty

parent_part = noone;
	//set to part id when spawned by an ALU

faulty = false;
	//bool determining if the ALU is faulty
	//if false, correct answers are returned as true
	//otherwise, correct answers are returned as false
var _faultr = choose(0, 1);
if (_faultr == 1) faulty = true;
if (faulty) {
	show_debug_message("FAULTY");
} else show_debug_message("NOT FAULTY");
question_count = irandom_range(3, 7);
	//set number of questions

ranges = [10, 22, 31, 36, 49];
digit_range = ranges[global.level_number];
	//make numbers larger based on level for difficulty scaling

equations_generated = false;
submitted_count = 0;
answers_inputted = false;
bools_calculated = false;

keyboard_string = "";
player_text = "";

equations = array_create(7);
correct_answers = array_create(7);
input_answers = [];
bool_outputs = array_create(7);

equation_pos_x = 700;
answer_pos_x = 1108;
bool_pos_x = 1400;
text_y = [64, 208, 352, 496, 640, 784, 928];

level_timers = [10, 10, 8, 8, 5];
var _fps = game_get_speed(gamespeed_fps); //fix w/ delta later
timer = _fps * level_timers[global.level_number];

failed_minigame = false;