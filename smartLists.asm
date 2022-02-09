
*
* Depending upon what a robot is doing, his extremities
* (legs and eye boxes) may be drawn differently.  Each
* entry in this table points to another structure, which
* defines how the extremities should be drawn.  Each robot
* structure has a field which is used to index into this
* table.
*
*              ---------------------------------
*              | 0 | 0 | x | 0 | x | x | x | x |
*              ---------------------------------
*   x and/or y is same --^
*   Down ------------------------^
*   Up ------------------------------^
*   Right -------------------------------^
*   Left ------------------------------------^

; build with scale factor 11
; vb smartlist
; move to position
; eq difs
;
; converted using lists from original and import to Vide
; list size halfed and scale set to 11 (was 4, for cranky vectrex -> halved)

newRobotExtremitiesVectorTable:
       DW    newRobotStandingStill;
       DW    newRobotMovingLeft;
       DW    newRobotMovingRight;
       DW    newRobotStandingStill;
       DW    newRobotMovingUp;
       DW    newRobotMovingLeft;
       DW    newRobotMovingRight;
       DW    newRobotStandingStill;
       DW    newRobotMovingDown;
       DW    newRobotMovingLeft;
       DW    newRobotMovingRight;

newRobotStandingStill:
       DW    robotStillCenter;Leg1;
       DW    robotStillCenter;Leg2;
       DW    robotStillRight;Leg1;
       DW    robotStillRight;Leg2;
       DW    robotStillNone;Leg1
       DW    robotStillNone;Leg2
       DW    robotStillLeft;;Leg1
       DW    robotStillLeft;;Leg2

newRobotMovingLeft
       DW    robotLeftLeg1;Leg1;
       DW    robotLeftLeg2;Leg2
       DW    robotLeftLeg1;Leg1;
       DW    robotLeftLeg2;Leg2
       DW    robotLeftLeg1;Leg1;
       DW    robotLeftLeg2;Leg2
       DW    robotLeftLeg1;Leg1
       DW    robotLeftLeg2;Leg2;
newRobotMovingRight
       DW    robotRightLeg1;Leg1;
       DW    robotRightLeg2;Leg2
       DW    robotRightLeg1;Leg1;
       DW    robotRightLeg2;Leg2
       DW    robotRightLeg1;Leg1;
       DW    robotRightLeg2;Leg2
       DW    robotRightLeg1;Leg1
       DW    robotRightLeg2;Leg2;

newRobotMovingUp
       DW    robotUpLeg3;Leg1;
       DW    robotUpLeg4;Leg3;
       DW    robotUpLeg3;Leg1;
       DW    robotUpLeg4;Leg3;
       DW    robotUpLeg3;Leg1;
       DW    robotUpLeg4;Leg3;
       DW    robotUpLeg3;Leg1;
       DW    robotUpLeg4;Leg3;

newRobotMovingDown
       DW    robotDownLeg3;Leg1;
       DW    robotDownLeg4;Leg3;
       DW    robotDownLeg3;Leg1;
       DW    robotDownLeg4;Leg3;
       DW    robotDownLeg3;Leg1;
       DW    robotDownLeg4;Leg3;
       DW    robotDownLeg3;Leg1;
       DW    robotDownLeg4;Leg3;

robotStillCenter
	db -$37, $01, -$1E, hi(SM_continue_single), lo(SM_continue_single)
	db  $00, $01,  $0E, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $0A, $01,  $00, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $2D, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $00, $01, -$0E, hi(SM_continue7_single), lo(SM_continue7_single)
	db -$18, $01,  $00
	db  $00, $01, -$0A
	db  $3E, $01,  $00
	db  $0C, $01,  $14
	db  $00, $01,  $28
	db -$0C, $01,  $14
	db -$3E, $01,  $00, hi(SM_continue5_single), lo(SM_continue5_single)
	db  $00, $01, -$0A
	db  $18, $01,  $00
	db  $00, $01, -$0E
	db -$2D, $01,  $00
	db -$0A, $01,  $00, hi(SM_startMove_single), lo(SM_startMove_single)
	db SHITREG_POKE_VALUE, $01,  $0E, hi(SM_startDraw_newY_eq_oldX_single), lo(SM_startDraw_newY_eq_oldX_single) ; y was  $00, now SHIFT
	db  $4F, $01, -$0A, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $00, $01, -$28, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $0E, $01,  $00, hi(SM_continue3_single), lo(SM_continue3_single)
	db  $00, $01,  $28
	db -$0E, $01,  $00
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)



