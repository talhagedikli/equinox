/// @description  approach(start, end, shift);
/// @param start
/// @param  end
/// @param  shift
function approach(argument0, argument1, argument2) {

	if(argument0 < argument1){
	    return min(argument0 + argument2, argument1); 
	}else{
	    return max(argument0 - argument2, argument1);
	}



}

function normalize(value, min, max) {
	var normalized = (value - min) / (max - min);
	return normalized;
}

function string_type(value) {
	enum str {
		digits,
		letters
	}
    
	static digits = [0,1,2,3,4,5,6,7,8,9,"-"];
    for (var i = 0; i < array_length(digits); i++) {
        if(value = digits[i]) { return str.digits };
    }
    return str.letters;
}

function wave(_from, _to, _duration, offset) {
//Wave(from, to, duration, offset)
 
// Returns a value that will wave back and forth between [from-to] over [duration] seconds
// Examples
//      image_angle = Wave(-45,45,1,0)  -> rock back and forth 90 degrees in a second
//      x = Wave(-10,10,0.25,0)         -> move left and right quickly
 
// Or here is a fun one! Make an object be all squishy!! ^u^
//      image_xscale = Wave(0.5, 2.0, 1.0, 0.0)
//      image_yscale = Wave(2.0, 0.5, 1.0, 0.0)
 
var _a4 = (_to - _from) * 0.5;
return _from + _a4 + sin((((current_time * 0.001) + _duration * offset) / _duration) * (pi*2)) * _a4;

}

/// @param {real} time represents time what you need exp: current_time/1000
/// @description Puts sin function inside of abs function
function asin(time) {
	return abs(dsin(time));	
	
}

/// @param {real} time represents time what you need exp: current_time/1000
/// @description Puts cos function inside of abs function
function acos(time) {
	return abs(dcos(time));	
	
}

///Map(val, min1, max1, min2, max2)   
function remap(value, min1, max1, min2, max2) {
	/*      
	value = 110;      
	m = Map(value, 0, 100, -20, -10);      
	// m = -9      
	*/ 
	return min2 + (max2 - min2) * ((value - min1) / (max1 - min1));
}
	
/// @description
/// @description Chance(percent)
/// @param percent
function chance(_percent) {
	
	// Returns true or false depending on RNG
	// ex: 
	//		Chance(0.7);	-> Returns true 70% of the time
	return _percent > random(1);

}

/// @description quick and dynamic guibar setup
function makeGuiBar() constructor { #macro GuiBar makeGuiBar()
	
	static create = function(x1, y1, barw, barh){
		xone = x1;
		yone = y1;
		
		rate = 1;
		smtRate = rate;
	
		width = barw;
		height = barh;
	};
	
	static step = function(val, valMax) {
		rate = val / valMax;
		smtRate = lerp(smtRate, rate, 0.1);
	}
		
	static drawGui = function(type, alpha, color, bottomline) {
		draw_set_alpha(alpha);
		draw_set_color(color);
		if (type == "vertical")
			draw_roundrect(xone, yone, xone + width, 
							yone + height * smtRate + (bottomline ? sign(height) : 0), false);
		else if (type == "horizontal")
			draw_roundrect(xone, yone, 
							xone + width * smtRate + (bottomline ? sign(width) : 0), yone + height, false);

		draw_set_alpha(1);
		draw_set_color(c_white);
		
	};	
	
};

/// @description directly draw bar with it's rate
function drawBar(x1, y1, width, height, rate, type, rounded, color, alpha, bottomline, lrp, lrp_rate) {
	static setRate = 1;
	if (rate != noone) {
		setRate = lrp ? lerp(setRate, rate, lrp_rate) : rate;	
	}
	
	draw_set_alpha(alpha);
	draw_set_color(color);
	if (type == "vertical") {
		if (rounded) {
		draw_roundrect(x1, y1, x1 + width, 
			y1 + height * (rate == noone ? 1 : setRate) + (bottomline ? sign(height) : 0), false);
		} else { draw_rectangle(x1, y1, x1 + width, 
			y1 + height * (rate == noone ? 1 : setRate) + (bottomline ? sign(height) : 0), false);
		}
	} else if (type == "horizontal") {
		if (rounded) {
		draw_roundrect(x1, y1, 
			x1 + width * (rate == noone ? 1 : setRate) + (bottomline ? sign(width) : 0), y1 + height, false);
		} else { draw_rectangle(x1, y1, 
			x1 + width * (rate == noone ? 1 : setRate) + (bottomline ? sign(width) : 0), y1 + height, false);
		}	
		
	}
	draw_set_alpha(1);
	draw_set_color(c_white);		
	
	
	
};


	




