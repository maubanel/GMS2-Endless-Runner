//Displacement
y += player_velocity_y;
	
if (jump) show_debug_message("y after gravity: " + string(y));
//Ground collision, let player fall through then correct
if (y >= global.ground_plane)
{
	y = global.ground_plane;
	on_ground = true;
	player_velocity_y = 0;
}

jump = false;