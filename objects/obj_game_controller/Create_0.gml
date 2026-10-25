/*
This is the main game controller, it is in charge of keeping track of
and changing game states
The GAME_STATE enum and global variables are established below
*/

enum GAME_STATE {
	TITLE,			//on the title screen
	LEVEL_SELECT,	//selecting levels on the title screen
	INTRO,			//sequence played when starting a new game
	TUTORIAL,		//ditto above
	LEVEL_1,
	LEVEL_2,
	LEVEL_3,
	LEVEL_4,
	LEVEL_5,
	ENDING,			//sequence played when level 5 is completed
	FREEPLAY		//unlockable mode, no time limits or objectives
};

global.game_finished = false;
	//flag to check if player has completed the whole game
global.game_state = GAME_STATE.TITLE;
	//global game state variable

global.active_part = noone;
	//global variable to track which CPU part is currently being fixed
	//if a CPU is active it will be set to that instance's ID
	//otherwise it will be set to noone
	//when a CPU is active the player will be taken to the minigame room

var _fps = game_get_speed(gamespeed_fps);
level_timers = [
_fps * 60 * 4,		//4 minutes
_fps * 60 * 3,		//3 minutes
_fps * 60 * 2,		//2 minutes
_fps * 60 * 2,		//2 minutes
_fps * 60 * 3		//3 minutes
];
	//array containing the values which the death timer will be set each level
	//_fps is a variable in case cereal wants to change it for some reason
	//change the last number to change the number of minutes per level
death_timer = level_timers[0];
	//if the death timer reaches 0, the player fails the level and must restart
	//every time a minigame is failed, 15 seconds is subtracted from the timer


