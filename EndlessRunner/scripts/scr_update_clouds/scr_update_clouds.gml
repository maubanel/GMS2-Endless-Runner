//If clouds go off left side of screen send back to right side and re-randomize the sprite

if (layer_get_x(cloud_1_layer) < 0 - CLOUD_WIDTH)
{
	layer_x(cloud_1_layer, room_width + irandom_range(0, 50));
	layer_y(cloud_1_layer, irandom_range(0, 200)); 
	scr_change_cloud_random(cloud_1_layer);
}

if (layer_get_x(cloud_2_layer) < 0 - CLOUD_WIDTH)
{
	layer_x(cloud_2_layer, room_width + irandom_range(0, 50));
	layer_y(cloud_2_layer, irandom_range(100, 300)); 
	scr_change_cloud_random(cloud_2_layer);
}

if (layer_get_x(cloud_3_layer) < 0 - CLOUD_WIDTH)
{
	layer_x(cloud_3_layer, room_width + irandom_range(0, 50));
	layer_y(cloud_3_layer, irandom_range(50, 400)); 
	scr_change_cloud_random(cloud_3_layer);
}

if (layer_get_x(cloud_4_layer) < 0 - CLOUD_WIDTH)
{
	layer_x(cloud_4_layer, room_width + irandom_range(0, 50));
	layer_y(cloud_4_layer, irandom_range(-100, 100));
	scr_change_cloud_random(cloud_4_layer);
}