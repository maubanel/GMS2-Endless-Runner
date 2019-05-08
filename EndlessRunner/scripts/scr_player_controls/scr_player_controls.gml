//Jumping
jump = false;
if (mouse_check_button_pressed(mb_left) && on_ground  && obj_game_controller.state == GAME_PLAY )
{
	jump = true;
	on_ground = false;
}