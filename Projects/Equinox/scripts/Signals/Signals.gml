//////////////////////////////////////////////////////////////////////////////////////////////////////////

function emitSignal(_signal, _id = id) {
	with (SignalManager) {
		var array = mainList[$ string(_id)];
		var safe = true;
		if (is_array(array)) {
			
			var i = 0; repeat(array_length(array)) {
				if (array[i] == _signal) {
					safe = false;
					break;
				}
				i++;
			}
			
			if (safe) array_push(array, _signal);

		} else {
			mainList[$ string(_id)] = array_create(1, _signal);
		}
	}
}

function findSignal(_signal, _id = id) {
	with (SignalManager) {
		var array = mainList[$ string(_id)];
		if (is_array(array) == false) break;

		var i = 0; repeat (array_length(array)) {
			if (array[i] == _signal) {
				return true;
			}
			
			i++;
		}
		return false;
		
	}
}
	
function wipeSignal(_signal, _id = id) {
	with (SignalManager) {
		var array = mainList[$ string(_id)];
		if (is_array(array) == false) break;
		
		var i = 0; repeat (array_length(array)) {
			if (array[i] == _signal) {
				array_delete(mainList[$ string(_id)], i, 1);	
				break;
			}
			
			i++;
		}
	}	
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////
#region OLD SIGNAL CODE
/* OLD SIGNAL CODE
function createSignal(_signal, _id = id) {
	var safe = true;
	var index = noone;
	with (SignalManager) {
		var k = 0; repeat (array_length(main)) {
			if (main[k][0] == _id) {
				index = k;
				var i = 0; repeat (array_length(main[k][1])) {
					if (main[k][1][i] == _signal) {
						safe = false;
					}
					i++;
				}
			}
			k++;
		}
		if (safe) {
			array_push(main, [_id ,[_signal]]);
		}
	}		
}
	
function getSignal(_signal, _id = id) {
	with (SignalManager) {
		var k = 0; repeat (array_length(main)) {
			if (main[k][0] == _id) {
				var i = 0; repeat (array_length(main[k][1])) {
					if (main[k][1][i] == _signal) return true;
					i++;
				}
				return false;
			}
			k++;
		}
	}
}
	
function eraseSignal(_signal, _id = id) {
	var safe = true;
	with (SignalManager) {
		var k = 0; repeat (array_length(main)) {
			if (main[k][0] == _id) {
				var i = 0; repeat (array_length(main[k][1])) {
					if (main[k][1][i] == _signal) {
						array_delete(main[k][1], i, 1);		
						if (array_length(main[k][1]) < 1) array_delete(main[k], 1, 1);
						safe = false;
						break;

					}
					i++;
				}
			}
			if (!safe) break;
			k++;
		}

	}
}
*/
#endregion