robotRightLeg1
robotStillRight
	db -$37, $01, -$1E, hi(SM_continue_single), lo(SM_continue_single)
	db  $00, $01,  $0E, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $0A, $01,  $00, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $2D, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $00, $01, -$0E, hi(SM_continue7_single), lo(SM_continue7_single)
	db -$18, $01,  $00
	db  $00, $01, -$0A
	db  $3E, $01,  $00
	db  $0C, $01,  $14
	db  $00, $01,  $28
	db -$0C, $01,  $14
	db -$3E, $01,  $00, hi(SM_continue5_single), lo(SM_continue5_single)
	db  $00, $01, -$0A
	db  $18, $01,  $00
	db  $00, $01, -$0E
	db -$2D, $01,  $00
	db -$0A, $01,  $00, hi(SM_startMove_single), lo(SM_startMove_single)
	db SHITREG_POKE_VALUE, $01,  $0E, hi(SM_startDraw_newY_eq_oldX_single), lo(SM_startDraw_newY_eq_oldX_single) ; y was  $00, now SHIFT
	db  $4F, $01,  $0A, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $00, $01, -$1E, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $0E, $01,  $00, hi(SM_continue2_single), lo(SM_continue2_single)
	db  $00, $01,  $1E
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)



robotStillNone
	db -$37, $01, -$1E, hi(SM_continue_single), lo(SM_continue_single)
	db  $00, $01,  $0E, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $0A, $01,  $00, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $2D, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $00, $01, -$0E, hi(SM_continue7_single), lo(SM_continue7_single)
	db -$18, $01,  $00
	db  $00, $01, -$0A
	db  $3E, $01,  $00
	db  $0C, $01,  $14
	db  $00, $01,  $28
	db -$0C, $01,  $14
	db -$3E, $01,  $00, hi(SM_continue5_single), lo(SM_continue5_single)
	db  $00, $01, -$0A
	db  $18, $01,  $00
	db  $00, $01, -$0E
	db -$2D, $01,  $00
	db -$0A, $01,  $00, hi(SM_startMove_single), lo(SM_startMove_single)
	db SHITREG_POKE_VALUE, $01,  $0E, hi(SM_startDraw_newY_eq_oldX_single), lo(SM_startDraw_newY_eq_oldX_single) ; y was  $00, now SHIFT
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)




robotLeftLeg1
robotStillLeft
	db -$37, $01, -$1E, hi(SM_continue_single), lo(SM_continue_single)
	db  $00, $01,  $0E, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $0A, $01,  $00, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $2D, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $00, $01, -$0E, hi(SM_continue7_single), lo(SM_continue7_single)
	db -$18, $01,  $00
	db  $00, $01, -$0A
	db  $3E, $01,  $00
	db  $0C, $01,  $14
	db  $00, $01,  $28
	db -$0C, $01,  $14
	db -$3E, $01,  $00, hi(SM_continue5_single), lo(SM_continue5_single)
	db  $00, $01, -$0A
	db  $18, $01,  $00
	db  $00, $01, -$0E
	db -$2D, $01,  $00
	db -$0A, $01,  $00, hi(SM_startMove_single), lo(SM_startMove_single)
	db SHITREG_POKE_VALUE, $01,  $0E, hi(SM_startDraw_newY_eq_oldX_single), lo(SM_startDraw_newY_eq_oldX_single) ; y was  $00, now SHIFT
	db  $4F, $01, -$46, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $00, $01,  $1E, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $0E, $01,  $00, hi(SM_continue2_single), lo(SM_continue2_single)
	db  $00, $01, -$1E
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)



robotLeftLeg2
	db -$37, $01, -$14, hi(SM_continue_single), lo(SM_continue_single)
	db  $00, $01,  $0E, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $0A, $01,  $00, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $2D, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $00, $01, -$17, hi(SM_continue7_single), lo(SM_continue7_single)
	db -$18, $01,  $00
	db  $00, $01, -$0A
	db  $3E, $01,  $00
	db  $0C, $01,  $14
	db  $00, $01,  $28
	db -$0C, $01,  $14
	db -$3E, $01,  $00, hi(SM_continue5_single), lo(SM_continue5_single)
	db  $00, $01, -$0A
	db  $18, $01,  $00
	db  $00, $01, -$17
	db -$2C, $01,  $00
	db -$0A, $01,  $00, hi(SM_startMove_single), lo(SM_startMove_single)
	db SHITREG_POKE_VALUE, $01,  $0E, hi(SM_startDraw_newY_eq_oldX_single), lo(SM_startDraw_newY_eq_oldX_single) ; y was  $00, now SHIFT
	db  $4F, $01, -$3C, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $00, $01,  $1E, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $0E, $01,  $00, hi(SM_continue2_single), lo(SM_continue2_single)
	db  $00, $01, -$1E
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)


