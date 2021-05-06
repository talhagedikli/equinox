global.zoom = false;
global.lastCamState = noone;
global.lastCamFollowing = noone;
///camera normal state
function camera_states_normal(){

}

///camera cell state
function camera_states_cell(){

}

function zoom_in(_target)
{

	with (Camera)
	{
		//save the latest following object and state before zooming
		global.lastCamFollowing = following;
		global.lastCamState		= state;
		//switch to zoom state and switch following object to zoom
		state		= cammodes.zoom;
		following	= _target;
	}
	//dummy - just keep that in zoom or not
	global.zoom = true;
	
}

function zoom_out()
{
	with (Camera)
	{
		//switch to oldest state and following object that you saved before
		state		= global.lastCamState;
		following	= global.lastCamFollowing;
	}
	//dummy - just keep that in zoom or not
	global.zoom = false;
}


	
