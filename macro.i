; dome Bruce Tomlin like defines
; and macros
Read_Btns           EQU      $F1BA                        ; 
Move_Mem_a          EQU      $F683                        ; 
VIA_port_b          EQU      $D000                        ;VIA port B data I/O register 

VIA_port_a          EQU      $D001                        ;VIA port A data I/O register (handshaking) 
VIA_DDR_b           EQU      $D002                        ;VIA port B data direction register (0=input 1=output) 
VIA_DDR_a           EQU      $D003                        ;VIA port A data direction register (0=input 1=output) 
VIA_t1_cnt_lo       EQU      $D004                        ;VIA timer 1 count register lo (scale factor) 
VIA_t1_cnt_hi       EQU      $D005                        ;VIA timer 1 count register hi 
VIA_t1_lch_lo       EQU      $D006                        ;VIA timer 1 latch register lo 
VIA_t1_lch_hi       EQU      $D007                        ;VIA timer 1 latch register hi 
VIA_t2_lo           EQU      $D008                        ;VIA timer 2 count/latch register lo (refresh) 
VIA_t2_hi           EQU      $D009                        ;VIA timer 2 count/latch register hi 
VIA_shift_reg       EQU      $D00A                        ;VIA shift register 
VIA_aux_cntl        EQU      $D00B                        ;VIA auxiliary control register 
VIA_cntl            EQU      $D00C                        ;VIA control register 
VIA_int_flags       EQU      $D00D                        ;VIA interrupt flags register 
VIA_int_enable      EQU      $D00E                        ;VIA interrupt enable register 
VIA_port_a_nohs     EQU      $D00F                        ;VIA port A data I/O register (no handshaking) 

MY_MOVE_TO_D_START  macro    
                    STA      <VIA_port_a                  ;Store Y in D/A register 
                    LDA      #$CE                         ;Blank low, zero high? 
                    STA      <VIA_cntl                    ; 
                    CLRA     
                    STA      <VIA_port_b                  ;Enable mux ; hey dis si "break integratorzero 440" 
                    brn      0                            ; y must be set more than xx cycles on some vectrex 
                    INC      <VIA_port_b                  ;Disable mux 
                    STB      <VIA_port_a                  ;Store X in D/A register 
                    STA      <VIA_t1_cnt_hi               ;enable timer 
                    endm     
MY_MOVE_TO_B_END    macro    
                    local    LF33D 
                    LDB      #$40                         ; 
LF33D\?:            BITB     <VIA_int_flags               ; 
                    BEQ      LF33D\?                      ; 
                    endm     

MY_MOVE_TO_D macro
 MY_MOVE_TO_D_START
 MY_MOVE_TO_B_END
 endm

_ZERO_VECTOR_BEAM   macro    
                    LDB      #$CC 
                    STB      VIA_cntl                     ;/BLANK low and /ZERO low 
                    endm     
_INTENSITY_A        macro    
                    STA      <VIA_port_a                  ;Store intensity in D/A 
                    LDD      #$0504                       ;mux disabled channel 2 
                    STA      <VIA_port_b                  ; 
                    STB      <VIA_port_b                  ;mux enabled channel 2 
                    STA      <VIA_port_b                  ;turn off mux 
                    endm     
DOUBLE_DRAW_OUTER_ZERO  macro  _pos, _x, _y 
                    ldd      #_pos 
                    MY_MOVE_TO_D_START  
                    lda      #$00 
                    MY_MOVE_TO_B_END  
                    nop      
                    STA      <VIA_port_a                  ;Send Y to A/D 
                    STA      <VIA_port_b                  ;Enable mux 
                    ldb      #_x 
                    nop      
                    nop      
                    INC      <VIA_port_b                  ;Disable mux 
                    STB      <VIA_port_a                  ;Send X to A/D 
                    ldb      #$ff 
                    STb      <VIA_shift_reg               ;Put pattern in shift register 
                    STa      <VIA_t1_cnt_hi               ;Set T1H (scale factor?) 
                    LDb      #$40                         ;B-reg = T1 interrupt bit 
LF3F4_1\? 
                    BITB     <VIA_int_flags               ;Wait for T1 to time out 
                    BEQ      LF3F4_1\? 
                    ldb      #_y 
                    STb      <VIA_port_a                  ;Send Y to A/D 
                    STA      <VIA_port_b                  ;Enable mux 
                    nop      
                    brn      0 
                    INC      <VIA_port_b                  ;Disable mux 
                    STA      <VIA_port_a                  ;Send X to A/D 
                    STa      <VIA_t1_cnt_hi               ;Set T1H (scale factor?) 
                    LDb      #$40                         ;B-reg = T1 interrupt bit 
