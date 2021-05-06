//Draw the fuel tank
//Variables
var tankx	= 10;
var tanky	= 40;
var tankw	= 48;
var tankh	= 150;

var rate = gas / gasMax;
gasRate = lerp(gasRate, rate, 0.1);

var tankl = GUI_H - tanky - gasRate * tankh - 1;		//-1 is a just a line at bottom of the tank

var atank = rate < 0.5 ? abs(dsin(current_time))*0.8 : 0.8;


//Actual draw phase
draw_set_alpha(atank);
draw_set_color(c_white);



draw_roundrect(tankx, GUI_H - tanky, tankw, tankl, false);
//draw_line_width(tankx + tankw + tankx, gh - tanky, tankx + tankw + tankx, gh - tanky - gasRate * tankh, 2);
//draw_text(tankx + tankw, gh - tanky - tankh, "100");

draw_set_alpha(1);
draw_set_color(c_white);






