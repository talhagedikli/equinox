/// @description 
global.clock.tick();

if (room == rWorld)
{
	if (InputManager.keyQPressed)
	{
		var i = 0; repeat(array_length(characters))
		{
			instance_destroy(characters[i]);
			i++;
		}
		if (!instance_exists(characters[charIndex]))
		{
			player = instance_create_layer(player.x, player.y, "Player", characters[charIndex]);
		}
		else
		{
			player = characters[charIndex];
		}
		charIndex++;
	}
}
