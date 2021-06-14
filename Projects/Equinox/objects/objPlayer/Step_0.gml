//player button inputs
#region//checking is on ground, if it is stop y move, if it isn't apply grav
//onGround and Onwall controls
checkCollisions();

if (isTouching) game_restart();

#endregion
//switching states
//switch (state) {
//	case states.normal:
//		player_state_normal();
//		clampSpeed();
//		break;
	
//	case states.crouch:
//		player_state_crouch();
//		clampSpeed();
//		break;
	
//	case states.dash:
//		player_state_dash();
//		clampSpeed(dashPower, dashPower);
//		break;

//}
//snowState.init();
snowState.step();

//applying gSpeed
applyGravity();


//horizontal and vertical collisions
check_collisions_pixel_perfect();
xScale = approach(xScale, 1, 0.03);
yScale = approach(yScale, 1, 0.03);


//tracking position
xPos = x;
yPos = y;

gasRate = gas/gasMax;




