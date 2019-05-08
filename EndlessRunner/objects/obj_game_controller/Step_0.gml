/// @description Global game functionality

//Get time in milliseconds since last frame
global.delta_time_seconds = delta_time * .000001;


//Animate clouds
scr_update_clouds();

//Animate ground
scr_update_ground();

//If debug is on then get latest info for display
if (debug)
{
	if (instance_exists(obj_player))
	{
		pg_debug_y = "Y: " + string(obj_player.y);
		pg_debug_y_width = room_width - (string_width(pg_debug_y) + debug_margin);
		pv_debug = 	"Player Velocity: " + string(obj_player.player_velocity_y);
		pv_debug_width = room_width - (string_width(pv_debug) + debug_margin);
		tv_debug = "Terminal Vel: " + string(obj_player.terminal_velocity * global.delta_time_seconds);
		tv_debug_width = room_width - (string_width(tv_debug) + debug_margin);
	}
	
}

//LERP to new speed of clouds if game_scalar has changed
if (current_cloud_speed != -game_scalar * cloud_speed / room_speed)
{
	if (orig_cloud_speed == 0) orig_cloud_speed = layer_get_hspeed(cloud_1_layer);
	cloud_timer += global.delta_time_seconds/speed_ramp;
	cloud_timer = clamp(cloud_timer, 0, 1);
	current_cloud_speed = lerp(orig_cloud_speed,  -game_scalar * cloud_speed / room_speed, cloud_timer);
	layer_hspeed (cloud_1_layer, current_cloud_speed);
	layer_hspeed (cloud_2_layer, current_cloud_speed);
	layer_hspeed (cloud_3_layer, current_cloud_speed);
	layer_hspeed (cloud_4_layer, current_cloud_speed);
} else 
{
	cloud_timer = 0;
	orig_cloud_speed = 0;
}

//	LERTP to new speed of ground if game_scalar has changes
if (global.current_ground_speed != -game_scalar * ground_speed / room_speed)
{
	if (orig_ground_speed == 0) orig_ground_speed = layer_get_hspeed(ground_1_layer);
	ground_timer += global.delta_time_seconds/speed_ramp;
	ground_timer = clamp(ground_timer, 0, 1);
	global.current_ground_speed = lerp(orig_ground_speed,  -game_scalar * ground_speed / room_speed, ground_timer);
	show_debug_message("ground_timer: " + string(ground_timer) + " speed: " + string(global.current_ground_speed)
	+ " from: " + string(orig_ground_speed) + " to: " + string(-game_scalar * ground_speed / room_speed) );
	layer_hspeed (ground_1_layer, global.current_ground_speed);
	layer_hspeed (ground_2_layer, global.current_ground_speed);
	layer_hspeed (ground_3_layer, global.current_ground_speed);
	layer_hspeed (ground_4_layer, global.current_ground_speed);
	layer_hspeed (ground_5_layer, global.current_ground_speed);
} else 
{
	ground_timer = 0;
	orig_ground_speed = 0;
}

//State machine
switch(state)
{
	//	Checks to see if start game is pressed
	case BEFORE_GAME: 

	if (mouse_check_button_pressed(mb_left)) //If game is started
	{
		// Change state
		state = GAME_START;	
		
		// Change game scalar to 1
		game_scalar = 1;	
		
		//	Reset flashing of game text
		scr_flash_reset();
		
		// Creates player T 2 second mark after starting game
		alarm[1] = 120;
	}
	break;
	
	case GAME_START:

	//Counts down to 0
	countdown_timer -= global.delta_time_seconds;
	
	//Once countdown is finished
	if (countdown_timer <= 0)
	{
		//	Immediate switch to game state
		state = GAME_PLAY;	
		
		// Reset countdown timer
		count_down_timer = 5;
		
		//	Start timeline to launch obstacles
		timeline_running = true;
	}
	break;
	
	case GAME_PLAY:
		
		// Update score every frame
		player_score += global.delta_time_seconds * score_scalar;

		// Change to string with padded spaces
		score_string = string_format(player_score, 5, 0);

		//	Change padded spaces to 0's in front of number
		score_string = string_replace_all(score_string, " ", "0");
		break;
		
		case GAME_OVER:
		
		//	Not sure we want this?
		if (mouse_check_button_pressed(mb_left) && point_distance(mouse_x, mouse_y, room_width * .5, room_height * .3) <= 192)
		{
			game_restart();
		}
		break;
		
	
}

	






