pc_sprite = spr_placeholder;
spr_list = [
spr_pc1, spr_pc2, spr_pc3,
spr_pc4, spr_pc5, spr_pc6
];
var _rand = irandom_range(0, array_length(spr_list) - 1);
pc_sprite = spr_list[_rand];

broken_parts = global.part_list;
parent_folder = noone;

parts_spawned = false;

str_to_obj = ds_map_create();
ds_map_add(str_to_obj, "ALU", obj_part_ALU);
ds_map_add(str_to_obj, "Clock", obj_part_Clock);
ds_map_add(str_to_obj, "FlashMem", obj_part_FlashMem);
ds_map_add(str_to_obj, "ICP", obj_part_ICP);
ds_map_add(str_to_obj, "SRAM", obj_part_SRAM);

cpu_pos_x = 960;
cpu_pos_y = 540
part_x_pos = [955, 1297, 1014, 574, 1183];
part_y_pos = [753, 871, 418, 371, 497];

//CPU sprite vars
cpu_scale = 0;

//cam vars
cam = view_get_camera(0);
cam_start_w = camera_get_view_width(cam);
cam_start_h = camera_get_view_height(cam);

cam_target_w = cam_start_w;
cam_target_h = cam_start_h;

cam_target_x = 960;
cam_target_y = 540;

zooming = false;