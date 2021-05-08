/// @description 
if (output == undefined) exit;

// Get command name, type and value
var i = 1; repeat (string_length(output)) {
	var c = string_char_at(output, i);
	
	if (c == " ") {
		command = string_copy(output, 1, i - 1);
		commlen	= i - 1;
		type = string_type(string_char_at(output, i + 1));
			
		if (type == str.digits) {
			value = real(string_copy(output, i + 1, maxCharacters));
		} else if (type == str.letters) {
			value = string_letters(string_copy(output, i + 1, maxCharacters));	
		}
	}
	i++;	
}

// After getting them set output to undefined
if (output != undefined) output = undefined;

// Value tester
if (command != undefined)
	global.test[$ command]		= value;

// Main commands
if (command == "show") {
	show_message(global.test[$ value]);
}
else if (command == "room_goto") {
	room_goto(value);
}

// Player commands
with (objPlayer) {
	if (other.command == "player_x") {
		x	= other.type == str.digits ? other.value : x;
	} 
	else if (other.command == "player_y") {
		y	= other.type == str.digits ? other.value : y;	
	}
}

// After using them set command name, type and value to default
if (command != undefined || commlen != undefined || type != undefined || value != undefined ) {
	command		= undefined;
	commlen		= undefined;
	type		= undefined;
	value		= undefined;
}









