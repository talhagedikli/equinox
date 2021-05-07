/// @description 
if (output == undefined) exit;

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

if (output != undefined) output = undefined;
with (objPlayer) {
	if (other.command == "gspeed") {
		gSpeed	= other.type == str.digits ? other.value : gSpeed;
	} else if (other.command == "mspeed") {
		mSpeed	= other.type == str.digits ? other.value : mSpeed;	
	} else if (other.command == "gas") { 
		gasMax		= other.type == str.digits ? other.value : gasMax;
		gas			= gasMax;
	}
}










