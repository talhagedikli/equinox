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
	time	= 0;
	value	= 0;
	done	= false;
	active	= false;
	wait	= false;
	sTime	= undefined;
	
	reverse = false;
	
	static fstart = function(_start, _end, _duration, _loop = false) { // Duration in frames

		if (active == false) {
			done	= false;
			time	= 0;
			active	= true;
		}
		var rate	= animcurve_channel_evaluate(channel, time / _duration); //  / (_duration * 60)
		value		= lerp(_start, _end, rate);
		time++;
		//var rate	= animcurve_channel_evaluate(channel, time / _duration); //  / (_duration * 60)
		//value		= lerp(_start, _end, rate);
		if (!wait) {
			if (!_loop) { // Non loop section

				if (time > _duration) { // (_duration * 60)
					done	= true;
					active	= false;
					exit;
				}
			} else { // Loop section
				if (time >= _duration * 60) reverse = true;
				else if (time <= 0) reverse = false
				if (reverse) time--;
				else time++;
			}
		}
	}
	
	static sstart = function(_start, _end, _duration, _loop = false) { // Duration in seconds
		var sec = current_time * 0.001;
		if (active == false) {
			done	= false;
			time	= 0;
			sTime	= sec;
			active	= true;
		}
		
		if (!wait) {
			if (!_loop) { // Non loop section
				time		= normalize(sec, sTime, sTime + _duration);				
				var rate	= animcurve_channel_evaluate(channel, time); //  / (_duration * 60)				
				value		= lerp(_start, _end, rate);
				value		= clamp(value, _start, _end);
				if (time >= 1) { // Timeout
					sTime	= undefined
					done	= true;
					active	= false;
					exit;
				}

				
			} else { // Loop section
				time = abs(sin((((sec - sTime) + _duration) / _duration) * (pi)));
				//var t = sec mod (sTime + _duration);
				var rate	= animcurve_channel_evaluate(channel, time); //  / (_duration * 60)
				value		= lerp(_start, _end, rate);

			}
		}
	}
	
	static stop = function() {
		time	= 0;
		sTime	= undefined;
		value	= 0;
		active	= false;
		done	= true;
		wait	= false;
	}
	
	static reset = function() {
		time	= 0;
		sTime	= undefined;
		value	= 0;
		done	= false;
		wait	= false;
		active	= false; 
	}
	
	static pause = function() {
		wait	= true;
	}
	
	static resume = function() {
		wait	= false;	
	}
	
}



