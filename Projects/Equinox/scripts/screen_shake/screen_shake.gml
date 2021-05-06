/// @function                   screenshake(_time, _magnitude, _fade);
/// @param  {real}  _time       The length of time - in steps - to shake the screen
/// @param  {real}  _magnitude  The amount of screenshake to apply
/// @param  {real}  _fade       How quickly the screenshake effect will fade out
/// @description    Set the screenshake object variables.
//for in game
function screen_shake(_time, _magnitude, _fade){
	with (Camera)
	{
	    shake = true;
	    shake_time = _time;
	    shake_magnitude = _magnitude;
	    shake_fade = _fade;
	}
}

///APPLY SCREEN SHAKE IN CAMERA OBJECT
//for camera
function apply_screen_shake(){
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