Wait_Recal          EQU      $F192                        ; 
Moveto_d            EQU      $F312                        ; 
Intensity_a         EQU      $F2AB                        ; 
Read_Btns       EQU     $F1BA   ;
                    bss      
                    org      $c880 
intensityMalban     ds       1 
presentsFlag        ds       1 
countDownIntro ds 1
counter2 ds 1
                    code     
introMalban: 
                    clr      intensityMalban 
                    clr      presentsFlag 
 lda #70
 sta countDownIntro
 sta counter2
loopIntro1 
                    jsr      voxSentence 
 jsr PLY_PLAY   
 jsr do_ym_sound2


 jsr Read_Btns
 lda >$c80F
 anda #$f
 sta >$c80F
 cmpa #1
 bne nOptions1
 jsr editOptions 
 bra optionsDone1
nOptions1
 tsta
 bne exitPresenting
optionsDone1
 
                    JSR      Wait_Recal                   ; Vectrex BIOS recalibration 
                    lda      intensityMalban 
                    JSR      Intensity_a                  ; Sets the intensity of the 
                    ldb      #$30                         ; scale move in list 
                    stb      <VIA_t1_cnt_lo               ; to timer t1 (lo= 
                                                          ; vector beam to $5f 
                    ldu      #malbanVList                 ; address of list 
                    jsr      draw_synced_list2 
                    ldu      #malbanVList                 ; address of list 
                    jsr      draw_synced_list2 
                    ldu      #malbanVList                 ; address of list 
                    jsr      draw_synced_list2 

            lda      presentsFlag 
                    bne      notToMuch 

                    ldu      #malbanVList                 ; address of list 
                    jsr      draw_synced_list2 
notToMuch



            lda      presentsFlag 
                    beq      nopresenting 
                                                          ; vector beam to $5f 
                    ldu      #presentsVlist               ; address of list 
                    jsr      draw_synced_list2 
nopresenting 
                    lda      intensityMalban 
                    adda     #1
                    sta      intensityMalban 
                    cmpa     #$7f 
                    bls      intOk1 
    lda     #$7f
    sta      intensityMalban 
 dec counter2
 bne loopIntro1
 inc counter2
                    lda      #$7f 
                    sta      presentsFlag 
 dec countDownIntro
 beq exitPresenting
intOk1 
                    sta      intensityMalban 
                    BRA      loopIntro1                   ; and repeat forever 
exitPresenting
 rts
;***************************************************************************
; SUBROUTINE SECTION
;***************************************************************************
;ZERO ing the integrators takes time. Measures at my vectrex show e.g.:
;If you move the beam with a to x = -127 and y = -127 at diffferent scale values, the time to reach zero:
;- scale $ff -> zero 110 cycles
;- scale $7f -> zero 75 cycles
;- scale $40 -> zero 57 cycles
;- scale $20 -> zero 53 cycles
ZERO_DELAY          EQU      7                            ; delay 7 counter is exactly 111 cycles delay between zero SETTING and zero unsetting (in moveto_d) 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;U = address of vectorlist
;X = (y,x) position of vectorlist (this will be point 0,0), positioning on screen
;A = scalefactor "Move" (after sync)
;B = scalefactor "Vector" (vectors in vectorlist)
;
;     mode, rel y, rel x,                                             
;     mode, rel y, rel x,                                             
;     .      .      .                                                
;     .      .      .                                                
;     mode, rel y, rel x,                                             
;     0x02
; where mode has the following meaning:         
; negative draw line                    
; 0 move to specified endpoint                              
; 1 sync (and move to list start and than to place in vectorlist)      
; 2 end
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
draw_synced_list2: 
                    ldx      #$3000 
                                                          ; first list entry (first will be a sync + moveto_d, so we just stay here!) 
                    lda      ,u+                          ; this will be a "1" 
sync2: 
                    deca                                  ; test if real sync - or end of list (2) 
                    bne      drawdone2                     ; if end of list -> jump 
; zero integrators
                    ldb      #$CC                         ; zero the integrators 
                    stb      <VIA_cntl                    ; store zeroing values to cntl 
                    ldb      #ZERO_DELAY                  ; and wait for zeroing to be actually done 
; reset integrators
                    clr      <VIA_port_a                  ; reset integrator offset 
                    lda      #%10000010 
; wait that zeroing surely has the desired effect!
zeroLoop2: 
                    sta      <VIA_port_b                  ; while waiting, zero offsets 
                    decb     
                    bne      zeroLoop2 
                    inc      <VIA_port_b 
moveTo2: 
                    ldd      ,u                           ; do our "internal" moveto d 
                    MY_MOVE_TO_D_START  
                    leau     2,u 
                    MY_MOVE_TO_B_END  
;nextListEntry: 
                    lda      ,u+                          ; load next "mode" byte 
                    beq      moveTo2                       ; if 0, than we should move somewhere 
                    bpl      sync2                         ; if still positive it is a 1 pr 2 _> goto sync 
; now we should draw a vector 
                    ldd      ,u                           ;Get next coordinate pair 
                    STA      <VIA_port_a                  ;Send Y to A/D 
                    LDA      #0                           ;Get pattern byte 
                    sta      <VIA_port_b                  ;Enable mux 
                    deca                                  ; $ff 
                    INC      <VIA_port_b                  ;Disable mux 
                    STB      <VIA_port_a                  ;Send X to A/D 
                    stx      <VIA_t1_cnt_lo               ;Clear T1H 
                    sta      <VIA_shift_reg               ;Store pattern in shift register 
                    leau     2,u 
                    LDB      #$40                         ;B-reg = T1 interrupt bit 
WaitILoop2: 
                    BITB     <VIA_int_flags               ;Wait for T1 to time out 
                    beq      WaitILoop2                    ; wait till line is finished 
                    clra     
nextListEntry2 
                    sta      <VIA_shift_reg               ; switch the light off (for sure) 
                    lda      ,u+                          ; load next "mode" byte 
                    beq      moveTo2                       ; if 0, than we should move somewhere 
                    bpl      sync2                         ; if still positive it is a 1 pr 2 _> goto sync 
; now we should draw a vector 
                    ldd      ,u                           ;Get next coordinate pair 
                    STA      <VIA_port_a                  ;Send Y to A/D 
                    LDA      #0                           ;Get pattern byte 
                    sta      <VIA_port_b                  ;Enable mux 
                    deca                                  ; $ff 
                    INC      <VIA_port_b                  ;Disable mux 
                    STB      <VIA_port_a                  ;Send X to A/D 
                    stx      <VIA_t1_cnt_lo               ;Clear T1H 
                    sta      <VIA_shift_reg               ;Store pattern in shift register 
                    leau     2,u 
                    clra     
                    LDB      #$40                         ;B-reg = T1 interrupt bit 
WaitILoop22: 
                    BITB     <VIA_int_flags               ;Wait for T1 to time out 
                    beq      WaitILoop22                   ; wait till line is finished 
                    bra      nextListEntry2 

drawdone2: 
                    rts      

;***************************************************************************
; DATA SECTION
;***************************************************************************
malbanVList: 
                    DB       $01, +$4B, -$4B              ; sync and move to y, x 
                    DB       $00, +$48, -$4B              ; additional sync move to y, x 
                    DB       $00, +$00, -$14              ; additional sync move to y, x 
                    DB       $FF, +$4B, +$00              ; draw, y, x 
                    DB       $FF, -$25, +$12              ; draw, y, x 
                    DB       $FF, +$00, +$0C              ; draw, y, x 
                    DB       $FF, +$25, +$0F              ; draw, y, x 
                    DB       $FF, -$4B, +$00              ; draw, y, x 
                    DB       $00, +$00, +$12              ; mode, y, x 
                    DB       $FF, +$26, +$00              ; draw, y, x 
                    DB       $FF, +$25, +$0F              ; draw, y, x 
                    DB       $FF, +$00, +$07              ; draw, y, x 
                    DB       $01, +$4B, -$4B              ; sync and move to y, x 
                    DB       $00, +$4B, -$0A              ; additional sync move to y, x 
                    DB       $00, +$48, +$00              ; additional sync move to y, x 
                    DB       $FF, -$25, +$0F              ; draw, y, x 
                    DB       $FF, +$00, -$25              ; draw, y, x 
                    DB       $00, +$00, +$25              ; mode, y, x 
                    DB       $FF, -$26, +$00              ; draw, y, x 
                    DB       $00, +$4B, +$14              ; mode, y, x 
                    DB       $FF, -$4B, +$00              ; draw, y, x 
                    DB       $FF, +$00, +$2D              ; draw, y, x 
                    DB       $00, +$00, +$14              ; mode, y, x 
                    DB       $FF, +$4B, +$00              ; draw, y, x 
                    DB       $01, +$4B, +$0F              ; sync and move to y, x 
                    DB       $00, +$4B, +$00              ; additional sync move to y, x 
                    DB       $00, +$48, +$00              ; additional sync move to y, x 
                    DB       $FF, +$00, +$1E              ; draw, y, x 
                    DB       $FF, -$0F, +$05              ; draw, y, x 
                    DB       $FF, -$14, -$0F              ; draw, y, x 
                    DB       $FF, -$05, +$19              ; draw, y, x 
                    DB       $FF, -$1E, +$00              ; draw, y, x 
                    DB       $FF, -$05, -$2D              ; draw, y, x 
                    DB       $00, +$00, +$41              ; mode, y, x 
                    DB       $FF, +$26, +$00              ; draw, y, x 
                    DB       $FF, +$25, +$0F              ; draw, y, x 
                    DB       $01, +$4B, +$4B              ; sync and move to y, x 
                    DB       $00, +$4B, +$14              ; additional sync move to y, x 
                    DB       $00, +$48, +$00              ; additional sync move to y, x 
                    DB       $FF, +$00, +$07              ; draw, y, x 
                    DB       $FF, -$25, +$0F              ; draw, y, x 
                    DB       $FF, +$00, -$25              ; draw, y, x 
                    DB       $00, +$00, +$25              ; mode, y, x 
                    DB       $FF, -$26, +$00              ; draw, y, x 
                    DB       $00, +$00, +$12              ; mode, y, x 
                    DB       $FF, +$4B, +$00              ; draw, y, x 
                    DB       $FF, -$4B, +$2D              ; draw, y, x 
                    DB       $FF, +$4B, +$00              ; draw, y, x 
                    DB       $02                          ; endmarker 
presentsVlist: 
                    DB       $01, +$19, -$19              ; sync and move to y, x 
                    DB       $00, +$19, -$19              ; additional sync move to y, x 
                    DB       $00, +$00, -$11              ; additional sync move to y, x 
                    DB       $FF, +$00, +$0A              ; draw, y, x 
                    DB       $FF, +$02, +$02              ; draw, y, x 
                    DB       $FF, +$08, +$00              ; draw, y, x 
                    DB       $FF, +$02, -$02              ; draw, y, x 
                    DB       $FF, +$00, -$0A              ; draw, y, x 
                    DB       $FF, -$19, +$00              ; draw, y, x 
                    DB       $00, +$00, +$11              ; mode, y, x 
                    DB       $01, +$19, -$19              ; sync and move to y, x 
                    DB       $00, +$0C, -$19              ; additional sync move to y, x 
                    DB       $FF, +$19, +$00              ; draw, y, x 
                    DB       $FF, +$00, +$0A              ; draw, y, x 
                    DB       $FF, -$02, +$03              ; draw, y, x 
                    DB       $FF, -$08, +$00              ; draw, y, x 
                    DB       $FF, -$02, -$03              ; draw, y, x 
                    DB       $FF, +$00, -$0A              ; draw, y, x 
                    DB       $FF, +$00, +$08              ; draw, y, x 
                    DB       $FF, -$0D, +$05              ; draw, y, x 
                    DB       $01, +$19, -$19              ; sync and move to y, x 
                    DB       $00, +$0C, -$0C              ; additional sync move to y, x 
                    DB       $00, +$19, +$11              ; mode, y, x 
                    DB       $FF, +$00, -$0C              ; draw, y, x 
                    DB       $FF, -$0A, +$00              ; draw, y, x 
                    DB       $FF, -$02, +$0A              ; draw, y, x 
                    DB       $FF, -$03, -$0A              ; draw, y, x 
                    DB       $FF, -$0A, +$00              ; draw, y, x 
                    DB       $FF, +$00, +$0C              ; draw, y, x 
                    DB       $01, +$19, -$14              ; sync and move to y, x 
                    DB       $00, +$0C, +$00              ; additional sync move to y, x 
                    DB       $00, +$03, +$05              ; mode, y, x 
                    DB       $FF, -$03, +$03              ; draw, y, x 
                    DB       $FF, +$00, +$07              ; draw, y, x 
                    DB       $FF, +$03, +$03              ; draw, y, x 
                    DB       $FF, +$07, +$00              ; draw, y, x 
                    DB       $FF, +$03, -$03              ; draw, y, x 
                    DB       $FF, +$00, -$07              ; draw, y, x 
                    DB       $FF, +$02, -$03              ; draw, y, x 
                    DB       $01, +$19, -$0F              ; sync and move to y, x 
                    DB       $00, +$19, +$00              ; additional sync move to y, x 
                    DB       $00, +$02, +$00              ; additional sync move to y, x 
                    DB       $FF, +$08, +$00              ; draw, y, x 
                    DB       $FF, +$02, +$03              ; draw, y, x 
                    DB       $FF, +$00, +$07              ; draw, y, x 
                    DB       $FF, -$02, +$03              ; draw, y, x 
                    DB       $00, +$02, +$11              ; mode, y, x 
                    DB       $FF, +$00, -$0D              ; draw, y, x 
                    DB       $FF, -$0A, +$00              ; draw, y, x 
                    DB       $01, +$19, +$02              ; sync and move to y, x 
                    DB       $00, +$19, +$00              ; additional sync move to y, x 
                    DB       $00, +$02, +$00              ; additional sync move to y, x 
                    DB       $FF, -$02, +$0A              ; draw, y, x 
                    DB       $FF, -$03, -$0A              ; draw, y, x 
                    DB       $FF, -$0A, +$00              ; draw, y, x 
                    DB       $FF, +$00, +$0D              ; draw, y, x 
                    DB       $00, +$00, +$05              ; mode, y, x 
                    DB       $FF, +$19, +$00              ; draw, y, x 
                    DB       $FF, -$19, +$0C              ; draw, y, x 
                    DB       $FF, +$19, +$00              ; draw, y, x 
                    DB       $01, +$19, +$19              ; sync and move to y, x 
                    DB       $00, +$19, +$07              ; additional sync move to y, x 
                    DB       $00, +$0C, +$00              ; additional sync move to y, x 
                    DB       $00, +$00, +$05              ; mode, y, x 
                    DB       $FF, +$00, +$0F              ; draw, y, x 
                    DB       $00, +$00, -$07              ; mode, y, x 
                    DB       $FF, -$19, +$00              ; draw, y, x 
                    DB       $00, +$03, +$0C              ; mode, y, x 
                    DB       $FF, -$03, +$03              ; draw, y, x 
                    DB       $FF, +$00, +$07              ; draw, y, x 
                    DB       $FF, +$03, +$03              ; draw, y, x 
                    DB       $01, +$19, +$19              ; sync and move to y, x 
                    DB       $00, +$0F, +$19              ; additional sync move to y, x 
                    DB       $00, +$00, +$14              ; additional sync move to y, x 
                    DB       $FF, +$07, +$00              ; draw, y, x 
                    DB       $FF, +$03, -$03              ; draw, y, x 
                    DB       $FF, +$00, -$07              ; draw, y, x 
                    DB       $FF, +$02, -$03              ; draw, y, x 
                    DB       $FF, +$08, +$00              ; draw, y, x 
                    DB       $FF, +$02, +$03              ; draw, y, x 
                    DB       $FF, +$00, +$07              ; draw, y, x 
                    DB       $FF, -$02, +$03              ; draw, y, x 
                    DB       $02                          ; endmarker 
