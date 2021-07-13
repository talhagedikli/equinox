#region CREATE
//animation
animation_init();
//speed variables
xSpeed 		= 0;
ySpeed 		= 0;
motion 		= new Vector2(0, 0);
grav 		= new Vector2(0, 0.07);
facing 		= 1;
position	= new Vector2(x, y);

//accel, decel and max speed
aSpeed		= 0.2;
dSpeed		= 0.5;
hMaxSpeed	= 3;
vMaxSpeed	= 3;
clampSpeed = function(_horizontal = hMaxSpeed, _vertical = vMaxSpeed)
{
	motion.y = clamp(motion.y, -_vertical, _vertical);
	motion.x = clamp(motion.x, -_horizontal, _horizontal);
}

groundAccel = 0.2;
groundDecel = 0.25;
airAccel	= 0.15;
airDecel	= 0.10;
crouchDecel = 0.075;

// Dash
dashDir 		= new Vector2(InputManager.horizontalInput, InputManager.verticalInput);
ghostDashTimer	= new Timer();
dashPower		= 8;
dashCountMax	= 5;
dashCount		= dashCountMax;
smtDashCount	= dashCount;
dashDur 		= 15;
dashTween		= new TweenV2(tweenType.QUARTEASEOUT);
isDashing		= false;

// Jump 
jPower			= -3;
jumps			= 0;
jumpsMax		= 1;
bufferCounter	= 0;
bufferMax		= 8;
coyoteCounter	= 0;
coyoteMax		= 6;
doubleJump		= false;
landed			= false;
canJump 		= false;

// Pack
packPower		= new Vector2(0, 0);
packPowerMax	= -0.25;
gasMax			= 128;
gas 			= gasMax;
gasBar			= new GuiBar(gas / gasMax);
gasTimer		= new Timer();

//control point variables
onGround	= false;
onWall		= false;
onCeiling	= false;
isTouching	= false;
checkCollisions = function()
{
	onGround	= place_meeting(x, y + 1, objBlock);
	onWall		= place_meeting(x + facing, y, objBlock);
	onCeiling	= place_meeting(x, y - 1, objBlock);
	isTouching	= onGround || onWall || onCeiling;
}
applyGravity = function()
{
	if (!onGround) 
	{
		motion.add(grav);
	}
}
#endregion //--------------------------------------------------------------------------------------------------------------------------------------------

#region STATE
state = new SnowState("normal");

state.history_enable();
state.set_history_max_size(15);
state.event_set_default_function("draw", function() {
		draw_circle(x, y, 10, true);
});
state.event_set_default_function("step", function() {
		show("i am in step event");
		position.set(x, y);
});

