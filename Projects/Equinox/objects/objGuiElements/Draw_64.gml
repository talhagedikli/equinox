#region TESTING VARIABLES
//names




//test[13][0] = "name";
//test[13][1] = myArray[@ 0];

//test[14][0] = "dmg ";
//test[14][1] = myArray[@ 1];




#region DISPLAY VARIABLES AND NAMES
//set font
draw_set_font(fntWriter);
//array length
var _arrayL = array_length(test);

//where to draw
//var _guiW = display_get_gui_width();
//var _guiH = display_get_gui_height();

//x and y margins
var _yM = 16;
var _xM = 16;

//creating string width and height
var _sH = 0;
var _sW1 = 0;
var _sW2 = 0;

var _totalW = 0;


var _x = _xM;
var _y = _yM;

//calculating max string height
var i = 0; repeat (_arrayL)
{
	var _h1 = string_height(string(test[i][0]));
	var _h2 = string_height(string(test[i][1]));
	if (_h1 > _h2)	{ _sH = _h1; }
	else			{ _sH = _h2; }
	i++;
}

//calculating string width of names
var i = 0; repeat (_arrayL)
{
	var _l1 = string_width(string(test[i][0]));
	if (_l1 > _sW1) { _sW1 = _l1; }
	i++;
}

//calculating max string width of values
var i = 0; repeat (_arrayL)
{
	var _l2 = string_width(string(test[i][1]));
	if (_l2 > _sW2) { _sW2 = _l2; }
	i++;
}

//calculating max rectangle's x and y values
var i = 0; repeat (_arrayL)
{
	var _l2 = string_width(string(test[i][1]));
	if (_l2 > _sW2) { _sW2 = _l2; }
	i++;
}


//background rect
_totalW = _xM + _sW1 + 6*_xM;
draw_set_alpha(0.5);
draw_set_color(c_black);
draw_rectangle(0, 0, _totalW, 2*_yM + _arrayL*_sH, false);
draw_set_alpha(1);
draw_set_color(c_white);

//draw text names
var i = 0; repeat (_arrayL)
{
	draw_text(_x, _y + (_sH * i), string(test[i][0]));
	i++;
}

//draw text values
var _x2 = _xM + _sW1 + _xM;

var i = 0; repeat (_arrayL)
{
    draw_text(_x2, _y + (_sH * i), ": " + string(test[i][1]));
	i++
}

#endregion

#endregion

#region BLACK BARS - DRAW_GUI(out)
/*
//variables
var _b = c_black;
var _w = c_white

//var _guiW = display_get_gui_width();
//var _guiH = display_get_gui_height();

//var _gapYOne = abs(targetYOne - yOne);
//var _gapYTwo = abs(targetYTwo - yTwo);


//DRAW BARS
if (global.createBars)
{
	//switch targets
	targetYOne = yUpTwo;
	targetYTwo = yDownTwo;
	
	//create bars
	draw_set_color(_b);
	draw_rectangle(xOne, yUpOne,	xTwo, yOne, false);
	draw_rectangle(xOne, yDownOne,	xTwo, yTwo, false);
	draw_set_color(_w);
	
	
}
else
{
	//switch targets
	targetYOne = yUpOne;
	targetYTwo = yDownOne;
	
	//bars fade out
	draw_set_color(_b);
	draw_rectangle(xOne, yUpOne,	xTwo, yOne, false);
	draw_rectangle(xOne, yDownOne,	xTwo, yTwo, false);
	draw_set_color(_w);
	
	//after it reaches to 0, destroy the bars that created
	//it may create a couple of bars but it destroys itself in a second 
	//NOTE: no need to destroy it, we just have one already(guiElemets)

}

//apply target to dynamic variables
yOne = lerp(yOne, targetYOne, 0.1);
yTwo = lerp(yTwo, targetYTwo, 0.1);
*/
#endregion

