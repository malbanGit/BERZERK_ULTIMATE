Vec_Text_Height     EQU      $C82A                        ;Default text height 
Vec_Text_Width      EQU      $C82B                        ;Default text width 
Vec_Joy_1_X         EQU      $C81B                        ;Joystick 1 left/right 
Vec_Joy_1_Y         EQU      $C81C                        ;Joystick 1 up/down 
Vec_Music_Flag      EQU      $C856                        ;Music active flag ($00=off $01=start $80=on) 
Do_Sound            EQU      $F289                        ; 
Init_Music_Buf      EQU      $F533                        ; 
initSavedHighscore 
; load high score from saves and put it in "RAM"
                    rts      

;displayHighScoreList
goBack 
                    leas     4,s                          ; push x and JSR 
                    JSR      DP_to_D0 
                    clr      isDemo 
                    jmp      startCartridge 

displayHighScoreListDemo 
                    clr      highScoreEditMode 
                    INIT_VOX_SPEECH_DIRECT  coinSentence, pitchNormal0 
                    inc      isDemo 
                    bra      isdemoentry 

;2) Highscore table consists of 6 ascii characters representing the score in ascii nothing special here
;3) Highscore on the eprom is kept as a 16bit unsigned int (0-65535)
;  upon conversion the score is shifted one position to the right (divided by 10), since the last position is always a 0
;  Thus on the eprom a score up to 655350 can be stored.
;
; ergo: in game highscore is correct displayed up to a score of 169990
; highscore recording and displaying in HS table is correct up to a score of 655350
; after that the score starts from 0 again 
;
;
;
;***************************************************************************
Vec_Loop_Count      EQU      $C825                        ;Loop counter word (incremented in Wait_Recal) 
RecalCounter        =        Vec_Loop_Count 
                    bss      
; replaces robots at $C91C
currentHSEditPlace  EQU      $C91C                        ; $c880 ; one of the three possible letters 
currentHSEditBlinkState  EQU  currentHSEditPlace+1        ; 
hsEditLetter1       EQU      currentHSEditBlinkState+1    ; three letters can be edited, 
hsEditLetter2       EQU      hsEditLetter1+1              ; these hold the actual ASCII values 
hsEditLetter3       EQU      hsEditLetter2+1 
mul_tmp2            equ      hsEditLetter3+1 
highScoreEditMode   equ      mul_tmp2 + 2 
highScorePlace      equ      highScoreEditMode + 1 
last_joy_x          equ      highScorePlace + 1 
last_joy_y          equ      last_joy_x + 1 
last_button         equ      last_joy_y + 1 
highScoreReached    equ      last_button + 1 
highScoreDone       equ      highScoreReached + 1         ; 2 
isDemo              equ      highScoreDone *1 
                    org      isDemo+1 
                    code     
;
NORMAL_TEXT_SIZE    EQU      $F160                        ; big text that is 
highscores_screen 
                    clr      isDemo 

isdemoentry 
                    ldx      RecalCounter                 ; save recal counter, since 
                    pshs     x 
                    JSR      DP_to_D0 
; setup high score editing stuff, like cursor pos and blinking
                    clr      currentHSEditPlace 
                    clr      currentHSEditBlinkState 
                    lda      # 'A'                        ; all letters in editor start with A-position
                    sta      hsEditLetter1 
                    sta      hsEditLetter2 
                    sta      hsEditLetter3 
                    direct   $D0 
                    tst      isDemo 
                    beq      thisIsNoDemo 
thisIsNoDemo
 
                    jsr      shutup 
                    ldu      #(laneRAM-laneData) 
                    leau     <laneData,u 
                    ldx      #lane1Data 
                    jsr      initLane 

                    leau     <laneData,u 
                    ldx      #lane8Data 
                    jsr      initLane 


                    ldd      #0 
                    std      roundCounter 
                    leau     <laneData,u 
                    std      ,u 
                    clr      RecalCounter                 ; recal counter is used as blinking "counter" 
                    clr      RecalCounter+1 
                    JSR      Read_Btns                    ; get button status once, since only 
                                                          ; differences are noticed 

highscores_screen_loop_1: 
                    direct   $D0 

                    ROUND_STARTUP2                        ; well, the startup... 
                    jsr      voxSentence 
                    lda      isDemo 
                    beq      nobackcheck 
                    jsr      PLY_PLAY 
                    jsr      do_ym_sound2 
                    lda      RecalCounter 
                    cmpa     #3 
                    lbeq     goBack 
nobackcheck 
                    ldy      #laneRAM 
doNextLane 
                    ldd      ,y 
                    beq      lanesDone 
                    jsr      doLane 
 tst      isDemo 
 beq      thisIsNoDemo2a


                    leay     <laneData,y 


                    bra      doNextLane 
thisIsNoDemo2a

lanesDone: 
; increase round counter!
                    ldx      roundCounter 
                    leax     1,x 
                    stx      roundCounter 

 tst      isDemo 
 bne noVersion
                    lda      #60 
                    _SCALE_A  

                    LDD      #$F520            ; load default text height & width 
                    STD      Vec_Text_HW                  ; poke it to ram location 

                    ldd      #$7fcb                       ; max, since -2 in each step 
                    ldu      #version
                    jsr      sync_Print_Str_d_fixed 
noVersion

                    LDD      #NORMAL_TEXT_SIZE            ; load default text height & width 
                    STD      Vec_Text_HW                  ; poke it to ram location 
                    JSR      Intensity_5F                 ; Sets the intensity of the 
                    ldd      #$fe3c 
                    std      Vec_Text_Height 
                    lda      #80 
                    _SCALE_A  

                    ldd      #$78AB                       ; max, since -2 in each step 
                    ldu      #highscore_string            ; high score title 
                    jsr      sync_Print_Str_d_fixed 
                    ldx      #highScoreTable 
                    lda      #5 
                    sta      tmp2 
                    ldd      #$5a8e 
                    pshs     d 
                    clr      mul_tmp2                     ; counter of highscores handled 
nextHSScore 
                    jsr      buildHighScoreTmp            ; build one highscore line (X is scoretable entry parameter) 
