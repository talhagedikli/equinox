global.createBars = false;
//global.destroyBars = false;
global.midBars = false;
//global.barsElement = noone;
//NORMAL BARS DRAWING
function create_bars()
{
	if (!global.midBars)
	{	
		instance_create_layer(x, y, "game", objBars);
		global.midBars = true;
		global.createBars = true;
	}

}

function destroy_bars()
{
	if (global.midBars)
	{
		global.createBars = false;
		global.midBars = false;
	}
	
}


/*/SEQUENCE BARS
function bars_in()
{
	if (layer_sequence_exists("game", sqBarsIn)) exit;
	var _cX = camera_get_view_x(VIEW);
	var _cY = camera_get_view_y(VIEW);
	global.barsElement = layer_sequence_create("game", _cX, _cY, sqBarsIn);
	global.midBars = true;
}

function bars_out()
{
	if (layer_sequence_exists("game", global.barsElement))
	{
		layer_sequence_destroy(global.barsElement);
		var _cX = camera_get_view_x(VIEW);
		var _cY = camera_get_view_y(VIEW);
		global.barsElement = layer_sequence_create("game", _cX, _cY, sqBarsOut);
	}
	
	
}*/

function delete_bars()
{
	global.midBars = false;
	layer_sequence_destroy(global.barsElement);
}
	

	
	
	
	
	