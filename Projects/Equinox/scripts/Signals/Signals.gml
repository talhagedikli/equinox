function createSignal(_signal, _id = id) {
	var safe = true;
	with (SignalManager) {
		var k = 0; repeat (array_length(main)) {
			if (main[k][0] == _id) {
				var i = 0; repeat (array_length(main[k][1])) {
					if (main[k][1][i] == _signal) {
						safe = false;
					}
					i++;
				}
			}
			k++;
		}
		if (safe) array_push(main, [_id ,[_signal]]);

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
	
function wipeSignal(_signal, _id = id) {
		with (SignalManager) {
			var k = 0; repeat (array_length(main)) {
				
				if (_id == main[k][0]) {
					var i = 0; repeat (array_length(main)) {
						if (main[k][1][i] == _signal) {
							array_delete(main, k, 1);
							break;
						}
						i++;
					}
				}
				k++;
			}
		}
}
	
