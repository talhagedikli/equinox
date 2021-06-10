// Tweens
function Tween(_type = tweenType.LINEAR) constructor { // Like EaseIn, QuartEaseOut etc..
	enum tweenType { // Channel indexes
		LINEAR,
		EASEIN,
		EASEINOUT,
		EASEOUT,
		CUBICEASEIN,
		CUBICEASEINOUT,
		CUBICEASEOUT,
		QUARTEASEIN,
		QUARTEASEINOUT,
		QUARTEASEOUT,
		EXPOEASEIN,
		EXPOEASEINOUT,
		EXPOEASEOUT,
		CIRCEASEIN,
		CIRCEASEINOUT,
		CIRCEASEOUT,
		BACKEASEIN,
		BACKEASEINOUT,
		BACKEASEOUT,
		ELASTICEASEIN,
		ELASTICEASEINOUT,
		ELASTICEASEOUT,
		BOUNCEEASEIN,
		BOUNCEEASEINOUT,
		BOUNCEEASEOUT,
		FASTTOSLOW,
		MIDSLOW
	}
	
	channel = animcurve_get_channel(acTweens, _type);
	time = 0;	
	value = 0;
	done = false;
	active = false;
	
	static evaluate = function(_start, _end, _duration, _loop = false) { // Duration in seconds
		//var points = channel.points;
		//var arrlen = array_length(points);
		//points[0].posx = 0;
		//points[0].value = _start;
		//points[arrlen - 1].posx = _duration*60;
		//points[arrlen - 1].value = _end;
		var rate = animcurve_channel_evaluate(channel, time/60);
		value = lerp(_start, _end, rate);
		active = true;
		
		if (!_loop) { // Non loop section
			time++;
			if (time >= _duration*60) {
				time = 0;
				done = true;
				active = false;
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
		active = false;
		done = true;
		exit;
	}
	
	static reset = function() {
		time = 0;
		value = 0;
		active = false;
		done = false;
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