robotRightLeg2
	db -$37, $01, -$14, hi(SM_continue_single), lo(SM_continue_single)
	db  $00, $01,  $0E, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $0A, $01,  $00, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $2D, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $00, $01, -$18, hi(SM_continue7_single), lo(SM_continue7_single)
	db -$18, $01,  $00
	db  $00, $01, -$0A
	db  $3E, $01,  $00
	db  $0C, $01,  $14
	db  $00, $01,  $28
	db -$0C, $01,  $14
	db -$3E, $01,  $00, hi(SM_continue5_single), lo(SM_continue5_single)
	db  $00, $01, -$0A
	db  $18, $01,  $00
	db  $00, $01, -$18
	db -$2D, $01,  $00
	db -$0A, $01,  $00, hi(SM_startMove_single), lo(SM_startMove_single)
	db SHITREG_POKE_VALUE, $01,  $0E, hi(SM_startDraw_newY_eq_oldX_single), lo(SM_startDraw_newY_eq_oldX_single) ; y was  $00, now SHIFT
	db  $4F, $01,  $14, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $00, $01, -$1E, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $0E, $01,  $00, hi(SM_continue2_single), lo(SM_continue2_single)
	db  $00, $01,  $1E
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)


robotUpLeg3
	db -$37, $01, -$1E, hi(SM_continue_single), lo(SM_continue_single)
	db  $00, $01,  $0E, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $0A, $01,  $00, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $2D, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $00, $01, -$0E, hi(SM_continue7_single), lo(SM_continue7_single)
	db -$18, $01,  $00
	db  $00, $01, -$0A
	db  $3E, $01,  $00
	db  $0C, $01,  $14
	db  $00, $01,  $28
	db -$0C, $01,  $14
	db -$3E, $01,  $00, hi(SM_continue5_single), lo(SM_continue5_single)
	db  $00, $01, -$0A
	db  $18, $01,  $00
	db  $00, $01, -$0E
	db -$23, $01,  $00
	db -$0A, $01,  $00, hi(SM_startMove_single), lo(SM_startMove_single)
	db SHITREG_POKE_VALUE, $01, -$0E, hi(SM_startDraw_newY_eq_oldX_single), lo(SM_startDraw_newY_eq_oldX_single) ; y was  $00, now SHIFT
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)
robotUpLeg4
	db -$2D, $01, -$1E, hi(SM_continue_single), lo(SM_continue_single)
	db  $00, $01,  $0E, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $0A, $01,  $00, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $23, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $00, $01, -$0E, hi(SM_continue7_single), lo(SM_continue7_single)
	db -$18, $01,  $00
	db  $00, $01, -$0A
	db  $3E, $01,  $00
	db  $0C, $01,  $14
	db  $00, $01,  $28
	db -$0C, $01,  $14
	db -$3E, $01,  $00, hi(SM_continue5_single), lo(SM_continue5_single)
	db  $00, $01, -$0A
	db  $18, $01,  $00
	db  $00, $01, -$0E
	db -$2D, $01,  $00
	db -$0A, $01,  $00, hi(SM_startMove_single), lo(SM_startMove_single)
	db SHITREG_POKE_VALUE, $01, -$0E, hi(SM_startDraw_newY_eq_oldX_single), lo(SM_startDraw_newY_eq_oldX_single) ; y was  $00, now SHIFT
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)