LF3F4_2\? 
                    BITB     <VIA_int_flags               ;Wait for T1 to time out 
                    BEQ      LF3F4_2\? 
                    LDB      #$CC 
                    STa      <VIA_shift_reg               ;Put pattern in shift register 
                    STB      VIA_cntl                     ;/BLANK low and /ZERO low 
                    endm     
;***************************************************************************
; divide (unsigned) D by 16 bit in TMP1
; result in B
; SLOW!
MY_DIV_D_BY_TMP1_TO_B  macro  
                    CLR      divide_tmp 
                    tst      tmp1 
                    bne      notZero\? 
                    tst      tmp1+1 
                    bne      notZero\? 
                    Bra      divide_by_zero\? 

notZero\? 
                    DEC      divide_tmp 
                    BRA      divide_next\? 

divide_by_zero1\?: 
                    LDB      divide_tmp 
                    NEGB     
                    BRA      divide_end\? 

divide_next\?: 
                    INC      divide_tmp 
                    SUBD     tmp1 
                    bcc      divide_next\? 
divide_by_zero\?: 
                    LDB      divide_tmp 
divide_end\?: 
                    endm     

; doesn't check diagonals!
; return edge crossing in the usual 4 bit format of berzerk
; this does not check actual walls - it checks if the relative position of the object
; with the current speed is outside of the coordinates of one quadrant!

CHECK_FOR_QUADRANT_EDGE_CROSSING macro MAP
                    clrb                                  ; 
                    cmpa     MAP                           ; 
                    bge      P0ED0\?                      ; 
                    orb      #$08                         ; 
                    bra      P0ED6\?                      ; 

P0ED0\?:            cmpa     MAP+1                          ; 
                    ble      P0ED6\?                      ; 
                    orb      #$04                         ; 
P0ED6\?:            lda      <$9C                         ; 
                    cmpa     MAP+2                          ; 
                    ble      P0EDF\?                      ; 
                    orb      #$02                         ; 
                    bra    P0EE5\?                                ; 

P0EDF\?:            cmpa     MAP+3                          ; 
                    bge      P0EE5\?                      ; 
                    orb      #$01                         ; 
P0EE5\?:                                                  ;        
                    endm     

