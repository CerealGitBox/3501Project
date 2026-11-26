/*
This is the master CPU part object
All events of this object are inherited by other CPU parts
Any changes made here will affect ALL other parts
That means DO NOT change it unless you know what you're doing
*/

str_name = "";

broken = false;
failed = false;
part_sprite = noone;
coll_sprite = noone;
x_off = 0;
border_sprite = noone;
spr_scale = 0;

minigame = noone;