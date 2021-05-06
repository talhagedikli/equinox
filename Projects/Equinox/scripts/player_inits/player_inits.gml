/// @description
//checks every frame (step event)
function player_buttons_init()
{
	keyLeft			= keyboard_check(vk_left)				or gamepad_button_check(0,gp_padl);
	keyRight		= keyboard_check(vk_right)				or gamepad_button_check(0,gp_padr);
	keyUp			= keyboard_check(vk_up)					or gamepad_button_check(0,gp_padu);
	keyDown			= keyboard_check(vk_down)				or gamepad_button_check(0,gp_padd);
	
	keyJumpPressed	= keyboard_check_pressed(vk_space)		or gamepad_button_check_pressed(0,gp_face1);
	keyJump			= keyboard_check(vk_space)				or gamepad_button_check(0,gp_face1);
	
	keyGrab			= keyboard_check(vk_lalt)				or gamepad_button_check(0,gp_shoulderrb);
	
	keyLeftPressed	= keyboard_check_pressed(vk_left)		or gamepad_button_check_pressed(0,gp_padl);
	keyRightPressed	= keyboard_check_pressed(vk_right)		or gamepad_button_check_pressed(0,gp_padr);
	keyUpPressed	= keyboard_check_pressed(vk_up)			or gamepad_button_check_pressed(0,gp_padu);
	keyDownPressed	= keyboard_check_pressed(vk_down)		or gamepad_button_check_pressed(0,gp_padd);
	
	
	keyDashPressed	= keyboard_check_pressed(vk_lshift) 	or gamepad_button_check_pressed(0,gp_face3);
	
	keyVPressed		= keyboard_check_pressed(ord("V"))		or gamepad_button_check_pressed(0,gp_face4);
	
	mouseLPressed	= mouse_check_button_pressed(mb_left);
	mouseRPressed	= mouse_check_button_pressed(mb_right);
	
	keyAlt			= keyboard_check(vk_alt);
	
}

