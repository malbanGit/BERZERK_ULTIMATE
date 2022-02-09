; this file is part of Karl Quappe, written by Malban in 2016
;
; Most parts were written by:
;
;   2016 Thomas G. Sontowski:
;   based on Alex Herbert's ds2430 driver
;
; if 32 byte save is enabled only a dirty "translation" of bigger data is done, much redundancy!
;***************************************************************************
                    include  "ds2431LowLevel.i"
                    include  "ds2431HighLevel.i"
;***************************************************************************
;;;;;;;;;;;;;
EEPROM_CHECKSUM     equ      $87                          ; any value other than $00 or $e0 
EEPROM_STORESIZE_HS  equ     32                           ;32 only 31 bytes must be used, last byte is always a generated checksum 
EEPROM_STORESIZE_OPTIONS  equ  8                          ;8 only 7 bytes must be used, last byte is always a generated checksum 
EEPROM_OPTION_BLOCK  EQU     0 
EEPROM_HS1_BLOCK    EQU      8 
EEPROM_HS2_BLOCK    EQU      40 
;;;;;;;;;;;;;
resetEprom 
                    jsr      copyDefaults 
                    tst      ignoreDs2431 
                    bne      noDevice1 
                    tst      ds2431Present 
                    beq      noDSDevice 
                    ldd      #(EEPROM_STORESIZE_OPTIONS*256)+EEPROM_OPTION_BLOCK 
                    std      current_eprom_blocksize 
                    ldx      #optionsBlock 
                    bSR      eeprom_save_options 
                    ldd      #(EEPROM_STORESIZE_HS*256)+EEPROM_HS1_BLOCK 
                    std      current_eprom_blocksize 
                    ldx      #highScoreCompetitionBlock 
                    bSR      eeprom_save_highscore 
                    ldd      #(EEPROM_STORESIZE_HS*256)+EEPROM_HS2_BLOCK 
                    std      current_eprom_blocksize 
                    ldx      #highScoreHardcoreBlock 
                    bra      eeprom_save_highscore 

noDSDevice 
                    tst      v4ecartflags 
                    bpl      noDevice1 
                    jmp      store_score 

noDevice1 
                    rts      

cleanStart 
                    jmp      copyDefaults 

;***************************************************************************
checkEprom 
                    tst      ignoreDs2431 
                    bne      cleanStart 
                    clr      ds2431Present 
                    jsr      ds1w_open                    ; open 1-wire port 
                    jsr      ds1w_reset                   ; reset device 
                    ;tsta     
                    bne      notPresent 
                    inc      ds2431Present 
notPresent 
                    jmp      ds1w_close                   ; close port 

;***************************************************************************
; current_eprom_blocksize = blocksize
; current_eprom_blockadr = block address in eeprom
; x = address to save
eeprom_save_highscore 
                    tfr      x,y 
                    bsr      toNewEeprom 
                    ldx      #newEepromRAMStart 
eeprom_save_options 
                    ldb      #$d0 
                    tfr      b,dp 
                    direct   $D0 
                    ldb      current_eprom_blocksize 
                    decb     
                    tst      ignoreDs2431 
                    bne      noDevice1 
                    tst      v4ecartflags 
                    bpl      eepromSave_1 
                    jmp      store_score 

eepromSave_1 
                    pshs     x 
                    lda      #(EEPROM_CHECKSUM)           ;<<8)+(EEPROM_STORESIZE-1) ; 
eesave_loop                                               ;        
                    suba     ,x+                          ; create checksum byte 
                    decb                                  ; 
                    bne      eesave_loop                  ; 
                    sta      ,x                           ; 
                    puls     x 
                    lbsr     ds2431_verify                ; compare ram to eeprom 
                    tsta                                  ; 
                    lbne     ds2431_save                  ; if different, then update eeprom 
                    rts      

;***************************************************************************
; current_eprom_blocksize = blocksize
; current_eprom_blockadr = block address in eeprom
; x = address to load To 

eeprom_load_highscore 
                    stx      eeprom_tmp 
                    ldx      #newEepromRAMStart           ; 
eeprom_load_option 
eeprom_load_1 
                    tst      ignoreDs2431 
                    bne      noDevice1 
 
                    tst      v4ecartflags 
                    bpl      eeprom_load_2
; COPY_VECROM_TO_RAM
                ldu #vec4SaveBuffer            ; Source copy the vec4ever switching function into place
                ldx #v4e_saveBlockStart ; destination
                lda #1+(v4e_saveBlockEnd-v4e_saveBlockStart)
                jmp Move_Mem_a
; rts
eeprom_load_2
                    jsr      ds2431_load                  ; load 32 byte eeprom to ram 
                    ldb      current_eprom_blocksize 
                    clra     
eeload_loop                                               ;        
                    adda     ,x+                          ; sum the bytes 
                    decb                                  ; 
                    bne      eeload_loop                  ; 
                    cmpa     #EEPROM_CHECKSUM             ; equal to checksum? 
                    lbne     resetEprom                   ; if not, then format the eeprom 
                    lda      current_eprom_blocksize 
                    cmpa     #8 
                    beq      doneEEL 
                    ldx      eeprom_tmp 
                    jsr      fromNewEeprom 
