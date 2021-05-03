function hue_shift_rgb(_col, _shift){
///@description	Shifts hue of an rgb color even if the values are > 1
///				White is (1, 1, 1), not (255, 255, 255)!
///@param color_array[r|g|b[0-1+]] as an array with r, g & b
///@param shift[0-1]

var in_col  = _col;
var max_val = max(in_col[0], in_col[1], in_col[2]);

// normalize:
var out_col_array = [in_col[0] / max_val, in_col[1] / max_val, in_col[2] / max_val];

// make color and get hsv:
var out_col_rgb = make_color_rgb(out_col_array[0] * 255, out_col_array[1] * 255, out_col_array[2] * 255);
var hue = color_get_hue(out_col_rgb);
var sat = color_get_saturation(out_col_rgb);
var val = color_get_value(out_col_rgb);

// shift hue:
hue += _shift * 255;
if (hue > 255) hue -= 255;

// apply hue:
out_col_rgb = make_color_hsv(hue, sat, val);

// denormalize
var r = color_get_red(out_col_rgb) / 255;
var g = color_get_green(out_col_rgb) / 255;
var b = color_get_blue(out_col_rgb) / 255;

out_col_array = [r * max_val, g * max_val, b * max_val];

// return
return out_col_array;



}