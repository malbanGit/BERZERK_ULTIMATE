WAIT_BETWEEN_RANDOM_SENTENCE  =  400                      ;~10 seconds 
Random              EQU      $F517                        ; 
Sound_Byte          EQU      $F256                        ; 
;
;
; VECVOX.I
;
;
; Copyright (c) 2004 Alex Herbert
;
;
;
; Include the serial driver
;
;        include "ser_ji.i"
;
; Constants
;
VOX_DATAMASK        equ      $ef                          ; bit mask for data line 
VOX_STATUSMASK      equ      $20                          ; bit mask for status line 
VOX_TERM            equ      $ff                          ; speech string terminator 
;
; Variables
;
; These routines require 2 bytes of RAM for the following variable:
;
; vox_addr - 16-bit pointer to next byte in speech string.
;
; You may wish to comment out the following lines and declare vox_addr
; elsewhere in your code.
;
;        bss
;vox_addr        ds      2
;
; Subroutines
;
                    code     
;
; vox_init
; --------
;
; Function:
;       Prepare joystick port for serial transmission and initialize
;       speech string pointer.
;
; Usage:
;       Call vox_init once at the start of your program.
;
; Note:
;       This routine writes $ef to PSG register 14 by calling Exec ROM
;       routine WRREG ($f256).  This is to mask serial output from all
;       joystick pins except the data line. (Port 2, pin 1.)
;       Care should be taken to not overwrite this register.  (There's
;       normally no reason to do so.)
;
; Caution:
;       The dp register will be set to $d0.
;
voxInit 
                    lda      #$d0 
                    tfr      a,dp                         ; dp = $d0 
                    ldd      #($0e<<8)|VOX_DATAMASK 
                    jsr      Sound_Byte                   ; WRREG (write data mask to PSG reg 14) 
; test if there is a vecVox, by filling its buffer to overflow and if it
; gives a "buffer full" we know its there
; this does not work!  - at least not with atari vecVox
; lda additionalFlags
; bita #$ff-BIT_VOX_FULL
; lbeq noVOX
vox_init2 
                    ldd      #0 
                    std      pitch_addr 
                    std      sentence_addr 
                    ldx      #vox_silence+1 
                    stx      vox_addr                     ; point to 'silence' speech string 
                    rts      

;
; vox_speak
; ---------
;
; Function:
;       Sends speech data to the VecVox.
;
; Usage:
;       Call vox_speak once per frame. (I.e. stick it in your main loop)
;       See note below.
;
;       Then, just store the start address of a speech string in
;       vox_addr when you want the VecVox to speak, and let this
;       routine do the work!
;
;       To abort speech in progress, point vox_addr at vox_silence or
;       call vox_init2 (which does exactly that).
;
; Note:
;    1. This subroutine requires that the current joystick button
;       status is held at RAM address $c80f (TRIGGR).  This is usually
;       set by calling the Executive ROM routine INPUT (a.k.a.
;       read_switches2) at $F1BA.
;
;    2. Speech strings should be terminated with VOX_TERM. ($ff)
;
; Caution:
;       Contents of the dp register may (or may not) be set to $d0.
;
voxSpeak 
vox_speak 
                    lda      voxEnabled 
                    beq      vox_exit 
                    ldx      vox_addr                     ; get speech pointer 
                    lda      ,x+                          ; read next byte 
                    cmpa     #VOX_TERM                    ; end of string? 
                    beq      vox_exit                     ; ...if so, exit 
                    stx      vox_addr                     ; store speech pointer 
                    jmp      ser_txbyte                   ; send byte 

vox_exit 
                    rts      

; DP must be $d0
; playes sentences which consists
; of one PITCH
; and an arbitraty number of words
; called each round
; each round one "letter" is put to vecVox, till the sentence is finished.
voxSentence 
                    lda      voxEnabled 
                    beq      vox_exit 
                    ldx      pitch_addr 
                    beq      pitchDone 
                    lda      ,x+                          ; read next byte 
                    cmpa     #VOX_TERM                    ; end of string? 
                    beq      pitchDoneNow                 ; ...if so, exit 
                    stx      pitch_addr 
                    jmp      ser_txbyte                   ; send byte 

pitchDoneNow 
                    ldd      #0 
                    std      pitch_addr 
                    ldx      sentence_addr 
                    beq      sentenceFinished 
                    ldd      ,x++ 
                    std      vox_addr 
                    stx      sentence_addr 
pitchDone 
                    ldx      vox_addr                     ; get speech pointer 
newWord 
                    lda      ,x+                          ; read next byte 
                    cmpa     #VOX_TERM                    ; end of string? 
                    beq      wordDone                     ; ...if so, exit 
                    stx      vox_addr                     ; store speech pointer 
                    jmp      ser_txbyte                   ; send byte 

