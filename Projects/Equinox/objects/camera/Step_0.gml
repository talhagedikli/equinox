/// @description  scaling fullscreen
//if window_get_fullscreen()
//{
//	var _ww = window_get_width(); 
//	var _wh = window_get_height(); 
//	surface_resize(application_surface, _ww, _wh);
//	display_set_gui_size(_ww, _wh);
//}
//else
//{
//	var _ww = window_get_width(); 
//	var _wh = window_get_height(); 
//	surface_resize(application_surface, _ww, _wh);
//	display_set_gui_size(_ww, _wh);
//}

if (WIN_W != APP_W || WIN_H != APP_H) {
	surface_resize(application_surface, view_wport[0], view_hport[0]);
}

if (WIN_W != GUI_W || WIN_H != GUI_H) {
	display_set_gui_size(view_wport[0], view_hport[0]);
}

