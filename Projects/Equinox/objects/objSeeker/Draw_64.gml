//Draw the fuel tank
var bara = gas/gasMax < 0.4 ? abs(dsin(current_time)) * 0.8 : 0.8;
gasBar.update(gas / gasMax, true).draw(10, GUI_H - 40, 25, -150, "vertical", c_white, bara, true, true);
gasBar.draw(0, GUI_H, GUI_W, -3, "horizontal", C_CRIMSON, bara, false, false);

smtDashCount = flerp(smtDashCount, dashCount, 0.2);
var i = 0; repeat(round(smtDashCount))
{
	CleanCircle(15 + i * 15, 15, 5).Blend(c_white, 0.8).Draw();
	i++;
}

	
	     



