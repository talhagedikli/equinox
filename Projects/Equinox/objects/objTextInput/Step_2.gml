/// @description 
if (output == undefined) exit;

// Get command name, type and value
var i = 1;
repeat(string_length(output)) {
    var c = string_char_at(output, i);

    if (c == " ") {
        command = string_copy(output, 1, i - 1);
        commlen = i - 1;
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

// Value setter
if (command != undefined)
    global.test[$ command] = value;
	
	
// Live variable tester
if (instance_exists(objPlayer)) {
	with (objPlayer) {
		hMaxSpeed	= get_val(hMaxSpeed,	"hmax");
		vMaxSpeed	= get_val(vMaxSpeed,	"vmax");
		gSpeed		= get_val(gSpeed,		"gspeed");
		gasMax		= get_val(gasMax,		"gasmax");
	}
	
		
}

//if (instance_exists(Camera)) {
//	with (Camera) {
//		defaultW	= get_val(defaultW,	"camw");
//		defaultH	= get_val(defaultH,	"camh");
//	}
		
//}



// Main commands
if (command == "show") {
    show_message(global.test[$ value]);
} else if (command == "room") {
    room_goto(value);
}

// Player commands
with(objPlayer) {
    if (other.command == "x") {
        x = other.type == str.digits ? other.value : x;
    } else if (other.command == "y") {
        y = other.type == str.digits ? other.value : y;
    }
}

// After using them set command name, type and value to default
if (command != undefined || commlen != undefined || type != undefined || value != undefined) {
    command = undefined;
    commlen = undefined;
    type = undefined;
    value = undefined;
}