robotDownLeg3
	db -$37, $01, -$1E, hi(SM_continue_single), lo(SM_continue_single)
	db  $00, $01,  $0E, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $0A, $01,  $00, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $2D, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $00, $01, -$0E, hi(SM_continue7_single), lo(SM_continue7_single)
	db -$18, $01,  $00
	db  $00, $01, -$0A
	db  $3E, $01,  $00
	db  $0C, $01,  $14
	db  $00, $01,  $28
	db -$0C, $01,  $14
	db -$3E, $01,  $00, hi(SM_continue5_single), lo(SM_continue5_single)
	db  $00, $01, -$0A
	db  $18, $01,  $00
	db  $00, $01, -$0E
	db -$23, $01,  $00
	db -$0A, $01,  $00, hi(SM_startMove_single), lo(SM_startMove_single)
	db SHITREG_POKE_VALUE, $01, -$0E, hi(SM_startDraw_newY_eq_oldX_single), lo(SM_startDraw_newY_eq_oldX_single) ; y was  $00, now SHIFT
	db  $45, $01,  $12, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $0E, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $00, $01, -$28, hi(SM_continue3_single), lo(SM_continue3_single)
	db -$0E, $01,  $00
	db  $00, $01,  $28
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)

robotDownLeg4
	db -$2D, $01, -$1E, hi(SM_continue_single), lo(SM_continue_single)
	db  $00, $01,  $0E, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $0A, $01,  $00, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $23, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $00, $01, -$0E, hi(SM_continue7_single), lo(SM_continue7_single)
	db -$18, $01,  $00
	db  $00, $01, -$0A
	db  $3E, $01,  $00
	db  $0C, $01,  $14
	db  $00, $01,  $28
	db -$0C, $01,  $14
	db -$3E, $01,  $00, hi(SM_continue5_single), lo(SM_continue5_single)
	db  $00, $01, -$0A
	db  $18, $01,  $00
	db  $00, $01, -$0E
	db -$2D, $01,  $00
	db -$0A, $01,  $00, hi(SM_startMove_single), lo(SM_startMove_single)
	db SHITREG_POKE_VALUE, $01, -$0E, hi(SM_startDraw_newY_eq_oldX_single), lo(SM_startDraw_newY_eq_oldX_single) ; y was  $00, now SHIFT
	db  $4F, $01,  $12, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $0E, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $00, $01, -$28, hi(SM_continue3_single), lo(SM_continue3_single)
	db -$0E, $01,  $00
	db  $00, $01,  $28
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)


manRunningList: 
                    DW       ManStandStandNeutral               ; 
                    DW       ManStandRunRight1            ; 
                    DW       ManStandRunRight2            ; 
                    DW       ManStandRunLeft1             ; 
                    DW       ManStandRunLeft2             ; 

manStandingList: 
                    DW       ManStandStandNeutral                  ; 
                    DW       ManStandStandLeft                 ; 
                    DW       ManStandStandRight                ; 
                    DW       ManStandStandUp                   ; 
                    DW       ManStandStandUpLeft            ; 
                    DW       ManStandStandUpRight           ; 
                    DW       ManStandStandDown                 ; 
                    DW       ManStandStandDownLeft            ; 
                    DW       ManStandStandDownRight           ; 

ManStandStandNeutral
	db  $00, $01,  $14, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$3C, $01,  $00, hi(SM_continue7_single), lo(SM_continue7_single)
	db  $00, $01, -$28
	db  $3C, $01,  $00
	db  $00, $01,  $14
	db  $0F, $01,  $14
	db  $0A, $01,  $00
	db  $0A, $01, -$14
	db -$0A, $01, -$14, hi(SM_continue4_single), lo(SM_continue4_single)
	db -$0A, $01,  $00
	db -$0F, $01,  $14
	db  $01, $01,  $05
	db -$3C, $01,  $0A, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$28, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$04, $01,  $0A, hi(SM_continue4_single), lo(SM_continue4_single)
	db -$04, $01, -$0A
	db  $00, $01, -$14
	db  $30, $01,  $00
	db  $32, $01,  $1D, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$0A, $01,  $14, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$1A, $01,  $00, hi(SM_continue_single), lo(SM_continue_single)
	db  $24, $01, -$3B, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$0A, $01, -$14, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$1A, $01,  $00, hi(SM_continue_single), lo(SM_continue_single)
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)

ManStandStandRight
	db  $00, $01,  $14, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$3C, $01,  $00, hi(SM_continue7_single), lo(SM_continue7_single)
	db  $00, $01, -$28
	db  $3C, $01,  $00
	db  $00, $01,  $14
	db  $0F, $01,  $14
	db  $0A, $01,  $00
	db  $0A, $01, -$14
	db -$0A, $01, -$14, hi(SM_continue4_single), lo(SM_continue4_single)
	db -$0A, $01,  $00
	db -$0F, $01,  $14
	db  $01, $01,  $05
	db -$3C, $01,  $0A, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$28, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$04, $01,  $0A, hi(SM_continue4_single), lo(SM_continue4_single)
	db -$04, $01, -$0A
	db  $00, $01, -$14
	db  $30, $01,  $00
	db  $32, $01,  $1E, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $00, $01,  $28, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$10, $01, -$40, hi(SM_continue2_single), lo(SM_continue2_single)
	db  $10, $01, -$10
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)

