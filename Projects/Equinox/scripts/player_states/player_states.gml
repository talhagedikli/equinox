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

/// @description quick and dynamic guibar setup

function makeGuiBar() constructor { #macro GuiBar makeGuiBar()
	
	static create = function(x1, y1, barw, barh){
		xone = x1;
		yone = y1;
		
		rate = 1;
		smtRate = rate;
	
		width = barw;
		height = barh;
	};
	
	static step = function(val, valMax) {
		rate = val / valMax;
		smtRate = lerp(smtRate, rate, 0.1);
	}
		
	static drawGui = function(type, alpha, color, bottomline) {
		draw_set_alpha(alpha);
		draw_set_color(color);
		if (type == "vertical")
			draw_roundrect(xone, yone, xone + width, 
							yone + height * smtRate + (bottomline ? sign(height) : 0), false);
		else if (type == "horizontal")
			draw_roundrect(xone, yone, 
							xone + width * smtRate + (bottomline ? sign(width) : 0), yone + height, false);

		draw_set_alpha(1);
		draw_set_color(c_white);
		
	};	
	
};

function drawBar(x1, y1, width, height, rate, type, rounded, color, alpha, bottomline, lrp, lrp_rate) {
	static setRate = 1;
	if (rate != noone) {
		setRate = lrp ? lerp(setRate, rate, lrp_rate) : rate;	
	}
	
	draw_set_alpha(alpha);
	draw_set_color(color);
	if (type == "vertical") {
		if (rounded) {
		draw_roundrect(x1, y1, x1 + width, 
			y1 + height * (rate == noone ? 1 : setRate) + (bottomline ? sign(height) : 0), false);
		} else { draw_rectangle(x1, y1, x1 + width, 
			y1 + height * (rate == noone ? 1 : setRate) + (bottomline ? sign(height) : 0), false);
		}
	} else if (type == "horizontal") {
		if (rounded) {
		draw_roundrect(x1, y1, 
			x1 + width * (rate == noone ? 1 : setRate) + (bottomline ? sign(width) : 0), y1 + height, false);
		} else { draw_rectangle(x1, y1, 
			x1 + width * (rate == noone ? 1 : setRate) + (bottomline ? sign(width) : 0), y1 + height, false);
		}	
		
	}
	draw_set_alpha(1);
	draw_set_color(c_white);		
	
	
	
};
	




//function TestVar() constructor {
//	static create = function(key, value) {
//		key = value;	
//	}
	
//	static step = function() {
//		static newvalue = undefined;
//		var value = global.test[$ key];
//		if (value == "undefined") value = undefined;

//		newvalue = newvalue != value ? value : variable;
	
//		if (global.test[$ key] != undefined)
//			return newvalue;
//		else 
//			return variable;	
//	}
	
//}

