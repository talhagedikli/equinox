#region// Camera
#macro VIEW		view_camera[0]

#macro GUI_W	display_get_gui_width()
#macro GUI_H	display_get_gui_height()

#macro CAM_W	camera_get_view_width(VIEW)
#macro CAM_H	camera_get_view_height(VIEW)

#macro CAM_X	camera_get_view_x(VIEW)
#macro CAM_Y	camera_get_view_y(VIEW)

#macro APP_W	surface_get_width(application_surface)
#macro APP_H	surface_get_height(application_surface)

#macro WIN_W	window_get_width()							
#macro WIN_H	window_get_height()

#macro DIS_W	display_get_width()							// The actual width of the monitor
#macro DIS_H	display_get_height()						// The actual height of the monitor
#endregion

#region// Colours
#macro C_CRIMSON		make_color_rgb(184, 15, 10)
#macro C_LMCHIFFON		make_color_rgb(255, 249, 204)
#macro C_BARNRED		make_color_rgb(124, 10, 2)
#macro C_DARKCHARCOAL	make_color_rgb(51, 51, 51)					
#macro R_COLOR			make_colour_hsv(irandom(255), irandom(255), irandom(255))
#endregion

#region// Inputs
#macro RIGHT			keyboard_check(vk_right)
#macro UP				keyboard_check(vk_up)
#macro LEFT				keyboard_check(vk_left)
#macro DOWN				keyboard_check(vk_down)

#macro SPACE			keyboard_check(vk_space)
#macro ALT				keyboard_check(vk_alt)

#macro RIGHT_PRESSED	keyboard_check_pressed(vk_right)
#macro UP_PRESSED		keyboard_check_pressed(vk_up)
#macro LEFT_PRESSED		keyboard_check_pressed(vk_left)
#macro DOWN_PRESSED		keyboard_check_pressed(vk_down)

#macro SPACE_PRESSED	keyboard_check_pressed(vk_space)
#macro ALT_PRESSED		keyboard_check_pressed(vk_alt)
#endregion

#region// General 
#macro FLIP_COIN		choose(true, false)
#endregion