; change string to appear edited!
                    tst      highScoreEditMode 
                    beq      noEdit 
                    JSR      Intensity_5F                 ; Sets the intensity of the 
                    lda      highScorePlace 
                    cmpa     mul_tmp2 
                    bne      noEdit 
                    JSR      Intensity_7F                 ; Sets the intensity of the 
; the current score string is the one we are editing currently
; that high score takes its "name" letters from the special editor positions
; the following code replaces in the tmp line the 3 letters, 
; in relation to the blink state also exchanges a letter with an underscore
                    lda      RecalCounter+1 
                    anda     #$0f 
                    bne      noBlinkChange 
                    lda      currentHSEditBlinkState 
                    inca     
                    anda     #$01 
                    sta      currentHSEditBlinkState 
noBlinkChange 
                    LDU      #highScoreTmpBuffer 
                    lda      hsEditLetter1 
                    sta      0,u 
                    lda      hsEditLetter2 
                    sta      1,u 
                    lda      hsEditLetter3 
                    sta      2,u 
                    tst      currentHSEditBlinkState 
                    beq      drawString 
; here place cursor instead of Letter
                    lda      # '_'
                    ldb      currentHSEditPlace 
                    sta      b,u 
drawString: 
noEdit: 
; each line of the high score is printed out, regardless of editing
                    inc      mul_tmp2 
                    leax     HighScoreEntry,x 
                    lda      #70 
                    _SCALE_A  
                    LDU      #highScoreTmpBuffer 
                    ldd      ,s 
                    pshs     x                            ; save x pointer 
                    jsr      sync_Print_Str_d_fixed 
                    puls     x 
                    lda      ,s 
                    suba     #30                          ; next highscore entry is 30 "pixels" down 
                    sta      ,s 
                    dec      tmp2 
                    bne      nextHSScore 
                    puls     d 
                    jsr      query_joystick 
                    tst      highScoreEditMode            ; if in edit mode - do question the joystick... and stuff 
                                                          ; hey dissi "bre ak once" 
                    bne      dohseditMode                 ; otherwise stay here and "return" to main screen on button press 
                    LDB      last_joy_x                   ; only jump if last joy pos was zero (needed for testing later) 
                    LDA      Vec_Joy_1_X                  ; load joystick 1 position X to A 
                    STA      last_joy_x                   ; store this joystick position 
                    BEQ      hs_no_new_xpos_dis 
                    tstb     
                    bne      hs_no_new_xpos_dis 
hs_no_new_xpos_dis 
                    JSR      Read_Btns                    ; get button status 
                    anda     #$0f                         ; no vox 
                    CMPA     #$00                         ; is a button pressed? 
                    lBEQ     highscores_screen_loop_1     ; no, than stay in init_screen_loop 
                    tst      isDemo 
                    lbeq      thisIsNoDemo2 
                    lda      >$c80F 
                    anda     #$f 
                    sta      >$c80F 
                    cmpa     #1 
                    bne      nOptions5 
                    jsr      editOptions 
                    jmp      highscores_screen_loop_1 

nOptions5 
thisIsNoDemo2 
                    puls     x                            ; restore counter 
                    stx      RecalCounter 
                    JSR      DP_to_C8 
                    rts      

;***************************************************************************
dohseditMode: 
; get joystick
; left right change cursor pos
; up down, change letters
; any button finish editing
                    JSR      Read_Btns                    ; get button status 
                    CMPA     #$00                         ; is a button pressed? 
                    bne      exitHS                       ; no, than stay in init_screen_loop 
; X POS TESTS
                    LDB      last_joy_x                   ; only jump if last joy pos was zero (needed for testing later) 
                    LDA      Vec_Joy_1_X                  ; load joystick 1 position X to A 
                    STA      last_joy_x                   ; store this joystick position 
                    BEQ      hs_no_new_xpos 
                    BMI      pos_left_hse                 ; joystick moved to left 
pos_right_hse: 
                    TSTB                                  ; test the old joystick position 
                    BNE      positioning_done_hse         ; was center 
; move right, letterpos =  letterpos +1
                    inc      currentHSEditPlace 
                    lda      currentHSEditPlace 
                    cmpa     #2 
                    ble      positioning_done_hse 
                    clr      currentHSEditPlace 
                    bra      positioning_done_hse 

pos_left_hse: 
                    TSTB                                  ; test the old joystick position 
                    BNE      positioning_done_hse         ; was center 
                    dec      currentHSEditPlace 
                    bpl      positioning_done_hse 
                    lda      #2 
                    sta      currentHSEditPlace 
                    bra      positioning_done_hse 

hs_no_new_xpos: 
; Y POS TESTS
                    LDB      last_joy_y                   ; only jump if last joy pos was zero (needed for testing later) 
                    LDA      Vec_Joy_1_Y                  ; load joystick 1 position X to A 
                    STA      last_joy_y                   ; store this joystick position 
                    BEQ      hs_no_new_ypos 
                    BMI      pos_down_hse                 ; joystick moved to left 
pos_up_hse: 
                    TSTB                                  ; test the old joystick position 
                    BNE      positioning_done_hse         ; was center 
; move up, letter =  letter -1
                    lda      currentHSEditPlace 
                    ldu      #hsEditLetter1 
                    ldb      a,u 
                    incb     
                    cmpb     # 'Z'
                    ble      letterOk_hse 
                    ldb      # 'A'
letterOk_hse 
                    stb      a,u 
                    bra      positioning_done_hse 

pos_down_hse: 
                    TSTB                                  ; test the old joystick position 
                    BNE      positioning_done_hse         ; was center 
                    lda      currentHSEditPlace 
                    ldu      #hsEditLetter1 
                    ldb      a,u 
                    decb     
                    cmpb     # 'A'
                    bge      letterOk_hse 
                    ldb      # 'Z'
                    bra      letterOk_hse 

hs_no_new_ypos: 
positioning_done_hse 
                    jmp      highscores_screen_loop_1 

exitHS: 
; write letters to HS and exit
                    ldu      #highScoreTable 
                    ldb      highScorePlace 
                    beq      hsFound 
addhsFound: 
                    leau     HighScoreEntry,u 
                    decb     
                    bne      addhsFound 
