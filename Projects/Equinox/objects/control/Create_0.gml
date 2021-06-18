///Create Event of the controller object
global.clock	= new iota_clock();
global.clock.set_update_frequency(60);
time = 0;


global.clock.add_cycle_method(function()
{
	time++;
	//if time mod 60 == 0 show_message("1sec");
});
