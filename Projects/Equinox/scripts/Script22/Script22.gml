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
