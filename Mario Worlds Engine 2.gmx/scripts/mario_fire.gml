///mario_fire();

/*
**  Name:
**      mario_fire();
**
**  Function:
**      Handles animation of Mario when he has the fire powerup
*/

//Handle shooting animation.
firing--;
if (special < 0)
    special++;

//If Mario is not holding anything.
if (!holding) {

    //If Mario is not sliding down a slope.
    if (sliding == false) {
    
        //If Mario is kicking something.
        if (kicking == false) {
        
            //If Mario is using the special firing attack.
            if (special > 0) {
            
                //Set the sprite
                sprite_index = spr_mario_fire_shoot2;
                
                //Prevent movement
                disablegrav = 1;
                hspeed = 0;
                vspeed = 0;
                
                //Animate
                image_speed = 0.3;
                if (special == 1) {
                
                    if (image_index != 0) {
                    
                        image_index = 0;
                        special = 2;
                    }
                }
            }

            else {
                
                //If Mario is not moving.
                if (state == cs_state_idle) {
                
                    //If Mario is shooting a fireball.
                    if (firing > 0) {
                    
                        //Do not animate
                        image_speed = 0;
                        image_index = 0;
                        
                        //Set the shooting sprite
                        sprite_index = spr_mario_fire_shoot;
                    }
                
                    else {
                
                        //Do not animate.
                        image_speed = 0;
                        image_index = 0;
                        
                        //Set the idle sprite.
                        sprite_index = spr_mario_fire_walk;
                    }
                }
                
                //Otherwise, if Mario is moving.
                else if (state == cs_state_walk) {
                        
                    //If Mario's vertical speed is lower than -0.1 and Mario is facing right.
                    if (hspeed < -0.1) 
                    && (xscale == 1)
                    && (sliding == false)
                    && (swimming == false) 
                    && (!collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom,obj_slippery,0,0)) {
                    
                        //Do not animate
                        image_speed = 0;
                        image_index = 0;
                    
                        //Set the turning sprite.
                        sprite_index = spr_mario_fire_skid;
                    }
                    
                    //If Mario's vertical speed is greater than 0.1 and Mario is facing left.
                    else if (hspeed > 0.1) 
                    && (xscale == -1)
                    && (sliding == false)
                    && (swimming == false)
                    && (!collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom,obj_slippery,0,0)) {
                    
                        //Do not animate
                        image_speed = 0;
                        image_index = 0;
                                    
                        //Set the turning sprite.
                        sprite_index = spr_mario_fire_skid;
                    }
                
                    else { //Otherwise, execute this.
                    
                        //If Mario is running.
                        if (run) {
                
                            //Set the walking sprite.
                            sprite_index = spr_mario_fire_run;
                        }
                        else { //Otherwise, If Mario is not running.
                
                            //Set the running sprite.
                            sprite_index = spr_mario_fire_walk;
                        }
                        
                        //Set the animation speed.
                        if (!collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom,obj_slippery,0,0))
                            image_speed = 0.065+abs(hspeed)/7.5;
                        else
                            image_speed = 0.130+abs(hspeed)/7.5;
                    }
                }
                
                //Otherwise, if Mario is doing his trademark pose.
                else if (state == cs_state_jump) {
                
                    //If Mario is not swimming.
                    if (!swimming) {
                    
                        //If Mario is spinning
                        if (spin) {
                        
                            //Animate
                            image_speed = 0.5;
                            
                            //Set the spinning sprite.
                            sprite_index = spr_mario_fire_spin;
                        }
                        else {
                    
                            //If Mario is running.
                            if (run) {
                            
                                //Do not animate.
                                image_speed = 0;
                                image_index = 0;
                                
                                //Set the jumping sprite.
                                sprite_index = spr_mario_fire_runjump;                        
                            }
                            else {
                            
                                //Set the jumping sprite.
                                sprite_index = spr_mario_fire_jump;                               
                                
                                //Do not animate.
                                image_speed = 0;
                                if (vspeed < 0)
                                    image_index = 0;
                                else
                                    image_index = 1;                      
                            }
                        }
                    }
                    else {
                    
                        //Set the swimming sprite
                        sprite_index = spr_mario_fire_swim;
                    
                        //Animate
                        if (vspeed >= 0) {
                        
                            //Do not animate
                            image_speed = 0;
                            image_index = 0;
                        }
                        else
                            image_speed = 0.15;
                    }
                }
                
                //Otherwise, if Mario is climbing
                else if (state == cs_state_climb) {
                    
                    //If Mario is climbing a la SMB3 / SMW
                    if (climbstyle == 0) {
                        
                        //If Mario is not moving.
                        if (speed == 0) {
                        
                            //Do not animate
                            image_speed = 0;
                            image_index = 0;
                            
                            //Reset temporary variable
                            noise = 0;
                        }
                        
                        //If Mario is moving.
                        else if (speed != 0) {
                        
                            //Animate
                            image_speed = 0.15;
                            
                            //Increment noise and play a sound when noise hits 7.
                            if (!place_meeting(x,y,obj_climb_net)) {
                            
                                if (vspeed < 0) {
                            
                                    noise++;
                                    if (noise >= 8) {
                                    
                                        //Reset noise.
                                        noise = 0;
                                        
                                        //Play 'Climb' sound
                                        audio_play_sound(snd_climb,0,0);                
                                    }
                                }
                                else {
                                
                                    //Reset noise.
                                    noise = 0;
                                }
                            }
                        }
                        
                        //Set the climbing pose.
                        sprite_index = spr_mario_fire_climb;
                    }
                    
                    //Otherwise, if Mario is climbing a la SMB1
                    else if (climbstyle == 1) {
                    
                        //Set the alt. climbing pose.
                        sprite_index = spr_mario_fire_climbalt;
                    
                        //If Mario is not moving
                        if (vspeed == 0) {
                        
                            //Do not animate
                            image_speed = 0;
                            image_index = 0;
                        }
                        else
                            image_speed = 0.2;
                    }
                }
            }
        }
        else { //Otherwise if it's kicking something.
        
            //Do not animate.
            image_speed = 0;
            image_index = 0;            
            
            //If Mario has kick something.
            if (kicking == 1) {
                            
                //Set the kicking pose.
                sprite_index = spr_mario_fire_kick;
            }
            
            //Otherwise, if Mario has tossed something.
            else if (kicking == 2) {
            
                //Set the tossing pose.
                sprite_index = spr_mario_fire_toss;
            }
        }
    }
    else { //Otherwise, if Mario is sliding down a slope.
    
        //Do not animate.
        image_speed = 0;
        image_index = 0;
        
        //Set the kicking pose.
        sprite_index = spr_mario_fire_slide;    
    }
}

