// Invader for Game Boy with C using GBDK library
// Started 9/1/2021
// Brian Kumanchik


// Notes: Game Boy resolution = 160 x 144


// to do: random invader X after blast


// includes
#include <gb/gb.h>
#include <stdio.h>
#include <rand.h> // needed to use random number function
#include <stdbool.h> // needed to use type bool
#include <gb/font.h>
#include <gb/console.h> // needed to use HUD

// include sprite c file
#include "sprites_turret.c"
#include "sprites_invader.c"


// variables ----------------------------------------------------------------------
// turret variables
int turret_x = 84;  // turret starting x
int turret_y = 125; // turret starting y
bool shot_fired = false; // turret fired state
int sx = -20; // turret shot starting x - off screen
int sy = -20; // turret shot starting y - off screen
bool turret_been_hit = false;
int turret_blast_delay = 60; // keep blast active on screen for 50 frames
int turret_exp_frame = 1; // turret explode start animation frame
int turret_anim_delay = 10; // turret explode animation delay
bool explosion_play = false; 

// invader variables
int invader_x = 85; // invader starting x
int invader_y = 40; // invader starting y
int i_anim_delay = 20; // invader animation (and move) delay
int inv_frame = 1; // invader start animation frame
int ix_speed = 2; // march speed
int i_dir = 1; // 1 = right, 0 = left
int rand_x; // random x for invader restart
// shoot variables
int inv_shot_x = 165; 
int inv_shot_y = 144; 
int inv_fire_pause = 180;
bool inv_fired = false; // invader fired state
// explode variables
bool been_hit = false;  // invader hit state
int bx = 165; // blast x
int by = 144; // blast y
int blast_delay = 60; // invader blast delay - pause after explosion
bool boom_play = false; 

// starting score, lives and game state
int score = 0;
int lives = 3;
bool game_over = false;
bool been_pressed = false; //has fire button been pressed



// my functions --------------------------------------------------------------------

// function to move and animate invader        
void move_anim_inv() { 
    i_anim_delay -=1;

    if(i_anim_delay < 0) {
        i_anim_delay = 20;

        inv_frame += 1;        
        if (inv_frame > 2) {
            inv_frame = 1;
        }

        if(!(been_hit)) {
            // move right
            if ((i_dir == 1) && (invader_x <= 144)) {
                invader_x += ix_speed;
                if (invader_x >= 144) {                    
                    invader_y += 4; // step down
                    i_dir = 0;
                }
            }        
            // move left
            if ((i_dir < 1) && (invader_x >= 24)) {
                invader_x -= ix_speed;
                if (invader_x <= 24) {                    
                    invader_y += 4; // step down
                    i_dir = 1;           
                }
            }
        }        
    }
    
    if (!(been_hit)) {
        if(inv_frame == 1) {
            set_sprite_tile( 8, 16);
            set_sprite_tile( 9, 18);             
        }
        else if(inv_frame == 2) {
            set_sprite_tile(8, 20);
            set_sprite_tile(9, 22);             
        }
    }
    else {
        set_sprite_tile(8, 24);
        set_sprite_tile(9, 26); 
    }    
    
    move_sprite(8, invader_x, invader_y);
    move_sprite(9, invader_x + 8, invader_y);
}


// function to make invader fire
void invader_fire() {    
    inv_fire_pause -= 1;

    if (!(inv_fired)) { // so once invader shot is fired it doesn't follow the invader still
        inv_shot_x = invader_x;
        inv_shot_y = invader_y;
    }
    
    if (inv_fire_pause < 0) {
        inv_fired = true;
        inv_shot_y += 3;            
    }
}    


// function to make turret explode (when hit) then start back in center
void turret_hit() {    
    if (turret_been_hit) {
        if (!(explosion_play)) {                
            // play sound explosion 
            NR41_REG = 0x09;  
            NR42_REG = 0xF1; 
            NR43_REG = 0x81;  
            NR44_REG = 0xC0;  
        }

        explosion_play = true;        
        turret_anim_delay -= 1;
        turret_blast_delay -= 1;

        if (turret_anim_delay < 0) {
            turret_exp_frame += 1;
            if (turret_exp_frame > 2) {
                turret_exp_frame = 1;                
            }
            turret_anim_delay = 10;  
        }

        if (turret_blast_delay < 0) {
            turret_blast_delay = 60;
            turret_been_hit = false;                 
            explosion_play = false;
            turret_x = 84; // reset turret x
            turret_y = 125; // reset turret y
        }
    }
}


