#region//macros
//camera
#macro VIEW view_camera[0]
#macro GUI_W display_get_gui_width()
#macro GUI_H display_get_gui_height()


#endregion

#region//enums
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
#endregion

