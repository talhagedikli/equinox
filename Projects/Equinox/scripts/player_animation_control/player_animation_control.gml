/// @description
function player_animation_control(){
	xScale = approach(xScale,1,0.03);
	yScale = approach(yScale,1,0.03);

	//animation control    
	switch state 
	{
	    case states.normal:
	        if (keyLeft)
			{
	            facing = -1;
	        }
			else if (keyRight)
			{
	            facing = 1;
	        }

        
	        if (onGround)
			{
	            if (keyLeft or keyRight)
				{
	                sprite = sprPlayerRun;
	            }
				else
				{
	                sprite = sprPlayerIdle;
	            }
	        }
			else
			{
	            sprite = sprPlayerIdle;
	            if (ySpeed < -1)
				{
	                frame = 2;
	            }
				else if (ySpeed > 1)
				{
	                frame = 1;
	            }
				else 
				{
	                frame = 0;
	            }
	        }
			
			/*/SOUND
			if (keyJump) 
			{
				if (!audio_is_playing(aJump))
				{
					audio_play_sound(aJump, 2, false);
				}
					
			}
			else 
			{
				audio_stop_sound(aJump);
			}*/
			
		break;

	    case states.crouch:
	        
			sprite = sprPlayerCrouch;
			
		break;
		
		case states.dash:
			/* çıkartıldı çünkü dash esnasında değişmemesi gerek(bunun yerine isDashing
			de olabilirdi)
			if (keyLeft)
			{
	            facing = -1;
	        }
			else if (keyRight)
			{
	            facing = 1;
	        }
			*/
			sprite = sprPlayerDash;
			
		break;
		
		case states.grab:
			if (keyJumpPressed)
			{
				facing = -facing;
			}
			
			sprite = sprPlayerIdle;
			frame = 2;
			
		break;
			
		case states.stop:
			sprite = sprPlayerIdle;
		
		break;

	}

	//reset frame to 0 if sprite changes
	if (lastSprite != sprite)
	{
	    lastSprite = sprite;
	    frame = 0;
	}

}