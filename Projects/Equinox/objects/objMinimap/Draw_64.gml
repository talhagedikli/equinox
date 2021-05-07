/// @description 
if (global.showMinimap) {
	// General variables
	var mapSize = 100;
	var gap		= 10;
	var radius	= 2;
	//display_set_gui_size(1366, 768);
	//draw_circle(600, 300, 50, false);
	//display_set_gui_size(-1, -1);
	
	// Create the minimap surface
	if(!surface_exists(minimap)) {
		minimap = surface_create(mapSize, mapSize);
	}
	surface_set_target(minimap);
	draw_clear_alpha(c_white, 0);
	
	if (minimapType == mmTypes.stable) {		// STABLE TYPE
		draw_set_color(c_white);
		draw_set_alpha(0.8);
		draw_roundrect_ext(0, 0, mapSize, mapSize, 20, 20, false);

		with(objParMinimap) { 
			draw_set_color(c_black);
			draw_set_alpha(1);
			draw_circle(x/room_width * mapSize, y/room_height * mapSize, radius, false);
			//draw_point(lerp(0, mapSize, x/room_width), lerp(0, mapSize, y/room_height));
		}
	}
	
	else if (minimapType == mmTypes.dynamic) {	// DYNAMIC TYPE
		draw_set_color(c_white);
		draw_set_alpha(0.8);
		
		var pX = (objPlayer.x / room_width) * mapSize;
		var pY = (objPlayer.y / room_height) * mapSize;
							
		var minScl = 2;											// Minimap downscale
		//draw_set_circle_precision(8);
		draw_circle(mapSize/2, mapSize/2, mapSize/2, false);	// Minimap background

		with(objParMinimap) { 
			draw_set_color(C_CRIMSON);
			draw_set_alpha(1);
			draw_circle(mapSize/2, mapSize/2, radius, false);
		} 

		with (objBlock) {
			draw_set_color(c_dkgray);
			draw_set_alpha(1);	
			if (point_in_circle(((x / room_width) * mapSize) * minScl, ((y / room_height) * mapSize) * minScl, 
									pX*minScl, pY*minScl, mapSize/2 - 5)) { // Checks if block in circle
		
				// Drawing blocks but their positions are in view of player
				draw_sprite_ext(sprite_index, image_index, (((x / room_width) * mapSize) - pX) * minScl + (mapSize / 2), 
														(((y / room_height) * mapSize) - pY) * minScl + (mapSize / 2),
															image_xscale * (mapSize / room_width), 
															image_yscale * (mapSize / room_height), 
																0, c_dkgray, 1);
			}
		}
	}
	// Reset values and surface and draw surface
	draw_set_color(c_white);
	draw_set_alpha(1);

	surface_reset_target();
	// Draw the surface to resized gui
	var resize	= 1;
	
	var miniX	= GUI_W - gap - mapSize*resize;
	var miniY	= GUI_H - gap - mapSize*resize;
	
	//surface_resize(minimap, mapSize*resize, mapSize*resize);
	draw_surface_ext(minimap, miniX, miniY, 1, 1, 0, c_white, 1);
	
}
