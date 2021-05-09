/// @description 
///Text Input Create Script
//input storage variable
input			= "";
output			= undefined;
focus			= false;
maxCharacters	= 20;

// Bar variables
gap		= 10;
barW	= 200;
barH	= 20;
barX	= gap;
barY	= GUI_H - gap - barH;
textX	= barX + gap/2;
textY	= barY + gap/3;

typeBar = new GuiBar();
typeBar.create(10, GUI_H - 10, 200, -20);

// Cursor variables
barAlpha		= 1;
cursor			= "|";


// Command varialbes
command = undefined;
commlen = undefined;
value	= undefined;
type	= undefined;

// Last input
lastInput		= undefined;
fadeTimer		= 0;
fadeMax			= 20;
fadeX			= textX;
fadeXMax		= 215;

global.test		= {
	
};

// Player 
set_val("gasmax", undefined);
set_val("hmax", undefined);
set_val("vmax", undefined);
set_val("gspeed", undefined);

// Camera
set_val("camw", undefined);
set_val("camh", undefined);

















