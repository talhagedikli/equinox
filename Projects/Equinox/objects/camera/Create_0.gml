//width and height 480*270
viewWidth		=	1920/4;
viewHeight		=	1080/4;
windowScale		=	2;

following		= objPlayer;

//spd variables
followSpd		= 0.2;
zoomSpd			= 0.05;

//its for cell camera
camXStart		= camera_get_view_x(VIEW);

//cam width and height
defaultW = viewWidth;
defaultH = viewHeight;

//first set to default
camW = defaultW;
camH = defaultH;

//to switch target
newW = 0;
newH = 0;

//camera target
if (instance_exists(following)) {
	targetX	= following.x - camW/2;
	targetY	= following.y - camH/2;
}
//set window size
window_set_size(viewWidth*windowScale, viewHeight*windowScale);
alarm[0] = 1;

//re-set surface and gui 
surface_resize(application_surface, viewWidth*windowScale, viewHeight*windowScale);
display_set_gui_size(viewWidth * windowScale, viewHeight * windowScale);


//shake
shake			= false;
shake_time		= 0;
shake_magnitude = 0;
shake_fade		= 0;

//enums 
enum camStates {
	normal,
	cell,
	zoom
}

// Methods
apply_screen_shake = function () {
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