ManStandStandLeft
	db  $00, $01,  $14, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$3C, $01,  $00, hi(SM_continue7_single), lo(SM_continue7_single)
	db  $00, $01, -$28
	db  $3C, $01,  $00
	db  $00, $01,  $14
	db  $0F, $01,  $14
	db  $0A, $01,  $00
	db  $0A, $01, -$14
	db -$0A, $01, -$14, hi(SM_continue4_single), lo(SM_continue4_single)
	db -$0A, $01,  $00
	db -$0F, $01,  $14
	db  $01, $01,  $05
	db -$3C, $01,  $0A, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$28, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$04, $01,  $0A, hi(SM_continue4_single), lo(SM_continue4_single)
	db -$04, $01, -$0A
	db  $00, $01, -$14
	db  $30, $01,  $00
	db  $32, $01,  $1E, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$10, $01, -$10, hi(SM_startDraw_yEqx_single), lo(SM_startDraw_yEqx_single); y is -$10
	db  $10, $01, -$40, hi(SM_continue2_single), lo(SM_continue2_single)
	db  $00, $01,  $28
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)

ManStandStandUp
	db  $00, $01,  $14, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$3C, $01,  $00, hi(SM_continue7_single), lo(SM_continue7_single)
	db  $00, $01, -$28
	db  $3C, $01,  $00
	db  $00, $01,  $14
	db  $0F, $01,  $14
	db  $0A, $01,  $00
	db  $0A, $01, -$14
	db -$0A, $01, -$14, hi(SM_continue4_single), lo(SM_continue4_single)
	db -$0A, $01,  $00
	db -$0F, $01,  $14
	db  $01, $01,  $05
	db -$3C, $01,  $0A, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$28, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$04, $01,  $0A, hi(SM_continue4_single), lo(SM_continue4_single)
	db -$04, $01, -$0A
	db  $00, $01, -$14
	db  $30, $01,  $00
	db  $32, $01,  $1E, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $0A, $01,  $14, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $24, $01,  $00, hi(SM_continue3_single), lo(SM_continue3_single)
	db -$3C, $01, -$1E
	db  $0E, $01, -$1E
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)

ManStandStandDown
	db  $00, $01,  $14, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$3C, $01,  $00, hi(SM_continue7_single), lo(SM_continue7_single)
	db  $00, $01, -$28
	db  $3C, $01,  $00
	db  $00, $01,  $14
	db  $0F, $01,  $14
	db  $0A, $01,  $00
	db  $0A, $01, -$14
	db -$0A, $01, -$14, hi(SM_continue4_single), lo(SM_continue4_single)
	db -$0A, $01,  $00
	db -$0F, $01,  $14
	db  $01, $01,  $05
	db -$3C, $01,  $0A, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$28, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$04, $01,  $0A, hi(SM_continue4_single), lo(SM_continue4_single)
	db -$04, $01, -$0A
	db  $00, $01, -$14
	db  $30, $01,  $00
	db  $32, $01,  $1E, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$14, $01, -$30, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$1C, $01, -$0C, hi(SM_continue3_single), lo(SM_continue3_single)
	db  $24, $01,  $00
	db  $0A, $01,  $14
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)

ManStandStandUpLeft
	db  $00, $01,  $14, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$3C, $01,  $00, hi(SM_continue7_single), lo(SM_continue7_single)
	db  $00, $01, -$28
	db  $3C, $01,  $00
	db  $00, $01,  $14
	db  $0F, $01,  $14
	db  $0A, $01,  $00
	db  $0A, $01, -$14
	db -$0A, $01, -$14, hi(SM_continue4_single), lo(SM_continue4_single)
	db -$0A, $01,  $00
	db -$0F, $01,  $14
	db  $01, $01,  $05
	db -$3C, $01,  $0A, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$28, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$04, $01,  $0A, hi(SM_continue4_single), lo(SM_continue4_single)
	db -$04, $01, -$0A
	db  $00, $01, -$14
	db  $30, $01,  $00
	db  $32, $01,  $1E, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$10, $01, -$10, hi(SM_startDraw_yEqx_single), lo(SM_startDraw_yEqx_single); y is -$10
	db  $30, $01, -$40, hi(SM_continue3_single), lo(SM_continue3_single)
	db -$30, $01,  $18
	db  $10, $01,  $10
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)

