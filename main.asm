;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12439 (MINGW32)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _invader_hit
	.globl _turret_hit
	.globl _invader_fire
	.globl _move_anim_inv
	.globl _gotoxy
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _printf
	.globl _set_sprite_data
	.globl _wait_vbl_done
	.globl _joypad
	.globl _game_over
	.globl _lives
	.globl _score
	.globl _blast_delay
	.globl _by
	.globl _bx
	.globl _been_hit
	.globl _inv_fired
	.globl _inv_fire_pause
	.globl _inv_shot_y
	.globl _inv_shot_x
	.globl _i_dir
	.globl _ix_speed
	.globl _inv_frame
	.globl _i_anim_delay
	.globl _invader_y
	.globl _invader_x
	.globl _explosion_play
	.globl _turret_anim_delay
	.globl _turret_exp_frame
	.globl _turret_blast_delay
	.globl _turret_been_hit
	.globl _sy
	.globl _sx
	.globl _shot_fired
	.globl _turret_y
	.globl _turret_x
	.globl _sprites_invader
	.globl _sprites_turret
	.globl _rand_x
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_rand_x::
	.ds 2
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_sprites_turret::
	.ds 256
_sprites_invader::
	.ds 256
_turret_x::
	.ds 2
_turret_y::
	.ds 2
_shot_fired::
	.ds 1
_sx::
	.ds 2
_sy::
	.ds 2
_turret_been_hit::
	.ds 1
_turret_blast_delay::
	.ds 2
_turret_exp_frame::
	.ds 2
_turret_anim_delay::
	.ds 2
_explosion_play::
	.ds 1
_invader_x::
	.ds 2
_invader_y::
	.ds 2
_i_anim_delay::
	.ds 2
_inv_frame::
	.ds 2
_ix_speed::
	.ds 2
_i_dir::
	.ds 2
_inv_shot_x::
	.ds 2
_inv_shot_y::
	.ds 2
_inv_fire_pause::
	.ds 2
_inv_fired::
	.ds 1
_been_hit::
	.ds 1
_bx::
	.ds 2
_by::
	.ds 2
_blast_delay::
	.ds 2
_score::
	.ds 2
_lives::
	.ds 2
