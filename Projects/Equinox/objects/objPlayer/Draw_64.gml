//Draw the fuel tank
//Variables
//var tankx	= 10;
//var tanky	= 40;
//var tankw	= 48;
//var tankh	= 150;

//var rate = gas / gasMax;
//gasRate = lerp(gasRate, rate, 0.1);

//var tankl = GUI_H - tanky - gasRate * tankh - 1;		//-1 is a just a line at bottom of the tank

//var atank = rate < 0.4 ? abs(dsin(current_time)) * 0.8 : 0.8;


////Actual draw phase
//draw_set_alpha(atank);
//draw_set_color(c_white);



//draw_roundrect(tankx, GUI_H - tanky, tankw, tankl, false);
////draw_line_width(tankx + tankw + tankx, gh - tanky, tankx + tankw + tankx, gh - tanky - gasRate * tankh, 2);
////draw_text(tankx + tankw, gh - tanky - tankh, "100");

//draw_set_alpha(1);
//draw_set_color(c_white);

//gasBar.drawGui("vertical", gasBar.rate < 0.4 ? abs(dsin(current_time)) * 0.8 : 0.8, c_white, true);
//testbar.drawGui("vertical", gasBar.rate < 0.4 ? abs(dsin(current_time)) * 0.8 : 0.8, C_CRIMSON, true);
var bara = gas/gasMax < 0.4 ? abs(dsin(current_time)) * 0.8 : 0.8;


gasBar.draw(10, GUI_H - 40, 25, -150, "vertical", c_white, bara, true, true);
gasBar.draw(0, GUI_H, GUI_W, -3, "horizontal", C_CRIMSON, bara, false, false);
//drawBar(GUI_W, GUI_H, -3, -GUI_H, gasRate, "vertical", false, C_CRIMSON, bara, true, true, 0.05);
//drawBar(GUI_W, 0, -GUI_W, 3, gasRate, "horizontal", false, C_CRIMSON, bara, true, true, 0.05);
//drawBar(0, 0, 3, GUI_W, gasRate, "vertical", false, C_CRIMSON, bara, true, true, 0.05);






