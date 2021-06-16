//some variables

//set camera's size
if (global.zoom)
{
	updateCameraSize(newW, newH);
}
else
{
	updateCameraSize(defaultW, defaultH);
}
// Camera states
if (state == camStates.normal)
{
	if (instance_exists(following))
	{
		var xTo, yTo;
		xTo = round(following.x) - (camW / 2);
		yTo = round(following.y) - (camH / 2);
		//camX = abs(difX) < EPSILON ? targetX : lerp(camX, targetX, followSpd);
		camX = flerp(camX, xTo, followSpd, 0.000001);
		camY = flerp(camY, yTo, followSpd, 0.000001);
		//camY = abs(difY) < EPSILON ? targetY : lerp(camY, targetY, followSpd);
		applyScreenShake();
	}
}
else if (state == camStates.cell)
{
	if (instance_exists(following))
	{
		var xTo, yTo;
		xTo = (following.x div viewWidth) * viewWidth;
		yTo = (following.y div viewHeight) * viewHeight;
		var difX, difY;
		difX = (xTo - camX);
		difY = (yTo - camY);
		camX = abs(difX) < 1 ? xTo : camX + difX / 15;
		camY = abs(difY) < 1 ? yTo : camY + difY / 15;
		//screen shake script to apply it
		applyScreenShake();
	}
}
else if (state == camStates.zoom)
{
	if (instance_exists(following))
	{
		//if zoomed in, make camera smaller
		newW = defaultW / 2;
		newH = defaultH / 2;
		//camW = flerp(camW, newW, zoomSpd);
		//camH = flerp(camH, newH, zoomSpd);
		//go to who you are focused to
		camX = flerp(camX, targetX, followSpd);
		camY = flerp(camY, targetY, followSpd);
	}
}
//clamp camera's position values inside of the room (cam width and height are dynamic)
camX = clamp(camX, 0, room_width - camW);
camY = clamp(camY, 0, room_height - camH);


if keyboard_check_pressed(ord("S")) 
{
	smooth = !smooth;
	application_surface_enable(!smooth);

	var pad = smooth ? 1 : 0;
	camera_set_view_size(VIEW, camW + pad, camH + pad);	
}
//apply the camera's positions and size

camera_set_view_pos(VIEW, camX, camY);


// Smooth camera
if (smooth) {
	if (!surface_exists(viewSurf)) {
		viewSurf = surface_create(viewWidth * windowScale + 1, viewHeight * windowScale + 1);
	}
	view_surface_id[0] = viewSurf;
} else {
	if (surface_exists(viewSurf)) {
		surface_free(viewSurf);
		viewSurf = -1;
	}
	view_surface_id[0] = -1;
	
}
//track the transition layer
if (layer_sequence_exists("transitions", global.sequenceLayer))
{
	layer_sequence_x(global.sequenceLayer, camX);
	layer_sequence_y(global.sequenceLayer, camY);
}