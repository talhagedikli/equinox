
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





