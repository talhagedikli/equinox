//////////////////////////////////////////////////////////////////////////////////////////////////////////
global.signals = {};
function signal_join(_signal, _id = id, _data = undefined) {
	with (SignalManager) {
		var array = global.signals[$ string(_id)];
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
			global.signals[$ string(_id)] = array_create(1, _signal);
			//if (!is_undefined(_data)) array_push(array, _data);			
		}
	}
}

function signal_find(_signal, _id = id, _func) {
	with (SignalManager) {
		var array = global.signals[$ string(_id)];
		if (!is_array(array)) {
			return false;
			exit;
		}

		var i = 0; repeat (array_length(array)) {
			if (array[i] == _signal) {
				_func();
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
		var array = global.signals[$ string(_id)];
		if (!is_array(array)) exit;
		
		var i = 0; repeat (array_length(array)) {
			if (array[i] == _signal) {
				array_delete(global.signals[$ string(_id)], i, 1);	
				break;
			}
			i++;
		}
	}	
}

function signal_wipe(_id = id) {
	with (SignalManager) {
		if (global.signals[$ _id] != undefined) {
			variable_struct_remove(global.signals, _id);
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
		delete global.signals;
	}
}








