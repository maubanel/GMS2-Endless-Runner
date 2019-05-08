//Time in air is equal to speed of ground in pixels per second divided by max jump distance


	
if (jump)
{

	player_velocity_y -= sqrt(2 * jump_force * player_gravity * global.delta_time_seconds * obj_game_controller.game_scalar);
}


if (!on_ground)
{
	player_velocity_y += player_gravity * global.delta_time_seconds * obj_game_controller.game_scalar;
	player_velocity_y = clamp(player_velocity_y, -terminal_velocity * global.delta_time_seconds, terminal_velocity * global.delta_time_seconds);
}







	