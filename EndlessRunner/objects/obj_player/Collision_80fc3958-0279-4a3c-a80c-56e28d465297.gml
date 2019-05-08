/// @description Player dies

//Player only dies if in GAME_PLAY state
if (obj_game_controller.state == GAME_PLAY)
{
	//Delay before changing game to GAME_OVER state
	if (!obj_game_controller.alarm[0]) obj_game_controller.alarm[0] = 180;
	
	//Switch away from GAME_PLAY state
	obj_game_controller.state = PLAYER_DEAD;
	
	//Slow entire sim down for dramatic effect
	obj_game_controller.game_scalar = .15;
	
	//Give player an upward jump velocity
	player_velocity_y = -sqrt(2 * jump_force * 1.2 * player_gravity * global.delta_time_seconds * obj_game_controller.game_scalar);
	
	//Player is no longer on_ground and will infinitely add gravity sending player behind ground and off the bottom of the screen
	on_ground = false;
	
	//Save high score
	ini_open("savedata.ini");
	if (obj_game_controller.player_score > ini_read_real("score", "high_score", 0))
	{
		ini_write_real("score", "high_score", floor(obj_game_controller.player_score));	
	}
	
	ini_close();
	
	//show_debug_message("You died");
	
}


