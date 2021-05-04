//camera
#macro VIEW view_camera[0]
#macro GUI_W display_get_gui_width()
#macro GUI_H display_get_gui_height()

enum states {
	//PLAYER
	normal,
	crouch,
	dash,
	grab,
	climb,
	
	rock,
	
	dead,
	stop,
	
	//ENEMY
	idle,
	chase,
	shoot,
	
	//BIRD
	vertwave,
	swappos,
	seek
}


#macro c_crimson	make_color_rgb(184, 15, 10)
#macro c_lmchiffon	make_color_rgb(255, 249, 204)