// function to make invader explode (when hit) then randomly start somewhere else
void invader_hit() {
    if (been_hit) {
        if (!(boom_play)) {
            // play sound boom 
            NR41_REG = 0x00;  
            NR42_REG = 0x92; 
            NR43_REG = 0x4f;  
            NR44_REG = 0xC0; 
        }               

        inv_shot_x = 165; // hide shot
        inv_shot_y = 144; // hide shot
        inv_fire_pause = 180; // and reset pause
        
        boom_play = true;        
        blast_delay -= 1;

        if (blast_delay < 0) {
            blast_delay = 60;
            boom_play = false;
            been_hit = false;
            bx = 165; // move boom off screen (following invader)
            by = 144;
            //(rand() % (upper - lower + 1)) + lower            
            //invader_x = rand() % (144 - 24 + 1) + 24; // move invader to random x position    
            invader_x = 85; // move invader back up after being hit        
            invader_y = 40; // move invader back up after being hit
        }
    }
}



// main----- ----------------------------------------------------------------------
void main() {
    // font setup 
    font_t main_font;
    font_init();
    main_font = font_load(font_min);
    //main_font = font_load(font_ibm);
    font_set(main_font);

    
    // sound setup
    NR52_REG = 0x80;    // $80 is 1000 0000 in binary and turns on sound
    NR50_REG = 0x77;    // $77 is 0111 0111 in binary and sets the volume for both left and right channel just set to max 0x77
    NR51_REG = 0xFF;    // $FF is 1111 1111 in binary, select which chanels we want to use in this case all of them. 
                        // One bit for the L one bit for the R of all four channels

    
    
    // tells GBDK to load two 8x8 sprites at once, making one 8x16 tile
    SPRITES_8x16;


    // setup sprites 
    // turret sprites
    set_sprite_data(0, 16, sprites_turret); // starting at zero, push four 8x8 tiles from turret array into sprite data
    // ** turret (including explosion) is sprites 0 and 1 **
    // turret
    set_sprite_tile(0, 0);                  // set tile 0 to whatever sprite is in sprite number 0 in sprite data
    set_sprite_tile(1, 2);
    // tur_exp_a
    set_sprite_tile(2, 4);                  
    set_sprite_tile(3, 6);
    // tur_exp_a
    set_sprite_tile(4, 8);                  
    set_sprite_tile(5, 10);
    // ** shot is sprite 6 **
    // shot
    set_sprite_tile(6, 12);                  
    //set_sprite_tile(7, 14);

    // ** invader (including blast) is sprites 8 and 9 **
    // invader sprites
    set_sprite_data(16, 16, sprites_invader);
    // invader_a
    set_sprite_tile(8, 16);
    set_sprite_tile(9, 18);    
    // invader_b
    set_sprite_tile(10, 20);
    set_sprite_tile(11, 22);    
    // blast
    set_sprite_tile(12, 24);
    set_sprite_tile(13, 26);  
    // inv_shot is sprite 14 **  
    // ** inv_shot      
    set_sprite_tile(14, 28);
    //set_sprite_tile(15, 30); 

        
    // call SHOW_SPRITES to display sprites
    SHOW_SPRITES;
    
    

    // game loop -------------------------------------------------------------
    while(1) {
        // game over state ---------------------------------------------------
             
        
        if(game_over) {
            // draw text 
            gotoxy(1, 1);        
            printf("SCORE %d ", score);
            gotoxy(12, 1);
            printf("LIVES %d ", lives);
            gotoxy(5, 8);
            printf("GAME  OVER");


        // reset stuff            
            if(joypad() & J_START) {                    
                turret_x = 84;  // turret starting x
                turret_y = 125; // turret starting y
                invader_x = 85; // invader starting x
                invader_y = 40; // invader starting y
                i_dir = 1;      // 1 = right, 0 = left
                lives = 3; // reset lives
                score = 0; // reset score
                explosion_play = false; 
                turret_been_hit = false;  
                move_sprite(8, invader_x, invader_y);
                move_sprite(9, invader_x + 8, invader_y);             
                game_over = false; 
                gotoxy(5, 8);
                printf("          "); // removes "GAME OVER" text                                                             
            }
        }


        // game running state ---------------------------------------------------
        if(!(game_over)) {         
            // call function to move and animate invader   
            move_anim_inv(); 

            // call function to make invader fire
            invader_fire();      

            // call function to make invader explode then randomly start somewhere else
            invader_hit(); 

            // call function to make turret explode (when hit) then start back in center
            turret_hit();
        

            // move and fire turret                  
            // check joypad Right
            if(joypad() & J_RIGHT && !(turret_been_hit)) {            
                if(turret_x < 142) {
                    turret_x += 1; 
                }                      
            }  
            // check joypad Left
            if(joypad() & J_LEFT && !(turret_been_hit)) {            
                if(turret_x > 21) {
                        turret_x -= 1; 
                }                 
            } 
            // check joypad A button             
            if(joypad() & J_A && !(been_pressed) && !(shot_fired) && !(turret_been_hit)) {                 
                // play sound - pew 
                NR41_REG = 0x07;  
                NR42_REG = 0x72; 
                NR43_REG = 0x21;  
                NR44_REG = 0xC0;  

                been_pressed = true;
                shot_fired = true;               
                sx=turret_x;
                sy=turret_y + 6;
            }
            if(!(joypad() & J_A)) {
                been_pressed = false; // fixes autofire, also with line below...
            }
            

            // check for turret shot going off screen before allowing to fire again
            if (shot_fired) {
                sy -= 3;             

                if (sy < 41) {                    
                    if(!(been_pressed)) { // ...here!
                        shot_fired = false;
                    }
                    sx = 165;
                    sy = 0;
                }
            }


            // check for invader shot going off screen before allowing to fire again
            if (inv_shot_y > 131
            ) {
                inv_fired = false;
                inv_shot_x = invader_x;
                inv_shot_y = invader_y;
                inv_fire_pause = 90;
            }
            
            
            // check for turret shot and invader collision            
            if ((sx + 6 >= invader_x) && (sx + 6 <= invader_x + 10) && (sy + 4 <= invader_y + 8)) {
                sx = 165;
                sy = 0;
                been_hit = true;
                score += 10; 
            }


            // check for invader shot and turret collision
            if ((inv_shot_x + 6) >= (turret_x) && (inv_shot_x + 4) <= (turret_x + 12) && (inv_shot_y + 6) >= (turret_y + 9)) {
                if (!(turret_been_hit)) {
                    lives -= 1;
                    
                    if (lives == 0) {  
                        // play sound explosion 
                        NR41_REG = 0x09;  
                        NR42_REG = 0xF1; 
                        NR43_REG = 0x81;  
                        NR44_REG = 0xC0;  

                        game_over = true;                                                  
                    }
                turret_been_hit = true;            
                }    
            }
            

            // draw some of the sprites
            // - invader shot
            if (inv_fired) {
                //DrawTexture(inv_shot, inv_shot_x, inv_shot_y, WHITE); 
                move_sprite(14, inv_shot_x, inv_shot_y);    // draw sprite 14 to these coordinates                  
            }
            else {
                //DrawTexture(inv_shot, -32, -32, WHITE);
                move_sprite(14, 165, 144);                  // draw sprite 14 to these coordinates                 
            }    

            // - turret - normal
            if (!(turret_been_hit)) {
                set_sprite_tile(0, 0);
                set_sprite_tile(1, 2);            
            }
            // - turret - exploding
            else {
                // - turret explosion a
                if (turret_exp_frame == 1) {               
                    set_sprite_tile(0, 4);
                    set_sprite_tile(1, 6); 
                }
                // - turret explosion b
                else if (turret_exp_frame == 2) {                
                    set_sprite_tile(0, 8);
                    set_sprite_tile(1, 10); 
                }
            }        
            move_sprite(0, turret_x, turret_y);     // draw sprite 0 to these coordinates
            move_sprite(1, turret_x + 8, turret_y); // draw sprite 1 to these coordinates

            // - turret shot        
            move_sprite(6, sx, sy); // draw sprite 6 to these coordinates


            // draw text 
            gotoxy(1, 1);        
            printf("SCORE %d ", score);
            gotoxy(12, 1);
            printf("LIVES %d ", lives);
            //gotoxy(5, 8);
            //printf("          "); // removes "GAME OVER" text
            
            
            wait_vbl_done(); // helps keep framerate
        }
    }
}





//printf( "Hello World" );        
// printf( "Frame = %d", inv_frame );    