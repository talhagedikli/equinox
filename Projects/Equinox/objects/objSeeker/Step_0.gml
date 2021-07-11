checkCollisions();
	
state.step();
	
xScale = approach(xScale, 1, 0.03);
yScale = approach(yScale, 1, 0.03);
check_collisions_pixel_perfect();
xPos = x;
yPos = y;
position.set(x, y);
x = position.x;
y = position.y;

	