// Tweens
function Tween(_type = type.LINEAR) constructor { // Like EaseIn, QuartEaseOut etc..
	enum tweenType { // Channel indexes
		LINEAR,
		EASEIN,
		EASEOUT,
		EASEINOUT,
		CUBICEASEIN,
		CUBICEASEOUT,
		CUBICEASEINOUT,
		QUARTEASEIN,
		QUARTEASEOUT,
		QUARTEASEINOUT
	}
	
	channel = animcurve_get_channel(acTweens, _type);
	time = 0;	
	value = 0;
	done = false;
	
	static evaluate = function(_start, _end, _duration, _loop = false) { // Duration in seconds
		channel.points[0].posx = 0;
		channel.points[0].value = _start;
		channel.points[1].posx = _duration*60;
		channel.points[1].value = _end;
		
		value = animcurve_channel_evaluate(channel, time);
		if (!_loop) { // Non loop section
			time++;
			if (time >= _duration*60) {
				time = 0;
				done = true;
				exit;
			}
		} else { // Loop section
			var reverse = false;
			if (time >= _duration*60) reverse = true;
			else if (time <= 0) reverse = false;
			
			if (reverse) time--;
			else time++;
		}
	}
	
	static stop = function() {
		time = 0;
		value = 0;
		done = false;
	}
	
	static remove = function() {
		delete id;	
	}
	

	
}

// Old evaluate
//static evaluate = function(_duration, _loop = false) { // Duration in seconds
//	var t = ((1/60) / _duration);
		
//	value = animcurve_channel_evaluate(channel, time);
//	if (time < 1) {
//		time += t;
//	} else {
			
//		if (_loop) {
				
				
//		} else {
//			time = 0;
//			done = true;
//			exit;
//		}
//	}
//}
