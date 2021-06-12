 //animation
 animation_init();
enum states {
	//PLAYER
	normal,
	crouch,
	dash
	
}

//state
state	= states.normal;

//speed variables
xSpeed			= 0;
ySpeed			= 0;
gSpeed			= 0.06;
facing			= 1;



//accel, decel and max speed
aSpeed			= 0.2;
dSpeed			= 0.5;
hMaxSpeed		= 2.5;
vMaxSpeed		= 2.5;
clampSpeed		= function(_horizontal = hMaxSpeed, _vertical = vMaxSpeed) {
	ySpeed = clamp(ySpeed, -_vertical, _vertical);
	xSpeed = clamp(xSpeed, -_horizontal, _horizontal);		
}

groundAccel		= 0.1;
groundDecel		= 0.075;

airAccel		= 0.1;
airDecel		= 0.075;

crouchDecel		= 0.075;

//counters and buffers
dashDir			= new Dir();
ghostDashTimer	= new Timer();
dashPower		= 8;
dashDur			= 0.25 * 60;
dashTween		= new Tween(tweenType.QUARTEASEOUT);
isDashing		= false;

// Jump variables
jPower			= -2;
jumps			= 0;
jumpsMax		= 1;
bufferCounter	= 0;
bufferMax		= 8;

coyoteCounter	= 0;
coyoteMax		= 6;

doubleJump		= false;
landed			= false;
canJump			= false;

// Walljump
//grabCounter		= 0;
//grabMax			= 50;
//grabFallDown		= 20;

//Backpack
packPower		= 0;
//packPowerAccel	= 0;
//packPowerDecel	= 0;
packPowerMax	= 0.25;
gasMax			= 128;
gas				= gasMax;
gasRate			= gas/gasMax;
gasBar			= new GuiBar(gas/gasMax);

//control point variables
onGround		= false;
onWall			= false;
onCeiling		= false;
isTouching		= false;