hsFound 
                    lda      hsEditLetter1 
                    sta      0,u 
                    lda      hsEditLetter2 
                    sta      1,u 
                    lda      hsEditLetter3 
                    sta      2,u 
                    puls     x 
                    stx      RecalCounter 
                    rts      

;***************************************************************************
highscore_string: 
                    db       "HIGH SCORE", $80 
; score table entry in x
; destroys D, y
; this builds one "highscore" line, that can be printed in the highscore screen
buildHighScoreTmp 
                    ldy      #highScoreTmpBuffer 
                    ldd      0,x                          ; name 
                    STd      ,y++ 
                    lda      2,x                          ; name 
                    STa      ,y+ 

                    ldb      3,x                          ; and level 

    lda      #' '; NEO
    STa      ,y+                          ; 


; if level is 3 digits
; remove the space between player name and score
; looks bad
; but displays correct values
 cmpb #99
 bls twoDigitLevel
    lda      #'1'
    STa      ,y+                          ; 

tryAgain100
    subb     #100 
    cmpb     #100 
    blo      contiuneHSBuild 
    lda      -1,y                         ; 
    inca     
    STa      -1,y                         ; 
    bra      tryAgain100

twoDigitLevel
                    lda      # ' '
                    STa      ,y+                          ; 

contiuneHSBuild
                    lda      #'1'
                    cmpb     #10 
                    blt      smallerTen 
                    STa      ,y+                          ; 
tryAgain 
                    subb     #10 
                    cmpb     #10 
                    blt      greater9 
                    lda      -1,y                         ; 
                    inca     
                    STa      -1,y                         ; 
                    bra      tryAgain 

smallerTen 
 lda -1,y
 cmpa #' '
 beq spaceIsOk
 lda #'0'
 bra cont10_
spaceIsOk

                    lda      # ' '                        ;  space 
cont10_
                    STa      ,y+                          ; 
greater9: 
                    addb     # '0'
                    STb      ,y+                          ; 
; NEO                    lda      # ' '
;                    STa      ,y+                          ; space 

                    ldd      4,x 
                    STd      ,y++                         ; 2 byte of score 


                    ldd      6,x 
                    STd      ,y++                         ; 2 byte of score 
                    ldd      8,x 
                    STd      ,y++                         ; 2 byte of score 
                    lda      #$81 
                    STa      ,y+                          ; score done 
                    rts      

;***************************************************************************
; add to all values in conversion buffer a '0'
; destroys d, x
addConversion0: 
                    ldb      #5 
                    ldx      #conversionBuffer 
next0add: 
                    lda      # '0'
                    adda     ,x 
                    sta      ,x+ 
                    decb     
                    bne      next0add 
                    rts      

;***************************************************************************
scrollOneRight 
                    ldy      #conversionBuffer 
                    ldd      2,y 
                    std      3,y 
                    ldd      0,y 
                    std      1,y 
                    lda      #$30 
                    sta      0,y 
                    rts      

;***************************************************************************
shutup 
                    MY_QUIT  
;                    DO_MY_SOUND  
                    JSR      DP_to_D0 
                    JMP      Do_Sound                     ; ROM function that does the sound playing 

                    include  "PRINT.I"
query_joystick: 
                    QUERY_JOYSTICK  
                    rts      

testHighScore 
                    jsr      checkHighScoreReached 
                    jsr      checkHS2 
                    JSR      DP_to_C8 
                    rts      

checkHighScoreReached 
                    clr      highScoreReached 
                    clr      highScorePlace               ; default 1 place! 
; lazy - build 
                    ldx      $C880                        ; load current player structure 
                    leax     1,x                          ; only 5 scores are releavnt (berzerk defaults to 6) 
                    jsr      toConversion5Sub             ; put current score to conversion buffer 
                    jsr      scrollOneRight 
                    jsr      convertAsciiToD              ; current score as "number" in D 
                    pshs     d                            ; remember it 
notEditAllowed: 
; load top score
                    ldx      #highScoreTable+4 
                    pshs     x 
                    jsr      toConversion5                ; put score to conversion buffer 
                    jsr      convertAsciiToD              ; score as "number" in D 
                    cmpd     2,s 
                    bls      highScoreFound 
                    inc      highScorePlace 
                    ldx      ,s 
                    leax     HighScoreEntry,x             ; 2. place high score 5 ascii 
                    jsr      toConversion5                ; put score to conversion buffer 
                    jsr      convertAsciiToD              ; score as "number" in D 
                    cmpd     2,s 
                    bls      highScoreFound 
                    inc      highScorePlace 
                    ldx      ,s 
                    leax     HighScoreEntry*2,x           ; 3. place high score 5 ascii 
                    jsr      toConversion5                ; put score to conversion buffer 
                    jsr      convertAsciiToD              ; score as "number" in D 
                    cmpd     2,s 
                    bls      highScoreFound 
                    inc      highScorePlace 
                    ldx      ,s 
                    leax     HighScoreEntry*3,x           ; 4. place high score 5 ascii 
                    jsr      toConversion5                ; put score to conversion buffer 
                    jsr      convertAsciiToD              ; score as "number" in D 
                    cmpd     2,s 
                    bls      highScoreFound 
                    inc      highScorePlace 
                    ldx      ,s 
                    leax     HighScoreEntry*4,x           ; 5. place high score 5 ascii 
                    jsr      toConversion5                ; put score to conversion buffer 
                    jsr      convertAsciiToD              ; score as "number" in D 
                    cmpd     2,s 
                    bls      highScoreFound 
; no highscore found
noHSOptionPre 
                    leas     4,s 
noHSOption: 
exitDeathAtt: 
                    rts      

highScoreFound 
                                                          ; in highScorePlace place we reached (0 based) 
                                                          ; in ,s the number score 
                    inc      highScoreReached             ; we reached a highscore 
                    ldd      2,s 
                    std      highScoreDone 
                    bra      noHSOptionPre 

;***************************************************************************
; check whether current game score (of a "game over" game)
; is worthy of high score table
; if so the highscore screen will be "called" in editor mode, and the player
; can enter his 3 letters
checkHS2: 
                    tst      highScoreReached             ; no - noHs 
                    beq      noHSOptio2n                  ; Training = no HS 