ManStandStandDownLeft
	db  $00, $01,  $14, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$3C, $01,  $00, hi(SM_continue7_single), lo(SM_continue7_single)
	db  $00, $01, -$28
	db  $3C, $01,  $00
	db  $00, $01,  $14
	db  $0F, $01,  $14
	db  $0A, $01,  $00
	db  $0A, $01, -$14
	db -$0A, $01, -$14, hi(SM_continue4_single), lo(SM_continue4_single)
	db -$0A, $01,  $00
	db -$0F, $01,  $14
	db  $01, $01,  $05
	db -$3C, $01,  $0A, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$28, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$04, $01,  $0A, hi(SM_continue7_single), lo(SM_continue7_single)
	db -$04, $01, -$0A
	db  $00, $01, -$14
	db  $30, $01,  $00
	db  $32, $01,  $1E
	db -$18, $01,  $10
	db -$20, $01, -$30
	db  $3A, $01,  $1A, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)

ManStandStandUpRight
	db  $00, $01,  $14, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$3C, $01,  $00, hi(SM_continue7_single), lo(SM_continue7_single)
	db  $00, $01, -$28
	db  $3C, $01,  $00
	db  $00, $01,  $14
	db  $0F, $01,  $14
	db  $0A, $01,  $00
	db  $0A, $01, -$14
	db -$0A, $01, -$14, hi(SM_continue4_single), lo(SM_continue4_single)
	db -$0A, $01,  $00
	db -$0F, $01,  $14
	db  $01, $01,  $05
	db -$3C, $01,  $0A, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$28, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$04, $01,  $0A, hi(SM_continue4_single), lo(SM_continue4_single)
	db -$04, $01, -$0A
	db  $00, $01, -$14
	db  $30, $01,  $00
	db  $32, $01,  $1E, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$10, $01,  $10, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $30, $01,  $18, hi(SM_continue3_single), lo(SM_continue3_single)
	db -$30, $01, -$40
	db  $10, $01, -$10
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)

ManStandStandDownRight
	db  $00, $01,  $14, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$3C, $01,  $00, hi(SM_continue7_single), lo(SM_continue7_single)
	db  $00, $01, -$28
	db  $3C, $01,  $00
	db  $00, $01,  $14
	db  $0F, $01,  $14
	db  $0A, $01,  $00
	db  $0A, $01, -$14
	db -$0A, $01, -$14, hi(SM_continue4_single), lo(SM_continue4_single)
	db -$0A, $01,  $00
	db -$0F, $01,  $14
	db  $01, $01,  $05
	db -$3C, $01,  $0A, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$28, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$04, $01,  $0A, hi(SM_continue4_single), lo(SM_continue4_single)
	db -$04, $01, -$0A
	db  $00, $01, -$14
	db  $30, $01,  $00
	db  $32, $01,  $1E, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$3C, $01,  $18, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $20, $01, -$30, hi(SM_continue2_single), lo(SM_continue2_single)
	db  $18, $01, -$10
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)




ManStandRunRight1
	db  $00, $01,  $14, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$3C, $01,  $00, hi(SM_continue7_single), lo(SM_continue7_single)
	db  $00, $01, -$28
	db  $3C, $01,  $00
	db  $00, $01,  $14
	db  $0F, $01,  $14
	db  $0A, $01,  $00
	db  $0A, $01, -$14
	db -$0A, $01, -$14, hi(SM_continue3_single), lo(SM_continue3_single)
	db -$0A, $01,  $00
	db -$0F, $01,  $14
	db -$3C, $01,  $0C, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$20, $01,  $16, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$16, $01,  $06, hi(SM_continue2_single), lo(SM_continue2_single)
	db -$02, $01,  $08
	db  $10, $01, -$68, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $0A, $01,  $04, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $08, $01,  $20, hi(SM_continue2_single), lo(SM_continue2_single)
	db  $16, $01,  $08
	db  $32, $01,  $1D, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$10, $01,  $10, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$16, $01, -$08, hi(SM_continue_single), lo(SM_continue_single)
	db  $04, $01, -$43, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $18, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $06, $01,  $14, hi(SM_continue_single), lo(SM_continue_single)
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)

