//generate 3-7 random math questions
//have player answer questions, CPU will say if they were correct or wrong
//if CPU and player answers match, ALU is fine
//otherwise, CPU is faulty
//if player chooses wrong state of CPU, time penalty
parent_part = noone;

faulty = false;
	//bool determining if the ALU is faulty
	//if false, correct answers are returned as true
	//otherwise, correct answers are returned as false
var _faultr = choose(0, 1);
if (_faultr == 1) faulty = true;
question_count = irandom_range(3, 7);
	//set number of questions

digit_range = 10;	//default for level 1
switch global.level_number {
	case 1:		//level 2
		digit_range = 22;
	break;
	case 2:		//level 3
		digit_range = 31;
	break;
	case 3:		//level 4
		digit_range = 36
	break;
	case 4:		//level 5
		digit_range = 49;
	break;
}
	//make numbers larger based on level for difficulty scaling
equations_generated = false;
answers_inputted = false;

keyboard_string = "";
player_text = "";

equations = array_create(7);
correct_answers = array_create(7);
input_answers = [];

equation_pos_x = 700;
answer_pos_x = 1108;
text_y = [64, 208, 352, 496, 640, 784];

timer = 0; //LEFT HERE <--