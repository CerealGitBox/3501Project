switch global.game_state {
	case GAME_STATE.LEVEL:
		//only draw text if the folder is currently open
		if (global.folder_open_id == id) {
			draw_sprite(spr_folder_open, 0, open_spr_x, open_spr_y);

			draw_text_scribble_ext(open_spr_x, open_spr_y,
			"[fnt_paper][c_black]"+inst.text, sprite_get_width(spr_folder_open));
		}
	break;
}