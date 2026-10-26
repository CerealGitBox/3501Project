text_arr = []; //array containing text
text_i = 0; //index of text array
text_end = 999; //index to stop at

box_x = 360;
box_y = 615;

txt_x = 440;
txt_y = 680;

txt_sound = noone; //talk sound
box_sprite = spr_textbox;
box_subimg = 0;

typist = scribble_typist();
typist.in(0.5, 0);