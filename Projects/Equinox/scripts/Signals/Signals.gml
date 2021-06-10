//////////////////////////////////////////////////////////////////////////////////////////////////////////
function signal_join(_signal, _id = id, _data = undefined) {
	with (SignalManager) {
		var array = mainList[$ string(_id)];
		var safe = true;
		if (is_array(array)) {
			// Check if array has the signal already
			var i = 0; repeat(array_length(array)) { 
				if (array[i] == _signal) {
					safe = false;
					break;
				}
				i++;
			}
			// If array does not have push the signal to array
			if (safe) array_push(array, _signal);
			//if (!is_undefined(_data)) array_push(array, _data);

		} else {
			// If array does not exist, create it
			mainList[$ string(_id)] = array_create(1, _signal);
			//if (!is_undefined(_data)) array_push(array, _data);			
		}
	}
}

function signal_find(_signal, _id = id) {
	with (SignalManager) {
		var array = mainList[$ string(_id)];
		if (!is_array(array)) {
			return false;
			exit;
		}

		var i = 0; repeat (array_length(array)) {
			if (array[i] == _signal) {
				return true;
			}
			i++;
		}
		return false;
	}
}

function signal_execute(_signal, _id = id, _func, _data = undefined) {
	with (SignalManager) {
		if (signal_find(_signal, _id)) {
			_func(_data);
		}
	}
}
	
function signal_leave(_signal, _id = id) {
	with (SignalManager) {
		var array = mainList[$ string(_id)];
		if (!is_array(array)) exit;
		
		var i = 0; repeat (array_length(array)) {
			if (array[i] == _signal) {
				array_delete(mainList[$ string(_id)], i, 1);	
				break;
			}
			i++;
		}
	}	
}

function signal_wipe(_id = id) {
	with (SignalManager) {
		if (mainList[$ _id] != undefined) {
			variable_struct_remove(mainList, _id);
		}
	}
}

function signal_equal(_signal, _idone, _idtwo) {
	with (SignalManager) {
		if (signal_find(_signal, _idone) && signal_find(_signal, _idtwo)) {
			return true;
		}
		return false;
	}
}

function signal_clean() {
	with (SignalManager) {
		delete mainList;
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
