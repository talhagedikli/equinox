/// @description  scaling fullscreen
if window_get_fullscreen()
{
	var _ww = window_get_width(); 
	var _wh = window_get_height(); 
	surface_resize(application_surface, _ww, _wh);
	display_set_gui_size(_ww, _wh);
}
else
{
	var _ww = window_get_width(); 
	var _wh = window_get_height(); 
	surface_resize(application_surface, _ww, _wh);
	display_set_gui_size(_ww, _wh);
}