//Otherwise, if Mario is holding something at his front.
else if (holding == 1) {

    //If Mario is not moving.
    if (state == cs_state_idle) {
    
        //Do not animate.
        image_speed = 0;
        image_index = 0;
    }
    
    //If Mario is moving.
    else if (state == cs_state_walk) {
        
        //If Mario is not turning.
        if (turning) {
        
            //Do not animate.
            image_speed = 0;
            image_index = 0;
        }
        else {
        
            //Set the animation speed.
            if (!collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom,obj_slippery,0,0))
                image_speed = 0.065+abs(hspeed)/7.5;
            else
                image_speed = 0.130+abs(hspeed)/7.5;
        }
    }
    
    //If Mario is doing his trademark pose.
    else if (state == cs_state_jump) {
    
        //Do not animate.
        image_speed = 0;
        if (!swimming) //If Mario is not swimming.
            image_index = 1;
        else {
        
            if (vspeed < 0)
                image_speed = 0.15;
            else {
            
                //Do not animate
                image_speed = 0;
                image_index = 0;
            }
        } 
    }
    
    //Set up the sprite
    if (state < cs_state_jump) { //If Mario is not swimming.
    
        if (!turning)
            sprite_index = spr_mario_fire_hold;
        else if (turning) {
        
            sprite_index = spr_mario_fire_spin;
        }
    }
    
    //Otherwise, if Mario is jumping / swimming.
    else if (state == cs_state_jump) {
    
        //If Mario is not swimming.
        if (!swimming)
            sprite_index = spr_mario_fire_hold;
        else
            sprite_index = spr_mario_fire_holdswim;
    }
}

//Otherwise, if Mario is holding on his head.
else if (holding == 2) {

    //If Mario is not moving.
    if (state == cs_state_idle) {
    
        //Do not animate.
        image_speed = 0;
        image_index = 0;
    }
    
    //If Mario is moving.
    else if (state == cs_state_walk) {
            
        //Set the animation speed.
        if (!collision_rectangle(bbox_left,bbox_bottom,bbox_right,bbox_bottom,obj_slippery,0,0))
            image_speed = 0.065+abs(hspeed)/7.5;
            
        //Otherwise, if it's swimming.
        else
            image_speed = 0.130+abs(hspeed)/7.5;
    }
    
    //If Mario is doing his trademark pose.
    else if (state == cs_state_jump) {
    
        //Do not animate.
        image_speed = 0;
        if (!swimming) //If Mario is not swimming.
            image_index = 1;
        else {
        
            if (vspeed < 0)
                image_speed = 0.15;
            else {
            
                //Do not animate
                image_speed = 0;
                image_index = 0;
            }
        } 
    }
    
    //Set up the sprite
    if (state < cs_state_jump) //If Mario is not swimming.
        sprite_index = spr_mario_fire_carry;
    
    //Otherwise, if Mario is jumping / swimming.
    else if (state == cs_state_jump) {
    
        //If Mario is not swimming.
        if (!swimming)
            sprite_index = spr_mario_fire_carry;
            
        //Otherwise, if it's swimming.
        else
            sprite_index = spr_mario_fire_carryswim;
    }
}

//Set the mask
mask_index = spr_playermask_big;

//Play a skid sound when Mario is turning directions.
if (sprite_index == spr_mario_fire_skid) {

    if (!skidnow) {
    
        //Prevent sound clipping
        skidnow = true;
    
        //Loop 'skid' sound.
        audio_play_sound(snd_skid, 0, 1);
    }
}
else {

    //Restart sound.
    skidnow = false;
    
    //Stop 'skid' sound.
    audio_stop_sound(snd_skid);
}