doneEEL 
                    rts                                   ; otherwise, return 

;                    struct   HighScoreEntry 
;                    ds       NAME,3                       ; 
;                    ds       LEVEL,1                      ; 
;                    ds       ASCIISCORE,6                 ; 
;                    end      struct 
;***************************************************************************
; from address in y
; to address always new eeprom
; d + x trashed,
;y at the end of the copying
toNewEeprom: 
                    lda      #5 
                    sta      levelDoneTemp 
; handle name 3 chars
                    ldx      #newEepromRAMStart 
convertNextScore: 
                    jsr      Encode3chars 
; handle level 5 bits 
                    lda      ,y+                          ; load level 
                    sta      ,x+                          ; store level 
                                                          ; handle score 
                    pshs     y,x 
                    tfr      y,x 
                    jsr      toConversion5                ; put current score to conversion buffer 
                    jsr      convertAsciiToD              ; current score as "number" in D 
                    puls     y,x 
                    leay     6,y 
                    std      ,x++                         ; store score 
                    dec      levelDoneTemp 
                    bne      convertNextScore 
; conversion done
; bytes in newEepromRAMStart
; = 3 + 5*5 = 28
                    rts      

;***************************************************************************
; loads the 5 ascii score pointed by x to 
; the 6 bcd score conversion buffer
; destroys d
toConversion5: 
                    ldy      #conversionBuffer 
                    ldd      ,x 
                    std      ,y 
                    ldd      2,x 
                    std      2,y 
                    lda      4,x 
                    sta      4,y 
                    lda      #0 
                    sta      5,y 
                    rts      
ASCII_REDUCE_D macro
 cmpa #$20
 bne noSpaceA_1\?
 adda #$10
noSpaceA_1\?
 cmpb #$20
 bne noSpaceB_1\?
 addb #$10
noSpaceB_1\?
 endm

toConversion5Sub: 
                    ldy      #conversionBuffer 
                    ldd      ,x 
 ASCII_REDUCE_D
                    std      ,y 

                    ldd      2,x 
 ASCII_REDUCE_D
                    std      2,y 

                    lda      4,x 
 ASCII_REDUCE_D
                    sta      4,y 

                    lda      #0 
                    sta      5,y 
                    rts      
****************************************************
; SLOW but straight forward, no need for speed!
; input asccii in conversionBuffer 6 bytes + $80
; last zero is discarded!
; max input 655350
; destroys x,y,d, tmp1 (16bit), tmp2 (16bit)
convertAsciiToD 
                    ldy      #conversionBuffer 
convertAsciiToDInY 
                    bsr      YleadingSpaceTo0 
                    ldx      #0 
                    ldb      ,y 
                    subb     # '0' 
                    ldu      #10000 
                    bsr      addToX_b_timesU 
                    ldb      1,y 
                    subb     # '0' 
                    ldu      #1000 
                    bsr      addToX_b_timesU 
                    ldb      2,y 
                    subb     # '0' 
                    ldu      #100 
                    bsr      addToX_b_timesU 
                    ldb      3,y 
                    subb     # '0' 
                    ldu      #10 
                    bsr      addToX_b_timesU 
                    ldb      4,y 
                    subb     # '0' 
                    ldu      #1 
                    bsr      addToX_b_timesU 
                    tfr      x,d 
                    rts      

;***************************************************************************
addToX_b_timesU 
                    stb      tmp1 
                    beq      addDoneX 
                    pshs     d 
                    tfr      x,d 
                    stu      tmp2 
anotherAddX: 
                    addd     tmp2 
                    dec      tmp1 
                    bne      anotherAddX 
                    tfr      d,x 
                    puls     d 
addDoneX: 
                    rts      
;***************************************************************************
YleadingSpaceTo0 
                    pshs     y 
                    ldb      #6 
nextLeady: 
                    lda      ,y+ 
                    cmpa     # ' '
                    bne      doneyl 
                    lda      # '0'
                    sta      -1,y 
                    decb     
                    bne      nextLeady 
doneyl 
                    puls     y ,pc 
;***************************************************************************
; x address to copy to
fromNewEeprom 
                    lda      #5 
                    sta      levelDoneTemp 
; handle name 3 chars
                    tfr      x,y 
;                    ldy      #eepromRAMStart 
                    ldx      #newEepromRAMStart 
convertNextScore2: 
                    jsr      Decode3chars 
; handle level 5 bits 
                    lda      ,x+                          ; load level 
                    sta      ,y+                          ; store level 
                                                          ; handle score 
                    ldd      ,x++                         ; get 16bit score 
                    pshs     y,x 
                    jsr      convertDToAscii 
                    puls     y,x 
                    ldu      #conversionBuffer 
                    ldd      ,u++                         ; copy 6 ascii bytes 
                    std      ,y++ 
                    ldd      ,u++ 
                    std      ,y++ 
                    ldd      ,u++ 
                    std      ,y++ 
                    dec      levelDoneTemp 
                    bne      convertNextScore2 
                    rts      
