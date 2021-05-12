//player button inputs
player_buttons_init();

#region//checking is on ground, if it is stop y move, if it isn't apply grav
//onGround and Onwall controls
onGround	= place_meeting(x, y + 1, objBlock);
onWall		= place_meeting(x + facing, y, objBlock);



#endregion


//animation speed
frame += frameSpeed;

//switching states
switch (state) {
	case states.normal:
		player_state_normal();
		break;
	
	case states.crouch:
		player_state_crouch();
		break;
	
	case states.dash:
		player_state_dash();
		break;

}

//applying gSpeed
if (!onGround) {
	ySpeed += gSpeed;
}

ySpeed = clamp(ySpeed, -vMaxSpeed, vMaxSpeed);
xSpeed = clamp(xSpeed, -hMaxSpeed, hMaxSpeed);

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






