var sprite = asset_get_index("spr_"+ argument0);
var object = asset_get_index("obj_"+ argument0);
var layer_dep = argument1;

instance_create_depth(room_width, global.ground_plane - sprite_get_height(sprite) + sprite_get_height(spr_player), layer_dep, object);
