/// @description 
#region // TITLE ROOM
if (room == rTitle) { // TITLE ROOM
	if (layer_exists("Sky")) {
		var sky = layer_background_get_id("Sky");
		layer_background_alpha(sky, abs(sin(current_time/10000)) * 0.7);
		layer_background_xscale(sky, 0.1);
		layer_background_yscale(sky, 0.1);
	}

	
} #endregion

#region // WORLD ROOM
else if (room == rWorld) {
	if (layer_exists("Sky")) {
		var sky = layer_background_get_id("Sky");
		layer_background_xscale(sky, 0.7);
		layer_background_yscale(sky, 0.7);
	}
	randomize();
	while (!place_meeting(x, y, objBlock) && !place_meeting(x, y, objPlayer) 
											&& instance_number(objBlock) < 50 ) {
		var bl = instance_create_layer(irandom(room_width div 32) * 32, 
										irandom(room_height div 32) * 32, "Collisions", objBlock);
	
		bl.image_xscale = irandom_range(1, 4);
		bl.image_yscale = irandom_range(1, 4);
	}	
	if (!place_meeting(x, y, objBlock) && !instance_exists(objPlayer)) {
		instance_create_layer(irandom(room_width), irandom(room_height), "Player", objPlayer);
		
	}
	
} #endregion