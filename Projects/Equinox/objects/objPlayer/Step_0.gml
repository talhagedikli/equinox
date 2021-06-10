//player button inputs
#region//checking is on ground, if it is stop y move, if it isn't apply grav
//onGround and Onwall controls
onGround	= place_meeting(x, y + 1, objBlock);
onWall		= tile_meeting(x + facing, y, objBlock);



#endregion


//animation speed
frame += frameSpeed;

//switching states
switch (state) {
	case states.normal:
		player_state_normal();
		ySpeed = clamp(ySpeed, -vMaxSpeed, vMaxSpeed);
		xSpeed = clamp(xSpeed, -hMaxSpeed, hMaxSpeed);
		break;
	
	case states.crouch:
		player_state_crouch();
			ySpeed = clamp(ySpeed, -vMaxSpeed, vMaxSpeed);
			xSpeed = clamp(xSpeed, -hMaxSpeed, hMaxSpeed);
		break;
	
	case states.dash:
		dashTween.evaluate(xSpeed, facing*10, 0.2);
		xSpeed = dashTween.value;
		ySpeed = 0;
		
		if (dashTween.done) {
			dashTween.stop();
			state = states.normal;
		}
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

//animation control
player_animation_control();

//frame reset to first frame(0)
frame_reset();

//tracking position
xPos = x;
yPos = y;

gasRate = gas/gasMax;

//gasBar.step(gas, gasMax);
//testbar.step(gas, gasMax);