_game_over::
	.ds 1
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:69: void move_anim_inv() { 
;	---------------------------------
; Function move_anim_inv
; ---------------------------------
_move_anim_inv::
;main.c:70: i_anim_delay -=1;
;setupPair	HL
;setupPair	HL
	ld	hl, #_i_anim_delay
;setupPair	HL
	ld	a, (hl+)
	ld	e, a
;setupPair	HL
	ld	a, (hl-)
	ld	d, a
	dec	de
;setupPair	HL
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;main.c:72: if(i_anim_delay < 0) {
;setupPair	HL
	ld	a, (hl)
	bit	7, a
	jp	Z, 00116$
;main.c:73: i_anim_delay = 20;
;setupPair	HL
	dec	hl
;setupPair	HL
	ld	a, #0x14
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:75: inv_frame += 1;        
;setupPair	HL
	ld	hl, #_inv_frame
	inc	(hl)
	jr	NZ, 00195$
;setupPair	HL
	inc	hl
	inc	(hl)
00195$:
;main.c:76: if (inv_frame > 2) {
;setupPair	HL
	ld	hl, #_inv_frame
	ld	a, #0x02
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00196$
	bit	7, d
	jr	NZ, 00197$
	cp	a, a
	jr	00197$
00196$:
	bit	7, d
	jr	Z, 00197$
	scf
00197$:
	jr	NC, 00102$
;main.c:77: inv_frame = 1;
;setupPair	HL
	ld	hl, #_inv_frame
;setupPair	HL
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00102$:
;main.c:80: if(!(been_hit)) {
;setupPair	HL
	ld	hl, #_been_hit
	bit	0, (hl)
	jp	NZ, 00116$
;main.c:82: if ((i_dir == 1) && (invader_x <= 144)) {
;setupPair	HL
	ld	hl, #_i_dir
;setupPair	HL
	ld	a, (hl+)
	dec	a
	or	a, (hl)
	jr	NZ, 00106$
;setupPair	HL
	ld	hl, #_invader_x
	ld	a, #0x90
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00200$
	bit	7, d
	jr	NZ, 00201$
	cp	a, a
	jr	00201$
00200$:
	bit	7, d
	jr	Z, 00201$
	scf
00201$:
	jr	C, 00106$
;main.c:83: invader_x += ix_speed;
;setupPair	HL
	ld	a, (#_invader_x)
;setupPair	HL
	ld	hl, #_ix_speed
	add	a, (hl)
;setupPair	HL
	ld	hl, #_invader_x
;setupPair	HL
	ld	(hl+), a
	ld	a, (hl)
;setupPair	HL
	ld	hl, #_ix_speed + 1
	adc	a, (hl)
;setupPair	HL
	ld	hl, #_invader_x + 1
;main.c:84: if (invader_x >= 144) {                    
;setupPair	HL
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0x90
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00202$
	bit	7, d
	jr	NZ, 00203$
	cp	a, a
	jr	00203$
00202$:
	bit	7, d
	jr	Z, 00203$
	scf
00203$:
	jr	C, 00106$
;main.c:85: invader_y += 4; // step down
;setupPair	HL
	ld	hl, #_invader_y
	ld	a, (hl)
	add	a, #0x04
;setupPair	HL
;setupPair	HL
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
;setupPair	HL
	ld	(hl), a
;main.c:86: i_dir = 0;
	xor	a, a
;setupPair	HL
	ld	hl, #_i_dir
;setupPair	HL
	ld	(hl+), a
	ld	(hl), a
00106$:
;main.c:90: if ((i_dir < 1) && (invader_x >= 24)) {
;setupPair	HL
	ld	hl, #_i_dir
	ld	a, (hl+)
	sub	a, #0x01
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00204$
	bit	7, d
	jr	NZ, 00205$
	cp	a, a
	jr	00205$
00204$:
	bit	7, d
	jr	Z, 00205$
	scf
00205$:
	jr	NC, 00116$
;setupPair	HL
	ld	hl, #_invader_x
	ld	a, (hl+)
	sub	a, #0x18
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00206$
	bit	7, d
	jr	NZ, 00207$
	cp	a, a
	jr	00207$
00206$:
	bit	7, d
	jr	Z, 00207$
	scf
00207$:
	jr	C, 00116$
;main.c:91: invader_x -= ix_speed;
;setupPair	HL
	ld	a, (#_invader_x)
;setupPair	HL
	ld	hl, #_ix_speed
	sub	a, (hl)
;setupPair	HL
	ld	hl, #_invader_x
;setupPair	HL
	ld	(hl+), a
	ld	a, (hl)
;setupPair	HL
	ld	hl, #_ix_speed + 1
	sbc	a, (hl)
;setupPair	HL
	ld	hl, #_invader_x + 1
;main.c:92: if (invader_x <= 24) {                    
;setupPair	HL
	ld	(hl-), a
	ld	a, #0x18
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00208$
	bit	7, d
	jr	NZ, 00209$
	cp	a, a
	jr	00209$
00208$:
	bit	7, d
	jr	Z, 00209$
	scf
00209$:
	jr	C, 00116$
;main.c:93: invader_y += 4; // step down
;setupPair	HL
	ld	hl, #_invader_y
	ld	a, (hl)
	add	a, #0x04
;setupPair	HL
;setupPair	HL
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
;setupPair	HL
	ld	(hl), a
;main.c:94: i_dir = 1;           
;setupPair	HL
	ld	hl, #_i_dir
;setupPair	HL
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00116$:
;main.c:100: if (!(been_hit)) {
;setupPair	HL
	ld	hl, #_been_hit
	bit	0, (hl)
	jr	NZ, 00123$
;main.c:101: if(inv_frame == 1) {
;setupPair	HL
	ld	hl, #_inv_frame
;setupPair	HL
	ld	a, (hl+)
	dec	a
	or	a, (hl)
	jr	NZ, 00120$
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 34)
	ld	(hl), #0x10
	ld	hl, #(_shadow_OAM + 38)
	ld	(hl), #0x12
;main.c:103: set_sprite_tile( 9, 18);             
	jr	00124$
00120$:
;main.c:105: else if(inv_frame == 2) {
;setupPair	HL
	ld	hl, #_inv_frame
;setupPair	HL
	ld	a, (hl+)
	sub	a, #0x02
	or	a, (hl)
	jr	NZ, 00124$
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 34)
	ld	(hl), #0x14
	ld	hl, #(_shadow_OAM + 38)
	ld	(hl), #0x16
;main.c:107: set_sprite_tile(9, 22);             
	jr	00124$
00123$:
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 34)
	ld	(hl), #0x18
	ld	hl, #(_shadow_OAM + 38)
	ld	(hl), #0x1a
;main.c:112: set_sprite_tile(9, 26); 
00124$:
;main.c:115: move_sprite(8, invader_x, invader_y);
;setupPair	HL
	ld	hl, #_invader_y
	ld	b, (hl)
;setupPair	HL
	ld	hl, #_invader_x
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 32)
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:116: move_sprite(9, invader_x + 8, invader_y);
;setupPair	HL
	ld	hl, #_invader_y
	ld	b, (hl)
;setupPair	HL
	ld	a, (#_invader_x)
	add	a, #0x08
	ld	c, a
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 36)
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:116: move_sprite(9, invader_x + 8, invader_y);
;main.c:117: }
	ret
;main.c:121: void invader_fire() {    
;	---------------------------------
; Function invader_fire
; ---------------------------------
_invader_fire::
;main.c:122: inv_fire_pause -= 1;
;setupPair	HL
;setupPair	HL
	ld	hl, #_inv_fire_pause
;setupPair	HL
	ld	a, (hl+)
	ld	e, a
;setupPair	HL
	ld	a, (hl-)
	ld	d, a
	dec	de
;setupPair	HL
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;main.c:124: if (!(inv_fired)) { // so once invader shot is fired it doesn't follow the invader still
;setupPair	HL
	ld	hl, #_inv_fired
	bit	0, (hl)
	jr	NZ, 00102$
;main.c:125: inv_shot_x = invader_x;
;setupPair	HL
	ld	a, (#_invader_x)
;setupPair	HL
	ld	(#_inv_shot_x),a
;setupPair	HL
	ld	a, (#_invader_x + 1)
;setupPair	HL
	ld	(#_inv_shot_x + 1),a
;main.c:126: inv_shot_y = invader_y;
;setupPair	HL
	ld	a, (#_invader_y)
;setupPair	HL
	ld	(#_inv_shot_y),a
;setupPair	HL
	ld	a, (#_invader_y + 1)
;setupPair	HL
	ld	(#_inv_shot_y + 1),a
00102$:
;main.c:129: if (inv_fire_pause < 0) {
;setupPair	HL
	ld	a, (#_inv_fire_pause + 1)
	bit	7, a
	ret	Z
;main.c:130: inv_fired = true;
;setupPair	HL
	ld	hl, #_inv_fired
	ld	(hl), #0x01
;main.c:131: inv_shot_y += 3;            
;setupPair	HL
	ld	hl, #_inv_shot_y
	ld	a, (hl)
	add	a, #0x03
;setupPair	HL
;setupPair	HL
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
;setupPair	HL
	ld	(hl), a
;main.c:133: }    
	ret
;main.c:137: void turret_hit() {    
;	---------------------------------
; Function turret_hit
; ---------------------------------
_turret_hit::
;main.c:138: if (turret_been_hit) {
;setupPair	HL
	ld	hl, #_turret_been_hit
	bit	0, (hl)
	ret	Z
;main.c:144: explosion_play = true;        
;setupPair	HL
	ld	hl, #_explosion_play
	ld	(hl), #0x01
;main.c:145: turret_anim_delay -= 1;
;setupPair	HL
;setupPair	HL
	ld	hl, #_turret_anim_delay
;setupPair	HL
	ld	a, (hl+)
	ld	e, a
;setupPair	HL
	ld	a, (hl-)
	ld	d, a
	dec	de
;setupPair	HL
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;main.c:146: turret_blast_delay -= 1;
;setupPair	HL
;setupPair	HL
	ld	hl, #_turret_blast_delay
;setupPair	HL
	ld	a, (hl+)
	ld	e, a
;setupPair	HL
	ld	a, (hl-)
	ld	d, a
	dec	de
;setupPair	HL
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;main.c:148: if (turret_anim_delay < 0) {
;setupPair	HL
	ld	a, (#_turret_anim_delay + 1)
	bit	7, a
	jr	Z, 00104$
;main.c:149: turret_exp_frame += 1;
;setupPair	HL
	ld	hl, #_turret_exp_frame
	inc	(hl)
	jr	NZ, 00131$
;setupPair	HL
	inc	hl
	inc	(hl)
00131$:
;main.c:150: if (turret_exp_frame > 2) {
;setupPair	HL
	ld	hl, #_turret_exp_frame
	ld	a, #0x02
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00132$
	bit	7, d
	jr	NZ, 00133$
	cp	a, a
	jr	00133$
00132$:
	bit	7, d
	jr	Z, 00133$
	scf
00133$:
	jr	NC, 00102$
;main.c:151: turret_exp_frame = 1;                
;setupPair	HL
	ld	hl, #_turret_exp_frame
;setupPair	HL
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00102$:
;main.c:153: turret_anim_delay = 10;  
;setupPair	HL
	ld	hl, #_turret_anim_delay
;setupPair	HL
	ld	a, #0x0a
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00104$:
;main.c:156: if (turret_blast_delay < 0) {
;setupPair	HL
	ld	hl, #_turret_blast_delay + 1
	bit	7, (hl)
	ret	Z
;main.c:157: turret_blast_delay = 60;
;setupPair	HL
	dec	hl
;setupPair	HL
	ld	a, #0x3c
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:158: turret_been_hit = false;                 
;setupPair	HL
	ld	hl, #_turret_been_hit
	ld	(hl), #0x00
;main.c:159: explosion_play = false;
;setupPair	HL
	ld	hl, #_explosion_play
	ld	(hl), #0x00
;main.c:160: turret_x = 84; // reset turret x
;setupPair	HL
	ld	hl, #_turret_x
;setupPair	HL
	ld	a, #0x54
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:161: turret_y = 125; // reset turret y
;setupPair	HL
	ld	hl, #_turret_y
;setupPair	HL
	ld	a, #0x7d
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:164: }
	ret
;main.c:168: void invader_hit() {
;	---------------------------------
; Function invader_hit
; ---------------------------------
_invader_hit::
;main.c:169: if (been_hit) {
;setupPair	HL
	ld	hl, #_been_hit
	bit	0, (hl)
	ret	Z
;main.c:175: inv_shot_x = 165; // hide shot
;setupPair	HL
	ld	hl, #_inv_shot_x
;setupPair	HL
	ld	a, #0xa5
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:176: inv_shot_y = 144; // hide shot
;setupPair	HL
	ld	hl, #_inv_shot_y
;setupPair	HL
	ld	a, #0x90
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:177: inv_fire_pause = 180; // and reset pause
;setupPair	HL
	ld	hl, #_inv_fire_pause
;setupPair	HL
	ld	a, #0xb4
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:180: blast_delay -= 1;
;setupPair	HL
;setupPair	HL
	ld	hl, #_blast_delay
;setupPair	HL
	ld	a, (hl+)
	ld	e, a
;setupPair	HL
	ld	a, (hl-)
	ld	d, a
	dec	de
;setupPair	HL
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;main.c:182: if (blast_delay < 0) {
;setupPair	HL
	bit	7, (hl)
	ret	Z
;main.c:183: blast_delay = 60;
;setupPair	HL
	dec	hl
;setupPair	HL
	ld	a, #0x3c
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:185: been_hit = false;
;setupPair	HL
	ld	hl, #_been_hit
	ld	(hl), #0x00
;main.c:186: bx = 165; // move boom off screen (following invader)
;setupPair	HL
	ld	hl, #_bx
;setupPair	HL
	ld	a, #0xa5
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:187: by = 144;
;setupPair	HL
	ld	hl, #_by
;setupPair	HL
	ld	a, #0x90
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:190: invader_x = 85; // move invader back up after being hit        
;setupPair	HL
	ld	hl, #_invader_x
;setupPair	HL
	ld	a, #0x55
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:191: invader_y = 40; // move invader back up after being hit
;setupPair	HL
	ld	hl, #_invader_y
;setupPair	HL
	ld	a, #0x28
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:194: }
	ret
;main.c:199: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	dec	sp
	dec	sp
;main.c:202: font_init();
	call	_font_init
;main.c:203: main_font = font_load(font_min);
	ld	de, #_font_min
	push	de
	call	_font_load
	pop	hl
;main.c:205: font_set(main_font);
	push	de
	call	_font_set
	pop	hl
;main.c:210: SPRITES_8x16;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x04
	ldh	(_LCDC_REG + 0), a
;main.c:215: set_sprite_data(0, 16, sprites_turret); // starting at zero, push four 8x8 tiles from turret array into sprite data
	ld	de, #_sprites_turret
	push	de
	ld	a, #0x10
	push	af
	inc	sp
	xor	a, a
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x02
	ld	hl, #(_shadow_OAM + 10)
	ld	(hl), #0x04
	ld	hl, #(_shadow_OAM + 14)
	ld	(hl), #0x06
	ld	hl, #(_shadow_OAM + 18)
	ld	(hl), #0x08
	ld	hl, #(_shadow_OAM + 22)
	ld	(hl), #0x0a
	ld	hl, #(_shadow_OAM + 26)
	ld	(hl), #0x0c
;main.c:233: set_sprite_data(16, 16, sprites_invader);
	ld	de, #_sprites_invader
	push	de
	ld	a, #0x10
	push	af
	inc	sp
	ld	a, #0x10
	push	af
	inc	sp
	call	_set_sprite_data
	add	sp, #4
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 34)
	ld	(hl), #0x10
	ld	hl, #(_shadow_OAM + 38)
	ld	(hl), #0x12
	ld	hl, #(_shadow_OAM + 42)
	ld	(hl), #0x14
	ld	hl, #(_shadow_OAM + 46)
	ld	(hl), #0x16
	ld	hl, #(_shadow_OAM + 50)
	ld	(hl), #0x18
	ld	hl, #(_shadow_OAM + 54)
	ld	(hl), #0x1a
	ld	hl, #(_shadow_OAM + 58)
	ld	(hl), #0x1c
;main.c:250: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:255: while(1) {
00151$:
;main.c:257: joydata = joypad(); // Read once per frame and cache the result
	call	_joypad
	ldhl	sp,	#0
	ld	a, e
	ld	(hl+), a
	ld	(hl), #0x00
;main.c:260: if(game_over) {
;setupPair	HL
	ld	hl, #_game_over
	bit	0, (hl)
	jp	Z, 00104$
;main.c:262: gotoxy(1, 1);        
	ld	hl, #0x101
	push	hl
	call	_gotoxy
	pop	hl
;main.c:263: printf("SCORE %d ", score);
;setupPair	HL
	ld	hl, #_score
;setupPair	HL
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	de, #___str_0
	push	de
	call	_printf
	add	sp, #4
;main.c:264: gotoxy(12, 1);
	ld	hl, #0x10c
	push	hl
	call	_gotoxy
	pop	hl
;main.c:265: printf("LIVES %d ", lives);
;setupPair	HL
	ld	hl, #_lives
;setupPair	HL
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	de, #___str_1
	push	de
	call	_printf
	add	sp, #4
;main.c:266: gotoxy(5, 8);
	ld	hl, #0x805
	push	hl
	call	_gotoxy
	pop	hl
;main.c:267: printf("GAME  OVER");
	ld	de, #___str_2
	push	de
	call	_printf
	pop	bc
;main.c:272: if(joydata & J_START) {                    
	push	hl
	ldhl	sp,	#2
	bit	7, (hl)
	pop	hl
	jr	Z, 00104$
;main.c:273: turret_x = 84;  // turret starting x
;setupPair	HL
	ld	hl, #_turret_x
;setupPair	HL
	ld	a, #0x54
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:274: turret_y = 125; // turret starting y
;setupPair	HL
	ld	hl, #_turret_y
;setupPair	HL
	ld	a, #0x7d
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:275: invader_x = 85; // invader starting x
;setupPair	HL
	ld	hl, #_invader_x
;setupPair	HL
	ld	a, #0x55
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:276: invader_y = 40; // invader starting y
;setupPair	HL
	ld	hl, #_invader_y
;setupPair	HL
	ld	a, #0x28
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:277: i_dir = 1;      // 1 = right, 0 = left
;setupPair	HL
	ld	hl, #_i_dir
;setupPair	HL
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:278: lives = 3; // reset lives
;setupPair	HL
	ld	hl, #_lives
;setupPair	HL
	ld	a, #0x03
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:279: score = 0; // reset score
	xor	a, a
;setupPair	HL
	ld	hl, #_score
;setupPair	HL
	ld	(hl+), a
	ld	(hl), a
;main.c:280: explosion_play = false; 
;setupPair	HL
	ld	hl, #_explosion_play
	ld	(hl), #0x00
;main.c:281: turret_been_hit = false;  
;setupPair	HL
	ld	hl, #_turret_been_hit
	ld	(hl), #0x00
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 32)
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, #0x28
	ld	(hl+), a
	ld	(hl), #0x55
;main.c:283: move_sprite(9, invader_x + 8, invader_y);             
;setupPair	HL
	ld	hl, #_invader_y
	ld	b, (hl)
;setupPair	HL
	ld	a, (#_invader_x)
	add	a, #0x08
	ld	c, a
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 36)
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:284: game_over = false; 
;setupPair	HL
	ld	hl, #_game_over
	ld	(hl), #0x00
;main.c:285: gotoxy(5, 8);
	ld	hl, #0x805
	push	hl
	call	_gotoxy
	pop	hl
;main.c:286: printf("          "); // removes "GAME OVER" text                                                             
	ld	de, #___str_3
	push	de
	call	_printf
	pop	hl
00104$:
;main.c:292: if(!(game_over)) {         
;setupPair	HL
	ld	hl, #_game_over
	bit	0, (hl)
	jp	NZ, 00151$
;main.c:294: move_anim_inv(); 
	call	_move_anim_inv
;main.c:297: invader_fire();      
	call	_invader_fire
;main.c:300: invader_hit(); 
	call	_invader_hit
;main.c:303: turret_hit();
	call	_turret_hit
;main.c:307: joydata = joypad(); // Read once per frame and cache the result
	call	_joypad
	ld	c, e
;main.c:309: if(joydata & J_RIGHT && (!(turret_been_hit))) {            
	bit	0, c
	jr	Z, 00108$
;setupPair	HL
	ld	hl, #_turret_been_hit
	bit	0, (hl)
	jr	NZ, 00108$
;main.c:310: if(turret_x < 142) {
;setupPair	HL
	ld	hl, #_turret_x
	ld	a, (hl+)
	sub	a, #0x8e
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00324$
	bit	7, d
	jr	NZ, 00325$
	cp	a, a
	jr	00325$
00324$:
	bit	7, d
	jr	Z, 00325$
	scf
00325$:
	jr	NC, 00108$
;main.c:311: turret_x += 1; 
;setupPair	HL
	ld	hl, #_turret_x
	inc	(hl)
	jr	NZ, 00326$
;setupPair	HL
	inc	hl
	inc	(hl)
00326$:
00108$:
;main.c:315: if(joydata & J_LEFT && (!(turret_been_hit))) {            
	bit	1, c
	jr	Z, 00113$
;setupPair	HL
	ld	hl, #_turret_been_hit
	bit	0, (hl)
	jr	NZ, 00113$
;main.c:316: if(turret_x > 21) {
;setupPair	HL
	ld	hl, #_turret_x
	ld	a, #0x15
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00328$
	bit	7, d
	jr	NZ, 00329$
	cp	a, a
	jr	00329$
00328$:
	bit	7, d
	jr	Z, 00329$
	scf
00329$:
	jr	NC, 00113$
;main.c:317: turret_x -= 1; 
;setupPair	HL
;setupPair	HL
	ld	hl, #_turret_x
;setupPair	HL
	ld	a, (hl+)
	ld	e, a
;setupPair	HL
	ld	a, (hl-)
	ld	d, a
	dec	de
;setupPair	HL
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
00113$:
;main.c:321: if(joydata & J_A && !(shot_fired) && (!(turret_been_hit))) {    
	bit	4, c
	jr	Z, 00116$
;setupPair	HL
	ld	hl, #_shot_fired
	bit	0, (hl)
	jr	NZ, 00116$
;setupPair	HL
	ld	hl, #_turret_been_hit
	bit	0, (hl)
	jr	NZ, 00116$
;main.c:324: shot_fired = true;               
;setupPair	HL
	ld	hl, #_shot_fired
	ld	(hl), #0x01
;main.c:325: sx=turret_x;
;setupPair	HL
	ld	a, (#_turret_x)
;setupPair	HL
	ld	(#_sx),a
;setupPair	HL
	ld	a, (#_turret_x + 1)
;setupPair	HL
	ld	(#_sx + 1),a
;main.c:326: sy=turret_y + 6;
;setupPair	HL
	ld	a, (#_turret_y)
	add	a, #0x06
;setupPair	HL
	ld	(#_sy),a
;setupPair	HL
	ld	a, (#_turret_y + 1)
	adc	a, #0x00
;setupPair	HL
	ld	(#_sy + 1),a
00116$:
;main.c:331: if (shot_fired) {
;setupPair	HL
	ld	hl, #_shot_fired
	bit	0, (hl)
	jr	Z, 00122$
;main.c:332: sy -= 3; 
;setupPair	HL
	ld	hl, #_sy
	ld	a, (hl)
	add	a, #0xfd
;setupPair	HL
;setupPair	HL
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0xff
;setupPair	HL
;main.c:333: if (sy < 41) {
;setupPair	HL
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0x29
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00331$
	bit	7, d
	jr	NZ, 00332$
	cp	a, a
	jr	00332$
00331$:
	bit	7, d
	jr	Z, 00332$
	scf
00332$:
	jr	NC, 00122$
;main.c:334: shot_fired = false;
;setupPair	HL
	ld	hl, #_shot_fired
	ld	(hl), #0x00
;main.c:335: sx = 165;
;setupPair	HL
	ld	hl, #_sx
;setupPair	HL
	ld	a, #0xa5
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:336: sy = 0;
	xor	a, a
;setupPair	HL
	ld	hl, #_sy
;setupPair	HL
	ld	(hl+), a
	ld	(hl), a
00122$:
;main.c:343: ) {
;setupPair	HL
	ld	hl, #_inv_shot_y
	ld	a, #0x83
	sub	a, (hl)
	inc	hl
	ld	a, #0x00
	sbc	a, (hl)
	ld	a, #0x00
	ld	d, a
	bit	7, (hl)
	jr	Z, 00333$
	bit	7, d
	jr	NZ, 00334$
	cp	a, a
	jr	00334$
00333$:
	bit	7, d
	jr	Z, 00334$
	scf
00334$:
	jr	NC, 00124$
;main.c:344: inv_fired = false;
;setupPair	HL
	ld	hl, #_inv_fired
	ld	(hl), #0x00
;main.c:345: inv_shot_x = invader_x;
;setupPair	HL
	ld	a, (#_invader_x)
;setupPair	HL
	ld	(#_inv_shot_x),a
;setupPair	HL
	ld	a, (#_invader_x + 1)
;setupPair	HL
	ld	(#_inv_shot_x + 1),a
;main.c:346: inv_shot_y = invader_y;
;setupPair	HL
	ld	a, (#_invader_y)
;setupPair	HL
	ld	(#_inv_shot_y),a
;setupPair	HL
	ld	a, (#_invader_y + 1)
;setupPair	HL
	ld	(#_inv_shot_y + 1),a
;main.c:347: inv_fire_pause = 90;
;setupPair	HL
	ld	hl, #_inv_fire_pause
;setupPair	HL
	ld	a, #0x5a
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00124$:
;main.c:352: if ((sx + 6 >= invader_x) && (sx + 6 <= invader_x + 10) && (sy + 4 <= invader_y + 8)) {
;setupPair	HL
	ld	hl, #_sx
;setupPair	HL
	ld	a, (hl+)
	add	a, #0x06
	ld	c, a
	ld	a, (hl)
	adc	a, #0x00
	ld	b, a
;setupPair	HL
	ld	hl, #_invader_x
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00335$
	bit	7, d
	jr	NZ, 00336$
	cp	a, a
	jr	00336$
00335$:
	bit	7, d
	jr	Z, 00336$
	scf
00336$:
	jr	C, 00126$
;setupPair	HL
;setupPair	HL
	ld	hl, #_invader_x
;setupPair	HL
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000a
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00337$
	bit	7, d
	jr	NZ, 00338$
	cp	a, a
	jr	00338$
00337$:
	bit	7, d
	jr	Z, 00338$
	scf
00338$:
	jr	C, 00126$
;setupPair	HL
	ld	hl, #_sy
;setupPair	HL
	ld	a, (hl+)
	add	a, #0x04
	ld	c, a
	ld	a, (hl)
	adc	a, #0x00
	ld	b, a
;setupPair	HL
;setupPair	HL
	ld	hl, #_invader_y
;setupPair	HL
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0008
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00339$
	bit	7, d
	jr	NZ, 00340$
	cp	a, a
	jr	00340$
00339$:
	bit	7, d
	jr	Z, 00340$
	scf
00340$:
	jr	C, 00126$
;main.c:353: sx = 165;
;setupPair	HL
	ld	hl, #_sx
;setupPair	HL
	ld	a, #0xa5
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:354: sy = 0;
	xor	a, a
;setupPair	HL
	ld	hl, #_sy
;setupPair	HL
	ld	(hl+), a
	ld	(hl), a
;main.c:355: been_hit = true;
;setupPair	HL
	ld	hl, #_been_hit
	ld	(hl), #0x01
;main.c:356: score += 10; 
;setupPair	HL
	ld	hl, #_score
	ld	a, (hl)
	add	a, #0x0a
;setupPair	HL
;setupPair	HL
	ld	(hl+), a
	ld	a, (hl)
	adc	a, #0x00
;setupPair	HL
	ld	(hl), a
00126$:
;main.c:361: if ((inv_shot_x + 6) >= (turret_x) && (inv_shot_x + 4) <= (turret_x + 12) && (inv_shot_y + 6) >= (turret_y + 9)) {
;setupPair	HL
	ld	hl, #_inv_shot_x
;setupPair	HL
	ld	a, (hl+)
	add	a, #0x06
	ld	c, a
	ld	a, (hl)
	adc	a, #0x00
	ld	b, a
;setupPair	HL
	ld	hl, #_turret_x
	ld	a, c
	sub	a, (hl)
	inc	hl
	ld	a, b
	sbc	a, (hl)
	ld	a, b
	ld	d, a
	bit	7, (hl)
	jr	Z, 00341$
	bit	7, d
	jr	NZ, 00342$
	cp	a, a
	jr	00342$
00341$:
	bit	7, d
	jr	Z, 00342$
	scf
00342$:
	jp	C, 00134$
;setupPair	HL
	ld	hl, #_inv_shot_x
;setupPair	HL
	ld	a, (hl+)
	add	a, #0x04
	ld	c, a
	ld	a, (hl)
	adc	a, #0x00
	ld	b, a
;setupPair	HL
;setupPair	HL
	ld	hl, #_turret_x
;setupPair	HL
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x000c
	add	hl, de
	inc	sp
	inc	sp
	push	hl
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00343$
	bit	7, d
	jr	NZ, 00344$
	cp	a, a
	jr	00344$
00343$:
	bit	7, d
	jr	Z, 00344$
	scf
00344$:
	jr	C, 00134$
;setupPair	HL
;setupPair	HL
	ld	hl, #_inv_shot_y
;setupPair	HL
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	ld	hl, #0x0006
	add	hl, de
	inc	sp
	inc	sp
	push	hl
;setupPair	HL
	ld	hl, #_turret_y
;setupPair	HL
	ld	a, (hl+)
	add	a, #0x09
	ld	c, a
	ld	a, (hl)
	adc	a, #0x00
	ld	b, a
	ldhl	sp,	#0
	ld	a, (hl+)
	sub	a, c
	ld	a, (hl)
	sbc	a, b
	ld	d, (hl)
	ld	a, b
	bit	7,a
	jr	Z, 00345$
	bit	7, d
	jr	NZ, 00346$
	cp	a, a
	jr	00346$
00345$:
	bit	7, d
	jr	Z, 00346$
	scf
00346$:
	jr	C, 00134$
;main.c:362: if (!(turret_been_hit)) {
;setupPair	HL
	ld	hl, #_turret_been_hit
	bit	0, (hl)
	jr	NZ, 00134$
;main.c:363: lives -= 1;
;setupPair	HL
;setupPair	HL
	ld	hl, #_lives
;setupPair	HL
	ld	a, (hl+)
	ld	e, a
;setupPair	HL
	ld	a, (hl-)
	ld	d, a
	dec	de
;setupPair	HL
	ld	a, e
	ld	(hl+), a
	ld	(hl), d
;main.c:365: if (lives == 0) {                    
;setupPair	HL
;setupPair	HL
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00130$
;main.c:366: game_over = true;                                                  
;setupPair	HL
	ld	hl, #_game_over
	ld	(hl), #0x01
00130$:
;main.c:368: turret_been_hit = true;            
;setupPair	HL
	ld	hl, #_turret_been_hit
	ld	(hl), #0x01
00134$:
;main.c:375: if (inv_fired) {
;setupPair	HL
	ld	hl, #_inv_fired
	bit	0, (hl)
	jr	Z, 00138$
;main.c:377: move_sprite(14, inv_shot_x, inv_shot_y);    // draw sprite 14 to these coordinates                  
;setupPair	HL
	ld	hl, #_inv_shot_y
	ld	b, (hl)
;setupPair	HL
	ld	hl, #_inv_shot_x
	ld	c, (hl)
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 56)
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:377: move_sprite(14, inv_shot_x, inv_shot_y);    // draw sprite 14 to these coordinates                  
	jr	00139$
00138$:
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 56)
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	(hl), #0x90
	inc	hl
	ld	(hl), #0xa5
;main.c:381: move_sprite(14, 165, 144);                  // draw sprite 14 to these coordinates                 
00139$:
;main.c:385: if (!(turret_been_hit)) {
;setupPair	HL
	ld	hl, #_turret_been_hit
	bit	0, (hl)
	jr	NZ, 00146$
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x02
;main.c:387: set_sprite_tile(1, 2);            
	jr	00147$
00146$:
;main.c:392: if (turret_exp_frame == 1) {               
;setupPair	HL
	ld	hl, #_turret_exp_frame
;setupPair	HL
	ld	a, (hl+)
	dec	a
	or	a, (hl)
	jr	NZ, 00143$
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x04
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x06
;main.c:394: set_sprite_tile(1, 6); 
	jr	00147$
00143$:
;main.c:397: else if (turret_exp_frame == 2) {                
;setupPair	HL
	ld	hl, #_turret_exp_frame
;setupPair	HL
	ld	a, (hl+)
	sub	a, #0x02
	or	a, (hl)
	jr	NZ, 00147$
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x08
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x0a
;main.c:399: set_sprite_tile(1, 10); 
00147$:
;main.c:402: move_sprite(0, turret_x, turret_y);     // draw sprite 0 to these coordinates
;setupPair	HL
	ld	hl, #_turret_y
	ld	c, (hl)
;setupPair	HL
	ld	hl, #_turret_x
	ld	b, (hl)
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:403: move_sprite(1, turret_x + 8, turret_y); // draw sprite 1 to these coordinates
;setupPair	HL
	ld	hl, #_turret_y
	ld	c, (hl)
;setupPair	HL
	ld	a, (#_turret_x)
	add	a, #0x08
	ld	b, a
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 4)
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:406: move_sprite(6, sx, sy); // draw sprite 6 to these coordinates
;setupPair	HL
	ld	hl, #_sy
	ld	c, (hl)
;setupPair	HL
	ld	hl, #_sx
	ld	b, (hl)
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 24)
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, c
	ld	(hl+), a
	ld	(hl), b
;main.c:410: gotoxy(1, 1);        
	ld	hl, #0x101
	push	hl
	call	_gotoxy
	pop	hl
;main.c:411: printf("SCORE %d ", score);
;setupPair	HL
	ld	hl, #_score
;setupPair	HL
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	de, #___str_0
	push	de
	call	_printf
	add	sp, #4
;main.c:412: gotoxy(12, 1);
	ld	hl, #0x10c
	push	hl
	call	_gotoxy
	pop	hl
;main.c:413: printf("LIVES %d ", lives);
;setupPair	HL
	ld	hl, #_lives
;setupPair	HL
	ld	a, (hl+)
	ld	e, a
	ld	d, (hl)
	push	de
	ld	de, #___str_1
	push	de
	call	_printf
	add	sp, #4
;main.c:418: wait_vbl_done(); // helps keep framerate
	call	_wait_vbl_done
	jp	00151$
;main.c:421: }
	inc	sp
	inc	sp
	ret
___str_0:
	.ascii "SCORE %d "
	.db 0x00
___str_1:
	.ascii "LIVES %d "
	.db 0x00
___str_2:
	.ascii "GAME  OVER"
	.db 0x00
___str_3:
	.ascii "          "
	.db 0x00
	.area _CODE
	.area _INITIALIZER
__xinit__sprites_turret:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x05	; 5
	.db #0x05	; 5
	.db #0x24	; 36
	.db #0x24	; 36
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x8b	; 139
	.db #0x8b	; 139
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x50	; 80	'P'
	.db #0x50	; 80	'P'
	.db #0xc8	; 200
	.db #0xc8	; 200
	.db #0xea	; 234
	.db #0xea	; 234
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x84	; 132
	.db #0x84	; 132
	.db #0x21	; 33
	.db #0x21	; 33
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x56	; 86	'V'
	.db #0x56	; 86	'V'
	.db #0x23	; 35
	.db #0x23	; 35
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x37	; 55	'7'
	.db #0x37	; 55	'7'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x32	; 50	'2'
	.db #0x32	; 50	'2'
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0xe2	; 226
	.db #0xe2	; 226
	.db #0x88	; 136
	.db #0x88	; 136
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe4	; 228
	.db #0xe4	; 228
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__sprites_invader:
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x6e	; 110	'n'
	.db #0x6e	; 110	'n'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xa0	; 160
	.db #0xa0	; 160
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xa0	; 160
	.db #0xa0	; 160
	.db #0xa0	; 160
	.db #0xa0	; 160
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x91	; 145
	.db #0x91	; 145
	.db #0xbf	; 191
	.db #0xbf	; 191
	.db #0xee	; 238
	.db #0xee	; 238
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0xa0	; 160
	.db #0xa0	; 160
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x20	; 32
	.db #0x20	; 32
	.db #0x4a	; 74	'J'
	.db #0x4a	; 74	'J'
	.db #0x11	; 17
	.db #0x11	; 17
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x40	; 64
	.db #0x40	; 64
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x02	; 2
	.db #0x02	; 2
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x08	; 8
	.db #0x08	; 8
	.db #0x04	; 4
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__turret_x:
	.dw #0x0054
__xinit__turret_y:
	.dw #0x007d
__xinit__shot_fired:
	.db #0x00	;  0
__xinit__sx:
	.dw #0xffec
__xinit__sy:
	.dw #0xffec
__xinit__turret_been_hit:
	.db #0x00	;  0
__xinit__turret_blast_delay:
	.dw #0x003c
__xinit__turret_exp_frame:
	.dw #0x0001
__xinit__turret_anim_delay:
	.dw #0x000a
__xinit__explosion_play:
	.db #0x00	;  0
__xinit__invader_x:
	.dw #0x0055
__xinit__invader_y:
	.dw #0x0028
__xinit__i_anim_delay:
	.dw #0x0014
__xinit__inv_frame:
	.dw #0x0001
__xinit__ix_speed:
	.dw #0x0002
__xinit__i_dir:
	.dw #0x0001
__xinit__inv_shot_x:
	.dw #0x00a5
__xinit__inv_shot_y:
	.dw #0x0090
__xinit__inv_fire_pause:
	.dw #0x00b4
__xinit__inv_fired:
	.db #0x00	;  0
__xinit__been_hit:
	.db #0x00	;  0
__xinit__bx:
	.dw #0x00a5
__xinit__by:
	.dw #0x0090
__xinit__blast_delay:
	.dw #0x003c
__xinit__score:
	.dw #0x0000
__xinit__lives:
	.dw #0x0003
__xinit__game_over:
	.db #0x00	;  0
	.area _CABS (ABS)
