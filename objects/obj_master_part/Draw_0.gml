switch global.substate {
	case SUBSTATE.IN_COMPUTER:
	depth = -200;
	if (broken) {
		draw_sprite_ext(part_sprite, 0, x, y,
		spr_scale, spr_scale, 0, c_red, 1);
	} else if (failed) {
		draw_sprite_ext(part_sprite, 0, x, y,
		spr_scale, spr_scale, 0, c_dkgray, 1);
	} else {
		draw_sprite_ext(part_sprite, 0, x, y,
		spr_scale, spr_scale, 0, c_white, 1);
	}
	if (point_in_rectangle(mouse_x, mouse_y,
	(x-sprite_get_width(coll_sprite)/2)+x_off, y-sprite_get_height(coll_sprite)/2,
	(x+sprite_get_width(coll_sprite)/2)+x_off, y+sprite_get_height(coll_sprite)/2)
	&& spr_scale == 1) {
		draw_sprite(border_sprite, 0, x, y);
	}
	break;
}