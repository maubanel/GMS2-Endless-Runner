
//	Get x value of tile and ground it to address tearign issues between chumks
layer_x(ground_1_layer, floor(layer_get_x(ground_1_layer)));
layer_x(ground_2_layer, floor(layer_get_x(ground_2_layer)));
layer_x(ground_3_layer, floor(layer_get_x(ground_3_layer)));
layer_x(ground_4_layer, floor(layer_get_x(ground_4_layer)));
layer_x(ground_5_layer, floor(layer_get_x(ground_5_layer)));


//When tile is off screen move it to the right hand side at end of chain of 5 groudn chunks
if (layer_get_x(ground_1_layer) <= - GROUND_WIDTH)
{
	layer_x(ground_1_layer, floor(layer_get_x(ground_5_layer)) + GROUND_WIDTH);
}

if (layer_get_x(ground_2_layer) <= - GROUND_WIDTH)
{
	layer_x(ground_2_layer, floor(layer_get_x(ground_1_layer)) + GROUND_WIDTH);
}

if (layer_get_x(ground_3_layer) <= - GROUND_WIDTH)
{
	layer_x(ground_3_layer, floor(layer_get_x(ground_2_layer)) + GROUND_WIDTH);
}

if (layer_get_x(ground_4_layer) <= - GROUND_WIDTH)
{
	layer_x(ground_4_layer, floor(layer_get_x(ground_3_layer)) + GROUND_WIDTH);
}

if (layer_get_x(ground_5_layer) <= - GROUND_WIDTH)
{
	layer_x(ground_5_layer, floor(layer_get_x(ground_4_layer)) + GROUND_WIDTH);
}

