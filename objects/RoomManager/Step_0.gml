switched = checkRoom();

if (switched)
{
	state.change(room_get_name(room));
	currentRoom = room;	
}

state.step();

///// @description 
//left	= checkLeft();
//entered = checkRoom();
//if (currentRoom != room)
//{
//	state.change(room_get_name(room));
//	currentRoom = room;
//}



//if (room == rTitle) 
//{ // TITLE ROOM
//	roomEnter(function() 
//	{ 
//		show("title");
//	});
	
//	roomLeft(function()
//	{
//		show("exited title");	
//	});
	
//}
//else if (room == rWorld) { // WORLD ROOM
//	roomEnter(function() 
//	{ 
//		randomize();
//		while (!place_meeting(x, y, objBlock) && !place_meeting(x, y, objPlayer) && instance_number(objBlock) < 50 ) 
//		{
//			var bl = instance_create_layer(irandom(room_width div 32) * 32, 
//											irandom(room_height div 32) * 32, "Collisions", objBlock);
	
//			bl.image_xscale = irandom_range(1, 4);
//			bl.image_yscale = irandom_range(1, 4);
//		}
//		show("world");
//	});
	
//	roomLeft(function()
//	{
//		show("exited world");	
//	});
//}




