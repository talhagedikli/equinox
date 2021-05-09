/// @func animation_end()
/// Mimpy didn't make it don't let him take credit
function animation_end() {
    return (image_index + image_speed*sprite_get_speed(sprite_index)/(sprite_get_speed_type(sprite_index)==spritespeed_framespergameframe? 1 : game_get_speed(gamespeed_fps)) >= image_number);    
}