ManStandRunRight2
	db  $00, $01,  $14, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$3C, $01,  $00, hi(SM_continue7_single), lo(SM_continue7_single)
	db  $00, $01, -$28
	db  $3C, $01,  $00
	db  $00, $01,  $14
	db  $0F, $01,  $14
	db  $0A, $01,  $00
	db  $0A, $01, -$14
	db -$0A, $01, -$14, hi(SM_continue3_single), lo(SM_continue3_single)
	db -$0A, $01,  $00
	db -$0F, $01,  $14
	db -$3C, $01,  $08, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$20, $01,  $0A, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$1A, $01, -$08, hi(SM_continue2_single), lo(SM_continue2_single)
	db  $00, $01,  $08
	db  $00, $01, -$24, hi(SM_startMove_yStays_single), lo(SM_startMove_yStays_single); y was  $00, now 0
	db  $02, $01, -$08, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $1A, $01,  $08, hi(SM_continue2_single), lo(SM_continue2_single)
	db  $1E, $01,  $02
	db  $32, $01,  $21, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$06, $01,  $14, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$1C, $01,  $00, hi(SM_continue_single), lo(SM_continue_single)
	db -$04, $01, -$43, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $16, $01, -$08, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $10, $01,  $10, hi(SM_continue_yEqx_single), lo(SM_continue_yEqx_single); y is  $10
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)

ManStandRunLeft1
	db  $00, $01,  $14, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$3C, $01,  $00, hi(SM_continue7_single), lo(SM_continue7_single)
	db  $00, $01, -$28
	db  $3C, $01,  $00
	db  $00, $01,  $14
	db  $0F, $01,  $14
	db  $0A, $01,  $00
	db  $0A, $01, -$14
	db -$0A, $01, -$14, hi(SM_continue3_single), lo(SM_continue3_single)
	db -$0A, $01,  $00
	db -$0F, $01,  $14
	db -$3C, $01,  $08, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$1E, $01, -$02, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$1A, $01,  $0E, hi(SM_continue2_single), lo(SM_continue2_single)
	db -$02, $01, -$04
	db  $00, $01, -$24, hi(SM_startMove_single), lo(SM_startMove_single)
	db  SHITREG_POKE_VALUE, $01,  $08, hi(SM_startDraw_yStays_single), lo(SM_startDraw_yStays_single); y was  $00, now SHIFT Poke
	db  $1A, $01, -$06, hi(SM_continue2_single), lo(SM_continue2_single)
	db  $20, $01,  $0A
	db  $32, $01,  $1D, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$10, $01,  $10, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$16, $01, -$08, hi(SM_continue_single), lo(SM_continue_single)
	db  $04, $01, -$43, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $18, $01,  $00, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $06, $01,  $14, hi(SM_continue_single), lo(SM_continue_single)
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)

ManStandRunLeft2
	db  $00, $01,  $14, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$3C, $01,  $00, hi(SM_continue7_single), lo(SM_continue7_single)
	db  $00, $01, -$28
	db  $3C, $01,  $00
	db  $00, $01,  $14
	db  $0F, $01,  $14
	db  $0A, $01,  $00
	db  $0A, $01, -$14
	db -$0A, $01, -$14, hi(SM_continue3_single), lo(SM_continue3_single)
	db -$0A, $01,  $00
	db -$0F, $01,  $14
	db -$3C, $01,  $08, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$16, $01,  $08, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$08, $01,  $20, hi(SM_continue2_single), lo(SM_continue2_single)
	db -$0A, $01,  $04
	db -$10, $01, -$64, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $02, $01,  $08, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $16, $01,  $06, hi(SM_continue2_single), lo(SM_continue2_single)
	db  $20, $01,  $16
	db  $32, $01,  $21, hi(SM_startMove_single), lo(SM_startMove_single)
	db -$06, $01,  $14, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db -$1C, $01,  $00, hi(SM_continue_single), lo(SM_continue_single)
	db -$04, $01, -$43, hi(SM_startMove_single), lo(SM_startMove_single)
	db  $16, $01, -$08, hi(SM_startDraw_single), lo(SM_startDraw_single)
	db  $10, $01,  $10, hi(SM_continue_yEqx_single), lo(SM_continue_yEqx_single); y is  $10
	db  $40, $00,  $00, hi(SM_lastDraw_rts), lo(SM_lastDraw_rts)
