; replaces robots at $C91C
optionSelected      EQU      $C91C                        ; $c880 
Intensity_3F        EQU      $F2A1 
                    code     
editOptions 
                    JSR      DP_to_D0 
                    direct   $D0 
waitTillNoButton 
                    jsr      Read_Btns 
                    lda      >$c80F 
                    anda     #$f 
                    sta      >$c80F 
                    bne      waitTillNoButton 
                    jsr      shutup 
                    clr      optionSelected 
optionsLoop2 
                    clr      last_button 
optionsLoop 
                    JSR      Read_Btns                    ; get button status once, since only 
                    jsr      query_joystick 
                    JSR      Wait_Recal                   ; sets dp to d0, and pos at 0, 0 
                    direct   $D0                          ; just for assembler optimization... 
                                                          ; differences are noticed 
                    LDD      #NORMAL_TEXT_SIZE            ; load default text height & width 
                    STD      Vec_Text_HW                  ; poke it to ram location 
                    JSR      Intensity_5F                 ; Sets the intensity of the 
                    ldd      #$fe3c 
                    std      Vec_Text_Height 
                    lda      #100 
                    _SCALE_A  
                    ldd      #$78b2                       ; max, since -2 in each step 
                    ldu      #options_string              ; high score title 
                    jsr      sync_Print_Str_d_fixed 
                    lda      #80 
                    _SCALE_A  
; Reset  ........................................
                    JSR      Intensity_3F                 ; Sets the intensity of the 
                    lda      optionSelected 
                    cmpa     #3 
                    bne      notResetSelected 
                    JSR      Intensity_7F                 ; Sets the intensity of the 
notResetSelected 
                    ldd      #$4a8e  +30*256 
                    ldu      #reset_string 
                    jsr      sync_Print_Str_d_fixed 
; Color ........................................
                    JSR      Intensity_3F                 ; Sets the intensity of the 
                    lda      optionSelected 
                    cmpa     #2 
                    bne      notColorSelected 
                    JSR      Intensity_7F                 ; Sets the intensity of the 
notColorSelected 
                    ldd      #$4a8e 
                    ldu      #color_string 
                    jsr      sync_Print_Str_d_fixed 
                    ldd      #$4a8e 
                    addb     #120 
                    ldu      #yes_string 
                    tst      colorEnabled 
                    bne      yesColor 
                    ldu      #no_string 
yesColor 
                    jsr      sync_Print_Str_d_fixed 
; ........................................
; VOX ........................................
                    JSR      Intensity_3F                 ; Sets the intensity of the 
                    lda      optionSelected 
                    cmpa     #1 
                    bne      notVoxSelected 
                    JSR      Intensity_7F                 ; Sets the intensity of the 
notVoxSelected 
                    ldd      #$4a8e -30*256 
                    ldu      #vecvox_string 
                    jsr      sync_Print_Str_d_fixed 
                    ldd      #$4a8e -30*256 
                    addb     #120 
                    ldu      #yes_string 
                    tst      voxEnabled 
                    bne      yesVox 
                    ldu      #no_string 
yesVox 
                    jsr      sync_Print_Str_d_fixed 
; ........................................
; BACK ........................................
                    JSR      Intensity_3F                 ; Sets the intensity of the 
                    lda      optionSelected 
                    bne      notBackSelected 
                    JSR      Intensity_7F                 ; Sets the intensity of the 
notBackSelected 
                    ldd      #$3a8e -60*256 
                    ldu      #back_string 
                    jsr      sync_Print_Str_d_fixed 
; ........................................
                                                          ; hey dissi "bre ak once" 
                    LDB      last_joy_y                   ; only jump if last joy pos was zero (needed for testing later) 
                    LDA      Vec_Joy_1_Y                  ; load joystick 1 position X to A 
                    STA      last_joy_y                   ; store this joystick position 
                    BEQ      op_no_new_ypos_dis 
                    tstb     
                    bne      op_no_new_ypos_dis 
                    tsta     
                    bmi      goDown 
goUp 
                    inc      optionSelected 
                    lda      optionSelected 
                    cmpa     #3 
                    ble      op_no_new_ypos_dis 
                    lda      #3 
                    sta      optionSelected 
                    bra      op_no_new_ypos_dis 

goDown 
                    dec      optionSelected 
                    bpl      op_no_new_ypos_dis 
                    clr      optionSelected 
                    bra      op_no_new_ypos_dis 

op_no_new_ypos_dis 
                    lda      $C80F 
                    anda     #$f 
                    lbeq     optionsLoop2 
                    cmpa     last_button 
                    lbeq     optionsLoop 
                    sta      last_button 
; button pressed
                    lda      optionSelected 
                    beq      goBack12 

                    cmpa     #3
	bne noReset 
; just do a reset and continue
 jsr copyDefaults

 jmp optionsLoop

noReset
                    cmpa     #1 
                    bne      noVoxChange 
                    lda      voxEnabled 
                    beq      doIncVox 
                    clr      voxEnabled 
                    jmp      optionsLoop 

doIncVox 
                    inc      voxEnabled 
                    jmp      optionsLoop 

noVoxChange 
; color change
                    lda      colorEnabled 
                    beq      doIncColor 
                    clr      colorEnabled 
                    jmp      optionsLoop 

doIncColor 
                    inc      colorEnabled 
                    jmp      optionsLoop 

goBack12 
                    ldd      #(EEPROM_STORESIZE_OPTIONS*256)+EEPROM_OPTION_BLOCK 
                    std      current_eprom_blocksize 
                    ldx      #optionsBlock 
                    jmp      eeprom_save_options 

options_string: 
                    db       "OPTIONS", $80 
color_string 
                    db       "COLOR", $80 
vecvox_string 
                    db       "VECVOX", $80 
reset_string 
                    db       "RESET", $80 
back_string 
                    db       "BACK", $80 
yes_string 
                    db       "YES", $80 
no_string 
                    db       "NO", $80 
