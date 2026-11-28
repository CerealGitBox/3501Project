//rhythm game
//player must press space on beat to recalibrate clock
//missing 2 or more times fails

parent_part = noone;

bpm_list = [120, 140, 160, 180, 200];
//target_bpm = bpm_list[global.level_number];
target_bpm = bpm_list[0];
beat_interval = (time_bpm_to_seconds(target_bpm));

total_beats = 8;
perfect_beats = 0;
beats_hit = 0;
beats_missed = 0;
beats_completed = 0;

perfect_tolerance = 0.05;
tolerance = 0.15;
beat_registered = false;

elapsed_time = 0;
next_beat = 1;

preview_timer = 0;
preview_beat = 0;
preview_done = false;

alarm_beat_count = 0;
alarm_timer = 0;
alarm_text = "";

checking_bpm = false;
beat_played = false;

box_x = 900;
box_y = 180;
box_w = 1000;
box_h = 600;

tracer_x = box_x;
tracer_y = box_y+box_h - 50;
tracer_base_y = tracer_y;
tracer_speed = 250;
tracer_col = c_lime;

tracer_jump = 0;
tracer_jump_target = 0;

tracer_jump_height = 250;
tracer_jump_height_current = 0;
tracer_jump_timer = 0;
tracer_jump_duration = 0.15;
tracer_jump_speed = 12;

failed_minigame = false;