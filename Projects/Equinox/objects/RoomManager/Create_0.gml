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

characters = [
	objPlayer,
	objSeeker
];

character = noone;
charIndex = 0;

switchChar = function(_x, _y)
{
	if (InputManager.keyQPressed)
	{
		var i = 0; repeat(array_length(characters))
		{
			if instance_exists(characters[i])
			{
				with (characters[i])
				{
					other.character = self;
					break;
				}
			}
			i++;
		}
		if (character != noone)
		{
			var _charx	= character.x;
			var _chary	= character.y;
			var _motion	= character.motion;
		}
		else
		{
			var _charx = _x;
			var _chary = _y;
			var _motion = new Vector2(0, 0);
		}
		charIndex++;
		charIndex = charIndex mod (array_length(characters));
		if (!instance_exists(characters[charIndex]))
		{
			var i = 0; repeat(array_length(characters))
			{
				instance_destroy(characters[i]);
				i++;
			}
			character = instance_create_layer(_charx, _chary, "Player", characters[charIndex]);
			character.motion = _motion;
		}
		else
		{
			with (characters[charIndex])
			{
				other.character = self;
			}
		}
	}
}

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

	},
	step: function()
	{
		switchChar(125, 125);
	},
	leave: function() 
	{
	}
})













