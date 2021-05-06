/// @description 
///Text Input Step Script
//check if box is focused
if (focus = true) {
	//if is focused, check for user hitting enter to stop input
     //Get input up to max characters.
	if (string_length(keyboard_string) < maxCharacters) 
		input = keyboard_string;
	else
		keyboard_string = input;
		
	 if (keyboard_check_pressed(vk_enter)) {
		 focus	= false;
		 output = string_copy(input, 1, maxCharacters);
		 input = "";
		 keyboard_string = input;
		 show_message(output);
	 }
}

if (keyboard_check_pressed(vk_tab)) { focus = !focus };
 
 if (focus) { 
	 global.control = false;
	 cursor = current_time/100 mod 10 > 5 ? "|" : "";
	 alpha	= lerp(alpha, 0.8, 0.1);
	 if (keyboard_check_pressed(vk_escape)) { focus = false };
	 

} else { 
	 global.control = true 
	 cursor = "";
	 alpha	= lerp(alpha, 0.2, 0.1);
	 //keyboard_string = "";
	 input	= "";
	 keyboard_string = input;
}
 
