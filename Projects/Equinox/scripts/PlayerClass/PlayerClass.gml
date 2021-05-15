/// @description player normal state
function player_state_normal() {
    #region //Movement phase
    if (InputManager.keyLeft) {
        xSpeed = approach(xSpeed, -hMaxSpeed, aSpeed);
    } else if (InputManager.keyRight) {
        xSpeed = approach(xSpeed, hMaxSpeed, aSpeed);
    } else {
        xSpeed = approach(xSpeed, 0, dSpeed);
    }

    //calculating aSpeed and dSpeed
    if (onGround == true) {
        aSpeed = groundAccel;
        dSpeed = groundDecel;
    } else {
        aSpeed = airAccel;
        dSpeed = airDecel;
    }
    #endregion

    #region //Jumping phase
    //Coyote time
    if (onGround == false) {
        if (coyoteCounter > 0) {
            coyoteCounter -= 1;
        }
    } else {
        coyoteCounter = coyoteMax;
    }

    //real jump section
    if (InputManager.keySpace and canJump == true and coyoteCounter > 0) {

        ySpeed = jPower;
        canJump = false;
        //some jump effects(create if its on ground)
        if (onGround) part_particles_create(global.partSystem, x, y, global.ptDirt, choose(1, 2, 3));
        squash_stretch(0.7, 1.3);
    }
    //to prevent the jump loop by holding down the key(canJump used for this)
    else if (!InputManager.keySpace and onGround == true) {
        canJump = true;
    }

    //jump buffer
    if (InputManager.keySpacePressed) {
        bufferCounter = bufferMax;
    }

    if (bufferCounter > 0) {
        bufferCounter -= 1;

        if (onGround == true) {
            bufferCounter = 0;
            ySpeed = jPower;
            //some jump effects 2
            part_particles_create(global.partSystem, x, y, global.ptDirt, choose(1, 2, 3));
            squash_stretch(0.7, 1.3);
        }
    }



    //double jump section
    if (jumps > 0 and InputManager.keySpacePressed and doubleJump) {
        //reduce jumps variable by 1 every step
        jumps -= 1;
        ySpeed = jPower;
        squash_stretch(0.7, 1.3);
    } else if (onGround == true) {
        //set jumps variable to jumpsMax if it's on ground
        jumps = jumpsMax;
    }

    //variable jump height
    if (onGround == false)
    {
    	if (ySpeed < 0 and !InputManager.keySpace && !InputManager.keyAlt)		
    	{
    		//if InputManager.keySpace is not pressed, slow down by 50 percent
    	    ySpeed *= 0.95;
    	}
    }

    //landed
    if (onGround == true) {
        if (landed == false) {
            //to track "just landed on ground" moment
            landed = true;
        }
    } else {
        //set landed back to false if it is on air
        landed = false;
    }
    #endregion


    #region //Flying section
    static _ptSystem = global.partSystem;
    static _pt = global.ptDashPixels;
    static time = 0;
    time++;

    if (InputManager.keyAlt) {
        if (gas > 0) {
            gas--;
            packPower = approach(packPower, packPowerMax, 0.005);
            if (time mod 5 == 0) //Creating some particles when flying
                part_particles_create(_ptSystem, x + random_range(-8, 8), y + sprite_yoffset, _pt, 1);
        } else {
            packPower = 0;
        }

        if (place_meeting(x, y - 1, objBlock)) packPower = 0;	// If head hits roof, cut the power

    } else {
        packPower = 0;
        if (onGround) {	
            gas = gasMax;
        }
    }
    ySpeed -= packPower;										// Apply packpower

    #endregion

	
	#region //Switching state phase
    //switch to crouch state
    //if (onGround and InputManager.keyDown) {
    //    squash_stretch(0.7, 1.2);
    //    state = states.crouch;
    //}

    ////switch to dash state
    //if (keyDashPressed and canDash == true and stopDashing == false)
    //{
    //	frame_freeze(150);	
    //	screen_shake(5, 3, 1);
    //	state = states.dash;
    //}
    //else if (!keyDashPressed and onGround == true)
    //{
    //	canDash = true;
    //}


    ////switch to grab state
    //if (onWall and keyGrab and onGround == false and stopGrabbing == false)
    //{
    //	//cangrab = false;
    //	state = states.grab
    //}
    //else if (onGround == true)
    //{
    //	//cangrab = true;
    //	canClimb = true;
    //	grabCounter = 0;
    //}


    #endregion

}

