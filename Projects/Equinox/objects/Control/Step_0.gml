/// @description 
if (InputManager.keyRPressed) { game_restart() };
if (InputManager.keyEscPressed) { game_end() };

if instance_exists(objPlayer) {
		if (getSignal("Landed", objPlayer.id)) {
		game_restart();
	}
}