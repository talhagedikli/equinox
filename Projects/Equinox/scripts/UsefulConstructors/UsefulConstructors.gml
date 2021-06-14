/// @description quick and dynamic guibar setup
function GuiBar(_rate = 1) constructor { // Makes a bar
	
	if (is_real(_rate)) smtRate = _rate;

	static step = function(rate = 1, lrp = true, lrpRate = 0.1) {
		if (is_real(rate))
			smtRate = lrp ? flerp(smtRate, rate, lrpRate) : rate;
	};
		
	static draw = function(x1, y1, width, height, type = "vertical", color = c_white, 
										alpha = 1, rounded = false, bottomline = false) {
		draw_set_alpha(alpha);
		draw_set_color(color);
		if (type == "vertical") { // 0 = vertical
			if (rounded) {
				draw_roundrect(x1, y1, x1 + width, 
					y1 + height * smtRate + (bottomline ? sign(height) : 0), false);
			} else { 
				draw_rectangle(x1, y1, x1 + width, 
					y1 + height * smtRate + (bottomline ? sign(height) : 0), false);
			}
		} else if (type == "horizontal") { // 1 = horizontal
			if (rounded) {
				draw_roundrect(x1, y1, 
					x1 + width * smtRate + (bottomline ? sign(width) : 0), y1 + height, false);
			} else { 
				draw_rectangle(x1, y1, 
					x1 + width * smtRate + (bottomline ? sign(width) : 0), y1 + height, false);
			}	
		
		}
		draw_set_alpha(1);
		draw_set_color(c_white);			
		
	};	
};

function Dir() constructor { // Finds x and y direction(like 0, 1 or -1) and angle
	angle	= undefined;
	x		= 0;
	y		= 0;
	
	static find = function(_hinput, _vinput) {
		angle = point_direction(0, 0, _hinput, _vinput);	
		x = _hinput;
		y = _vinput;
	};
};

function Timer() constructor { // For basic timer
	time	= 0;
	done	= false;
	active	= false;
	sTime	= undefined;
	
	static start = function(_duration = infinity) {
		if ((time < _duration) && !done) {
			time++;
			if (done == true) done = false;
			if (active == false) active = true;
		} else {
			done	= true;
			active	= false;
			exit;
		}
	};
	
	static sstart = function(_duration, _loop = false) { // Duration in seconds
		var sec = current_time * 0.001;
		if (sTime == undefined) sTime = sec;
		if (!_loop) {
			if (sec >= sTime + _duration) {
				done = true;
				active = false;
				exit;
			} else {
				done = false;
				active = true;
			}
		} else {
			active = true;
			if (sec >= sTime + _duration) {
				done	= true;
				sTime	= sec;
			} else {
				done = false;
			}
		}
	};
	
	static onTimeout = function(_func) {
		if (done) {
			_func();
		}
	};
	
	static reset = function() {
		time	= 0;
		sTime	= undefined;
		done	= false;
	};
	
	static stop = function() {
		time	= 0;
		sTime	= undefined;
		done	= true;
		active	= false;
		exit;
	};
	
};


























#region Old Functions
/// @description directly draw bar with it's rate
//function drawBar(x1, y1, width, height, rate = noone, type = "vertical", rounded = false, 
//								color = c_white, alpha = 1, bottomline = true, lrp = false, lrpRate = 0.1) {
//	static setRate = rate;
//	if (rate != noone) {
//		if (lrp) {
//			setRate = flerp(setRate, rate, lrpRate);	
//		}
//	}
	
//	draw_set_alpha(alpha);
//	draw_set_color(color);
//	if (type == "vertical") { // 0 = vertical
//		if (rounded) {
//			draw_roundrect(x1, y1, x1 + width, 
//				y1 + height * (setRate) + (bottomline ? sign(height) : 0), false);
//		} else { 
//			draw_rectangle(x1, y1, x1 + width, 
//				y1 + height * (setRate) + (bottomline ? sign(height) : 0), false);
//		}
//	} else if (type == "horizontal") { // 1 = horizontal
//		if (rounded) {
//			draw_roundrect(x1, y1, 
//				x1 + width * (rate == noone ? 1 : setRate) + (bottomline ? sign(width) : 0), y1 + height, false);
//		} else { 
//			draw_rectangle(x1, y1, 
//				x1 + width * (rate == noone ? 1 : setRate) + (bottomline ? sign(width) : 0), y1 + height, false);
//		}	
		
//	}
//	draw_set_alpha(1);
//	draw_set_color(c_white);	
//	//show_debug_message(setRate);
	
	
	
//};


#endregion


