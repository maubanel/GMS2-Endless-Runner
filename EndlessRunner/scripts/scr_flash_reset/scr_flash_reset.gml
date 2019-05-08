/// @function scr_flash()
/// @description resets flash counter for scr_flash


//////////////////////////////////////////////////////////////////////////
//																		//
//			MResets flash counter in scr_flash							//
//																		//	
//																		//
//////////////////////////////////////////////////////////////////////////



//Need a variable to track time passes when function is called
if (!variable_instance_exists(id, "flash_counter")) 
{
	flash_counter = pi/2;
}

else
{
	flash_counter = pi/2;	
}
