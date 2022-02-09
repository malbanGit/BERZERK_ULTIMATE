SPRITE_SCALE        =        11                           ; 80 highest possible value 
SHITREG_POKE_VALUE  =        $01 
WAIT2               macro    
                    nop                                   ; wait 2 cycles 
                    endm     
WAIT3               macro    
                    brn      0                            ; wait 3 cycles 
                    endm     
WAIT4               macro    
                    WAIT2    
                    WAIT2    
                    endm     
WAIT5               macro    
                    WAIT3    
                    WAIT2    
                    endm     
WAIT6               macro    
                    tfr      a,a                          ; wait 6 cycles 
                    endm     
WAIT7               macro    
                    WAIT5    
                    WAIT2    
                    endm     
WAIT8               macro    
                    WAIT6    
                    WAIT2    
                    endm     
WAIT9               macro    
                    WAIT6    
                    WAIT3    
                    endm     
WAIT10              macro    
                    WAIT6    
                    WAIT4    
                    endm     
ADD_BURST           macro    
                    endm     
DELAY_NONE          macro    
                    ADD_BURST  
                    endm     
;
Y_DELAY_4           macro    
                    WAIT4    
                    ADD_BURST  
                    endm     
Y_DELAY_HALF_4      macro    
                    WAIT2    
                    ADD_BURST  
                    endm     
;
Y_DELAY             macro    
                    Y_DELAY_4  
                    ADD_BURST  
                    endm     
Y_DELAY_HALF        macro    
                    Y_DELAY_HALF_4  
                    endm     
SET_Y_INT           macro    
                    sta      <VIA_port_b                  ; 4 
                    stb      <VIA_port_a                  ; 4 
 

                    endm     
VB_SPRITE_SCALE     =        SPRITE_SCALE 
; NOPS add one less, since PULL X is one cycle more than pull a!
ADD_NOPS            macro    
                    if       VB_SPRITE_SCALE>8 
                    nop      (VB_SPRITE_SCALE-8)/2 
                    endif    
                    endm     
ADD_NOPS_NOU        macro    
                    if       VB_SPRITE_SCALE>(8-5) 
                    nop      (VB_SPRITE_SCALE-8-5)/2 
                    endif    
                    endm     
WAIT_BEFORE         macro    
                    WAIT3    
                    endm     
WAIT_AFTER          macro    
                    WAIT7    
                    endm     
INIT_MOVE_org       macro    
                    sta      <VIA_shift_reg               ; 
                    DELAY_NONE  
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi 
                    endm     
INIT_MOVE           macro    
                    ldb      #%11100000 
                    stb      <VIA_shift_reg               ; 
                    DELAY_NONE  
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi 
                    endm     
INIT_MOVE_SJ        macro    
                    DELAY_NONE  
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi 
                    sta      <VIA_shift_reg               ; 
                    endm     
;***************************************************************************
drawSmart                                                 ;#isfunction  
                    clra     
                    pulu     b,x,pc 
