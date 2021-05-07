/// @description 
/// @description 
///On Text Input Draw
//draw a rectangle that represents the text box
//make sure that this rectangle and the collision one match up
var gap = 10;
var inW = 200;
var inH = 20;
var inX = gap;
var inY = GUI_H - gap - inH;
var strH = string_height("A");

draw_set_alpha(alpha);
draw_set_color(c_dkgray);
draw_roundrect(inX, inY, inX + inW, inY + inH, false);
//draw the text
if (lastInput != undefined) {
	fadeX = lerp(fadeX, inX + inW + gap/2, 0.2);
	draw_set_alpha(fadeTimer / fadeMax);
	draw_set_color(c_white);
	draw_set_font(fntText);
	draw_text(fadeX, inY + gap/3, lastInput);
	fadeTimer--;
}

//draw the text
draw_set_alpha(1);
draw_set_color(c_white);
draw_set_font(fntText);
draw_text(inX + gap/2, inY + gap/3, input + cursor);


draw_set_alpha(1);
draw_set_color(c_white);