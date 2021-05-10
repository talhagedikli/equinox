 //animation
animation_init();

enum states {
	//PLAYER
	normal,
	crouch,
	dash,
	grab,
	climb,
	
	rock,
	
	dead,
	stop,
}

//state
state	= states.normal;

//speed variables
xSpeed			= 0;
ySpeed			= 0;
gSpeed			= 0.05;

jPower			= -2;
jumps			= 0;
jumpsMax		= 1;

wallJumpX		= 3;
wallJumpY		= -5;

xDashPower		= 6;
yDashPower		= -5;
dashX			= 0;
dashY			= 0;

//accel, decel and max speed
aSpeed			= 0.2;
dSpeed			= 0.5;
hMaxSpeed		= 2.5;
vMaxSpeed		= 2.5;

//accels and decel variables
groundAccel		= 0.1;
groundDecel		= 0.1;

airAccel		= 0.1;
airDecel		= 0.075;

/* 
dashAccel		= 2;
dashDecel		= 2;
*/

//counters and buffers
dashCounter		= 0;
dashCounterMax	= 10;

bufferCounter	= 0;
bufferMax		= 8;

coyoteCounter	= 0;
coyoteMax		= 6;

doubleJump		= false;

grabCounter		= 0;
grabMax			= 50;
grabFallDown	= 20;

//Backpack
packPower		= 0;
packPowerAccel	= 0;
packPowerDecel	= 0;
packPowerMax	= 0.25;
gasMax			= 128;
gas				= gasMax;
gasRate			= gas/gasMax;

//control point variables
landed			= false;		//edited

onGround		= false;
onWall			= false;

canJump			= false;
//canGrab			= false;
canClimb		= false;
canDash			= false;

isDashing		= false;
//isClimbing		= false;


////Outline vars
//uniPixelW		= shader_get_uniform(shOutline, "pixelW");
//uniPixelH		= shader_get_uniform(shOutline, "pixelH");
//texelW			= texture_get_texel_width(sprite_get_texture(sprite_index, 0));
//texelH			= texture_get_texel_height(sprite_get_texture(sprite_index, 0));
//sLights			= shader_get_sampler_index(shOutline, "lights");//simpler2D exp

//tLight			= undefined;
//oLight			= noone;
//pLight			= undefined;

//gasBar			= new GuiBar;
//gasBar.create(10,			 GUI_H - 40, 25, -150);

//testbar			= new GuiBar;
//testbar.create(10 + 25 + 10, GUI_H - 40, 25, -150);












