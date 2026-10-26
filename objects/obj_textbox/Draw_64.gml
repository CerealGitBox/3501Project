depth = 0;
draw_sprite(box_sprite, box_subimg, box_x, box_y);

var element = scribble(text_arr[text_i]);
element.wrap(1068);
element.starting_format("fnt_main", c_white);
element.draw(txt_x, txt_y, typist);