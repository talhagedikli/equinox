//some variables
camX	= camera_get_view_x(VIEW);
camY	= camera_get_view_y(VIEW);

//set camera's size
if (global.zoom) {
	camW = flerp(camW, newW, zoomSpd);
	camH = flerp(camH, newH, zoomSpd);
} else {
	camW = flerp(camW, defaultW, zoomSpd);
	camH = flerp(camH, defaultH, zoomSpd);
}

// Camera states
if (state == camStates.normal) {
	if (instance_exists(following)) {
		var xTo, yTo;
		var targetX	= following.x - camW/2;
		var targetY	= following.y - camH/2;			
		//follow the "following" object
		//var difX, difY;
			
		//difX = (targetX - camX);
		//difY = (targetY - camY);
			
		//camX = abs(difX) < EPSILON ? targetX : lerp(camX, targetX, followSpd);
		camX = flerp(camX, targetX, followSpd);
		camY = flerp(camY, targetY, followSpd);
		//camY = abs(difY) < EPSILON ? targetY : lerp(camY, targetY, followSpd);
			
		//screen shake script to apply it
		apply_screen_shake();
	}
	
}
else if (state == camStates.cell) {
	if (instance_exists(following)) {
		#region Old cell code
		////to prevent smth
		//camX = camXStart
		////var _cellN = room_width div viewWidth;
		////var _camCell = camX div viewWidth;
		////var _playerCell = objPlayer.x div viewWidth;
		//var _times = (following.x - camX) div viewWidth;
			
		////x pos
		//camX = viewWidth*_times;
		////y pos
		//camY = lerp(camY, targetY, followSpd);
		#endregion
			
		var xTo, yTo;
		xTo = (following.x div viewWidth) * viewWidth;
		yTo = (following.y div viewHeight) * viewHeight;
			
		var difX, difY;
		difX = (xTo - camX);
		difY = (yTo - camY);
			
			
		//if (abs(difX) < 1) camX = xTo; else camX += difX/15;
		//if (abs(difY) < 1) camY = yTo; else camY += difY/15;
		camX = abs(difX) < 1 ? xTo : camX + difX/15;
		camY = abs(difY) < 1 ? yTo : camY + difY/15;
			
			
		//screen shake script to apply it
		apply_screen_shake();
	}
	
}
else if (state == camStates.zoom) {
	if (instance_exists(following))
	{
		//if zoomed in, make camera smaller
		newW = defaultW/2;
		newH = defaultH/2;
			
		//go to who you are focused to
		camX = flerp(camX, targetX, followSpd); 
		camY = flerp(camY, targetY, followSpd);
	}
	
}


//clamp camera's position values inside of the room (cam width and height are dynamic)
camX = clamp(camX, 0, room_width - camW);
camY = clamp(camY, 0, room_height - camH);

//apply the camera's positions and size
camera_set_view_pos(VIEW, camX, camY);
camera_set_view_size(VIEW, camW, camH);



//track the transition layer
if (layer_sequence_exists("transitions", global.sequenceLayer)) 
{
	layer_sequence_x(global.sequenceLayer, camX);
	layer_sequence_y(global.sequenceLayer, camY);
}



