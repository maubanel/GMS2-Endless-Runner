/// @description Variables for global game states

//	State Machine macro constants used to track various global game states
#macro BEFORE_GAME 0
#macro GAME_START 1
#macro GAME_PLAY 2
#macro PLAYER_DEAD 3
#macro GAME_OVER 4


//	Backround constants
#macro CLOUD_WIDTH 256 // Width of cloud tile
#macro GROUND_WIDTH 512 // Width of ground tile

//	holds current state
state = BEFORE_GAME;

//	adjusts the speed of simulation that gets faster with time
game_scalar = .1;

//	Speed in pixels per second of ground at its normalized game_scalar speed (1)
ground_speed = 300;

//	Speed in pixels per second of clouds as its normalized game_scalar speed (1)
cloud_speed  = 10;

 
//	Stores current player score
player_score = 0;

//	Stores string of player score with padded spaces
score_string = string_format(player_score, 5, 0);

//	Change padded spaces to 0's in front of player score number
score_string = string_replace_all(score_string, " ", "0");

// Scales score to how many points given per second of gameplay
score_scalar = 5;

//	LERP timer for adjusting cloud speed
cloud_timer = 0;

//	LERP timer for adjusting ground speed
ground_timer = 0;

//	Stores the first speed of LERP when changing cloud speeds
orig_cloud_speed = 0;

//	Stores the first speed of LERP when changing ground speeds
orig_ground_speed = 0;

// Time in seconds for cloud and ground LERP
speed_ramp = 5;

// Stores in milliseconds time since last frame (delta_time)
global.delta_time_seconds = 0;

//	How many seconds game counts down at begining of game
countdown_timer = 5;

//	Total width of ground backgrounds (more than the game room width)
total_ground_width = GROUND_WIDTH * 4;

//	Where ground is located for collision detection
global.ground_plane = room_height - 372 - sprite_get_height(spr_player);

//	Stores all-time high score
high_score = 0;

//	Lods high score and if doesn't exist loads 0
if (!file_exists("savedata.ini"))
{
	ini_open("savedata.ini");
	ini_write_real("score", "high_score", 0);
	ini_close();
}
else
{
	ini_open("savedata.ini");	
	high_score = ini_read_real("score", "high_score", 0)
	ini_close();
}


//	Stores string of high score with padded spaces
high_score_string = string_format(high_score, 5, 0);

//	Change padded spaces to 0's in front of high score number
high_score_string = string_replace_all(high_score_string, " ", "0");

//Store index of timeline
timeline_index = tml_game;

debug = true;
if (debug)
{
	//	Margin from top and right of screen for debug text
	debug_margin = 40;

	//	Stores player velocity as a string
	pv_debug = "";

	//	Stores width of pv string
	pv_debug_width  = 0;

	//	Stores terminal velocity as a string
	tv_debug = "";
	
	//	Stores width of terminal velocity string
	tv_debug_width = 0;
	
	//	Stores y value of player in world space string
	pg_debug_y_width = 0;
	
	//	Stores width of y value
	pg_debug_y = "";
	
}

//Stores current cloud speed
current_cloud_speed = 0;


//global.current_ground_speed = ground_speed * global.delta_time_seconds * game_scalar;

// Randomize random seed
randomize();

//	Create cloud layers for 4 random clouds
cloud_1_layer = layer_create(300);
cloud_2_layer = layer_create(301);
cloud_3_layer = layer_create(302);
cloud_4_layer = layer_create(303);

//	Randomly picks from clouds for first cloud
layer_sprite_create(cloud_1_layer, 0, 0, spr_cloud_1);
scr_change_cloud_random(cloud_1_layer);
					
layer_x(cloud_1_layer, irandom_range(0, room_width * .2));
layer_y(cloud_1_layer, irandom_range(0, 200)); 
layer_hspeed(cloud_1_layer, 0);

//	Randomly picks from clouds for second cloud
layer_sprite_create(cloud_2_layer, 0, 0, spr_cloud_1);
scr_change_cloud_random(cloud_2_layer);

layer_x(cloud_2_layer, floor(irandom_range(room_width * .3,room_width * .5)));
layer_y(cloud_2_layer, irandom_range(100, 300)); 
layer_hspeed(cloud_2_layer, 0);

//	Randomly picks from clouds for third cloud
layer_sprite_create(cloud_3_layer, 0, 0, spr_cloud_1);
scr_change_cloud_random(cloud_3_layer);
	
layer_x(cloud_3_layer, floor(irandom_range(room_width * .6,room_width * .7)));
layer_y(cloud_3_layer, irandom_range(50, 400)); 
layer_hspeed(cloud_3_layer, 0);

//	Randomly picks from clouds for fourth cloud
layer_sprite_create(cloud_4_layer, 0, 0, spr_cloud_1);
scr_change_cloud_random(cloud_4_layer);
layer_x(cloud_4_layer, floor(irandom_range(room_width * .8,room_width * 1)));
layer_y(cloud_4_layer, irandom_range(-100, 100)); 	
layer_hspeed(cloud_4_layer, 0);

//Stores current cloud speed
global.current_ground_speed = 0;


//Create 5 ground layers
ground_1_layer = layer_create(100);
ground_2_layer = layer_create(101);
ground_3_layer = layer_create(102);
ground_4_layer = layer_create(103);
ground_5_layer = layer_create(104);

//	Add 5 ground pieces
layer_sprite_create(ground_1_layer, 0, 0, spr_ground);
layer_sprite_create(ground_2_layer, 0, 0, spr_ground);
layer_sprite_create(ground_3_layer, 0, 0, spr_ground);
layer_sprite_create(ground_4_layer, 0, 0, spr_ground);
layer_sprite_create(ground_5_layer, 0, 0, spr_ground);


// Position at left hand most side of ground pieces speed of 0, uses GROUND WIDTH for y as it is square in shape
layer_y(ground_1_layer,room_height - GROUND_WIDTH); 
layer_hspeed(ground_1_layer, 0);

// Position at second left hand most side of ground pieces speed of 0
layer_x(ground_2_layer, GROUND_WIDTH);
layer_y(ground_2_layer,room_height - GROUND_WIDTH); 
layer_hspeed(ground_2_layer, 0);

// Position at center ground pieces speed of 0
layer_x(ground_3_layer, 2 * GROUND_WIDTH);
layer_y(ground_3_layer,room_height - GROUND_WIDTH); 
layer_hspeed(ground_3_layer,0);

// Position at second right hand most side of ground pieces speed of 0
layer_x(ground_4_layer, 3 * GROUND_WIDTH);
layer_y(ground_4_layer,room_height - GROUND_WIDTH); 
layer_hspeed(ground_4_layer, 0);

// Position at right hand most side of ground pieces speed of 0
layer_x(ground_5_layer, 4 * GROUND_WIDTH);
layer_y(ground_5_layer,room_height - GROUND_WIDTH); 
layer_hspeed(ground_5_layer, 0);