wordDone 
                    ldu      sentence_addr 
                    beq      sentenceFinishedReally 
                    ldx      ,u++ 
                    beq      sentenceFinished 
                    stu      sentence_addr 
                    bra      newWord 

sentenceFinished 
                    stx      sentence_addr 
sentenceFinishedReally 
                    rts      

vox_addr            equ      tmp2 +2 
pitch_addr          equ      vox_addr +2 
sentence_addr       equ      pitch_addr +2 
vox_addr            equ      tmp2 +2 
pitch_addr          equ      vox_addr +2 
sentence_addr       equ      pitch_addr +2 
;
; Silence string
;
; Initial speech string.  Point vox_addr here to abort speech
; in progress.
;
vox_silence 
                    db       $00,VOX_TERM 
randomVox 
; check if vox is playing, es -> out
; check RecalCounter
; if count down, reset Recal Counter
; if countdown, random whether plaing or nor
                    ldd      RecalCounter 
                    cmpd     #WAIT_BETWEEN_RANDOM_SENTENCE ;~10 seconds 
                    blo      noRandomVox 
                    ldd      #0 
                    std      RecalCounter 
                    ldx      sentence_addr 
                    bne      noRandomVox 
                    jsr      Random 
                    cmpa     #70 
                    blo      noRandomVox 
; play a random vocxi -  random pitch
                    anda     #7 
                    lsla     
                    ldx      #pitchTable 
                    ldd      a,x 
                    std      pitch_addr 
; play a random vocxi -  random sentence
                    lda      chickenFlag 
                    beq      notChickenOut 
                    jsr      Random 
                    anda     #$7 
                    lsla     
                    ldx      #sentenceChicken 
                    ldd      a,x 
                    std      sentence_addr 
                    rts      

notChickenOut 
                    jsr      Random 
                    anda     #$f 
                    lsla     
                    ldx      #sentenceNonChicken 
                    ldd      a,x 
                    std      sentence_addr 
noRandomVox 
                    rts      

                    include  "ser_ji.i"
                    include  "jetphones.i"
; INIT_VOX_SPEECH_DIRECT gotSentence, pitchNormal
; WIKI
;
; The game's voice synthesizer generates speech for the robots during certain in-game events:
; 
;     "Coin detected in pocket": During attract mode, specifically while showing the high score list.;
;     "Intruder alert! Intruder alert!": Spoken when Evil Otto appears.
;     "The humanoid must not escape" or "The intruder must not escape": Heard when the player escapes a room after destroying every robot.
;     "Chicken, fight like a robot": Heard when the player escapes a room without destroying every robot.
;     "Got the humanoid, got the intruder!": Heard when the player loses a life. (The "got the intruder" part is a minor third higher than the "got the humanoid" part.)
; 
; There is random robot chatter playing in the background, with phrases usually consisting of "Charge", "Attack", "Kill", "Destroy", "Shoot", 
; or "Get", followed by "The Humanoid", "The intruder", "it", or "the chicken" (the last only if the player got the "Chicken, fight like a robot" 
; message from the previous room), creating sentences such as "Attack it", "Get the Humanoid", "Destroy the intruder", "Kill the chicken", and so on.
;  The speed and pitch of the phrases vary, from deep and slow, to high and fast. 
pitchTable 
                    dw       pitchNormal0 
                    dw       pitchNormal1 
                    dw       pitchNormal2 
                    dw       pitchNormal3 
                    dw       pitchNormal4 
                    dw       pitchNormal5 
                    dw       pitchNormal6 
                    dw       pitchNormal7 
sentence_none 
                    dw       0 
randomSentenceTable 
sentenceChicken 
                    dw       c1,c2,c3,c4,c5,c6,c7,c8 
; 8 chicken
c1:                 dw       getWord, chickenWord, 0      ; not only after "chicken" 
c2:                 dw       killWord, chickenWord, 0     ; not only after "chicken" 
c3:                 dw       destroyWord, chickenWord, 0  ; not only after "chicken" 
c4:                 dw       shootWord, chickenWord, 0    ; not only after "chicken" 
c5:                 dw       attackWord, chickenWord, 0   ; not only after "chicken" 
c6:                 dw       destroyWord, chickenWord, 0  ; not only after "chicken" 
c7:                 dw       shootWord, chickenWord, 0    ; not only after "chicken" 
c8:                 dw       chargeWord, 0 
sentenceNonChicken 
                    dw       nc1,nc2,nc3,nc4,nc5,nc6,nc7,nc8 
                    dw       nc9,nca,ncb,ncc,ncd,nce,ncf,ncg 
