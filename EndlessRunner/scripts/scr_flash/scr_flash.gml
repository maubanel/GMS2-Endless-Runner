/// @function scr_flash(alpha_start, alpha_fin, dur)
/// @description flashes an object's alpha up and down
/// @arg {real} alpha_start The starting alpha a number between  0 and 1
/// @arg {real} alpha_end The ending alpha a number between 0 and 1 
/// @arg {real} dur The length of time to fade in and out once in seconds

//////////////////////////////////////////////////////////////////////////
//																		//
//			Makes game object's alpha flash on and off in seconds.		//
//			Used often in games to indicate that an object is injured	//
//																		//
//																		//
//			Requires global.delta_time_seconds = delta_time * .000001;	//
//																		//
//////////////////////////////////////////////////////////////////////////

var alpha_start = argument0;
var alpha_end= argument1;
var dur = argument2;


//Need a variable to track time passes when function is called
if (!variable_instance_exists(id, "flash_counter")) 
{
	flash_counter = pi/2;
}


//	Normalize value so that flash_counter is a second to flash on and off in 1 second
flash_counter += global.delta_time_seconds * pi * 2;

// Get desired value for duration needed by multiplying dur by normalized value
var flash_speed = flash_counter * (1/dur);

// Difference between alpha_end and start
var alpha_range = alpha_end - alpha_start;

// Place value in range between alpha_start and alpha_end
var alpha = (alpha_range * ((sin(flash_speed) + 1) *.5)) + alpha_start;

// Set alpha of object if from non-draw event
//image_alpha = alpha;

//Else if from draw event return value
return alpha;