;***************************************************************************
; SLOW but straight forward, no need for speed!
; input number in D
; output number * 10 as ascii in conversionBuffer (with $80)
; max result -> 655350
; destroys u,x,y,d, tmp1 (16bit), tmp2 (16bit), divide_tmp
convertDToAscii 
                    ldy      #conversionBuffer 
convertDToAsciiInY 
                    tfr      d,x 
                    ldu      #10000 
                    stu      tmp1 
                    bsr      divide_d_by_tmp1 
                    bsr      reduceX_by_b_timesU 
                    addb     # '0'
                    stb      ,y 
                    tfr      x,d 
                    ldu      #1000 
                    stu      tmp1 
                    bsr      divide_d_by_tmp1 
                    bsr      reduceX_by_b_timesU 
                    addb     # '0'
                    stb      1,y 
                    tfr      x,d 
                    ldu      #100 
                    stu      tmp1 
                    bsr      divide_d_by_tmp1 
                    bsr      reduceX_by_b_timesU 
                    addb     # '0'
                    stb      2,y 
                    tfr      x,d 
                    ldu      #10 
                    stu      tmp1 
                    bsr      divide_d_by_tmp1 
                    bsr      reduceX_by_b_timesU 
                    addb     # '0'
                    stb      3,y 
                    tfr      x,d 
                    ldu      #1 
                    stu      tmp1 
                    lbsr     divide_d_by_tmp1 
                    bsr      reduceX_by_b_timesU 
                    addb     # '0'
                    stb      4,y 
                    ldd      # '0'*256+$81
                    std      5,y 
                    bra      Yleading0ToSpace 
;***************************************************************************
; divide 16 bit number in D by 16 bit number in tmp1, result must fit in 8 bit, result in b
; UNSIGNED
divide_d_by_tmp1 
                    MY_DIV_D_BY_TMP1_TO_B  
                    rts      

;***************************************************************************
; destroys tmp1 tmp2, alters X 
reduceX_by_b_timesU 
                    pshs     d 
                    stb      tmp2 
                    stu      tmp1 
                    tfr      x,d 
                    tst      tmp2 
                    beq      endreduce 
nextreduce: 
                    subd     tmp1 
                    dec      tmp2 
                    bne      nextreduce 
                    tfr      d,x 
endreduce: 
                    puls     d,pc 
;***************************************************************************
                                                          ; input : y = output string pointer 
                                                          ; x = input pointer to uint16 
Decode3chars        lda      ,x                           ; byte 0: 1aaaaabb 
                    asra     
                    asra     
                    anda     #$1f 
                    beq      decode_zero 
                    adda     # 'A'-' '-1
decode_zero         adda     # ' '
                    sta      ,y+                          ; char 0 
                    lda      ,x+                          ; byte 0: 1aaaaabb 
                    ldb      ,x                           ; byte 1: bbbccccc 
                    rolb     
                    rola     
                    rolb     
                    rola     
                    rolb     
                    rola     
                    anda     #$1f 
                    beq      decode_one 
                    adda     # 'A'-' '-1
decode_one          adda     # ' '
                    sta      ,y+                          ; char 1 
                    lda      ,x+                          ; byte 1: bbbccccc 
                    anda     #$1f 
                    beq      decode_two 
                    adda     # 'A'-' '-1
decode_two          adda     # ' '
                    sta      ,y+                          ; char 2 
                    rts      
;***************************************************************************
; destroys d
Yleading0ToSpace 
                    pshs     y 
                    ldb      #6 
nextLeady0: 
                    lda      ,y+ 
                    cmpa     # '0'
                    bne      doneyl0 
                    lda      # ' '
                    sta      -1,y 
                    decb     
                    bne      nextLeady0 
doneyl0 
                    puls     y ,pc 
;***************************************************************************
; routines from thomas encode/decode
                                                          ; input : y = string pointer 
                                                          ; x = output pointer to uint16 
Encode3chars        lda      ,y+                          ; char 0 
                    suba     # ' '
                    beq      encode_zero 
                    suba     # 'A'-' '-1
encode_zero         asla     
                    asla     
                    ora      #$80                         ; the flag bit 
                    sta      ,x                           ; byte 0: 1aaaaa00 
                    lda      ,y+                          ; char 1 
                    suba     # ' '
                    beq      encode_one 
                    suba     # 'A'-' '-1
encode_one          clrb     
                    asra     
                    rorb     
                    asra     
                    rorb     
                    asra     
                    rorb     
                    ora      ,x                           ; byte 0: 1aaaaabb 
                    sta      ,x+ 
                    stb      ,x                           ; byte 1: bbb00000 
                    lda      ,y+                          ; char 2 
                    suba     # ' '
                    beq      encode_two 
                    suba     # 'A'-' '-1
encode_two          ora      ,x                           ; byte 1: bbbccccc 
                    sta      ,x+ 
                    rts      

;***************************************************************************
;;;;;;;;;;;;;
