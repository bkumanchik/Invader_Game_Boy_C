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
	.globl _rand
	.globl _printf
	.globl _set_sprite_data
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _waitpad
	.globl _joypad
	.globl _been_pressed
	.globl _game_over
	.globl _lives
	.globl _score
	.globl _boom_play
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
	.globl _title_map
	.globl _title_data
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
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
_boom_play::
	.ds 1
_score::
	.ds 2
_lives::
	.ds 2
_game_over::
	.ds 1
_been_pressed::
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
;main.c:66: void move_anim_inv() { 
;	---------------------------------
; Function move_anim_inv
; ---------------------------------
_move_anim_inv::
;main.c:67: i_anim_delay -=1;
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
;main.c:69: if(i_anim_delay < 0) {
;setupPair	HL
	ld	a, (hl)
	bit	7, a
	jp	Z, 00116$
;main.c:70: i_anim_delay = 20;
;setupPair	HL
	dec	hl
;setupPair	HL
	ld	a, #0x14
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:72: inv_frame += 1;        
;setupPair	HL
	ld	hl, #_inv_frame
	inc	(hl)
	jr	NZ, 00195$
;setupPair	HL
	inc	hl
	inc	(hl)
00195$:
;main.c:73: if (inv_frame > 2) {
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
;main.c:74: inv_frame = 1;
;setupPair	HL
	ld	hl, #_inv_frame
;setupPair	HL
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00102$:
;main.c:77: if(!(been_hit)) {
;setupPair	HL
	ld	hl, #_been_hit
	bit	0, (hl)
	jp	NZ, 00116$
;main.c:79: if ((i_dir == 1) && (invader_x <= 140)) {
;setupPair	HL
	ld	hl, #_i_dir
;setupPair	HL
	ld	a, (hl+)
	dec	a
	or	a, (hl)
	jr	NZ, 00106$
;setupPair	HL
	ld	hl, #_invader_x
	ld	a, #0x8c
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
;main.c:80: invader_x += ix_speed;
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
;main.c:81: if (invader_x >= 140) {                    
;setupPair	HL
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0x8c
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
;main.c:82: invader_y += 4; // step down
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
;main.c:83: i_dir = 0;
	xor	a, a
;setupPair	HL
	ld	hl, #_i_dir
;setupPair	HL
	ld	(hl+), a
	ld	(hl), a
00106$:
;main.c:87: if ((i_dir < 1) && (invader_x >= 24)) {
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
;main.c:88: invader_x -= ix_speed;
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
;main.c:89: if (invader_x <= 24) {                    
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
;main.c:90: invader_y += 4; // step down
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
;main.c:91: i_dir = 1;           
;setupPair	HL
	ld	hl, #_i_dir
;setupPair	HL
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00116$:
;main.c:97: if (!(been_hit)) {
;setupPair	HL
	ld	hl, #_been_hit
	bit	0, (hl)
	jr	NZ, 00123$
;main.c:98: if(inv_frame == 1) {
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
;main.c:100: set_sprite_tile( 9, 18);             
	jr	00124$
00120$:
;main.c:102: else if(inv_frame == 2) {
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
;main.c:104: set_sprite_tile(9, 22);             
	jr	00124$
00123$:
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 34)
	ld	(hl), #0x18
	ld	hl, #(_shadow_OAM + 38)
	ld	(hl), #0x1a
;main.c:109: set_sprite_tile(9, 26); 
00124$:
;main.c:112: move_sprite(8, invader_x, invader_y);
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
;main.c:113: move_sprite(9, invader_x + 8, invader_y);
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
;main.c:113: move_sprite(9, invader_x + 8, invader_y);
;main.c:114: }
	ret
_title_data:
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
	.db #0x1f	; 31
	.db #0x1f	; 31
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
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
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
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x01	; 1
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0x0e	; 14
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0xff	; 255
	.db #0xff	; 255
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
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0x0e	; 14
	.db #0x0e	; 14
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
	.db #0x1f	; 31
	.db #0x1f	; 31
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
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3c	; 60
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3c	; 60
	.db #0x3c	; 60
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
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfd	; 253
	.db #0xf9	; 249
	.db #0xfd	; 253
	.db #0xf9	; 249
	.db #0xfd	; 253
	.db #0xf9	; 249
	.db #0xfd	; 253
	.db #0xf9	; 249
	.db #0xf9	; 249
	.db #0xf9	; 249
	.db #0xf9	; 249
	.db #0xf9	; 249
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xf3	; 243
	.db #0xfb	; 251
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0xf1	; 241
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfe	; 254
	.db #0xfc	; 252
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x70	; 112	'p'
	.db #0x78	; 120	'x'
	.db #0xf0	; 240
	.db #0x70	; 112	'p'
	.db #0xf0	; 240
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x8f	; 143
	.db #0x0f	; 15
	.db #0x07	; 7
	.db #0x8f	; 143
	.db #0x8f	; 143
	.db #0x87	; 135
	.db #0x8f	; 143
	.db #0x87	; 135
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfc	; 252
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xff	; 255
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
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x83	; 131
	.db #0x03	; 3
	.db #0xc3	; 195
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
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
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0x8f	; 143
	.db #0xdf	; 223
	.db #0x8f	; 143
	.db #0xdf	; 223
	.db #0xdf	; 223
	.db #0x8f	; 143
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0xfc	; 252
	.db #0xfe	; 254
	.db #0xff	; 255
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
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0xf9	; 249
	.db #0xf9	; 249
	.db #0xf9	; 249
	.db #0xf9	; 249
	.db #0xf9	; 249
	.db #0xf9	; 249
	.db #0xf1	; 241
	.db #0xf9	; 249
	.db #0xf1	; 241
	.db #0xf9	; 249
	.db #0xf1	; 241
	.db #0xf9	; 249
	.db #0xf9	; 249
	.db #0xf1	; 241
	.db #0xf9	; 249
	.db #0xf1	; 241
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xe7	; 231
	.db #0xe3	; 227
	.db #0xe7	; 231
	.db #0xf1	; 241
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0xff	; 255
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x81	; 129
	.db #0xc0	; 192
	.db #0xc1	; 193
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x83	; 131
	.db #0x83	; 131
	.db #0x83	; 131
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xdf	; 223
	.db #0xff	; 255
	.db #0xdf	; 223
	.db #0xcf	; 207
	.db #0x8f	; 143
	.db #0xc7	; 199
	.db #0x8f	; 143
	.db #0x8f	; 143
	.db #0x87	; 135
	.db #0x8f	; 143
	.db #0x87	; 135
	.db #0x8f	; 143
	.db #0x87	; 135
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xc7	; 199
	.db #0xe7	; 231
	.db #0xc7	; 199
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xe0	; 224
	.db #0xf1	; 241
	.db #0xe1	; 225
	.db #0xf0	; 240
	.db #0xe1	; 225
	.db #0xf0	; 240
	.db #0xf1	; 241
	.db #0xe0	; 224
	.db #0xf1	; 241
	.db #0xe1	; 225
	.db #0xf3	; 243
	.db #0xe3	; 227
	.db #0xf3	; 243
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xf3	; 243
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xdf	; 223
	.db #0x8f	; 143
	.db #0xdf	; 223
	.db #0x8f	; 143
	.db #0xdf	; 223
	.db #0x0f	; 15
	.db #0x1f	; 31
	.db #0x0f	; 15
	.db #0x9f	; 159
	.db #0x8f	; 143
	.db #0x9f	; 159
	.db #0x8f	; 143
	.db #0x8f	; 143
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xef	; 239
	.db #0xe7	; 231
	.db #0xe7	; 231
	.db #0xe7	; 231
	.db #0xc3	; 195
	.db #0xe7	; 231
	.db #0xc7	; 199
	.db #0xe7	; 231
	.db #0xcf	; 207
	.db #0xe7	; 231
	.db #0xfe	; 254
	.db #0xfc	; 252
	.db #0xfc	; 252
	.db #0xfe	; 254
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xe0	; 224
	.db #0xc0	; 192
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf9	; 249
	.db #0xf1	; 241
	.db #0xf9	; 249
	.db #0xf1	; 241
	.db #0xf9	; 249
	.db #0xf1	; 241
	.db #0xf9	; 249
	.db #0xf1	; 241
	.db #0xf9	; 249
	.db #0xf1	; 241
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe3	; 227
	.db #0xe1	; 225
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0xe0	; 224
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0x70	; 112	'p'
	.db #0xf0	; 240
	.db #0x30	; 48	'0'
	.db #0x10	; 16
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x3f	; 63
	.db #0x7f	; 127
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x3e	; 62
	.db #0x3f	; 63
	.db #0x3e	; 62
	.db #0x1e	; 30
	.db #0x0e	; 14
	.db #0x1e	; 30
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x87	; 135
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x07	; 7
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x8f	; 143
	.db #0x87	; 135
	.db #0x97	; 151
	.db #0x8f	; 143
	.db #0xbf	; 191
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x73	; 115	's'
	.db #0x03	; 3
	.db #0x23	; 35
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0xc7	; 199
	.db #0xe7	; 231
	.db #0xe7	; 231
	.db #0xe7	; 231
	.db #0xe7	; 231
	.db #0xe3	; 227
	.db #0xf7	; 247
	.db #0xf3	; 243
	.db #0xf7	; 247
	.db #0x00	; 0
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf1	; 241
	.db #0xe1	; 225
	.db #0xf7	; 247
	.db #0xe3	; 227
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x08	; 8
	.db #0xf0	; 240
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0xe3	; 227
	.db #0xc3	; 195
	.db #0xe3	; 227
	.db #0x03	; 3
	.db #0x83	; 131
	.db #0x03	; 3
	.db #0x03	; 3
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xf0	; 240
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
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0xcf	; 207
	.db #0x0f	; 15
	.db #0xcf	; 207
	.db #0x8f	; 143
	.db #0x8f	; 143
	.db #0x8f	; 143
	.db #0x87	; 135
	.db #0x0f	; 15
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xfe	; 254
	.db #0xff	; 255
	.db #0xdf	; 223
	.db #0xef	; 239
	.db #0xdf	; 223
	.db #0xe7	; 231
	.db #0xcf	; 207
	.db #0xe7	; 231
	.db #0xc7	; 199
	.db #0x07	; 7
	.db #0x06	; 6
	.db #0x04	; 4
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0xc0	; 192
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x80	; 128
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
_title_map:
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
	.db #0x01	; 1
	.db #0x00	; 0
	.db #0x00	; 0
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
	.db #0x03	; 3
	.db #0x04	; 4
	.db #0x05	; 5
	.db #0x06	; 6
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
	.db #0x07	; 7
	.db #0x08	; 8
	.db #0x09	; 9
	.db #0x0a	; 10
	.db #0x0b	; 11
	.db #0x0c	; 12
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
	.db #0x0d	; 13
	.db #0x0e	; 14
	.db #0x0f	; 15
	.db #0x0f	; 15
	.db #0x10	; 16
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
	.db #0x12	; 18
	.db #0x13	; 19
	.db #0x14	; 20
	.db #0x15	; 21
	.db #0x16	; 22
	.db #0x17	; 23
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
	.db #0x18	; 24
	.db #0x19	; 25
	.db #0x1a	; 26
	.db #0x1b	; 27
	.db #0x1c	; 28
	.db #0x1d	; 29
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x20	; 32
	.db #0x21	; 33
	.db #0x22	; 34
	.db #0x23	; 35
	.db #0x24	; 36
	.db #0x25	; 37
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x29	; 41
	.db #0x2a	; 42
	.db #0x2b	; 43
	.db #0x2c	; 44
	.db #0x2d	; 45
	.db #0x2e	; 46
	.db #0x2f	; 47
	.db #0x30	; 48	'0'
	.db #0x31	; 49	'1'
	.db #0x32	; 50	'2'
	.db #0x33	; 51	'3'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x34	; 52	'4'
	.db #0x35	; 53	'5'
	.db #0x36	; 54	'6'
	.db #0x37	; 55	'7'
	.db #0x38	; 56	'8'
	.db #0x39	; 57	'9'
	.db #0x3a	; 58
	.db #0x3b	; 59
	.db #0x3c	; 60
	.db #0x3d	; 61
	.db #0x3e	; 62
	.db #0x3f	; 63
	.db #0x40	; 64
	.db #0x41	; 65	'A'
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
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
;main.c:118: void invader_fire() {    
;	---------------------------------
; Function invader_fire
; ---------------------------------
_invader_fire::
;main.c:119: inv_fire_pause -= 1;
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
;main.c:121: if (!(inv_fired)) { // so once invader shot is fired it doesn't follow the invader still
;setupPair	HL
	ld	hl, #_inv_fired
	bit	0, (hl)
	jr	NZ, 00102$
;main.c:122: inv_shot_x = invader_x;
;setupPair	HL
	ld	a, (#_invader_x)
;setupPair	HL
	ld	(#_inv_shot_x),a
;setupPair	HL
	ld	a, (#_invader_x + 1)
;setupPair	HL
	ld	(#_inv_shot_x + 1),a
;main.c:123: inv_shot_y = invader_y;
;setupPair	HL
	ld	a, (#_invader_y)
;setupPair	HL
	ld	(#_inv_shot_y),a
;setupPair	HL
	ld	a, (#_invader_y + 1)
;setupPair	HL
	ld	(#_inv_shot_y + 1),a
00102$:
;main.c:126: if (inv_fire_pause < 0) {
;setupPair	HL
	ld	a, (#_inv_fire_pause + 1)
	bit	7, a
	ret	Z
;main.c:127: inv_fired = true;
;setupPair	HL
	ld	hl, #_inv_fired
	ld	(hl), #0x01
;main.c:128: inv_shot_y += 3;            
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
;main.c:130: }    
	ret
;main.c:134: void turret_hit() {    
;	---------------------------------
; Function turret_hit
; ---------------------------------
_turret_hit::
;main.c:135: if (turret_been_hit) {
;setupPair	HL
	ld	hl, #_turret_been_hit
	bit	0, (hl)
	ret	Z
;main.c:136: if (!(explosion_play)) {                
;setupPair	HL
	ld	hl, #_explosion_play
	bit	0, (hl)
	jr	NZ, 00102$
;main.c:138: NR41_REG = 0x09;  
	ld	a, #0x09
	ldh	(_NR41_REG + 0), a
;main.c:139: NR42_REG = 0xF1; 
	ld	a, #0xf1
	ldh	(_NR42_REG + 0), a
;main.c:140: NR43_REG = 0x81;  
	ld	a, #0x81
	ldh	(_NR43_REG + 0), a
;main.c:141: NR44_REG = 0xC0;  
	ld	a, #0xc0
	ldh	(_NR44_REG + 0), a
00102$:
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
	jr	Z, 00106$
;main.c:149: turret_exp_frame += 1;
;setupPair	HL
	ld	hl, #_turret_exp_frame
	inc	(hl)
	jr	NZ, 00138$
;setupPair	HL
	inc	hl
	inc	(hl)
00138$:
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
	jr	Z, 00139$
	bit	7, d
	jr	NZ, 00140$
	cp	a, a
	jr	00140$
00139$:
	bit	7, d
	jr	Z, 00140$
	scf
00140$:
	jr	NC, 00104$
;main.c:151: turret_exp_frame = 1;                
;setupPair	HL
	ld	hl, #_turret_exp_frame
;setupPair	HL
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00104$:
;main.c:153: turret_anim_delay = 10;  
;setupPair	HL
	ld	hl, #_turret_anim_delay
;setupPair	HL
	ld	a, #0x0a
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00106$:
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
;main.c:170: if (!(boom_play)) {
;setupPair	HL
	ld	hl, #_boom_play
	bit	0, (hl)
	jr	NZ, 00102$
;main.c:172: NR41_REG = 0x00;  
	xor	a, a
	ldh	(_NR41_REG + 0), a
;main.c:173: NR42_REG = 0x92; 
	ld	a, #0x92
	ldh	(_NR42_REG + 0), a
;main.c:174: NR43_REG = 0x4f;  
	ld	a, #0x4f
	ldh	(_NR43_REG + 0), a
;main.c:175: NR44_REG = 0xC0; 
	ld	a, #0xc0
	ldh	(_NR44_REG + 0), a
00102$:
;main.c:178: inv_shot_x = 165; // hide shot
;setupPair	HL
	ld	hl, #_inv_shot_x
;setupPair	HL
	ld	a, #0xa5
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:179: inv_shot_y = 144; // hide shot
;setupPair	HL
	ld	hl, #_inv_shot_y
;setupPair	HL
	ld	a, #0x90
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:180: inv_fire_pause = 180; // and reset pause
;setupPair	HL
	ld	hl, #_inv_fire_pause
;setupPair	HL
	ld	a, #0xb4
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:182: boom_play = true;        
;setupPair	HL
	ld	hl, #_boom_play
	ld	(hl), #0x01
;main.c:183: blast_delay -= 1;
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
;main.c:185: if (blast_delay < 0) {
;setupPair	HL
	bit	7, (hl)
	ret	Z
;main.c:186: blast_delay = 60;
;setupPair	HL
	dec	hl
;setupPair	HL
	ld	a, #0x3c
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:187: boom_play = false;
;setupPair	HL
	ld	hl, #_boom_play
	ld	(hl), #0x00
;main.c:188: been_hit = false;
;setupPair	HL
	ld	hl, #_been_hit
	ld	(hl), #0x00
;main.c:189: bx = 165; // move boom off screen (following invader)
;setupPair	HL
	ld	hl, #_bx
;setupPair	HL
	ld	a, #0xa5
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:190: by = 144;
;setupPair	HL
	ld	hl, #_by
;setupPair	HL
	ld	a, #0x90
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:191: invader_x = ((unsigned char)rand() % (140 - 24 + 1)) + 24; // move invader to random x position       
	call	_rand
	ld	a, e
	ld	h, #0x75
;	spillPairReg hl
;	spillPairReg hl
	push	hl
	inc	sp
	push	af
	inc	sp
	call	__moduchar
	pop	hl
	ld	d, #0x00
	ld	hl, #0x0018
	add	hl, de
	ld	a, l
	ld	(_invader_x), a
	ld	a, h
	ld	(_invader_x + 1), a
;main.c:192: invader_y = 40; // move invader back up after being hit
;setupPair	HL
	ld	hl, #_invader_y
;setupPair	HL
	ld	a, #0x28
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:195: }
	ret
;main.c:200: void main() {
;	---------------------------------
; Function main
; ---------------------------------
_main::
	dec	sp
	dec	sp
;main.c:202: set_bkg_data(0, 66, title_data);
	ld	de, #_title_data
	push	de
	ld	hl, #0x4200
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:203: set_bkg_tiles(0, 0, 20, 18, title_map);
	ld	de, #_title_map
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;main.c:204: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:205: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:206: waitpad(J_START); // check for Start to be pressed
	ld	a, #0x80
	push	af
	inc	sp
	call	_waitpad
	inc	sp
;main.c:211: font_init();
	call	_font_init
;main.c:212: main_font = font_load(font_min);
	ld	de, #_font_min
	push	de
	call	_font_load
	pop	hl
;main.c:214: font_set(main_font);
	push	de
	call	_font_set
	pop	hl
;main.c:218: NR52_REG = 0x80;    // $80 is 1000 0000 in binary and turns on sound
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;main.c:219: NR50_REG = 0x77;    // $77 is 0111 0111 in binary and sets the volume for both left and right channel just set to max 0x77
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;main.c:220: NR51_REG = 0xFF;    // $FF is 1111 1111 in binary, select which chanels we want to use in this case all of them. 
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;main.c:226: SPRITES_8x16;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x04
	ldh	(_LCDC_REG + 0), a
;main.c:231: set_sprite_data(0, 16, sprites_turret); // starting at zero, push four 8x8 tiles from turret array into sprite data
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
;main.c:249: set_sprite_data(16, 16, sprites_invader);
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
;main.c:266: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:271: while(1) {
00156$:
;main.c:273: if(game_over) {
;setupPair	HL
	ld	hl, #_game_over
	bit	0, (hl)
	jp	Z, 00104$
;main.c:275: gotoxy(1, 1);        
	ld	hl, #0x101
	push	hl
	call	_gotoxy
	pop	hl
;main.c:276: printf("SCORE %d ", score);
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
;main.c:277: gotoxy(12, 1);
	ld	hl, #0x10c
	push	hl
	call	_gotoxy
	pop	hl
;main.c:278: printf("LIVES %d ", lives);
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
;main.c:279: gotoxy(5, 8);
	ld	hl, #0x805
	push	hl
	call	_gotoxy
	pop	hl
;main.c:280: printf("GAME  OVER");
	ld	de, #___str_2
	push	de
	call	_printf
	pop	hl
;main.c:284: if(joypad() & J_START) {                    
	call	_joypad
	ld	a, e
	rlca
	jr	NC, 00104$
;main.c:285: turret_x = 84;  // turret starting x
;setupPair	HL
	ld	hl, #_turret_x
;setupPair	HL
	ld	a, #0x54
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:286: turret_y = 125; // turret starting y
;setupPair	HL
	ld	hl, #_turret_y
;setupPair	HL
	ld	a, #0x7d
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:287: invader_x = 85; // invader starting x
;setupPair	HL
	ld	hl, #_invader_x
;setupPair	HL
	ld	a, #0x55
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:288: invader_y = 40; // invader starting y
;setupPair	HL
	ld	hl, #_invader_y
;setupPair	HL
	ld	a, #0x28
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:289: i_dir = 1;      // 1 = right, 0 = left
;setupPair	HL
	ld	hl, #_i_dir
;setupPair	HL
	ld	a, #0x01
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:290: lives = 3; // reset lives
;setupPair	HL
	ld	hl, #_lives
;setupPair	HL
	ld	a, #0x03
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:291: score = 0; // reset score
	xor	a, a
;setupPair	HL
	ld	hl, #_score
;setupPair	HL
	ld	(hl+), a
	ld	(hl), a
;main.c:292: explosion_play = false; 
;setupPair	HL
	ld	hl, #_explosion_play
	ld	(hl), #0x00
;main.c:293: turret_been_hit = false;  
;setupPair	HL
	ld	hl, #_turret_been_hit
	ld	(hl), #0x00
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 32)
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, #0x28
	ld	(hl+), a
	ld	(hl), #0x55
;main.c:295: move_sprite(9, invader_x + 8, invader_y);             
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
;main.c:296: game_over = false; 
;setupPair	HL
	ld	hl, #_game_over
	ld	(hl), #0x00
;main.c:297: gotoxy(5, 8);
	ld	hl, #0x805
	push	hl
	call	_gotoxy
	pop	hl
;main.c:298: printf("          "); // removes "GAME OVER" text                                                             
	ld	de, #___str_3
	push	de
	call	_printf
	pop	hl
00104$:
;main.c:304: if(!(game_over)){              
;setupPair	HL
	ld	hl, #_game_over
	bit	0, (hl)
	jp	NZ, 00156$
;main.c:306: move_anim_inv(); 
	call	_move_anim_inv
;main.c:309: invader_fire();      
	call	_invader_fire
;main.c:312: invader_hit(); 
	call	_invader_hit
;main.c:315: turret_hit();
	call	_turret_hit
;main.c:320: if(joypad() & J_RIGHT && !(turret_been_hit)) {            
	call	_joypad
	ld	a, e
	rrca
	jr	NC, 00108$
;setupPair	HL
	ld	hl, #_turret_been_hit
	bit	0, (hl)
	jr	NZ, 00108$
;main.c:321: if(turret_x < 142) {
;setupPair	HL
	ld	hl, #_turret_x
	ld	a, (hl+)
	sub	a, #0x8e
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00344$
	bit	7, d
	jr	NZ, 00345$
	cp	a, a
	jr	00345$
00344$:
	bit	7, d
	jr	Z, 00345$
	scf
00345$:
	jr	NC, 00108$
;main.c:322: turret_x += 1; 
;setupPair	HL
	ld	hl, #_turret_x
	inc	(hl)
	jr	NZ, 00346$
;setupPair	HL
	inc	hl
	inc	(hl)
00346$:
00108$:
;main.c:326: if(joypad() & J_LEFT && !(turret_been_hit)) {            
	call	_joypad
	bit	1, e
	jr	Z, 00113$
;setupPair	HL
	ld	hl, #_turret_been_hit
	bit	0, (hl)
	jr	NZ, 00113$
;main.c:327: if(turret_x > 21) {
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
	jr	Z, 00348$
	bit	7, d
	jr	NZ, 00349$
	cp	a, a
	jr	00349$
00348$:
	bit	7, d
	jr	Z, 00349$
	scf
00349$:
	jr	NC, 00113$
;main.c:328: turret_x -= 1; 
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
;main.c:332: if(joypad() & J_A && !(been_pressed) && !(shot_fired) && !(turret_been_hit)) {                 
	call	_joypad
	bit	4, e
	jr	Z, 00116$
;setupPair	HL
	ld	hl, #_been_pressed
	bit	0, (hl)
	jr	NZ, 00116$
;setupPair	HL
	ld	hl, #_shot_fired
	bit	0, (hl)
	jr	NZ, 00116$
;setupPair	HL
	ld	hl, #_turret_been_hit
	bit	0, (hl)
	jr	NZ, 00116$
;main.c:334: NR41_REG = 0x07;  
	ld	a, #0x07
	ldh	(_NR41_REG + 0), a
;main.c:335: NR42_REG = 0x72; 
	ld	a, #0x72
	ldh	(_NR42_REG + 0), a
;main.c:336: NR43_REG = 0x21;  
	ld	a, #0x21
	ldh	(_NR43_REG + 0), a
;main.c:337: NR44_REG = 0xC0;  
	ld	a, #0xc0
	ldh	(_NR44_REG + 0), a
;main.c:339: been_pressed = true;
;setupPair	HL
	ld	hl, #_been_pressed
	ld	(hl), #0x01
;main.c:340: shot_fired = true;               
;setupPair	HL
	ld	hl, #_shot_fired
	ld	(hl), #0x01
;main.c:341: sx=turret_x;
;setupPair	HL
	ld	a, (#_turret_x)
;setupPair	HL
	ld	(#_sx),a
;setupPair	HL
	ld	a, (#_turret_x + 1)
;setupPair	HL
	ld	(#_sx + 1),a
;main.c:342: sy=turret_y + 6;
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
;main.c:344: if(!(joypad() & J_A)) {
	call	_joypad
	bit	4, e
	jr	NZ, 00121$
;main.c:345: been_pressed = false; // fixes autofire, also with line below...
;setupPair	HL
	ld	hl, #_been_pressed
	ld	(hl), #0x00
00121$:
;main.c:350: if (shot_fired) {
;setupPair	HL
	ld	hl, #_shot_fired
	bit	0, (hl)
	jr	Z, 00127$
;main.c:351: sy -= 3;             
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
;main.c:353: if (sy < 41) {                    
;setupPair	HL
	ld	(hl-), a
	ld	a, (hl+)
	sub	a, #0x29
	ld	a, (hl)
	sbc	a, #0x00
	ld	d, (hl)
	ld	a, #0x00
	bit	7,a
	jr	Z, 00353$
	bit	7, d
	jr	NZ, 00354$
	cp	a, a
	jr	00354$
00353$:
	bit	7, d
	jr	Z, 00354$
	scf
00354$:
	jr	NC, 00127$
;main.c:354: if(!(been_pressed)) { // ...here!
;setupPair	HL
	ld	hl, #_been_pressed
	bit	0, (hl)
	jr	NZ, 00123$
;main.c:355: shot_fired = false;
;setupPair	HL
	ld	hl, #_shot_fired
	ld	(hl), #0x00
00123$:
;main.c:357: sx = 165;
;setupPair	HL
	ld	hl, #_sx
;setupPair	HL
	ld	a, #0xa5
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:358: sy = 0;
	xor	a, a
;setupPair	HL
	ld	hl, #_sy
;setupPair	HL
	ld	(hl+), a
	ld	(hl), a
00127$:
;main.c:365: ) {
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
	jr	Z, 00355$
	bit	7, d
	jr	NZ, 00356$
	cp	a, a
	jr	00356$
00355$:
	bit	7, d
	jr	Z, 00356$
	scf
00356$:
	jr	NC, 00129$
;main.c:366: inv_fired = false;
;setupPair	HL
	ld	hl, #_inv_fired
	ld	(hl), #0x00
;main.c:367: inv_shot_x = invader_x;
;setupPair	HL
	ld	a, (#_invader_x)
;setupPair	HL
	ld	(#_inv_shot_x),a
;setupPair	HL
	ld	a, (#_invader_x + 1)
;setupPair	HL
	ld	(#_inv_shot_x + 1),a
;main.c:368: inv_shot_y = invader_y;
;setupPair	HL
	ld	a, (#_invader_y)
;setupPair	HL
	ld	(#_inv_shot_y),a
;setupPair	HL
	ld	a, (#_invader_y + 1)
;setupPair	HL
	ld	(#_inv_shot_y + 1),a
;main.c:369: inv_fire_pause = 90;
;setupPair	HL
	ld	hl, #_inv_fire_pause
;setupPair	HL
	ld	a, #0x5a
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
00129$:
;main.c:374: if ((sx + 6 >= invader_x) && (sx + 6 <= invader_x + 10) && (sy + 4 <= invader_y + 8)) {
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
	jr	Z, 00357$
	bit	7, d
	jr	NZ, 00358$
	cp	a, a
	jr	00358$
00357$:
	bit	7, d
	jr	Z, 00358$
	scf
00358$:
	jr	C, 00131$
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
	jr	Z, 00359$
	bit	7, d
	jr	NZ, 00360$
	cp	a, a
	jr	00360$
00359$:
	bit	7, d
	jr	Z, 00360$
	scf
00360$:
	jr	C, 00131$
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
	jr	Z, 00361$
	bit	7, d
	jr	NZ, 00362$
	cp	a, a
	jr	00362$
00361$:
	bit	7, d
	jr	Z, 00362$
	scf
00362$:
	jr	C, 00131$
;main.c:375: sx = 165;
;setupPair	HL
	ld	hl, #_sx
;setupPair	HL
	ld	a, #0xa5
	ld	(hl+), a
	xor	a, a
	ld	(hl), a
;main.c:376: sy = 0;
	xor	a, a
;setupPair	HL
	ld	hl, #_sy
;setupPair	HL
	ld	(hl+), a
	ld	(hl), a
;main.c:377: been_hit = true;
;setupPair	HL
	ld	hl, #_been_hit
	ld	(hl), #0x01
;main.c:378: score += 10; 
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
00131$:
;main.c:383: if ((inv_shot_x + 6) >= (turret_x) && (inv_shot_x + 4) <= (turret_x + 12) && (inv_shot_y + 6) >= (turret_y + 9)) {
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
	jr	Z, 00363$
	bit	7, d
	jr	NZ, 00364$
	cp	a, a
	jr	00364$
00363$:
	bit	7, d
	jr	Z, 00364$
	scf
00364$:
	jp	C, 00139$
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
	jr	Z, 00365$
	bit	7, d
	jr	NZ, 00366$
	cp	a, a
	jr	00366$
00365$:
	bit	7, d
	jr	Z, 00366$
	scf
00366$:
	jr	C, 00139$
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
	jr	Z, 00367$
	bit	7, d
	jr	NZ, 00368$
	cp	a, a
	jr	00368$
00367$:
	bit	7, d
	jr	Z, 00368$
	scf
00368$:
	jr	C, 00139$
;main.c:384: if (!(turret_been_hit)) {
;setupPair	HL
	ld	hl, #_turret_been_hit
	bit	0, (hl)
	jr	NZ, 00139$
;main.c:385: lives -= 1;
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
;main.c:387: if (lives == 0) {  
;setupPair	HL
;setupPair	HL
	ld	a, (hl-)
	or	a, (hl)
	jr	NZ, 00135$
;main.c:389: NR41_REG = 0x09;  
	ld	a, #0x09
	ldh	(_NR41_REG + 0), a
;main.c:390: NR42_REG = 0xF1; 
	ld	a, #0xf1
	ldh	(_NR42_REG + 0), a
;main.c:391: NR43_REG = 0x81;  
	ld	a, #0x81
	ldh	(_NR43_REG + 0), a
;main.c:392: NR44_REG = 0xC0;  
	ld	a, #0xc0
	ldh	(_NR44_REG + 0), a
;main.c:394: game_over = true;                                                  
;setupPair	HL
	ld	hl, #_game_over
	ld	(hl), #0x01
00135$:
;main.c:396: turret_been_hit = true;            
;setupPair	HL
	ld	hl, #_turret_been_hit
	ld	(hl), #0x01
00139$:
;main.c:403: if (inv_fired) {
;setupPair	HL
	ld	hl, #_inv_fired
	bit	0, (hl)
	jr	Z, 00143$
;main.c:405: move_sprite(14, inv_shot_x, inv_shot_y);    // draw sprite 14 to these coordinates                  
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
;main.c:405: move_sprite(14, inv_shot_x, inv_shot_y);    // draw sprite 14 to these coordinates                  
	jr	00144$
00143$:
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #(_shadow_OAM + 56)
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	(hl), #0x90
	inc	hl
	ld	(hl), #0xa5
;main.c:409: move_sprite(14, 165, 144);                  // draw sprite 14 to these coordinates                 
00144$:
;main.c:413: if (!(turret_been_hit)) {
;setupPair	HL
	ld	hl, #_turret_been_hit
	bit	0, (hl)
	jr	NZ, 00151$
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x02
;main.c:415: set_sprite_tile(1, 2);            
	jr	00152$
00151$:
;main.c:420: if (turret_exp_frame == 1) {               
;setupPair	HL
	ld	hl, #_turret_exp_frame
;setupPair	HL
	ld	a, (hl+)
	dec	a
	or	a, (hl)
	jr	NZ, 00148$
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x04
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x06
;main.c:422: set_sprite_tile(1, 6); 
	jr	00152$
00148$:
;main.c:425: else if (turret_exp_frame == 2) {                
;setupPair	HL
	ld	hl, #_turret_exp_frame
;setupPair	HL
	ld	a, (hl+)
	sub	a, #0x02
	or	a, (hl)
	jr	NZ, 00152$
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x08
	ld	hl, #(_shadow_OAM + 6)
	ld	(hl), #0x0a
;main.c:427: set_sprite_tile(1, 10); 
00152$:
;main.c:430: move_sprite(0, turret_x, turret_y);     // draw sprite 0 to these coordinates
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
;main.c:431: move_sprite(1, turret_x + 8, turret_y); // draw sprite 1 to these coordinates
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
;main.c:434: move_sprite(6, sx, sy); // draw sprite 6 to these coordinates
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
;main.c:438: gotoxy(1, 1);        
	ld	hl, #0x101
	push	hl
	call	_gotoxy
	pop	hl
;main.c:439: printf("SCORE %d ", score);
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
;main.c:440: gotoxy(12, 1);
	ld	hl, #0x10c
	push	hl
	call	_gotoxy
	pop	hl
;main.c:441: printf("LIVES %d ", lives);
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
;main.c:446: wait_vbl_done(); // helps keep framerate
	call	_wait_vbl_done
	jp	00156$
;main.c:449: }
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
	.dw #0x0054
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
__xinit__boom_play:
	.db #0x00	;  0
__xinit__score:
	.dw #0x0000
__xinit__lives:
	.dw #0x0003
__xinit__game_over:
	.db #0x00	;  0
__xinit__been_pressed:
	.db #0x00	;  0
	.area _CABS (ABS)