; 16 non chicken
nc1:                dw       getWord, intruderWord, 0 
nc2:                dw       getWord, itWOrd, 0 
nc3:                dw       getWord, humanoidWord, 0 
nc4:                dw       killWord, intruderWord, 0 
nc5:                dw       killWord, itWOrd, 0 
nc6:                dw       killWord, humanoidWord, 0 
nc7:                dw       destroyWord, intruderWord, 0 
nc8:                dw       destroyWord, itWOrd, 0 
nc9:                dw       destroyWord, humanoidWord, 0 
nca:                dw       shootWord, intruderWord, 0 
ncb:                dw       shootWord, itWOrd, 0 
ncc:                dw       shootWord, humanoidWord, 0 
ncd:                dw       attackWord, intruderWord, 0 
nce:                dw       attackWord, itWOrd, 0 
ncf:                dw       attackWord, humanoidWord, 0 
ncg:                dw       chargeWord, 0 
gotSentence 
                    dw       gotWord, humanoidWord, gotWord, intruderWord, 0 
intruderSentence 
                    dw       intruderAlert, 0 
coinSentence 
                    dw       coinDetected, 0 
chickenSentence 
                    dw       chicken, 0 
mustNotEscape1 
                    dw       humanoidWord, mustNotWord, 0 
mustNotEscape2 
                    dw       intruderWord, mustNotWord, 0 
; *******************
; ----- speech data follows
; *******************
; different pitches
pitchNormal0 
                    db       RESET, PITCH, 80, BEND, 5 , EOP 
pitchNormal1 
                    db       RESET, PITCH, 60, BEND, 5 , EOP 
pitchNormal2 
                    db       RESET, PITCH, 110, BEND, 5 , EOP 
pitchNormal3 
                    db       RESET, PITCH, 80, BEND, 4 , EOP 
pitchNormal4 
                    db       RESET, PITCH, 60, BEND, 4 , EOP 
pitchNormal5 
                    db       RESET, PITCH, 110, BEND, 4 , EOP 
pitchNormal6 
                    db       RESET, PITCH, 80, BEND, 6 , EOP 
pitchNormal7 
                    db       RESET, PITCH, 60, BEND, 6 , EOP 
; Special sentence
intruderAlert                                             ;        intruder Alert 
                    db       IH, NE, TT, RR, UW, FAST 
                    db       DE, FAST, AX, RR, PAUSE5, PAUSE5, AX, LE, AXRR, TT 
                    db       EOP 
; coin detected in pocket
coinDetected 
                    db       OK, FAST, OWIY, NE, PAUSE5, DE, IH, TT, EH, KO 
                    db       TT, EH, DE, PAUSE5, SLOW, IH, SLOW, NE, PAUSE5, PO 
                    db       OH, KE, EH, TT, RESET, EOP 
chicken 
; chicken fight like a robot
                    db       CH, IH, KE, EH, NE, PAUSE5, PAUSE2, SLOW, FF, FAST 
                    db       OHIY, PAUSE4, TT, PAUSE5, LE, FAST, OHIY, EK, PAUSE5, FAST 
                    db       EYIY, PAUSE5, RR, FAST, OWWW, SLOW, BO, OH, SLOW, TT 
                    db       EOP 
humanoidWord 
; the humanoid
                    db       DH, IY, PAUSE5 
                    db       HO, IYUW, MM, FAST, AY, NO, FAST, OWIY, DE, PAUSE5, EOP 
intruderWord 
; the intruder
                    db       DH, IY, PAUSE5, IH, NE, TT, RR, UW, FAST, DE 
                    db       FAST, AX, FAST, RR, PAUSE5, EOP 
; the chicken
chickenWord 
                    db       DH, EH, PAUSE5, CH, IH, KE, EH, NE, PAUSE5, EOP 
; ... must not escape
mustNotWord 
                    db       MM, UX, SE, TT, PAUSE5, NE, OH 
                    db       TT, PAUSE5, EH, SE, KE, FAST, EYIY, PAUSE4, PE, PAUSE5, EOP 
; it
itWOrd 
                    db       IH, SLOW, TT, PAUSE5, EOP 
; get 
getWord 
                    db       SLOW, GE, SLOW, EH, TT, PAUSE5, EOP 
destroyWord 
; destroy 
                    db       DE, FAST, EH, SE, TT, RR, FAST, OWIY, PAUSE5, EOP 
killWord 
; kill 
                    db       KO, IH, LE, PAUSE5, EOP 
chargeWord 
; charge
                    db       CH, SLOW, AW,AW,AW, RR, JH, PAUSE5, EOP 
attackWord 
; attack 
                    db       AY, SLOW, TT, TT, AY, SLOW, KO, EOP 
shootWord 
; shoot
                    db       SH, SLOW, UW, TT, EOP, PAUSE5, EOP 
; got ...
gotWord 
                    db       SLOW, GO, OH, OH, TT, PAUSE5, EOP 
