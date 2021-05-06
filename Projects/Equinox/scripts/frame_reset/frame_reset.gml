/// @description
function frame_reset(){
	if(floor(frame) >= sprite_get_number(sprite))
	{
	    frame = 0;
	}

}
