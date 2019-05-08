/// @description Insert description here
// You can write your code in this editor
draw_set_color(c_yellow);
draw_set_font(fnt_hud);
draw_text(360, 50, score_string);
draw_text(40, 50, "HI " + high_score_string);
draw_set_color(c_white);

switch (state)
{
	case BEFORE_GAME:
		draw_set_color(c_yellow);
		draw_set_halign(fa_center);
		draw_set_valign(fa_middle);
		draw_set_font(fnt_title);
		draw_set_alpha(clamp(scr_flash(0.1, 2, 1), .1, .8));
		draw_text( room_width * .5, room_height * .5, "Tap Screen \nto Play!"); 
		break;
		
	case GAME_START:
		draw_set_alpha(1);
		draw_set_color(c_yellow);
		draw_set_font(fnt_title);
		draw_set_halign(fa_center);
		draw_text(room_width * .5, 400,"Tap Screen to Jump!");
		draw_text(room_width * .5, room_height * .5, ceil(countdown_timer));
		draw_set_color(c_white);
		break;
		
	case GAME_PLAY: case PLAYER_DEAD:

		break;
		
	case GAME_OVER:
		draw_set_alpha(1);
		draw_set_font(fnt_title);
		draw_set_color(c_yellow);
		draw_set_halign(fa_center);
		draw_sprite(spr_restart, 0, room_width * .5, room_height * .3);
		draw_text(room_width * .5, room_height * .5,  "Game Over!");
		draw_set_color(c_white);
	break;
}

if (debug)
{
	draw_set_halign(fa_left);
	draw_set_color(c_black);
	draw_set_font(fnt_debug);
	draw_set_alpha(1);
	draw_text(pv_debug_width, debug_margin, pv_debug); 
	draw_text(tv_debug_width, debug_margin + 30, tv_debug);
	var state_string;
	switch(state)
	{
	case BEFORE_GAME:
		state_string = "Before Game";
		break;
		
	case GAME_START:
		state_string = "Game Start";
		break;
		
	case GAME_PLAY:
			state_string = "Game Play";
			break;
			
	case PLAYER_DEAD:
			state_string = "Player Dead";
			break;
			
	case GAME_OVER:
		state_string = "Game Over";
		break;
	}
	var state_width = room_width - string_width(state_string) - debug_margin;
	draw_text(state_width, debug_margin + 60, state_string);
	draw_text(pg_debug_y_width, debug_margin + 90, pg_debug_y);
	var speed_width = room_width - string_width("Game Speed: " + string(global.current_ground_speed))  - debug_margin;
	draw_text(speed_width, debug_margin + 120, "Game Speed: " + string(global.current_ground_speed));
}