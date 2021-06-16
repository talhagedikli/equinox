//width and height 480*270
viewWidth		=	1920/4;
viewHeight		=	1080/4;
windowScale		=	2;

camera_set_view_size(VIEW, viewWidth, viewHeight);

following		= objPlayer;

//spd variables
followSpd		= 0.1;
zoomSpd			= 0.05;

//cam width and height
defaultW = viewWidth;
defaultH = viewHeight;

//first set to default
camW = defaultW;
camH = defaultH;

camX = camera_get_view_x(VIEW);
camY = camera_get_view_y(VIEW);

//to switch target
newW = 0;
newH = 0;

//camera target
if (instance_exists(following)) 
{
	targetX	= following.x - camW/2;
	targetY	= following.y - camH/2;
}
//set window size
window_set_size(viewWidth*windowScale, viewHeight*windowScale);
alarm[0] = 1;

//re-set surface and gui 
surface_resize(application_surface, viewWidth*windowScale, viewHeight*windowScale);
display_set_gui_size(viewWidth*windowScale, viewHeight*windowScale);

viewSurf	= -1;
smooth		= false;

application_surface_enable(!smooth);
//shake
shake			= false;
shake_time		= 0;
shake_magnitude = 0;
shake_fade		= 0;

//enums 
enum camStates 
{
	normal,
	cell,
	zoom
}

// Methods
applyScreenShake = function () 
{
	if (shake)
	{
		//reduce shake time by 1(every step)
		shake_time -= 1;
			
		//calculate shake magnitude
		var _xval = choose(-shake_magnitude, shake_magnitude); 
		var _yval = choose(-shake_magnitude, shake_magnitude);
			
		//apply the shake
		camX = camX + _xval;
		camY = camY + _yval;
			
		if (shake_time <= 0) 
		{
			//if shake time is zero, shake fade
			shake_magnitude -= shake_fade; 

			if (shake_magnitude <= 0) 
			{
				//if shake fade is zero, turn shake of
			    shake = false; 
			} 
		}
	}
	
}

updateCameraSize = function (_w, _h) 
{
	camW = flerp(camW, _w, zoomSpd);
	camH = flerp(camH, _h, zoomSpd);
}

//state = new SnowState("normal");

//state.history_enable();
//state.set_history_max_size(5);

//state.add("normal", {
//	enter: function()
//	{
		
//	},
//	step: function()
//	{
		
//	}
	
	
//});

//state.add("cell", {
//	enter: function()
//	{
		
//	},
//	step: function()
//	{
		
//	}	
	
	
//});

//state.add("zoom", {
//	enter: function()
//	{
		
//	},
//	step: function()
//	{
		
//	}	
	
	
//});