;***************************************************************************
;/* HIGHEST SCALE FOR SMARTLIST + CONTINUE is 16!
SM_continue_yd4_yStays_single                             ;#isfunction  
SM_continue_yStays_single                                 ;#isfunction  
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi               ; 4 
                    ADD_NOPS  
                    pulu     b,x,pc 
SM_continue7_single                                       ;#isfunction  
                    SET_Y_INT  
                    Y_DELAY                               ; 4 
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi               ; 4 
                    ADD_NOPS                              ; 21 
; this is one pulu cycle more!
; thus ADD_NOPS can be one cycle less!
; minus 6!
                    pulu     b,x                          ; 5+3 
SM_continue6_single                                       ;#isfunction  
                    SET_Y_INT  
                    Y_DELAY                               ; 4 
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi               ; 4 
                    ADD_NOPS                              ; 21 
                    pulu     b,x                          ; 5+3 
SM_continue5_single                                       ;#isfunction  
                    SET_Y_INT  
                    Y_DELAY                               ; 4 
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi               ; 4 
                    ADD_NOPS                              ; 21 
                    pulu     b,x                          ; 5+3 
SM_continue4_single                                       ;#isfunction  
                    SET_Y_INT  
                    Y_DELAY                               ; 4 
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi               ; 4 
                    ADD_NOPS                              ; 21 
                    pulu     b,x                          ; 5+3 
SM_continue3_single                                       ;#isfunction  
                    SET_Y_INT  
                    Y_DELAY                               ; 4 
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi               ; 4 
                    ADD_NOPS                              ; 21 
                    pulu     b,x                          ; 5+3 
SM_continue2_single                                       ;#isfunction  
                    SET_Y_INT  
                    Y_DELAY                               ; 4 
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi               ; 4 
                    ADD_NOPS                              ; 21 
                    pulu     b,x                          ; 5+3 
; continue uses same shift  
SM_continue_single                                        ;#isfunction  
                    stb      <VIA_port_a                  ; 4 shift not changed, move might also be a draw 
; y is inherently known to be == old_x, y was set to 0 by generator
SM_continue_newY_eq_oldX_single:                          ;#isfunction  
                    sta      <VIA_port_b                  ; 4 
                    Y_DELAY                               ; 4 
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    pulu     b,x,pc 
SM_continue_yd4_single                                    ;#isfunction  
                    stb      <VIA_port_a                  ; 4 shift not changed, move might also be a draw 
; y is inherently known to be == old_x, y was set to 0 by generator
SM_continue_yd4_newY_eq_oldX_single:                      ;#isfunction  
                    sta      <VIA_port_b                  ; 4 
                    Y_DELAY_4                             ; 4 
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    pulu     b,x,pc 
SM_continue_single_sj                                     ;#isfunction  
                    stb      <VIA_port_a                  ; 4 shift not changed, move might also be a draw 
; y is inherently known to be == old_x, y was set to 0 by generator
SM_continue_newY_eq_oldX_single_sj:                       ;#isfunction  
                    sta      <VIA_port_b                  ; 4 
                    Y_DELAY                               ; 4 
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi 
                    ADD_NOPS_NOU                          ; reduced by ldu ,u - 5 cycles 
                    ldu      ,u 
                    pulu     b,x,pc 
; continue uses same shift
; y is inherently known to be == x, 
SM_continue_yd4_yEqx_single                               ;#isfunction  
                    SET_Y_INT  
                    Y_DELAY_HALF_4                        ; 4 
                    inc      <VIA_port_b 
                    sta      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    pulu     b,x,pc 
SM_continue_yEqx_single                                   ;#isfunction  
                    SET_Y_INT  
                    Y_DELAY_HALF                          ; 4 
                    inc      <VIA_port_b 
                    sta      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    pulu     b,x,pc 
SM_continue_tripple                                       ;#isfunction  
                    SET_Y_INT  
                    Y_DELAY                               ; 4 
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    jmp      cont2 

SM_continue_quadro                                        ;#isfunction  
                    SET_Y_INT  
                    Y_DELAY                               ; 4 
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    jmp      cont3 

SM_continue_hex                                           ;#isfunction  
                    SET_Y_INT  
                    Y_DELAY                               ; 4 
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    jmp      cont5 

SM_continue_octo                                          ;#isfunction  
                    SET_Y_INT  
                    Y_DELAY                               ; 4 
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    WAIT_BEFORE  
cont7 
                    WAIT_AFTER  
                    clr      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    WAIT_BEFORE  
cont6 
                    WAIT_AFTER  
                    clr      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    WAIT_BEFORE  
cont5 
                    WAIT_AFTER  
                    clr      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    WAIT_BEFORE  
cont4 
                    WAIT_AFTER  
                    clr      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    WAIT_BEFORE  
cont3 
                    WAIT_AFTER  
                    clr      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    WAIT_BEFORE  
cont2 
                    WAIT_AFTER  
                    clr      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    jmp      SM_repeat_same 

SM_repeat_same                                            ;#isfunction  
                    pulu     b,x 
                    clr      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    pulu     pc 
SM_continue_double                                        ;#isfunction  
                    SET_Y_INT  
                    Y_DELAY                               ; 4 
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    jmp      SM_repeat_same 

SM_continue_yd4_double                                    ;#isfunction 
                    SET_Y_INT  
                    Y_DELAY_4                             ; 4 
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    jmp      SM_repeat_same 

SM_startMove_yd4_single                                   ;#isfunction  
SM_startMove_single:                                      ;#isfunction  
                    SET_Y_INT  
                    INIT_MOVE  
                    ADD_NOPS  
                    pulu     b,x,pc 
SM_startMove_single_sj:                                   ;#isfunction  
                    SET_Y_INT  
                    ldu      ,u 
                    INIT_MOVE_SJ  
                    ADD_NOPS_NOU                          ; reduced by ldu ,u - 5 cycles 
                    pulu     b,x,pc 
SM_startMove_yd4_single_sj:                               ;#isfunction  
                    SET_Y_INT  
                    ldu      ,u 
                    INIT_MOVE_SJ  
                    ADD_NOPS_NOU                          ; reduced by ldu ,u - 5 cycles 
                    pulu     b,x,pc 
SM_startMove_yd4_double:                                  ;#isfunction  
SM_startMove_double:                                      ;#isfunction  
                    SET_Y_INT  
                    INIT_MOVE  
                    ADD_NOPS  
                    jmp      SM_repeat_same2 

SM_startDraw_tripple                                      ;#isfunction  
                    SET_Y_INT  
                    ldb      #SHITREG_POKE_VALUE          ; 2 
                    stb      <VIA_shift_reg               ; 4 
                    DELAY_NONE  
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi               ; 4 
                    ADD_NOPS  
                    jmp      cont2 

SM_startDraw_double                                       ;#isfunction  
                    SET_Y_INT  
                    ldb      #SHITREG_POKE_VALUE          ; 2 
                    stb      <VIA_shift_reg               ; 4 
                    DELAY_NONE  
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi               ; 4 
                    ADD_NOPS  
                    jmp      SM_repeat_same2 

SM_startMove_tripple                                      ;#isfunction  
                    SET_Y_INT  
                    INIT_MOVE  
                    ADD_NOPS  
                    bra      move2 

SM_startMove_quadro                                       ;#isfunction  
                    SET_Y_INT  
                    INIT_MOVE  
                    ADD_NOPS  
                    bra      move3 

move3 
                    WAIT_AFTER  
                    clr      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    WAIT_BEFORE  
move2 
                    WAIT_AFTER  
                    clr      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    jmp      SM_repeat_same2 

SM_repeat_same2                                           ;#isfunction  
                    pulu     b,x 
                    clr      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    pulu     pc 
SM_startMove_double_sj                                    ;#isfunction  
                    SET_Y_INT  
                    ldu      ,u 
                    INIT_MOVE_SJ  
                    ADD_NOPS  
                    brn      0 
                    brn      0 
                    clr      <VIA_t1_cnt_hi 
                    ADD_NOPS                              ; reduced by ldu ,u - 5 cycles 
                    pulu     b,x, pc 
SM_startMove_yStays_single                                ;#isfunction  
                    INIT_MOVE  
                    ADD_NOPS  
                    pulu     b,x,pc 
SM_startMove_yStays_single_sj 
                    ldu      ,u 
                    INIT_MOVE_SJ  
                    ADD_NOPS_NOU                          ; reduced by ldu ,u - 5 cycles 
                    pulu     b,x,pc 
; assuming b = 1
SM_startDraw_yStays_single                                ;#isfunction  
                    stb      <VIA_shift_reg               ; 4 
                    DELAY_NONE  
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi               ; 4 
                    ADD_NOPS  
                    pulu     b,x,pc 
; assume b contains SHIFT
SM_startDraw_xyStays_single                               ;#isfunction  
                    stb      <VIA_shift_reg 
                    sta      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    pulu     b,x,pc 
SM_startDraw_yStays_single_sj                             ;#isfunction  
;                    ldb      #SHITREG_POKE_VALUE          ; 2 
                    stb      <VIA_shift_reg               ; 4 
                    DELAY_NONE  
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi               ; 4 
                    ADD_NOPS_NOU                          ; reduced by ldu ,u - 5 cycles 
                    ldu      ,u 
                    pulu     b,x,pc 
SM_startDraw_yd4_single                                   ;#isfunction 
SM_startDraw_single:                                      ;#isfunction  
                    SET_Y_INT  
                    ldb      #SHITREG_POKE_VALUE          ; 2 
                    stb      <VIA_shift_reg               ; 4 
                    DELAY_NONE  
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi               ; 4 
                    ADD_NOPS  
                    pulu     b,x,pc 
SM_startDraw_single_sj 
                    SET_Y_INT  
                    ldb      #SHITREG_POKE_VALUE          ; 2 
                    stb      <VIA_shift_reg               ; 4 
                    DELAY_NONE  
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi               ; 4 
                    ADD_NOPS_NOU                          ; reduced by ldu ,u - 5 cycles 
                    ldu      ,u 
                    pulu     b,x,pc 
SM_startDraw_yEqx_single_sj                               ;#isfunction  
                    SET_Y_INT  
                    ldb      #$01 
                    stb      <VIA_shift_reg               ; 4 - ASSUMING SHITREG_POKE_VALUE = 1 
                    DELAY_NONE  
                    stb      <VIA_port_b 
                    sta      <VIA_t1_cnt_hi 
                    ADD_NOPS_NOU                          ; reduced by ldu ,u - 5 cycles 
                    ldu      ,u 
                    pulu     b,x,pc 
SM_startDraw_yEqx_single                                  ;#isfunction  
SM_startDraw_yd4_yEqx_single                              ;#isfunction  
                    SET_Y_INT  
                    ldb      #$01 
                    stb      <VIA_shift_reg               ; 4 - ASSUMING SHITREG_POKE_VALUE = 1 
                    DELAY_NONE  
                    stb      <VIA_port_b 
                    sta      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    pulu     b,x,pc 
SM_startMove_yEqx_single                                  ;#isfunction  
                    SET_Y_INT  
                    Y_DELAY_HALF  
                    inc      <VIA_port_b 
                    sta      <VIA_t1_cnt_hi 
                    sta      <VIA_shift_reg               ; 4 
                    ADD_NOPS  
                    pulu     b,x,pc 
SM_startMove_yd4_yEqx_single                              ;#isfunction  
                    SET_Y_INT  
                    Y_DELAY_HALF_4  
                    inc      <VIA_port_b 
                    sta      <VIA_t1_cnt_hi 
                    sta      <VIA_shift_reg               ; 4 
                    ADD_NOPS  
                    pulu     b,x,pc 
SM_startMove_xyStays_single                               ;#isfunction  
                    sta      <VIA_t1_cnt_hi 
                    stb      <VIA_shift_reg 
                    ADD_NOPS  
                    pulu     b,x,pc 
SM_startMove_yEqx_single_sj                               ;#isfunction  
                    SET_Y_INT  
                    WAIT2    
                    DELAY_NONE  
                    inc      <VIA_port_b 
                    sta      <VIA_t1_cnt_hi 
                    sta      <VIA_shift_reg               ; 4 
                    ADD_NOPS_NOU                          ; reduced by ldu ,u - 5 cycles 
                    ldu      ,u 
                    pulu     b,x,pc 
SM_startMove_yd4_yEqx_single_sj                           ;#isfunction  
                    SET_Y_INT  
                    WAIT2    
                    Y_DELAY_HALF_4  
                    inc      <VIA_port_b 
                    sta      <VIA_t1_cnt_hi 
                    sta      <VIA_shift_reg               ; 4 
                    ADD_NOPS_NOU                          ; reduced by ldu ,u - 5 cycles 
                    ldu      ,u 
                    pulu     b,x,pc 
SM_startMove_newY_eq_oldX_single                          ;#isfunction 
                    sta      <VIA_port_b                  ; 4 
                    INIT_MOVE  
                    ADD_NOPS                              ; reduced by ldu ,u - 5 cycles 
                    pulu     b,x,pc 
SM_startMove_newY_eq_oldX_single_sj                       ;#isfunction  
                    sta      <VIA_port_b                  ; 4 
                    ldu      ,u 
                    INIT_MOVE_SJ  
                    ADD_NOPS_NOU                          ; reduced by ldu ,u - 5 cycles 
                    pulu     b,x,pc 
SM_startDraw_newY_eq_oldX_single:                         ;#isfunction  
                    sta      <VIA_port_b                  ; 4 
                    ldb      #SHITREG_POKE_VALUE 
                    stb      <VIA_shift_reg               ; 4 
                    DELAY_NONE  
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi 
                    ADD_NOPS  
                    pulu     b,x,pc 
SM_startDraw_newY_eq_oldX_single_sj:                      ;#isfunction  
                    sta      <VIA_port_b                  ; 4 
                    ldb      #SHITREG_POKE_VALUE 
                    stb      <VIA_shift_reg               ; 4 
                    DELAY_NONE  
                    stx      <VIA_port_b                  ; 5 
                    sta      <VIA_t1_cnt_hi 
                    ADD_NOPS_NOU                          ; reduced by ldu ,u - 5 cycles 
                    ldu      ,u 
                    pulu     b,x,pc 
SM_lastDraw_rts                                           ;#isfunction  
SM_FlagWait: 
                    bitb     <VIA_int_flags 
                    beq      SM_FlagWait 
                    sta      <VIA_shift_reg 
SM_rts:                                                   ;#isfunction  
                    ldb      #$7f 
                    LDA      #$CC 
                    STA      VIA_cntl                     ;/BLANK low and /ZERO low 
                    stB      VIA_t1_cnt_lo 
; and ensures integrators are clean (good positioning!)
;                    ldd      #0 
                    stx      <VIA_port_b 
                    rts      