/// @description player dash state
function player_state_dash() {

    //variables
    static _oldGraw		= gSpeed;
    static _newGraw		= 0;
    static _ptSystem	= global.partSystem;
    static _pt			= global.ptDashPixels;
    static _xOff		= sprite_xoffset;
    static _yOff		= sprite_yoffset;
    //apply new gSpeed
    gSpeed = _newGraw;

    if (InputManager.keyLeft) {
        facing = -1;
    } else if (InputManager.keyRight) {
        facing = 1;
    }

    //dash just once
    canDash = false;

    //cant jump after dash
    canJump = false;

    //increasing dash counter by one
    dashCounter++;

    //dash pixels
    if (dashCounter mod 3 == 0) {
        part_particles_create(_ptSystem, x - (facing * _xOff / 3), y - (_yOff / 4), _pt, 1);
    }

    //calculating dash speeds (dashX and dashY just once)
    if (isDashing == false) {
        if (InputManager.keyRight or InputManager.keyLeft) {
            dashX = facing * xDashPower;
            squash_stretch(1.3, 0.6);

            if (InputManager.keyUp) {
                dashY = yDashPower;
            } else if (InputManager.keyDown) {
                dashY = -yDashPower;
            } else {
                dashY = 0;
            }
        } else //if nothing pressed but up and down
        {
            dashX = 0;
            if (InputManager.keyUp) {
                dashY = yDashPower;
                squash_stretch(0.6, 1.4);
            } else if (InputManager.keyDown) {
                dashY = -yDashPower;
                squash_stretch(0.6, 1.4);
            } else //actual nothing pressed				
            {
                dashX = facing * xDashPower;
                dashY = 0;
                squash_stretch(1.3, 0.6);
            }
        }

    }

    isDashing = true;


    //apply the speeds
    xSpeed = dashX;
    ySpeed = dashY;

    //leave dash state
    if (dashCounter == dashCounterMax) {
        /*
        if (xSpeed != 0)
        {
        	xSpeed = facing*hMaxSpeed;
        }*/

        //smooth stopping
        ySpeed = sign(ySpeed) * hMaxSpeed;
        xSpeed = sign(xSpeed) * hMaxSpeed;

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
function player_state_crouch() {
    static _crouchDecel = dSpeed;

    xSpeed = approach(xSpeed, 0, _crouchDecel);

    //from cube
    squash_stretch(1.4, 0.6);

    //switch statement
    if (!InputManager.keyDown) {
        state = states.normal;
    }

}
	
/// @description
function player_animation_control() {
	xScale = approach(xScale, 1, 0.03);
	yScale = approach(yScale, 1, 0.03);

	//animation control    
	switch state 
	{
	    case states.normal:
	        if (keyLeft)
			{
	            facing = -1;
	        }
			else if (keyRight)
			{
	            facing = 1;
	        }

        
	        if (onGround)
			{
	            if (keyLeft or keyRight)
				{
	                sprite = sprPlayer;
	            }
				else
				{
	                sprite = sprPlayer;
	            }
	        }
			else
			{
	            sprite = sprPlayer;
	            if (ySpeed < -1)
				{
	                frame = 2;
	            }
				else if (ySpeed > 1)
				{
	                frame = 1;
	            }
				else 
				{
	                frame = 0;
	            }
	        }
			
			/*/SOUND
			if (keyJump) 
			{
				if (!audio_is_playing(aJump))
				{
					audio_play_sound(aJump, 2, false);
				}
					
			}
			else 
			{
				audio_stop_sound(aJump);
			}*/
			
		break;

	    case states.crouch:
	        
			sprite_index = sprPlayerCrouch;
			
		break;
		
		case states.dash:
			/* çıkartıldı çünkü dash esnasında değişmemesi gerek(bunun yerine isDashing
			de olabilirdi)
			if (keyLeft)
			{
	            facing = -1;
	        }
			else if (keyRight)
			{
	            facing = 1;
	        }
			*/
			sprite = sprPlayer;
			
		break;
		
		case states.grab:
			if (keyJumpPressed)
			{
				facing = -facing;
			}
			
			sprite = sprPlayer;
			frame = 2;
			
		break;
			
		case states.stop:
			sprite = sprPlayer;
		
		break;

	}

	//reset frame to 0 if sprite changes
	if (lastSprite != sprite)
	{
	    lastSprite = sprite;
	    frame = 0;
	}

}

/// @description
//checks every frame (step event)
function player_buttons_init() { // Old code
	keyLeft			= keyboard_check(vk_left)				or gamepad_button_check(0,gp_padl);
	keyRight		= keyboard_check(vk_right)				or gamepad_button_check(0,gp_padr);
	keyUp			= keyboard_check(vk_up)					or gamepad_button_check(0,gp_padu);
	keyDown			= keyboard_check(vk_down)				or gamepad_button_check(0,gp_padd);
	
	keyJumpPressed	= keyboard_check_pressed(vk_space)		or gamepad_button_check_pressed(0,gp_face1);
	keyJump			= keyboard_check(vk_space)				or gamepad_button_check(0,gp_face1);
	
	keyGrab			= keyboard_check(vk_lalt)				or gamepad_button_check(0,gp_shoulderrb);
	
	keyLeftPressed	= keyboard_check_pressed(vk_left)		or gamepad_button_check_pressed(0,gp_padl);
	keyRightPressed	= keyboard_check_pressed(vk_right)		or gamepad_button_check_pressed(0,gp_padr);
	keyUpPressed	= keyboard_check_pressed(vk_up)			or gamepad_button_check_pressed(0,gp_padu);
	keyDownPressed	= keyboard_check_pressed(vk_down)		or gamepad_button_check_pressed(0,gp_padd);
	
	
	keyDashPressed	= keyboard_check_pressed(vk_lshift) 	or gamepad_button_check_pressed(0,gp_face3);
	
	keyVPressed		= keyboard_check_pressed(ord("V"))		or gamepad_button_check_pressed(0,gp_face4);
	
	mouseLPressed	= mouse_check_button_pressed(mb_left);
	mouseRPressed	= mouse_check_button_pressed(mb_right);
	
	keyAlt			= keyboard_check(vk_alt);
	
}



