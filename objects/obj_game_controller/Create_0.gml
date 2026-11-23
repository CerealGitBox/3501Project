/*
This is the main game controller, it is in charge of keeping track of
and changing game states
The GAME_STATE enum and global variables are established below
VERY IMPORTANT that this object is persistent
*/

enum GAME_STATE {
	TITLE,			//on the title screen
	LEVEL_SELECT,	//selecting levels on the title screen
	INTRO,			//sequence played when starting a new game
	TUTORIAL,		//ditto above
	LEVEL,
	ENDING,			//sequence played when level 5 is completed
	FREEPLAY		//unlockable mode, no time limits or objectives
};
global.level_number = 0;
	//track what level the player is on
	//0 = level 1, 1 = level 2, etc, max of 4

enum SUBSTATE {
	DEFAULT,		//player is not doing anything
	JOB_CHOSEN,		//player has selected a paper but not gone into the computer yet
	IN_COMPUTER,			//player is inside the CPU looking for parts to fix
	IN_MINIGAME		//player has correctly chosen a broken part and is in a minigame
};
global.game_state = GAME_STATE.TITLE;
	//global game state variable
global.substate = SUBSTATE.DEFAULT;
	//substate variable, tracks what the player is doing within levels

global.active_part = noone;
	//global variable to track which CPU part is currently being fixed
	//if a CPU is active it will be set to that instance's ID
	//otherwise it will be set to noone
	//when a CPU is active the player will be taken to the minigame room
global.part_list = [];
	//global array to track what parts currently need to be fixed

var _fps = game_get_speed(gamespeed_fps);
global.level_timers = [
_fps * 60 * 4,		//4 minutes
_fps * 60 * 3,		//3 minutes
_fps * 60 * 2,		//2 minutes
_fps * 60 * 2,		//2 minutes
_fps * 60 * 3		//3 minutes
];
	//array containing the values which the death timer will be set each level
	//_fps is a variable in case cereal wants to change it for some reason
	//change the last number to change the number of minutes per level

global.max_parts = [2, 3, 3, 4, 5];
	//array dictating how many parts can be broken on a single CPU for each level
	//ex. level 1 can only have up to 2 parts broken at a time

death_timer = global.level_timers[0];
	//if the death timer reaches 0, the player fails the level and must restart
	//every time a minigame is failed, 15 seconds is subtracted from the timer

//spawn flags
intro_box_spawned = false;
first_folder_spawned = false;
pc_spawned = false;
cpu_spawned = false;

global.game_finished = false;
	//flag to check if player has completed the whole game