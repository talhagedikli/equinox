/// @description 
///Text Input Create Script
//input storage variable
input = "";
output = undefined;
//focus check bool
focus = false;
//string max characters
//this is set to 10 because that is the max the default 100px box will hold
//experiment with more or less characters depending on size
maxCharacters = 20;
alpha			= 1;

cursorTime = 0;
cursor = "|";
delay = 20;
//alarm[0] = delay;

command = undefined;
commlen = undefined;
value	= undefined;
lastInput = undefined;
fadeTimer	= 0;
fadeMax		= 40;
fadeX		= 15;