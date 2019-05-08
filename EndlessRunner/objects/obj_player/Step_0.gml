/// @description Insert description here

switch(obj_game_controller.state)
{
	case GAME_START:
		//Player Physics
		scr_player_physics();
	
		//Player Displacement & Collision Detection
		scr_player_move();
		break;
	
	case GAME_PLAY:
	
		//Player Controls
		scr_player_controls();
	
		//Player Physics
		scr_player_physics();
	
		//Player Displacement & Collision Detection
		scr_player_move();
		
		break;


	case PLAYER_DEAD: case GAME_OVER:
	
		//Gravity
		scr_player_physics();
	
		//Displacement with no collision detection (can't run scr_player_move)
		y += player_velocity_y;
	
	break;

}
