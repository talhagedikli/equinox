/// @description player normal state
function player_state_normal()
{
	#region//MOVEMENT SECTION////////////////////////////////////////////////////////////////
	if (keyLeft)
	{
		xSpeed = approach(xSpeed, -mSpeed, aSpeed);
	}
	else if (keyRight)
	{
		xSpeed = approach(xSpeed, mSpeed, aSpeed);
	}
	else
	{
		xSpeed = approach(xSpeed, 0, dSpeed);
	}
		
	//calculating aSpeed and dSpeed
	if (onGround == true)
	{
		aSpeed	= groundAccel;
		dSpeed	= groundDecel;
	}
	else
	{
		aSpeed	= airAccel;
		dSpeed	= airDecel;
	}
	

	#endregion
	
	
	#region//JUMP SECTION///////////////////////////////////////////////////////////////////	
	//coyote time calculations
	if (onGround == false)
	{
		if (coyoteCounter > 0)
		{
			coyoteCounter -= 1;
		}
	}
	else
	{
		coyoteCounter = coyoteMax;
	}
	
	//real jump section
	if (keyJump and canJump == true and coyoteCounter > 0)
	{
		
		ySpeed = jPower;
		canJump = false;
		//some jump effects(create if its on ground)
		if (onGround) part_particles_create(global.partSystem, x, y, global.ptDirt, choose(1,2,3));
		squash_stretch(0.7,1.3);
	}
	//to prevent the jump loop by holding down the key(canJump used for this)
	else if (!keyJump and onGround == true)		
	{
		canJump = true;
	}
		
	//jump buffer
	if (keyJumpPressed)
	{
		bufferCounter = bufferMax;
	}
	
	if (bufferCounter > 0)
	{
		bufferCounter -= 1;
		
		if (onGround == true)
		{
			bufferCounter = 0;
			ySpeed = jPower;
			//some jump effects 2
			part_particles_create(global.partSystem, x, y, global.ptDirt, choose(1,2,3));
			squash_stretch(0.7,1.3);
		}
	}
	
	
	
	//double jump section
	if (jumps > 0 and keyJumpPressed)
	{
		//reduce jumps variable by 1 every step
		jumps -= 1;
		ySpeed = jPower;
		squash_stretch(0.7,1.3);
	}
	else if (onGround == true)
	{
		//set jumps variable to jumpsMax if it's on ground
		jumps = jumpsMax;
	}
	
	//variable jump height
	if (onGround == false)
	{
		if (ySpeed < 0 and !keyJump)		
		{
			//if keyJump is not pressed, slow down by 50 percent
		    ySpeed *= 0.5;
		}
	}
		
	//landed
	if (onGround == true)
	{
		if (landed == false)				
		{
			//to track "just landed on ground" moment
		    landed = true;
			squash_stretch(1.3,0.7);
		}
	}
	else
	{
		//set landed back to false if it is on air
		landed = false;
	}
	#endregion
	
	
	#region//SWITCHING STATEMENT SECTION///////////////////////////////////////////////////
	//switch to crouch state
	if (onGround and keyDown)
	{
		squash_stretch(0.7, 1.2);
		state = states.crouch;
	}
	
	//switch to dash state
	if (keyDashPressed and canDash == true and stopDashing == false)
	{
		frame_freeze(150);	
		screen_shake(5, 3, 1);
		squash_stretch(1.5,0.5);
		state = states.dash;
	}
	else if (!keyDashPressed and onGround == true)
	{
		canDash = true;
	}
	
	
	//switch to grab state
	if (onWall and keyGrab and onGround == false and stopGrabbing == false)
	{
		//cangrab = false;
		state = states.grab
	}
	else if (onGround == true)
	{
		//cangrab = true;
		canClimb = true;
		grabCounter = 0;
	}
	
	#region create dashPort
	////calculate port creating margin
	//if (instance_exists(objDashport))
	//{
	//	dashportCounter++;
		
	//	if (dashportCounter > dashportMax)
    //    {
    //        dashportCounter = 0;
	//		//start to fade out
	//		with (dashPort)
    //        {
	//			fadeOut = true;
    //        }
    //    }
		
	//	var _x = dashPort.x;
	//	var _y = dashPort.y;
		
	//	//teleport to the port's positions
	//	if (mouseLPressed and place_free(_x, _y))
	//	{
	//		//if teleported, set counter to 0
	//		dashportCounter = 0;
			
	//		x = _x;
	//		y = _y;
	//		//approach same speed with it
	//		xSpeed = approach(dashPort.speed, 0, dSpeed);
			
	//		//face same direction with it
	//		facing = sign(dashPort.speed);
			
	//		//dont create it twice
	//		canDashport = false;
			
	//		with (dashPort)
	//		{
	//			instance_destroy();
	//		}
	//	}
		
	//}
	//else if (!instance_exists(objDashport) and mouseLPressed and canDashport == true)
    //{
	//	//creating dashport (speed etc. in its obj)
	//	var _portX = x - facing*1;
	//	var _portY = y;
    //    dashPort = instance_create_layer(_portX, _portY, "effects", objDashport);
		
    //}
	//else
	//{
	//	canDashport = true;
	//}
	#endregion
	
	#endregion
		
}

