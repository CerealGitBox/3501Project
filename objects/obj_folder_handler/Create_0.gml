var _fps = game_get_speed(gamespeed_fps);
spawn_intervals = [
_fps * 35,	//level 1
_fps * 30,	//level 2
_fps * 25,	//level 3
_fps * 20,	//level 4
_fps * 15	//level 5
];
	//array of cooldown times for making a new paper on each level
on_cooldown = true;
	//bool to check if cooldown is active, no new paper can spawn if true
spawn_timer = spawn_intervals[global.level_number];
	//when timer reaches 0, on_cooldown is set to false
spawn_chance = 500;
	//chance for a paper to spawn if cooldown is false
	
global.folder_open_id = noone;
	//id of the paper currently being viewed