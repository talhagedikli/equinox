//////////////////////////////////////////////////////////////////////////////////////////////////////////
global.signals = {};

function signal_join(_signal, _id = id)
{
	var array = global.signals[$ string(_id)];
	var safe = true;
	if (is_array(array))
	{
		// Check if array has the signal already
		var i = 0;
		repeat(array_length(array))
		{
			if (array[i] == _signal)
			{
				safe = false;
				break;
			}
			i++;
		}
		if (safe) 
		{
			array_push(array, _signal);
		}

	}
	else
	{
		// If array does not exist, create it
		global.signals[$ string(_id)] = array_create(1, _signal);
		array = global.signals[$ string(_id)];
		//if (!is_undefined(_data)) array_push(array, _data);			
	}
	if (signal_find(_signal, _id))
	{
		var i = 2; repeat (argument_count - 2) 
		{
			array_push(array, argument[i]);
			i++;
		}			
	}
}

function data_to_arg()
{
	argument[0] = 5;
	show(argument[0]);
}

function signal_find(_signal, _id = id, _func = function(data = []) { 
	if (array_length(data) != 0)
	{
		var j = 0; repeat (array_length(data))
		{
			argument[j] = data[j];
			j++;
		}
	}	
})
{
	var array = global.signals[$ string(_id)];
	data = [];
	if (!is_array(array))
	{
		return false;
		exit;
	}
	var i = 0;
	repeat(array_length(array))
	{
		if (array[i] == _signal)
		{
			data = [];
			var j = 1; repeat (array_length(array) - 1)
			{
				array_push(data, array[j]);
				j++;
			}
			//var run = function(data)
			//{
			//	var k = 0; repeat (array_length(data))
			//	{
			//		argument[k] = data[k];
			//		k++;
			//	}
			//	show_message(argument[0]);
			//	//var k = 0; repeat (argument_count - 1)
			//	//{
			//	//	show_message(argument[k]);	
			//	//	k++;
			//	//}
			//}
			_func(data);
			return true;
		}
		i++;
	}
	return false;
}

function signal_leave(_signal, _id = id)
{
	var array = global.signals[$ string(_id)];
	if (!is_array(array)) exit;
	var i = 0;
	repeat(array_length(array))
	{
		if (array[i] == _signal)
		{
			array_delete(global.signals[$ string(_id)], i, 1);
			break;
		}
		i++;
	}
	if (array_length(global.signals[$ string(_id)]) <= 0) signal_wipe(_id);
}

function signal_wipe(_id = id)
{
	if (global.signals[$ _id] != undefined)
	{
		variable_struct_remove(global.signals, _id);
	}
}

function signal_equal(_signal, _idone, _idtwo)
{
	if (signal_find(_signal, _idone) && signal_find(_signal, _idtwo))
	{
		return true;
	}
	return false;
}

function signal_clean()
{
	delete global.signals;
}