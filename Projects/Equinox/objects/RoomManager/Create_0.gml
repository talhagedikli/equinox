/// @description 
switched = false;
currentRoom = rTitle;

checkRoom = function()
{
	if (currentRoom != room) {
		currentRoom = room;
		return true;
	}
	return false;
};

//checkLeft = function() 
//{
//	if (global.midTransition && global.roomTarget != room) 
//	{
//		return true;
//	}
//	return false;
//};

//roomEnter = function (_func) 
//{
//	if (entered)
//	{
//		_func();
//	}
//};

//roomLeft = function (_func)
//{
//	if (global.roomSwitched)
//	{
//		_func();
//		global.roomSwitched = false;
//	}
	
//};

state = new SnowState(room_get_name(rTitle));
state
	.history_enable()
	.set_history_max_size(15)
	
	.add(room_get_name(rTitle), {	// ----------TITLE
	enter: function() 
	{
	},
	step: function()
	{
	},
	leave: function() 
	{
	}
})
	
	.add(room_get_name(rWorld), {	// ----------WORLD
	enter: function() 
	{
		//randomize();
		//while (!place_meeting(x, y, objBlock) && !place_meeting(x, y, objPlayer) && instance_number(objBlock) < 50 ) 
		//{
		//	var bl = instance_create_layer(irandom(room_width div 32) * 32, 
		//									irandom(room_height div 32) * 32, "Collisions", objBlock);
	
		//	bl.image_xscale = irandom_range(1, 4);
		//	bl.image_yscale = irandom_range(1, 4);
		//}
	},
	step: function()
	{

	},
	leave: function() 
	{
	}
})













