//player button inputs
#region//checking is on ground, if it is stop y move, if it isn't apply grav
//onGround and Onwall controls
onGround	= place_meeting(x, y + 1, objBlock);
onWall		= place_meeting(x + facing, y, objBlock);
onCeiling	= place_meeting(x, y - 1, objBlock);
isTouching	= onGround || onWall || onCeiling;

if (isTouching) game_restart();


#endregion


//switching states
switch (state) {
	case states.normal:
		player_state_normal();
		clampSpeed();
		break;
	
	case states.crouch:
		player_state_crouch();
		clampSpeed();
		break;
	
	case states.dash:
		player_state_dash();
		clampSpeed(dashPower, dashPower);
		break;

}



//if (getSignal("Landed", id)) {
//	image_blend = c_crimson;
//	show_debug_message("landed");
//	wipeSignal("Landed", id);
//}
if InputManager.keyDownPressed {
	//wipeSignal("Right");	
	//wipeSignal("Left");	
	//wipeSignal("Landed");	
	
}




//applying gSpeed
if (!onGround) {
	ySpeed += gSpeed;
}



//horizontal and vertical collisions
check_collisions_pixel_perfect();
//if (!tile_meeting(x+sign(xSpeed), y, "Rocks")) {
//	x += xSpeed;
//} 

//if (!tile_meeting(x, y +sign(ySpeed), "Rocks")) {
//	y += ySpeed;
//}
xScale = approach(xScale, 1, 0.03);
yScale = approach(yScale, 1, 0.03);


//tracking position
xPos = x;
yPos = y;

gasRate = gas/gasMax;

//gasBar.step(gas, gasMax);
//testbar.step(gas, gasMax);






