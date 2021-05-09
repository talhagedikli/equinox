/// @description Display the bar and input text
// Draw bar
draw_set_alpha(barAlpha);
draw_set_color(c_dkgray);
typeBar.drawGui("horizontal", barAlpha, c_dkgray);

// Draw the last input
if (lastInput != undefined) {
	fadeX = lerp(fadeX, fadeXMax, 0.2);
	draw_set_alpha(fadeTimer / fadeMax * barAlpha);
	draw_set_color(c_white);
	draw_set_font(fntText);
	draw_text(fadeX, textY, lastInput);
	
	if (fadeX == fadeXMax) fadeTimer -= 0.5;
	
}

// Draw input
draw_set_alpha(barAlpha);
draw_set_color(c_white);
draw_set_font(fntText);
draw_text(textX, textY, input + cursor);

// Reset vars
draw_set_alpha(1);
draw_set_color(c_white);