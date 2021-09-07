//Invader PC CPP with Raylib Library
//started 03-29-2021
//Brian Kumanchik


/* #include "raylib.h"


// turret variables
int turret_x = 256 - 14; // turret starting x
int turret_y = 512 - 64; // turret starting y
bool shot_fired = false; // turret fired state
int sx = -20; // turret shot starting x - off screen
int sy = -20; // turret shot starting y - off screen
bool turret_been_hit = false;
int turret_blast_delay = 60; // keep blast active on screen for 50 frames
int turret_exp_frame = 1; // turret explode start animation frame
int turret_anim_delay = 10; // turret explode animation delay
bool explosion_play = false; 

// invader variables
int invader_x = 256 - 14; // invader starting x
int invader_y = 80;       // invader starting y
int i_anim_delay = 20; // invader animation (and move) delay
int inv_frame = 1; // invader start animation frame
int ix_speed = 6; // march speed
int i_dir = 1; // 1 = right, 0 = left
//// shoot variables
int inv_shot_x = -32; 
int inv_shot_y = -32; 
int inv_fire_pause = 180;
bool inv_fired = false; // invader fired state
//// explode variables
bool been_hit = false;  // invader hit state
int bx = -32; // blast x
int by = -32; // blast y
int blast_delay = 60; // invader blast delay - pause after explosion
bool boom_play = false; 

// starting score, lives and game state
int score = 0;
int lives = 3;
bool game_over = false;
//bool been_pressed = false; //has fire button been  */pressed


/* // function to move and animate invader
void move_anim_inv() {    
    // invader anim code 
    i_anim_delay -= 1;
    if ((i_anim_delay < 0) && !(been_hit)) {        
        i_anim_delay = 20;
        
        inv_frame += 1;
        if (inv_frame > 2) {
            inv_frame = 1;
        }
        
        // move right
        if ((i_dir == 1) && (invader_x <= 464)) {
            invader_x += ix_speed;
            if (invader_x > 464) {
                //ix_speed += 1; // speed up
                invader_y += 16; // step down
                i_dir = -1;
            }
        }        
        
        // move left
        if ((i_dir < 1) && (invader_x >= 16)) {
            invader_x -= ix_speed;
            if (invader_x < 21) {
                //ix_speed += 1; // speed up
                invader_y += 21; // step down
                i_dir = 1;           
            }
        }        
    }
} */


/* // function to make invader fire
void invader_fire() {    
    inv_fire_pause -= 1;

    if (!(inv_fired)) { // so once invader shot is fired it doesn't follow the invader still
        inv_shot_x = invader_x - 1;
        inv_shot_y = invader_y + 20;
    }
    
    if (inv_fire_pause < 0) {
        inv_fired = true;
        inv_shot_y += 7;
    }
} */


/* // function to make turret explode (when hit) then start back in center
void turret_hit() {    
    if (turret_been_hit) {
        if (!(explosion_play)) {            
            Sound explosionWav = LoadSound("sounds/explosion.wav");  
            PlaySound(explosionWav);  
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
            turret_x = 256 - 14; // reset turret x
            turret_y = 512 - 64; // reset turret y
        }
    }
} */


/* // function to make invader explode (when hit) then randomly start somewhere else
void invader_hit() {
    if (been_hit) {
        if (!(boom_play)) {
            Sound boomWav = LoadSound("sounds/boom.wav");  
            PlaySound(boomWav);
        }       
        
        inv_shot_x = -32; // hide shot
        inv_shot_y = -32; // hide shot
        inv_fire_pause = 90; // and reset pause
        
        boom_play = true;        
        blast_delay -= 1;

        if (blast_delay < 0) {
            blast_delay = 60;
            boom_play = false;
            been_hit = false;
            bx = -32; // move boom off screen (following invader)
            by = -32;
            invader_x = rand() % (464 - 16) + 4; // move invader to random x position
            invader_y = 80; // move invader back up after being hit
        }
    }
} */