/// @description player dash state
function player_state_dash()
{
	
	//variables
	var static _oldGraw = gSpeed;
	var _newGraw	    = 0;
	var _ptSystem		= global.partSystem;
	var _pt				= global.ptDashPixels;
	var _xOff			= sprite_xoffset;
	var _yOff			= sprite_yoffset;
	//apply new gSpeed
	gSpeed = _newGraw;
	
	//dash just once
	canDash = false;
	
	//cant jump after dash
	canJump = false;
	
	//increasing dash counter by one
	dashCounter ++;
	
	//dash pixels
	if (dashCounter mod 3 == 0)
	{
		part_particles_create(_ptSystem, x-(facing*_xOff/3), y-(_yOff/4), _pt, 1);
	}
	
	//calculating dash speeds (dashX and dashY just once)
	if (isDashing == false)
	{
		if (keyRight or keyLeft)
		{
			isDashing = true
			dashX = facing*xDashPower;
			squash_stretch(1.3,0.6);
		
			if (keyUp)
			{
				dashY = yDashPower;
			}
			else if (keyDown)
			{
				dashY = -yDashPower;
			}
			else
			{
				dashY = 0;
			}
		}
		else						//if nothing pressed but up and down
		{
			isDashing = true
			dashX = 0;
			if (keyUp)				
			{ 
				dashY= yDashPower; 
				squash_stretch(0.6, 1.4); 
			}
			else if (keyDown)		
			{ 
				dashY = -yDashPower;	
				squash_stretch(0.6, 1.4); 
			}
			else					//actual nothing pressed				
			{ 
				dashX = facing*xDashPower; 
				dashY = 0;
				squash_stretch(1.3,0.6);
			}	
		}
		
	}
	
	
	//apply the speeds
	xSpeed = dashX;
	ySpeed = dashY;
	
	//leave dash state
	if (dashCounter == dashCounterMax)
	{	
		/*
		if (xSpeed != 0)
		{
			xSpeed = facing*mSpeed;
		}*/
		
		//smooth stopping
		ySpeed = sign(ySpeed)*mSpeed;
		xSpeed = sign(xSpeed)*mSpeed;
		
		//set dashCounter to 0
		dashCounter = 0;
		
		//get gravity back
		gSpeed = _oldGraw;
		isDashing = false;
		
		//switch state
		state = states.normal;
	
	}

}

/// @description player crouch state
function player_state_crouch()
{
	var _crouchDecel = dSpeed;
	
	xSpeed = approach(xSpeed, 0, _crouchDecel);
	
	//from cube
	xScale = 1.1;
	yScale = 0.8;
	
	//switch statement
	if (!keyDown)
	{
		state = states.normal;
	}

}

/// @description player grab state
function player_state_grab()
{
	//variables
	var static _oldGraw	= gSpeed;
	var	_newGraw		= 0;
	var _fSpd			= 0.1;
	//gSpeed in grab state
	gSpeed = _newGraw;
	
	//counter calculating
	grabCounter += 1;
	
	//stop character when just grab the wall-- you can add if onWall top of here
	if (grabCounter > grabMax)
	{
		//ySpeed = approach(ySpeed, 4, _oldGraw);
		gSpeed = _oldGraw;
	}
	else if (grabCounter > grabFallDown) 
	{
		ySpeed = approach(ySpeed, 0.1, _oldGraw);
	}
	else
	{
		xSpeed = 0;
		ySpeed = 0;
	}

	//if walljump, switch to normal state EDITED - facing edited in animation control
	if (keyJumpPressed)
	{
		squash_stretch(0.7, 1.3);
		
		facing = -facing;
		
		ySpeed = wallJumpY;
		xSpeed = facing*wallJumpX;
		gSpeed = _oldGraw;
		
		state = states.normal;	//NOTE - we dont have to switch statement
	}
	
	//switch to dash state EDITED - facing keys edited in animation control
	if (keyDashPressed and canDash == true) 
	{
		gSpeed = _oldGraw;
		
		state = states.dash; 
	}
	
	//if keygrab is released or grabCounter reaches grabMax, switch to normal state
	if (onGround == true or !keyGrab or onWall == false)
	{
		gSpeed = _oldGraw;
		state = states.normal;
	}

}

/// @description player dead state
function player_state_dead()
{
    
    xSpeed = 0;
	gSpeed = 0.0025;  
    
}

// @description player stop state
function player_state_stop()
{
	xSpeed = approach(xSpeed, 0, dSpeed);
}