state.add("normal", {
	enter: function() {},
	step: function()
	{
	#region MOVEMENT
	if (InputManager.keyLeft)
	{
	    motion.x = approach(motion.x, -hMaxSpeed, aSpeed);
	    facing = -1;
	}
	else if (InputManager.keyRight)
	{
	    motion.x = approach(motion.x, hMaxSpeed, aSpeed);
	    facing = 1;
	}
	else
	{
	    motion.x = approach(motion.x, 0, dSpeed);
	}
	//calculating aSpeed and dSpeed
	if (onGround == true)
	{
	    aSpeed = groundAccel;
	    dSpeed = groundDecel;
	}
	else
	{
	    aSpeed = airAccel;
	    dSpeed = airDecel;
	}
	#endregion
	#region JUMPING
	//Coyote time
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
	if (InputManager.keySpace and canJump and coyoteCounter > 0)
	{
	    motion.y += jPower;
	    canJump = false;
	    //some jump effects(create if its on ground)
	    if (onGround) part_particles_create_color(global.partSystem, x, y, global.ptDirt, image_blend, choose(1, 2, 3));
	    squash_stretch(0.7, 1.3);
	}
	//to prevent the jump loop by holding down the key(canJump used for this)
	else if (!InputManager.keySpace and onGround == true)
	{
	    canJump = true;
	}
	//jump buffer
	if (InputManager.keySpacePressed)
	{
	    bufferCounter = bufferMax;
	}
	if (bufferCounter > 0)
	{
	    bufferCounter -= 1;
	    if (onGround == true)
	    {
		    bufferCounter = 0;
		    motion.y = jPower;
		    //some jump effects 2
		    part_particles_create(global.partSystem, x, y, global.ptDirt, choose(1, 2, 3));
		    squash_stretch(0.7, 1.3);
	    }
	}
	
	//double jump section
	if (jumps > 0 and InputManager.keySpacePressed and doubleJump)
	{
	    //reduce jumps variable by 1 every step
	    jumps -= 1;
	    motion.y = jPower;
	    squash_stretch(0.7, 1.3);
	}
	else if (onGround == true)
	{
	    //set jumps variable to jumpsMax if it's on ground
	    jumps = jumpsMax;
	}
	//variable jump height
	if (onGround == false)
	{
	    if (motion.y < 0 and!InputManager.keySpace && !InputManager.keyAlt)
	    {
		    //if InputManager.keySpace is not pressed, slow down by 50 percent
		    motion.y *= 0.7;
	    }
	}
	//landed
	if (onGround == true)
	{
	    if (landed == false)
	    {
		    //to track "just landed on ground" moment
		    landed = true;
	    }
		dashCount = dashCountMax;
	}
	else
	{
	    //set landed back to false if it is on air
	    landed = false;
	}
	#endregion
	#region FLYING
	if (InputManager.keyAlt)
	{
	    if (gas > 0)
	    {
			gas--;
			gasTimer.startRt(0.05, true);
			gasTimer.onTimeout(function() {
				part_particles_create(global.partSystem, x + random_range(-8, 8), y + sprite_yoffset, global.ptDashPixels, 1);
			});
			packPower.set(packPower.x, approach(packPower.y, packPowerMax, 0.0075));
		    if (onCeiling) packPower = 0; // If head hits roof, cut the power
		}
		else
		{
			packPower.set(packPower.x, approach(packPower.y, 0, 0.05));
		}
	}
	else
	{
		gasTimer.reset();
	    packPower.set(packPower.x, approach(packPower.y, 0, 0.05));
	    gas	= onGround ? gasMax : gas;
	}
	motion.add(packPower);
	motion.add(grav);
	//#endregion
	#region SWITCHNG
	if (InputManager.keyShiftPressed)
	{
		if (dashCount > 0)
		{
		    state.change("dash", function()
			{
			    if (InputManager.horizontalInput == 0 && InputManager.verticalInput == 0)
			    {
			        dashDir.set(facing, 0);
			    }
			    else
			    {
			        dashDir.set(InputManager.horizontalInput, InputManager.verticalInput);
			    }
			    isDashing = true;
				dashCount--;
		    });
		}
	}
	#endregion
	clampSpeed(hMaxSpeed, vMaxSpeed);
	motion.set(clamp(motion.x, -hMaxSpeed, hMaxSpeed), clamp(motion.y, -vMaxSpeed, vMaxSpeed));
	}
});
state.add("crouch", {
	enter: function() 
	{
		// Code here
	},
	step: function() 
	{
		// Code here	
	}
});

state.add("dash", {
	enter: function() 
	{
		// Code here
		ghostDashTimer.start(dashDur/4);
		dashTween.start(0, dashPower, dashDur);
		dashDir.normalize();

	},
	step: function()
	{
		motion.set(lengthdir_x(dashTween.value, dashDir.get_direction()), lengthdir_y(dashTween.value, dashDir.get_direction()));
		ghostDashTimer.onTimeout(function()
		{
			part_particles_create(global.partSystem, x, y, global.ptGhostDash, 1);
			ghostDashTimer.reset();
		});
		show_debug_message(dashTween.value);
		//if dashTween.value == 0 show_message("done");
		if (dashTween.done || (onWall && motion.x != 0))
		{
		    state.change("normal", function()
			{
				ghostDashTimer.stop();
			    dashTween.stop();
			    isDashing = false;
		    });
		}
		clampSpeed(dashPower, dashPower);
		motion.limit_magnitude(dashPower);
	}
});
#endregion //--------------------------------------------------------------------------------------------------------------------------------------------

Camera.following = self;

global.clock.variable_interpolate("x", "iotaX");
global.clock.variable_interpolate("y", "iotaY");

global.clock.add_cycle_method(function() {
	
});







