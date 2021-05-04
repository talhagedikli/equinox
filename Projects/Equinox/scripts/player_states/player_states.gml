/// @description player normal state
function player_state_normal() {
    #region //MOVEMENT SECTION////////////////////////////////////////////////////////////////
    if (keyLeft) {
        xSpeed = approach(xSpeed, -mSpeed, aSpeed);
    } else if (keyRight) {
        xSpeed = approach(xSpeed, mSpeed, aSpeed);
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

    #region //JUMP SECTION///////////////////////////////////////////////////////////////////	
    //Coyote time
    if (onGround == false) {
        if (coyoteCounter > 0) {
            coyoteCounter -= 1;
        }
    } else {
        coyoteCounter = coyoteMax;
    }

    //real jump section
    if (keyJump and canJump == true and coyoteCounter > 0) {

        ySpeed = jPower;
        canJump = false;
        //some jump effects(create if its on ground)
        if (onGround) part_particles_create(global.partSystem, x, y, global.ptDirt, choose(1, 2, 3));
        squash_stretch(0.7, 1.3);
    }
    //to prevent the jump loop by holding down the key(canJump used for this)
    else if (!keyJump and onGround == true) {
        canJump = true;
    }

    //jump buffer
    if (keyJumpPressed) {
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
    if (jumps > 0 and keyJumpPressed and doubleJump) {
        //reduce jumps variable by 1 every step
        jumps -= 1;
        ySpeed = jPower;
        squash_stretch(0.7, 1.3);
    } else if (onGround == true) {
        //set jumps variable to jumpsMax if it's on ground
        jumps = jumpsMax;
    }

    //variable jump height
    //if (onGround == false)
    //{
    //	if (ySpeed < 0 and !keyJump)		
    //	{
    //		//if keyJump is not pressed, slow down by 50 percent
    //	    ySpeed *= 0.5;
    //	}
    //}

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
    //if (keyPush and gas > 0) {
    //	gas--;
    //	packPower = approach(packPower, packPowerMax, 0.05);

    //} else if (!onGround){
    //	packPower = approach(packPower, 0, 5);
    //	gas = gasMax;
    //}
    static _ptSystem = global.partSystem;
    static _pt = global.ptDashPixels;
    static time = 0;
    time++;

    if (keyPush) {
        if (gas > 0) {
            gas--;
            packPower = approach(packPower, packPowerMax, 0.005);
            if (time mod 5 == 0)
                part_particles_create(_ptSystem, x + random_range(-8, 8), y + sprite_yoffset, _pt, 1);
        } else {
            packPower = 0;
        }

        if (place_meeting(x, y - 1, objBlock)) packPower = 0;

    } else {
        packPower = 0;
        if (onGround) {
            gas = gasMax;
        }
    }
    ySpeed -= packPower;

    #endregion


    #region //SWITCHING STATEMENT SECTION///////////////////////////////////////////////////
    //switch to crouch state
    if (onGround and keyDown) {
        squash_stretch(0.7, 1.2);
        state = states.crouch;
    }

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

    if (keyLeft) {
        facing = -1;
    } else if (keyRight) {
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
        if (keyRight or keyLeft) {
            dashX = facing * xDashPower;
            squash_stretch(1.3, 0.6);

            if (keyUp) {
                dashY = yDashPower;
            } else if (keyDown) {
                dashY = -yDashPower;
            } else {
                dashY = 0;
            }
        } else //if nothing pressed but up and down
        {
            dashX = 0;
            if (keyUp) {
                dashY = yDashPower;
                squash_stretch(0.6, 1.4);
            } else if (keyDown) {
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
        	xSpeed = facing*mSpeed;
        }*/

        //smooth stopping
        ySpeed = sign(ySpeed) * mSpeed;
        xSpeed = sign(xSpeed) * mSpeed;

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
    if (!keyDown) {
        state = states.normal;
    }

}

/// @description player grab state
function player_state_grab() {
    //variables
    static _oldGraw = gSpeed;
    static _newGraw = 0;
    static _fSpd = 0.1;
    //gSpeed in grab state
    gSpeed = _newGraw;

    //counter calculating
    grabCounter += 1;

    //stop character when just grab the wall-- you can add if onWall top of here
    if (grabCounter > grabMax) {
        //ySpeed = approach(ySpeed, 4, _oldGraw);
        gSpeed = _oldGraw;
    } else if (grabCounter > grabFallDown) {
        ySpeed = approach(ySpeed, 0.1, _oldGraw);
    } else {
        xSpeed = 0;
        ySpeed = 0;
    }

    //if walljump, switch to normal state EDITED - facing edited in animation control
    if (keyJumpPressed) {
        squash_stretch(0.7, 1.3);

        facing = -facing;

        ySpeed = wallJumpY;
        xSpeed = facing * wallJumpX;
        gSpeed = _oldGraw;

        state = states.normal; //NOTE - we dont have to switch statement
    }

    //switch to dash state EDITED - facing keys edited in animation control
    if (keyDashPressed and canDash == true) {
        gSpeed = _oldGraw;

        state = states.dash;
    }

    //if keygrab is released or grabCounter reaches grabMax, switch to normal state
    if (onGround == true or!keyGrab or onWall == false) {
        gSpeed = _oldGraw;
        state = states.normal;
    }

}

/// @description player dead state
function player_state_dead() {

    xSpeed = 0;
    gSpeed = 0.0025;

}

// @description player stop state
function player_state_stop() {
    xSpeed = approach(xSpeed, 0, dSpeed);
}