*
* CheckForContact()
*
* This function checks to see if two objects have come
* into contact (such as a bullet and a robot, a bullet
* and the player, or a robot and the player.  The 2
* objects do not need to come into exact contact, but
* rather, they only need to come within a prespecified
* distance.
*
* Entry:
*   x = ptr to object to which contact is being checked.
*   a = y position to check for contact with object.
*   b = x position to check for contact with object.
*   y = ptr to table telling how close contact must be.
*
* Exit:
*   The carry bit will be set if contact was made.
CHECK_FOR_CONTACT macro MAP
                    suba     ,x                           ; 
                    subb     1,x                          ; 
                    cmpa     MAP                           ; 
                    bgt      P0D32\?                        ; 
                    cmpa     MAP+1                          ; 
                    blt      P0D32\?                        ; 
                    cmpb     MAP+2                         ; 
                    bgt      P0D32\?                        ; 
                    cmpb     MAP+3                         ; 
                    blt      P0D32\?                        ; 
                    orcc     #$01                         ; 
                    bra   mEnd\?                                 ; 

P0D32\?:              andcc    #$FE                         ; 
mEnd\?       
 endm













UPDATE_ONE_BULLET macro
                    lda      B_VELOCITY,u                 ; 
                    deca                                  ; original map is for 1 
                    sta      <$f2                         ; tmp 
; update position in relation to direction and velocity
                    ldb      B_DIRECTION,u                ; 
                    bitb     #1 
                    beq      noLeft_f\? 
                    lda      B_XPOS,u 
                    suba     B_VELOCITY,u                 ; 
                    sta      B_XPOS,u 
                    lda      B_XPOS_TAIL,u 
                    suba     B_VELOCITY,u                 ; 
                    sta      B_XPOS_TAIL,u 
                    bra      doVertical_f\? 

noLeft_f\?
                    bitb     #2 
                    beq      noRight_f\? 
                    lda      B_XPOS,u 
                    adda     B_VELOCITY,u                 ; 
                    sta      B_XPOS,u 
                    lda      B_XPOS_TAIL,u 
                    adda     B_VELOCITY,u                 ; 
                    sta      B_XPOS_TAIL,u 
noRight_f\? 
doVertical_f\? 
                    bitb     #4 
                    beq      noup_f\?
                    lda      B_YPOS,u 
                    adda     B_VELOCITY,u                 ; 
                    sta      B_YPOS,u 
                    lda      B_YPOS_TAIL,u 
                    adda     B_VELOCITY,u                 ; 
                    sta      B_YPOS_TAIL,u 
                    bra      moveUpdatefinished_f\?

noup_f\?
                    bitb     #8 
                    beq      noDown_f\? 
                    lda      B_YPOS,u 
                    suba     B_VELOCITY,u                 ; 
                    sta      B_YPOS,u 
                    lda      B_YPOS_TAIL,u 
                    suba     B_VELOCITY,u                 ; 
                    sta      B_YPOS_TAIL,u 
noDown_f\?
moveUpdatefinished_f\?

; idea:
; seperate player/robot bullets in the processing
; than we don't have tobuild that everytime when bullets "alternate"

; create a BulletToWallThresholds in relation to speed
;BulletToWallThresholds
                    lda      B_VELOCITY,u                 ; 
                    cmpa     currentMapVelocity 
                    beq      mapKnown\? 
                    sta      currentMapVelocity 
;BulletToWallThresholds:
;       DB    $01;
;       DB    $3F;
;       DB    $27;
;       DB    $01;
                    lda      BulletToWallThresholds 
                    adda     <$f2 
                    sta      MapVelocity 
                    sta      MapVelocity+3 
                    lda      BulletToWallThresholds+1 
                    suba     <$f2 
                    sta      MapVelocity+1 
                    lda      BulletToWallThresholds+2 
                    suba     <$f2 
                    sta      MapVelocity+2 
mapKnown\? 
* See if bullet collided with a wall
                    ldd      B_YPOS_TAIL,u                ; * Bullet's head position 
                    jsr      MapPointToQnMakeRel          ;MapPointToQuadrantAndMakeRelative; 
;                    tst      <quadrantOfPoint             ; 
;                    bmi      noWallHere\?                      ; 
; do one check for complete speed!
;                    ldx      #MapVelocity 
                    CHECK_FOR_QUADRANT_EDGE_CROSSING  MapVelocity ; jsr CheckForQuadrantEdgeCrossing ; 
noWallHere\?           
                    ; in $99 is the bitmap of the current walls
                    ; in b is the bitmap of the current "edge" corssing of the quadrant
                    bitb     <$99                         ; * Contact with wall? 
                    beq      noWallHit\?                     ; 
                    jsr      removeBullet 
 bra skipUpdate
noWallHit\?

 endm


; destroys d 
INIT_VOX_SPEECH_DIRECT macro speechaddr, pitchAddr
 lda [vox_addr]
 cmpa #VOX_TERM       ; 
 bne noNewSpeech\?        ; ...if so, exit
 lda pitch_addr
 bne noNewSpeech\?
 lda sentence_addr
 bne noNewSpeech\?
 ldd #pitchAddr
 std pitch_addr
 ldd #speechaddr
 std sentence_addr
noNewSpeech\?
 endm

FORCE_INIT_VOX_SPEECH_DIRECT macro speechaddr, pitchAddr
 ldd #pitchAddr
 std pitch_addr
 ldd #speechaddr
 std sentence_addr
noNewSpeech\?
 endm

; speech sentence adr in x
; speech pitch adr in u
; destroys a 
INIT_VOX_SPEECH_X macro
 lda [vox_addr]
 cmpa    #VOX_TERM       ; 
 bne     noNewSpeech\?        ; ...if so, exit
 stx sentence_addr
 stu pitch_addr
noNewSpeech\?
 endm
_DP_TO_C8           macro                                 ;   pretty for optimizing to use a makro :-) 
                    LDA      #$C8 
                    TFR      A,DP 
                    direct   $C8 
                    endm     
;***************************************************************************
_DP_TO_D0           macro                                 ;   pretty for optimizing to use a makro :-) 
                    LDA      #$D0 
                    TFR      A,DP 
                    direct   $D0 
                    endm     

;
;***************************************************************************
; this makro is supposed to 'reset' the sound hardware,
MY_QUIT             macro    
                    CLR      Vec_Music_Flag               ; no music is playing ->0 
                    JSR      Init_Music_Buf               ; shadow regs 
                                                          ; in the next do sound call 
                                                          ; all regs are cleared automatically 
                    endm                                  ; end of macro 
;***************************************************************************
; this makro should be called every round a music is to be played
; this does not play the sound, it initializes it only, but also every round!
;
; BIOS MUSIC
; leaves with DP set to C8
; expects music to be initialized
; and pointer in music_active
DO_MY_SOUND         macro                                 ; name of macro 
                    _DP_TO_C8                             ; (MAKRO) the 'Init_Music_chk' expects this 
                   ; LDU      music_active                 ; get active music 
                   ; JSR      Init_Music_chk               ; and init new notes 
                    endm                                  ; end of macro 

;***************************************************************************
; this makro is sort of the startup for every display round
; does all sound stuff and recalibration, leaves with
; DP set to D0
; destroyes pretty much every register...
; BIOS MUSIC
ROUND_STARTUP       macro                                 ; name of macro 
                    tst      musicOption 
                    bne      doNotPlayMusic\? 
                    DO_MY_SOUND                           ; (MAKRO) see above 
