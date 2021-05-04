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
	
	case states.grab:
		player_state_grab();
		break;
		
	case states.dead:
		player_state_dead();
		break;
		
	case states.stop:
		player_state_stop();
		break;

}

//applying gSpeed
if (!onGround) {
	ySpeed += gSpeed;
}

ySpeed = clamp(ySpeed, -2.5, 2.5);

//horizontal and vertical collisions
check_collisions_pixel_perfect();

//animation control
player_animation_control();

//frame reset to first frame(0)
frame_reset();

//tracking position
xPos = x;
yPos = y;





