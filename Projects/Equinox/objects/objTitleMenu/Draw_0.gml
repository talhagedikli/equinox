/// @description 
if keyboard_check_pressed(vk_shift) {
	menuLevel = menuLevel == 0 ? 1 : 0;
}


var length = array_length(menu[menuLevel]);


var i = 0; repeat (length) {
	
	draw_text(x, y + i*(string_height("TEST") + 1), menu[menuLevel][i]);
	
	
	i++;	
}