; in 'highScorePlace' is our place and
; in 'highScoreDone' is the hex value of our score
; in 'highScoreLevel' is our current level (-1)
                    ldx      #highScoreTable 
                    tfr      x,y 
                    leay     (5*HighScoreEntry),y         ; last hs entry + 1 
                    leax     (4*HighScoreEntry),x         ; last hs entry 
                    ldb      #4                           ; highscore place to compare with - from last to first 
compareNext 
                    cmpb     highScorePlace               ; from previous testings we now (if we achieved highscore - the place of the entry (sounds redundant...) 
                    beq      putHSToX                     ; if place was found - put the current values in there 
                    decb                                  ; otherwise we copy the score form one entry above to this entry, since the high score list "scrolls" down one entry 
                    leax     -HighScoreEntry,x            ; 10 (HighScoreEntry) = length of a highscore entry 
                    leay     -HighScoreEntry,y 
                    bsr      copyHSEntry                  ; copy the selected data downwards 
                    bra      compareNext                  ; and do next entry if our place was not reached 

putHSToX: 
; convert score to ascii
                    ldd      highScoreDone                ; load score to D 
                    pshs     x                            ; save X 
                    jsr      convertDToAscii              ; convert to ascii 
                    puls     x 
                    ldu      #conversionBuffer            ; result is in conversion buffer 
                    ldd      ,u++                         ; copy conversion buffer ascii data 
                    std      4,x                          ; to our current place in the highscore table 
                    ldd      ,u++ 
                    std      6,x 
                    ldd      ,u++ 
                    std      8,x 
                    ldu      $C880                        ; 
                    lda      12,u                         ; levels played 
                    inca     
                    sta      3,x                          ; level reached - not supported 
                    inc      highScoreEditMode            ; switch to high score editor mode 
                    jsr      highscores_screen            ; and call the high score screen 
                    clr      highScoreEditMode            ; switch editor mode off 
                    ldd      #(EEPROM_STORESIZE_HS*256)+EEPROM_HS1_BLOCK 
                    ldx      #highScoreCompetitionBlock 
doTheSave 
                    std      current_eprom_blocksize 
                    jsr      eeprom_save_highscore 
noHSOptio2n 
waitTillNoButton22 
                    jsr      DP_to_D0 
                    jsr      Read_Btns 
                    lda      >$c80F 
                    anda     #$f 
                    sta      >$c80F 
                    bne      waitTillNoButton22 
                    rts      

;***************************************************************************
; copy HS entry from x to y - without destroying register
copyHSEntry 
                    pshs     d,x,y 
                    ldb      #HighScoreEntry              ; length of one entry 
contcopyhs 
                    lda      ,x+ 
                    sta      ,y+ 
                    decb     
                    bne      contcopyhs 
                    puls     d,x,y ,pc 
                    bss      
                    org      highScoreDone+1 
NO_OF_LANES         =        (2 +1)                       ; plus one for ZERO 
BEHAVIOUR_NONE      equ      0 
BEHAVIOUR_PAUSE     equ      4 
BEHAVIOUR_ANIMATION_LOOP  equ  8 
ELEMENT_ANIM        EQU      0 
ELEMENT_PAUSE       EQU      1 
ELEMENT_LIST        EQU      2 
ELEMENT_YM          EQU      3 
ELEMENT_GOTO        EQU      4 
; V2
                    struct   laneData 
                    ds       LANE_CURRENT_ELEMENT,1 
                    ds       LANE_DELAY_COUNT,1 
                    ds       LANE_ANIM_COUNT,1 
                    ds       LANE_ANIM_LOOP,1 
                    ds       LANE_CURRENT_MOVE_SCALE, 1 
                    ds       LANE_CURRENT_DRAW_SCALE, 1 
                    ds       LANE_SCALE_TO,1 
                    ds       LANE_SCALE_DELAY,1 
                    ds       LANE_SCALE_INCREASE,1 
                    ds       LANE_CURRENT_INTENSITY, 1 
                    ds       LANE_INTENSITY_DELAY,1 
                    ds       LANE_INTENSITY_TO,1 
                    ds       LANE_INTENSITY_INCREASE,1 
                    ds       LANE_CURRENT_POSITION, 0 
                    ds       LANE_CURRENT_POSITION_Y, 1 
                    ds       LANE_CURRENT_POSITION_X, 1 
                    ds       LANE_POS_TO, 0 
                    ds       LANE_POS_Y_TO,1 
                    ds       LANE_POS_X_TO,1 
                    ds       LANE_POS_DELAY, 0 
                    ds       LANE_POS_DELAY_Y,1 
                    ds       LANE_POS_DELAY_X,1 
                    ds       LANE_POS_INCREASE, 0 
                    ds       LANE_POS_INCREASE_Y,1 
                    ds       LANE_POS_INCREASE_X,1 
                    ds       LANE_ELEMENT_COUNT,2 
                    ds       LANE_DRAW,2 
                    ds       LANE_ROM_DATA,2 
                    end struct 
                    struct   elementData 
                    ds       ELEMENT_ANIM_LIST,2 
                    ds       ELEMENT_ANIM_DELAY,1 
                    ds       ELEMENT_SCALE_FROM,1 
                    ds       ELEMENT_SCALE_TO,1 
                    ds       ELEMENT_SCALE_DELAY,1 
                    ds       ELEMENT_SCALE_INCREASE,1 
                    ds       ELEMENT_INTENSITY_FROM,1 
                    ds       ELEMENT_INTENSITY_TO,1 
                    ds       ELEMENT_INTENSITY_DELAY,1 
                    ds       ELEMENT_INTENSITY_INCREASE,1 
                    ds       ELEMENT_POS_FROM,0 
                    ds       ELEMENT_POS_FROM_Y,1 
                    ds       ELEMENT_POS_FROM_X,1 
                    ds       ELEMENT_POS_TO,0 
                    ds       ELEMENT_POS_TO_Y,1 
                    ds       ELEMENT_POS_TO_X,1 
                    ds       ELEMENT_POS_DELAY,0 
                    ds       ELEMENT_POS_DELAY_Y,1 
                    ds       ELEMENT_POS_DELAY_X,1 
                    ds       ELEMENT_POS_INCREASE,0 
                    ds       ELEMENT_POS_INCREASE_Y,1 
                    ds       ELEMENT_POS_INCREASE_X,1 
                    ds       ELEMENT_MOVE_SCALE,1 
                    ds       ELEMENT_DRAW,2 
                    ds       ELEMENT_BEHAVIOUR,1 
                    ds       ELEMENT_END_COUNT,2 
                    ds       ELEMENT_TYPE, 1 
                    end struct 
laneRAM             ds       laneData*NO_OF_LANES 
roundCounter        ds       2 
                    code     
; V2
;***************************************************************************
; in U pointer to lane RAM
; in X pointer to lane Data
initLane: 
                    stx      LANE_ROM_DATA, u 
                    ldx      ,x                           ; first element 
                    clr      LANE_CURRENT_ELEMENT,u 
init_element: 
                    lda      ELEMENT_BEHAVIOUR,x 
                    anda     #BEHAVIOUR_ANIMATION_LOOP 
                    sta      LANE_ANIM_LOOP,u 
                    lda      ELEMENT_MOVE_SCALE,x         ; 
                    sta      LANE_CURRENT_MOVE_SCALE,u 
                    lda      ELEMENT_ANIM_DELAY ,x 
                    sta      LANE_DELAY_COUNT, u 
                    clr      LANE_ANIM_COUNT, u 
; SCALE
                    lda      ELEMENT_SCALE_FROM,x         ; 
                    sta      LANE_CURRENT_DRAW_SCALE,u 
                    lda      ELEMENT_SCALE_DELAY,x 
                    sta      LANE_SCALE_DELAY,u 
                    lda      ELEMENT_SCALE_INCREASE,x 
                    sta      LANE_SCALE_INCREASE,u 
                    lda      ELEMENT_SCALE_TO,x           ; 
                    sta      LANE_SCALE_TO,u 
; INTENSITY
                    lda      ELEMENT_INTENSITY_FROM,x     ; 
                    sta      LANE_CURRENT_INTENSITY,u 
                    lda      ELEMENT_INTENSITY_DELAY,x 
                    sta      LANE_INTENSITY_DELAY,u 
                    lda      ELEMENT_INTENSITY_INCREASE,x 
                    sta      LANE_INTENSITY_INCREASE,u 
                    lda      ELEMENT_INTENSITY_TO,x       ; 
                    sta      LANE_INTENSITY_TO,u 
; POS
                    ldd      ELEMENT_POS_FROM,x           ; 
                    std      LANE_CURRENT_POSITION,u 
                    ldd      ELEMENT_POS_DELAY,x 
                    std      LANE_POS_DELAY,u 
                    ldd      ELEMENT_POS_INCREASE,x 
                    std      LANE_POS_INCREASE,u 
                    ldd      ELEMENT_POS_TO,x             ; 
                    std      LANE_POS_TO,u 
                    ldd      ELEMENT_DRAW,x 
                    std      LANE_DRAW,u 
                    ldd      ELEMENT_END_COUNT, x 
                    std      LANE_ELEMENT_COUNT, u 
draw_pause:                                               ;        some direct RTS 
                    rts      

; pointer to lane RAM in Y
initNextElement 
                    ldx      LANE_ROM_DATA,y 
                    lda      LANE_CURRENT_ELEMENT, y 
                    asla     
                    ldx      a,x 
not_gotoElement: 
                    tfr      y,u 
                    inc      LANE_CURRENT_ELEMENT,y 
                    lda      LANE_CURRENT_ELEMENT,y 
                    ldx      LANE_ROM_DATA,y 
                    asla     
                    ldx      a,x 
                    bne      not_last_element 
                    lda      #$ff 
                    sta      LANE_CURRENT_ELEMENT,y 
                    bra      not_gotoElement 

not_last_element 
                    jsr      init_element 
;***************************************************************************
; pointer to lane RAM in Y
doLane 
                    ldx      LANE_ELEMENT_COUNT,y 
                    leax     -1,x 
                    stx      LANE_ELEMENT_COUNT,y         ; dec element counter 
                    beq      initNextElement 
continueWithElement 
                    ldx      LANE_ROM_DATA,y 
                    lda      LANE_CURRENT_ELEMENT, y 
                    asla     
                    ldx      a,x 
; in x pointer to ROM element data struct
                    dec      LANE_DELAY_COUNT,y 
                    bne      drawCurrentAnimationFrame 
                    lda      ELEMENT_ANIM_DELAY ,x 
                    sta      LANE_DELAY_COUNT, y 
                    inc      LANE_ANIM_COUNT, y 
                    CLRA     
                    LDB      LANE_ANIM_COUNT,y            ; current animation frame 
                    ASLB                                  ; times two since it is a word pointer 
                    ROLA     
                    LDU      ,x                           ; address of data 
                    LDU      d,U 
                    bne      drawCurrentAnimationFrame 
; otherwise this animation is done
; check for loop - or init next lane element!
                    tst      LANE_ANIM_LOOP,y 
                    bne      loopAnim 
                                                          ; stay at current frame 
                    dec      LANE_ANIM_COUNT, y 
                    bra      drawCurrentAnimationFrame 

loopAnim: 
                    clr      LANE_ANIM_COUNT, y           ; for now reset animation 
; todo check for "stay"continueWithElement
drawCurrentAnimationFrame: 
                    lda      LANE_SCALE_INCREASE,y 
                    beq      noScaleChange 
                    dec      LANE_SCALE_DELAY,y 
                    bne      noScaleChange 
                    adda     LANE_CURRENT_DRAW_SCALE,y 
                    sta      LANE_CURRENT_DRAW_SCALE,y 
                    suba     LANE_SCALE_TO,y 
                    bne      scale_final_not_reached 
                    clr      LANE_SCALE_INCREASE,y        ; zero means no change 
                    bra      noScaleChange 

scale_final_not_reached 
                    lda      ELEMENT_SCALE_DELAY,x 
                    sta      LANE_SCALE_DELAY,y 
noScaleChange 
                    lda      LANE_INTENSITY_INCREASE,y 
                    beq      noIntensityChange 
                    dec      LANE_INTENSITY_DELAY,y 
                    bne      noIntensityChange 
                    adda     LANE_CURRENT_INTENSITY,y 
                    sta      LANE_CURRENT_INTENSITY,y 
                    suba     LANE_INTENSITY_TO,y 
                    bne      intensity_final_not_reached 
                    clr      LANE_INTENSITY_INCREASE,y    ; zero means no change 
                    bra      noIntensityChange 

intensity_final_not_reached 
                    lda      ELEMENT_INTENSITY_DELAY,x 
                    sta      LANE_INTENSITY_DELAY,y 
noIntensityChange 
                    lda      LANE_POS_INCREASE_X,y 
                    beq      noXChange 
                    dec      LANE_POS_DELAY_X,y 
                    bne      noXChange 
                    adda     LANE_CURRENT_POSITION_X,y 
                    sta      LANE_CURRENT_POSITION_X,y 
                    suba     LANE_POS_X_TO,y 
                    bne      X_final_not_reached 
                    clr      LANE_POS_INCREASE_X,y        ; zero means no change 
                    bra      noXChange 

X_final_not_reached 
                    lda      ELEMENT_POS_DELAY_X,x 
                    sta      LANE_POS_DELAY_X,y 
noXChange 
                    lda      LANE_POS_INCREASE_Y,y 
                    beq      noYChange 
                    dec      LANE_POS_DELAY_Y,y 
                    bne      noYChange 
                    adda     LANE_CURRENT_POSITION_Y,y 
                    sta      LANE_CURRENT_POSITION_Y,y 
                    suba     LANE_POS_Y_TO,y 
                    bne      Y_final_not_reached 
                    clr      LANE_POS_INCREASE_Y,y        ; zero means no change 
                    bra      noYChange 

Y_final_not_reached 
                    lda      ELEMENT_POS_DELAY_Y,x 
                    sta      LANE_POS_DELAY_Y,y 
noYChange 
                    lda      LANE_CURRENT_INTENSITY,y 
                    bmi      noIntensity 
                    _INTENSITY_A  
noIntensity 
; todo set intensity - when another vlist that extended sync is done
                    CLRA     
                    LDB      LANE_ANIM_COUNT,y            ; current animation frame 
                    ASLB                                  ; times two since it is a word pointer 
                    ROLA     
                    LDU      ,x                           ; address of data 
                    LDU      d,U 
                    LDd      LANE_CURRENT_POSITION,y      ; current animation frame 
                    tfr      d,x                          ; in x position of list 
; A scale positioning 
; N scale move in list 
                    ldd      LANE_CURRENT_MOVE_SCALE, y 
                    JSR      [LANE_DRAW, y]               ; Vectrex BIOS print routine 
                    rts      

;SUB_START
;***************************************************************************
; SUBROUTINE SECTION
;***************************************************************************
;ZERO ing the integrators takes time. Measures at my vectrex show e.g.:
;If you move the beam with a to x = -127 and y = -127 at diffferent scale values, the time to reach zero:
;- scale $ff -> zero 110 cycles
;- scale $7f -> zero 75 cycles
;- scale $40 -> zero 57 cycles
;- scale $20 -> zero 53 cycles
ZERO_DELAY_AS       EQU      7                            ; delay 7 counter is exactly 111 cycles delay between zero SETTING and zero unsetting (in moveto_d) 
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
draw_synced_list: 
                    pshs     a                            ; remember out different scale factors 
                    pshs     b 
                                                          ; first list entry (first will be a sync + moveto_d, so we just stay here!) 
                    lda      ,u+                          ; this will be a "1" 
sync_as: 
                    deca                                  ; test if real sync - or end of list (2) 
                    bne      drawdone_as                  ; if end of list -> jump 
; zero integrators
                    ldb      #$CC                         ; zero the integrators 
                    stb      <VIA_cntl                    ; store zeroing values to cntl 
                    ldb      #ZERO_DELAY_AS               ; and wait for zeroing to be actually done 
; reset integrators
                    clr      <VIA_port_a                  ; reset integrator offset 
                    lda      #%10000010 
; wait that zeroing surely has the desired effect!
zeroLoop_as: 
                    sta      <VIA_port_b                  ; while waiting, zero offsets 
                    decb     
                    bne      zeroLoop_as 
                    inc      <VIA_port_b 
; unzero is done by moveto_d
                    lda      1,s                          ; scalefactor move 
                    sta      <VIA_t1_cnt_lo               ; to timer t1 (lo= 
                    tfr      x,d                          ; load our coordinates of "entry" of vectorlist 
                    MY_MOVE_TO_D                          ;jsr  Moveto_d ; move there 
                    lda      ,s                           ; scale factor vector 
                    sta      <VIA_t1_cnt_lo               ; to timer T1 (lo) 
moveTo_as: 
                    ldd      ,u++                         ; do our "internal" moveto d 
                    beq      nextListEntry_as             ; there was a move 0,0, if so 
                    MY_MOVE_TO_D                          ;jsr  Moveto_d 
nextListEntry_as: 
                    lda      ,u+                          ; load next "mode" byte 
                    beq      moveTo_as                    ; if 0, than we should move somewhere 
                    bpl      sync_as                      ; if still positive it is a 1 pr 2 _> goto sync 
; now we should draw a vector 
                    ldd      ,u++                         ;Get next coordinate pair 
                    STA      <VIA_port_a                  ;Send Y to A/D 
                    CLR      <VIA_port_b                  ;Enable mux 
                    LDA      #$ff                         ;Get pattern byte 
                    INC      <VIA_port_b                  ;Disable mux 
                    STB      <VIA_port_a                  ;Send X to A/D 
                    LDB      #$40                         ;B-reg = T1 interrupt bit 
                    CLR      <VIA_t1_cnt_hi               ;Clear T1H 
                    STA      <VIA_shift_reg               ;Store pattern in shift register 
setPatternLoop_as: 
                    BITB     <VIA_int_flags               ;Wait for T1 to time out 
                    beq      setPatternLoop_as            ; wait till line is finished 
                    nop      
                    CLR      <VIA_shift_reg               ; switch the light off (for sure) 
                    bra      nextListEntry_as 

drawdone_as: 
                    puls     d                            ; correct stack and go back 
                    rts      

;***************************************************************************
;SUB_END
;SUB_END
lane1Data: 
                    dw       element_11 
                    dw       element_12 
                    dw       0 
element_11: 
                    dw       AnimList_15 
                    db       3                            ; delay 
                    db       11                           ; scale from 
                    db       11                           ; scale to 
                    db       0                            ; scale delay 
                    db       0                            ; scale increase 
                    db       80                           ; intensityFrom 
                    db       80                           ; intensityTo 
                    db       0                            ; intensityDelay 
                    db       0                            ; intensityIncrease 
                    db       -80, 100                     ; position from (y,x) 
                    db       -80, -100                    ; position to (y,x) 
                    db       0, 1                         ; position delay (y,x) 
                    db       0, -1                        ; position increase (y,x) 
                    db       80                           ; move scale 
                    dw       draw_synced_list             ; draw jsr 
                    db       BEHAVIOUR_NONE+BEHAVIOUR_ANIMATION_LOOP ; BEHAVIOUR_PAUSE / BEHAVIOUR_ANIMATION_LOOP 
                    dw       200                          ; element end count 
                    db       ELEMENT_ANIM                 ; type of element 
element_12: 
                    dw       AnimList_16 
                    db       3                            ; delay 
                    db       11                           ; scale from 
                    db       11                           ; scale to 
                    db       0                            ; scale delay 
                    db       0                            ; scale increase 
                    db       80                           ; intensityFrom 
                    db       80                           ; intensityTo 
                    db       0                            ; intensityDelay 
                    db       0                            ; intensityIncrease 
                    db       -80, -100                    ; position from (y,x) 
                    db       -80, 100                     ; position to (y,x) 
                    db       0, 1                         ; position delay (y,x) 
                    db       0, 1                         ; position increase (y,x) 
                    db       80                           ; move scale 
                    dw       draw_synced_list             ; draw jsr 
                    db       BEHAVIOUR_NONE+BEHAVIOUR_ANIMATION_LOOP ; BEHAVIOUR_PAUSE / BEHAVIOUR_ANIMATION_LOOP 
                    dw       200                          ; element end count 
                    db       ELEMENT_ANIM                 ; type of element 
lane8Data: 
                    dw       element_81 
                    dw       element_82 
                    dw       0 
element_81: 
                    dw       AnimList_16 
                    db       3                            ; delay 
                    db       11                           ; scale from 
                    db       11                           ; scale to 
                    db       0                            ; scale delay 
                    db       0                            ; scale increase 
                    db       80                           ; intensityFrom 
                    db       80                           ; intensityTo 
                    db       0                            ; intensityDelay 
                    db       0                            ; intensityIncrease 
                    db       -100, -100                   ; position from (y,x) 
                    db       -100, 100                    ; position to (y,x) 
                    db       0, 1                         ; position delay (y,x) 
                    db       0, 1                         ; position increase (y,x) 
                    db       80                           ; move scale 
                    dw       draw_synced_list             ; draw jsr 
                    db       BEHAVIOUR_NONE+BEHAVIOUR_ANIMATION_LOOP ; BEHAVIOUR_PAUSE / BEHAVIOUR_ANIMATION_LOOP 
                    dw       200                          ; element end count 
                    db       ELEMENT_ANIM                 ; type of element 
element_82: 
                    dw       AnimList_15 
                    db       3                            ; delay 
                    db       11                           ; scale from 
                    db       11                           ; scale to 
                    db       0                            ; scale delay 
                    db       0                            ; scale increase 
                    db       80                           ; intensityFrom 
                    db       80                           ; intensityTo 
                    db       0                            ; intensityDelay 
                    db       0                            ; intensityIncrease 
                    db       -100, 100                    ; position from (y,x) 
                    db       -100, -100                   ; position to (y,x) 
                    db       0, 1                         ; position delay (y,x) 
                    db       0, -1                        ; position increase (y,x) 
                    db       80                           ; move scale 
                    dw       draw_synced_list             ; draw jsr 
                    db       BEHAVIOUR_NONE+BEHAVIOUR_ANIMATION_LOOP ; BEHAVIOUR_PAUSE / BEHAVIOUR_ANIMATION_LOOP 
                    dw       200                          ; element end count 
                    db       ELEMENT_ANIM                 ; type of element 
BLOW_UP_16          EQU      1 
AnimList_15: 
                    DW       AnimList_15_0                ; list of all single vectorlists in this 
                    DW       AnimList_15_1 
                    DW       0 
AnimList_15_0: 
                    DB       $01, -$37*BLOW_UP_16, +$1E*BLOW_UP_16 ; sync and move to y, x 
                    DB       $FF, +$00*BLOW_UP_16, -$0E*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$0A*BLOW_UP_16, +$00*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$2D*BLOW_UP_16, +$00*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_16, +$0E*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, -$18*BLOW_UP_16, +$00*BLOW_UP_16 ; draw, y, x 
                    DB       $01, -$18*BLOW_UP_16, +$1E*BLOW_UP_16 ; sync and move to y, x 
                    DB       $FF, +$00*BLOW_UP_16, +$0A*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$3E*BLOW_UP_16, +$00*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$0C*BLOW_UP_16, -$14*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_16, -$28*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, -$0C*BLOW_UP_16, -$14*BLOW_UP_16 ; draw, y, x 
                    DB       $01, +$26*BLOW_UP_16, -$28*BLOW_UP_16 ; sync and move to y, x 
                    DB       $FF, -$3E*BLOW_UP_16, +$00*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_16, +$0A*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$18*BLOW_UP_16, +$00*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_16, +$0E*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, -$2D*BLOW_UP_16, +$00*BLOW_UP_16 ; draw, y, x 
                    DB       $01, -$2D*BLOW_UP_16, -$10*BLOW_UP_16 ; sync and move to y, x 
                    DB       $FF, -$0A*BLOW_UP_16, +$00*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_16, -$0E*BLOW_UP_16 ; draw, y, x 
                    DB       $00, +$4F*BLOW_UP_16, -$0A*BLOW_UP_16 ; mode, y, x 
                    DB       $FF, +$00*BLOW_UP_16, +$1E*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$0E*BLOW_UP_16, +$00*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_16, -$1E*BLOW_UP_16 ; draw, y, x 
                    DB       $02                          ; endmarker 
AnimList_15_1: 
                    DB       $01, -$36*BLOW_UP_16, +$16*BLOW_UP_16 ; sync and move to y, x 
                    DB       $FF, +$00*BLOW_UP_16, -$0E*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$0A*BLOW_UP_16, +$00*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$2C*BLOW_UP_16, +$00*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_16, +$17*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, -$18*BLOW_UP_16, +$00*BLOW_UP_16 ; draw, y, x 
                    DB       $01, -$18*BLOW_UP_16, +$1F*BLOW_UP_16 ; sync and move to y, x 
                    DB       $FF, +$00*BLOW_UP_16, +$0A*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$3E*BLOW_UP_16, +$00*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$0C*BLOW_UP_16, -$14*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_16, -$28*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, -$0C*BLOW_UP_16, -$14*BLOW_UP_16 ; draw, y, x 
                    DB       $01, +$26*BLOW_UP_16, -$27*BLOW_UP_16 ; sync and move to y, x 
                    DB       $FF, -$3E*BLOW_UP_16, +$00*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_16, +$0A*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$18*BLOW_UP_16, +$00*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_16, +$17*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, -$2D*BLOW_UP_16, +$00*BLOW_UP_16 ; draw, y, x 
                    DB       $01, -$2D*BLOW_UP_16, -$06*BLOW_UP_16 ; sync and move to y, x 
                    DB       $FF, -$0A*BLOW_UP_16, +$00*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_16, -$0E*BLOW_UP_16 ; draw, y, x 
                    DB       $00, +$50*BLOW_UP_16, -$12*BLOW_UP_16 ; mode, y, x 
                    DB       $FF, +$00*BLOW_UP_16, +$1E*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$0E*BLOW_UP_16, +$00*BLOW_UP_16 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_16, -$1E*BLOW_UP_16 ; draw, y, x 
                    DB       $02                          ; endmarker 
BLOW_UP_17          EQU      1 
AnimList_16: 
                    DW       AnimList_16_0                ; list of all single vectorlists in this 
                    DW       AnimList_16_1 
                    DW       0 
AnimList_16_0: 
                    DB       $01, -$37*BLOW_UP_17, -$14*BLOW_UP_17 ; sync and move to y, x 
                    DB       $FF, +$00*BLOW_UP_17, +$0E*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$0A*BLOW_UP_17, +$00*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$2D*BLOW_UP_17, +$00*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_17, -$18*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, -$18*BLOW_UP_17, +$00*BLOW_UP_17 ; draw, y, x 
                    DB       $01, -$18*BLOW_UP_17, -$1E*BLOW_UP_17 ; sync and move to y, x 
                    DB       $FF, +$00*BLOW_UP_17, -$0A*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$3E*BLOW_UP_17, +$00*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$0C*BLOW_UP_17, +$14*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_17, +$28*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, -$0C*BLOW_UP_17, +$14*BLOW_UP_17 ; draw, y, x 
                    DB       $01, +$26*BLOW_UP_17, +$28*BLOW_UP_17 ; sync and move to y, x 
                    DB       $FF, -$3E*BLOW_UP_17, +$00*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_17, -$0A*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$18*BLOW_UP_17, +$00*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_17, -$18*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, -$2D*BLOW_UP_17, +$00*BLOW_UP_17 ; draw, y, x 
                    DB       $01, -$2D*BLOW_UP_17, +$06*BLOW_UP_17 ; sync and move to y, x 
                    DB       $FF, -$0A*BLOW_UP_17, +$00*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_17, +$0E*BLOW_UP_17 ; draw, y, x 
                    DB       $00, +$4F*BLOW_UP_17, +$14*BLOW_UP_17 ; mode, y, x 
                    DB       $FF, +$00*BLOW_UP_17, -$1E*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$0E*BLOW_UP_17, +$00*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_17, +$1E*BLOW_UP_17 ; draw, y, x 
                    DB       $02                          ; endmarker 
AnimList_16_1: 
                    DB       $01, -$37*BLOW_UP_17, -$1E*BLOW_UP_17 ; sync and move to y, x 
                    DB       $FF, +$00*BLOW_UP_17, +$0E*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$0A*BLOW_UP_17, +$00*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$2D*BLOW_UP_17, +$00*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_17, -$0E*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, -$18*BLOW_UP_17, +$00*BLOW_UP_17 ; draw, y, x 
                    DB       $01, -$18*BLOW_UP_17, -$1E*BLOW_UP_17 ; sync and move to y, x 
                    DB       $FF, +$00*BLOW_UP_17, -$0A*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$3E*BLOW_UP_17, +$00*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$0C*BLOW_UP_17, +$14*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_17, +$28*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, -$0C*BLOW_UP_17, +$14*BLOW_UP_17 ; draw, y, x 
                    DB       $01, +$26*BLOW_UP_17, +$28*BLOW_UP_17 ; sync and move to y, x 
                    DB       $FF, -$3E*BLOW_UP_17, +$00*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_17, -$0A*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$18*BLOW_UP_17, +$00*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_17, -$0E*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, -$2D*BLOW_UP_17, +$00*BLOW_UP_17 ; draw, y, x 
                    DB       $01, -$2D*BLOW_UP_17, +$10*BLOW_UP_17 ; sync and move to y, x 
                    DB       $FF, -$0A*BLOW_UP_17, +$00*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_17, +$0E*BLOW_UP_17 ; draw, y, x 
                    DB       $00, +$4F*BLOW_UP_17, +$0A*BLOW_UP_17 ; mode, y, x 
                    DB       $FF, +$00*BLOW_UP_17, -$1E*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$0E*BLOW_UP_17, +$00*BLOW_UP_17 ; draw, y, x 
                    DB       $FF, +$00*BLOW_UP_17, +$1E*BLOW_UP_17 ; draw, y, x 
                    DB       $02                          ; endmarker 