// Main entry point
int main(void){
/*     // Initialization (x-size, y-size, window title) 
    InitWindow(512, 512, "Invader");
    
    // load sprites   
    // - turret
    Texture2D turret = LoadTexture("sprites/turret.png");  
    Texture2D tur_exp_1 = LoadTexture("sprites/tur_exp_1.png");  
    Texture2D tur_exp_2 = LoadTexture("sprites/tur_exp_2.png"); 
    Texture2D shot = LoadTexture("sprites/shot.png"); 
    
    // - invader
    Texture2D inv_a_1 = LoadTexture("sprites/inv_a_1.png"); 
    Texture2D inv_a_2 = LoadTexture("sprites/inv_a_2.png"); 
    Texture2D inv_shot = LoadTexture("sprites/inv_shot.png"); 
    Texture2D blast = LoadTexture("sprites/blast.png"); 
    
    
    // Initialize audio device    
    InitAudioDevice();       
    
    
    //int framesCounter = 0; // Useful to count frames, not sure if I need this
    SetTargetFPS(60); // Set framerate    
     */
    
    // Main game loop
    while (!WindowShouldClose()) // Detect window close button or ESC key
    {
        // game over state
        if (game_over) {
            BeginDrawing();                    
            ClearBackground(BLACK);
            
            // draw text during game over state               
            DrawText(TextFormat("SCORE: %i", score), 30, 20, 20, WHITE);               
            DrawText(TextFormat("LIVES: %i", lives), 394, 20, 20, WHITE); 
            DrawText(TextFormat("GAME OVER"), 256 - 60, 256 - 20, 20, WHITE);
            
            // draw sprites during game over state
            if (turret_exp_frame == 1) {
                DrawTexture(tur_exp_1, turret_x, turret_y, WHITE);
            }
            else if (turret_exp_frame == 2) {
                DrawTexture(tur_exp_2, turret_x, turret_y, WHITE);
            }
            if (inv_frame == 1) {
                DrawTexture(inv_a_1, invader_x, invader_y, WHITE);
            }   
            else if (inv_frame == 2) {
                DrawTexture(inv_a_2, invader_x, invader_y, WHITE);
            } 
            DrawTexture(inv_shot, inv_shot_x, inv_shot_y, WHITE); 
            
            // reset stuff
            if (IsGamepadButtonPressed(0, 6)) { // B     
                turret_been_hit = false;
                turret_x = 256 - 14;  // reset turret to center of screen
                turret_y = 512 - 64; // reset turret y
                invader_x = 256 - 14; // reset invader to center of screen
                invader_y = 80;   // reset invader back to top
                lives = 3; // reset lives
                score = 0; // reset score
                explosion_play = false;                
                game_over = false;                 
            }
            
            EndDrawing();
        }
        
        
        // game running state
        if (!(game_over)) {
            // Update - every frame  
            
            // call function to move and animate invader
            //move_anim_inv();
            
            // call function to make invader fire
            //invader_fire();
            
            // read gamepad
            // d-pad right
          /*   if (IsGamepadButtonDown(0, 2) && (turret_x < 464) && !(turret_been_hit)) { 
                turret_x += 3;
            }  
            // d-pad left
            if (IsGamepadButtonDown(0, 4) && (turret_x > 21) && !(turret_been_hit)) { 
                turret_x -= 3; 
            }       */  
            /* // A button
            if (IsGamepadButtonPressed(0, 7)  && !(shot_fired) && (!(turret_been_hit))) { 
                Sound pewWav = LoadSound("sounds/pew.wav"); 
                PlaySound(pewWav);            
                shot_fired = true;               
                sx=turret_x;
                sy=turret_y;
            } */
                   
                   
            /* // check for turret shot going off screen before allowing to fire again
            if (shot_fired) {
                sy -= 8; 
                if (sy < 80) {
                    shot_fired = false;
                    sx = -32;
                    sy = -32;
                }
            } */
            
            
            /* // check for invader shot going off screen before allowing to fire again
            if (inv_shot_y > 455
            ) {
                inv_fired = false;
                inv_shot_x = invader_x - 1;
                inv_shot_y = invader_y + 7;
                inv_fire_pause = 90;
            } */
            
            
            /* // check for turret shot and invader collision            
            if ((sx + 16 >= invader_x) && (sx + 10 <= invader_x + 28) && (sy <= invader_y + 27)) {
                sx = -32;
                sy = -32;
                been_hit = true;
                score += 10;
            } */
            
            
            /* // check for invader shot and turret collision
            ////if inv_shot_x+20 > tx and inv_shot_x+8 < tx+28 and inv_shot_y+24 > ty+16:
            if ((inv_shot_x + 20) >= (turret_x) && (inv_shot_x + 8) <= (turret_x + 28) && (inv_shot_y + 24) >= (turret_y + 16)) {
                if (!(turret_been_hit)) {
                    lives -= 1;
                    
                    if (lives == 0) {                    
                        game_over = true;                                                  
                    }
                turret_been_hit = true;            
                }    
            } */
            
            
            // Draw - every frame     
            /* BeginDrawing();                    
            ClearBackground(BLACK); */            
                
            
            // draw sprites
            // - turret          
            /* if (!(turret_been_hit)) {
                DrawTexture(turret, turret_x, turret_y, WHITE);
            } */
            // - turret explosion 1 & 2 
           /*  else {
                if (turret_exp_frame == 1) {
                    DrawTexture(tur_exp_1, turret_x, turret_y, WHITE);
                }
                else if (turret_exp_frame == 2) {
                    DrawTexture(tur_exp_2, turret_x, turret_y, WHITE);
                }
            } */
            // - turret shot
            //DrawTexture(shot, sx, sy, WHITE);
            
            /* // invader
            if (!(been_hit)) {
                if (inv_frame == 1) {
                    DrawTexture(inv_a_1, invader_x, invader_y, WHITE);
                }   
                else if (inv_frame == 2) {
                    DrawTexture(inv_a_2, invader_x, invader_y, WHITE);
                } 
            }
            else {
                DrawTexture(blast, invader_x, invader_y, WHITE);
            }
            
            // - invader shot
            if (inv_fired) {
                DrawTexture(inv_shot, inv_shot_x, inv_shot_y, WHITE);                    
            }
            else {
                DrawTexture(inv_shot, -32, -32, WHITE);                   
            }     */
            
            
            /* // call function to make invader explode then randomly start somewhere else
            invader_hit(); */
            
            /* // call function to make turret explode (when hit) then start back in center
            turret_hit(); */
            
            
            // draw text                
            /* DrawText(TextFormat("SCORE: %i", score), 30, 20, 20, WHITE);               
            DrawText(TextFormat("LIVES: %i", lives), 394, 20, 20, WHITE);                   

            
            EndDrawing();   */ 
        }
    }    
    
   
    // Close window and OpenGL context
   /*  CloseWindow();
    

    return 0;
} */


// if (IsKeyPressed(KEY_SPACE)) PlaySound(pewWav);

// if (IsGamepadButtonDown(0, 7)) DrawRectangle(292 + 44, 228, 26, 19, GREEN); // B

// DrawRectangle(0, 0, 512, 512, BLACK);