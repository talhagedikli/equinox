function set_val(key, value) {
	global.test[$ key] = value;
}

function get_val(variable, key) {
	static newvalue = undefined;
	var value = global.test[$ key];
	if (value == "undefined") value = undefined;

	newvalue = newvalue != value ? value : variable;
	
	if (global.test[$ key] != undefined)
		return newvalue;
	else 
		return variable;
	
}


enum str {
	digits,
	letters
}

function string_type(value){
    
	static digits = [0,1,2,3,4,5,6,7,8,9,"-"];
    for (var i = 0; i < array_length(digits); i++) {
        if(value = digits[i]) { return str.digits };
    }
    return str.letters;
}