doNotPlayMusic\? 
                    ldx      RecalCounter                 ; recal counter, about 21 Minutes befor roll over 
                    leax     1,x 
                    stx      RecalCounter 
                    JSR      Wait_Recal                   ; sets dp to d0, and pos at 0, 0 
                    direct   $D0                          ; just for assembler optimization... 
                    JSR      Do_Sound                     ; ROM function that does the sound playing 
                    endm                                  ; end of macro 
ROUND_STARTUP2       macro                                 ; name of macro 
                    ldx      RecalCounter                 ; recal counter, about 21 Minutes befor roll over 
                    leax     1,x 
                    stx      RecalCounter 
                    JSR      Wait_Recal                   ; sets dp to d0, and pos at 0, 0 
                    direct   $D0                          ; just for assembler optimization... 
                    endm                                  ; end of macro 
;***************************************************************************
_SCALE_A            macro    
                    STA      VIA_t1_cnt_lo                ; move to time 1 lo, this means scaling 
                    endm     


;***************************************************************************
QUERY_JOYSTICK      macro    
; joytick pot readings are also switched by the (de)muliplexer (analog section)
; with joystick pots the switching is not done in regard of the output (in opposite to "input" switching of integrator logic)
; but with regard to input
; thus, the SEL part of the mux now selects which joystick pot is selected and send to the compare logic.
; mux sel:
;    xxxx x00x: port 0 horizontal
;    xxxx x01x: port 0 vertical
;    xxxx x10x: port 1 horizontal
;    xxxx x11x: port 1 vertical
; 
; the result of the pot reading is compared to the 
; value present in the dac and according to the comparisson the compare flag of VIA (bit 5 of port b) is set.
; (compare bit is set if contents of dac was "smaller" (signed) than the "pot" read)
DIGITAL_JOYTICK_LOOP_MIN  EQU  $08 
                    ldd      #$0300                       ; mux disabled, mux sel = 01 (vertical pot port 0) 
                    std      <VIA_port_b 
                    dec      <VIA_port_b                  ; mux enabled, mux sel = 01 
                    ldb      #DIGITAL_JOYTICK_LOOP_MIN    ; a wait loop 32 times a loop (waiting for the pots to "read" values, and feed to compare logic) 
waitLoopV\?: 
                    decb                                  ; ... 
                    bne      waitLoopV\?                  ; wait... 
                    inc      <VIA_port_b                  ; disable mux 
                    ldd      #$4020                       ; load a with test value (positive y) 
                    sta      <VIA_port_a                  ; test value to DAC 
                    lda      #$01                         ; default result value y was pushed UP 
                    bitb     <VIA_port_b                  ; test comparator 
                    bne      yReadDone\?                  ; if comparator cleared - joystick was moved up 
                    neg      <VIA_port_a                  ; "load" with negative value 
                    nega                                  ; also switch the possible result in A 
                    bitb     <VIA_port_b                  ; test comparator again 
                    beq      yReadDone\?                  ; if cleared the joystick was moved down 
                    clra                                  ; if still not cleared, we clear a as the final vertical test result (no move at all) 
yReadDone\?: 
                    sta      >Vec_Joy_1_Y                 ; remember the result in "our" joystick data 

noymove\? 
;
; now the same for horizontal
                    ldd      #$0100                       ; mux disabled, mux sel = 00 (horizontal pot port 0) 
                    std      <VIA_port_b 
                    dec      <VIA_port_b                  ; mux enabled, mux sel = 01 
                    ldb      #DIGITAL_JOYTICK_LOOP_MIN    ; a wait loop 32 times a loop (waiting for the pots to "read" values, and feed to compare logic) 
waitLoopH\?: 
                    decb                                  ; ... 
                    bne      waitLoopH\?                  ; wait... 
                    inc      <VIA_port_b                  ; disable mux 
                    ldd      #$4020                       ; load a with test value (positive x) 
                    sta      <VIA_port_a                  ; test value to DAC 
                    lda      #$01                         ; default result value x was pushed right 
                    bitb     <VIA_port_b                  ; test comparator 
                    bne      xReadDone\?                  ; if comparator cleared - joystick was moved right 
                    neg      <VIA_port_a                  ; "load" with negative value 
                    nega                                  ; also switch the possible result in A 
                    bitb     <VIA_port_b                  ; test comparator again 
                    beq      xReadDone\?                  ; if cleared the joystick was moved left 
                    clra                                  ; if still not cleared, we clear a as the final vertical test result (no move at all) 
xReadDone\?: 
                    sta      >Vec_Joy_1_X                 ; remember the result in "our" joystick data 
noxmove\? 
                    endm     
