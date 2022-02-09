
; This file was build using VIDE - Vectrex Integrated Development Environment
; Original bin file was: /Users/chrissalo/NetBeansProjects/Vide/projects/Berzerk/berzerkMusic.bin
; 
; offset for AKS file assumed: $0000 guessed by accessing byte data[13] * 256)
; not used by vectrex player and therefor omitted:
;  DB "AT10" ; Signature of Arkos Tracker files
;  DB $01 ; sample channel
;  DB $40, 42, 0f ; YM custom frequence - little endian
;  DB $02 ; Replay frequency (0=13hz,1=25hz,2=50hz,3=100hz,4=150hz,5=300hz)
SongAddressBerzerkMusicId:
 db $06 ; $0009: default speed
 dw $0150 ; $000A: size of instrument table (without this word pointer)
 dw instrument0BerzerkMusicId ; $000C: [$002E] pointer to instrument 0
 dw instrument1BerzerkMusicId ; $000E: [$0037] pointer to instrument 1
 dw instrument2BerzerkMusicId ; $0010: [$0050] pointer to instrument 2
 dw instrument3BerzerkMusicId ; $0012: [$0058] pointer to instrument 3
 dw instrument4BerzerkMusicId ; $0014: [$0069] pointer to instrument 4
 dw instrument5BerzerkMusicId ; $0016: [$0074] pointer to instrument 5
 dw instrument6BerzerkMusicId ; $0018: [$007D] pointer to instrument 6
 dw instrument7BerzerkMusicId ; $001A: [$009E] pointer to instrument 7
 dw instrument8BerzerkMusicId ; $001C: [$00B5] pointer to instrument 8
 dw instrument9BerzerkMusicId ; $001E: [$00CD] pointer to instrument 9
 dw instrument10BerzerkMusicId ; $0020: [$00DE] pointer to instrument 10
 dw instrument11BerzerkMusicId ; $0022: [$00ED] pointer to instrument 11
 dw instrument12BerzerkMusicId ; $0024: [$00FC] pointer to instrument 12
 dw instrument13BerzerkMusicId ; $0026: [$0120] pointer to instrument 13
 dw instrument14BerzerkMusicId ; $0028: [$012F] pointer to instrument 14
 dw instrument15BerzerkMusicId ; $002A: [$013E] pointer to instrument 15
 dw instrument16BerzerkMusicId ; $002C: [$014D] pointer to instrument 16
instrument0BerzerkMusicId:
 db $00 ; $002E: speed
 db $00 ; $002F: retrig
instrument0loopBerzerkMusicId:
 db $00 ; $0030: dataColumn_0 (non hard), vol=$0
 db $00 ; $0031: dataColumn_0 (non hard), vol=$0
 db $00 ; $0032: dataColumn_0 (non hard), vol=$0
 db $00 ; $0033: dataColumn_0 (non hard), vol=$0
 db $0D ; $0034: dataColumn_0 (hard)
 dw instrument0loopBerzerkMusicId ; $0035: [$0030] loop
instrument1BerzerkMusicId:
 db $03 ; $0037: speed
 db $00 ; $0038: retrig
 db $34 ; $0039: dataColumn_0 (non hard), vol=$D
 db $24 ; $003A: dataColumn_0 (non hard), vol=$9
 db $A0 ; $003B: dataColumn_0 (non hard), vol=$8
 dw $FFFE ; $003C: pitch
 db $24 ; $003E: dataColumn_0 (non hard), vol=$9
 db $9C ; $003F: dataColumn_0 (non hard), vol=$7
 dw $0001 ; $0040: pitch
 db $A0 ; $0042: dataColumn_0 (non hard), vol=$8
 dw $FFFE ; $0043: pitch
 db $9C ; $0045: dataColumn_0 (non hard), vol=$7
 dw $FFFF ; $0046: pitch
 db $18 ; $0048: dataColumn_0 (non hard), vol=$6
 db $94 ; $0049: dataColumn_0 (non hard), vol=$5
 dw $FFFE ; $004A: pitch
 db $10 ; $004C: dataColumn_0 (non hard), vol=$4
 db $0D ; $004D: dataColumn_0 (hard)
 dw instrument0loopBerzerkMusicId ; $004E: [$0030] loop
instrument2BerzerkMusicId:
 db $01 ; $0050: speed
 db $00 ; $0051: retrig
 db $36 ; $0052: dataColumn_0 (non hard), vol=$D
 db $16 ; $0053: dataColumn_1, noise=$16
 db $34 ; $0054: dataColumn_0 (non hard), vol=$D
 db $0D ; $0055: dataColumn_0 (hard)
 dw instrument0loopBerzerkMusicId ; $0056: [$0030] loop
instrument3BerzerkMusicId:
 db $02 ; $0058: speed
 db $00 ; $0059: retrig
 db $2E ; $005A: dataColumn_0 (non hard), vol=$B
 db $01 ; $005B: dataColumn_1, noise=$01
 db $1E ; $005C: dataColumn_0 (non hard), vol=$7
 db $02 ; $005D: dataColumn_1, noise=$02
 db $02 ; $005E: dataColumn_0 (non hard), vol=$0
 db $20 ; $005F: dataColumn_1
 db $02 ; $0060: dataColumn_0 (non hard), vol=$0
 db $20 ; $0061: dataColumn_1
 db $02 ; $0062: dataColumn_0 (non hard), vol=$0
 db $20 ; $0063: dataColumn_1
 db $02 ; $0064: dataColumn_0 (non hard), vol=$0
 db $20 ; $0065: dataColumn_1
 db $0D ; $0066: dataColumn_0 (hard)
 dw instrument0loopBerzerkMusicId ; $0067: [$0030] loop
instrument4BerzerkMusicId:
 db $02 ; $0069: speed
 db $00 ; $006A: retrig
 db $3C ; $006B: dataColumn_0 (non hard), vol=$F
 db $38 ; $006C: dataColumn_0 (non hard), vol=$E
 db $34 ; $006D: dataColumn_0 (non hard), vol=$D
 db $2C ; $006E: dataColumn_0 (non hard), vol=$B
 db $20 ; $006F: dataColumn_0 (non hard), vol=$8
 db $18 ; $0070: dataColumn_0 (non hard), vol=$6
 db $0D ; $0071: dataColumn_0 (hard)
 dw instrument0loopBerzerkMusicId ; $0072: [$0030] loop
instrument5BerzerkMusicId:
 db $01 ; $0074: speed
 db $00 ; $0075: retrig
 db $22 ; $0076: dataColumn_0 (non hard), vol=$8
 db $01 ; $0077: dataColumn_1, noise=$01
 db $2A ; $0078: dataColumn_0 (non hard), vol=$A
 db $01 ; $0079: dataColumn_1, noise=$01
 db $0D ; $007A: dataColumn_0 (hard)
 dw instrument0loopBerzerkMusicId ; $007B: [$0030] loop
instrument6BerzerkMusicId:
 db $01 ; $007D: speed
 db $00 ; $007E: retrig
 db $3E ; $007F: dataColumn_0 (non hard), vol=$F
 db $3F ; $0080: dataColumn_1, noise=$1F
 db $3E ; $0081: dataColumn_0 (non hard), vol=$F
 db $02 ; $0082: dataColumn_1, noise=$02
 db $00 ; $0083: dataColumn_0 (non hard), vol=$0
 db $32 ; $0084: dataColumn_0 (non hard), vol=$C
 db $0A ; $0085: dataColumn_1, noise=$0A
 db $2A ; $0086: dataColumn_0 (non hard), vol=$A
 db $39 ; $0087: dataColumn_1, noise=$19
 db $32 ; $0088: dataColumn_0 (non hard), vol=$C
 db $0D ; $0089: dataColumn_1, noise=$0D
 db $2E ; $008A: dataColumn_0 (non hard), vol=$B
 db $2B ; $008B: dataColumn_1, noise=$0B
 db $1E ; $008C: dataColumn_0 (non hard), vol=$7
 db $0B ; $008D: dataColumn_1, noise=$0B
 db $12 ; $008E: dataColumn_0 (non hard), vol=$4
 db $27 ; $008F: dataColumn_1, noise=$07
 db $52 ; $0090: dataColumn_0 (non hard), vol=$4
 db $24 ; $0091: dataColumn_1, noise=$04
 db $0C ; $0092: arpegio
 db $12 ; $0093: dataColumn_0 (non hard), vol=$4
 db $01 ; $0094: dataColumn_1, noise=$01
 db $4C ; $0095: dataColumn_0 (non hard), vol=$3
 db $0C ; $0096: arpegio
 db $0A ; $0097: dataColumn_0 (non hard), vol=$2
 db $21 ; $0098: dataColumn_1, noise=$01
 db $48 ; $0099: dataColumn_0 (non hard), vol=$2
 db $0C ; $009A: arpegio
 db $0D ; $009B: dataColumn_0 (hard)
 dw instrument0loopBerzerkMusicId ; $009C: [$0030] loop
instrument7BerzerkMusicId:
 db $09 ; $009E: speed
 db $00 ; $009F: retrig
instrument7loopBerzerkMusicId:
 db $B4 ; $00A0: dataColumn_0 (non hard), vol=$D
 dw $FFFC ; $00A1: pitch
 db $B4 ; $00A3: dataColumn_0 (non hard), vol=$D
 dw $FFFE ; $00A4: pitch
 db $B4 ; $00A6: dataColumn_0 (non hard), vol=$D
 dw $FFFF ; $00A7: pitch
 db $B4 ; $00A9: dataColumn_0 (non hard), vol=$D
 dw $FFFB ; $00AA: pitch
 db $B4 ; $00AC: dataColumn_0 (non hard), vol=$D
 dw $FFFE ; $00AD: pitch
 db $B4 ; $00AF: dataColumn_0 (non hard), vol=$D
 dw $FFFF ; $00B0: pitch
 db $0D ; $00B2: dataColumn_0 (hard)
 dw instrument7loopBerzerkMusicId ; $00B3: [$00A0] loop
instrument8BerzerkMusicId:
 db $01 ; $00B5: speed
 db $00 ; $00B6: retrig
 db $78 ; $00B7: dataColumn_0 (non hard), vol=$E
 db $0C ; $00B8: arpegio
 db $70 ; $00B9: dataColumn_0 (non hard), vol=$C
 db $18 ; $00BA: arpegio
 db $20 ; $00BB: dataColumn_0 (non hard), vol=$8
 db $F0 ; $00BC: dataColumn_0 (non hard), vol=$C
 dw $FFFF ; $00BD: pitch
 db $0C ; $00BF: arpegio
 db $60 ; $00C0: dataColumn_0 (non hard), vol=$8
 db $18 ; $00C1: arpegio
 db $58 ; $00C2: dataColumn_0 (non hard), vol=$6
 db $18 ; $00C3: arpegio
 db $6C ; $00C4: dataColumn_0 (non hard), vol=$B
 db $0C ; $00C5: arpegio
 db $54 ; $00C6: dataColumn_0 (non hard), vol=$5
 db $0C ; $00C7: arpegio
 db $4C ; $00C8: dataColumn_0 (non hard), vol=$3
 db $0C ; $00C9: arpegio
 db $0D ; $00CA: dataColumn_0 (hard)
 dw instrument0loopBerzerkMusicId ; $00CB: [$0030] loop
instrument9BerzerkMusicId:
 db $01 ; $00CD: speed
 db $00 ; $00CE: retrig
 db $74 ; $00CF: dataColumn_0 (non hard), vol=$D
 db $0C ; $00D0: arpegio
 db $60 ; $00D1: dataColumn_0 (non hard), vol=$8
 db $18 ; $00D2: arpegio
 db $68 ; $00D3: dataColumn_0 (non hard), vol=$A
 db $0C ; $00D4: arpegio
 db $28 ; $00D5: dataColumn_0 (non hard), vol=$A
 db $4C ; $00D6: dataColumn_0 (non hard), vol=$3
 db $0C ; $00D7: arpegio
 db $14 ; $00D8: dataColumn_0 (non hard), vol=$5
 db $70 ; $00D9: dataColumn_0 (non hard), vol=$C
 db $0C ; $00DA: arpegio
 db $0D ; $00DB: dataColumn_0 (hard)
 dw instrument0loopBerzerkMusicId ; $00DC: [$0030] loop
instrument10BerzerkMusicId:
 db $02 ; $00DE: speed
 db $00 ; $00DF: retrig
 db $34 ; $00E0: dataColumn_0 (non hard), vol=$D
 db $70 ; $00E1: dataColumn_0 (non hard), vol=$C
 db $03 ; $00E2: arpegio
 db $6C ; $00E3: dataColumn_0 (non hard), vol=$B
 db $07 ; $00E4: arpegio
instrument10loopBerzerkMusicId:
 db $2C ; $00E5: dataColumn_0 (non hard), vol=$B
 db $6C ; $00E6: dataColumn_0 (non hard), vol=$B
 db $03 ; $00E7: arpegio
 db $6C ; $00E8: dataColumn_0 (non hard), vol=$B
 db $07 ; $00E9: arpegio
 db $0D ; $00EA: dataColumn_0 (hard)
 dw instrument10loopBerzerkMusicId ; $00EB: [$00E5] loop
instrument11BerzerkMusicId:
 db $02 ; $00ED: speed
 db $00 ; $00EE: retrig
 db $34 ; $00EF: dataColumn_0 (non hard), vol=$D
 db $70 ; $00F0: dataColumn_0 (non hard), vol=$C
 db $05 ; $00F1: arpegio
 db $6C ; $00F2: dataColumn_0 (non hard), vol=$B
 db $09 ; $00F3: arpegio
instrument11loopBerzerkMusicId:
 db $2C ; $00F4: dataColumn_0 (non hard), vol=$B
 db $6C ; $00F5: dataColumn_0 (non hard), vol=$B
 db $05 ; $00F6: arpegio
 db $6C ; $00F7: dataColumn_0 (non hard), vol=$B
 db $09 ; $00F8: arpegio
 db $0D ; $00F9: dataColumn_0 (hard)
 dw instrument11loopBerzerkMusicId ; $00FA: [$00F4] loop
instrument12BerzerkMusicId:
 db $01 ; $00FC: speed
 db $00 ; $00FD: retrig
instrument12loopBerzerkMusicId:
 db $F0 ; $00FE: dataColumn_0 (non hard), vol=$C
 dw $FFFE ; $00FF: pitch
 db $F3 ; $0101: arpegio
 db $EC ; $0102: dataColumn_0 (non hard), vol=$B
 dw $FFFF ; $0103: pitch
 db $F7 ; $0105: arpegio
 db $F0 ; $0106: dataColumn_0 (non hard), vol=$C
 dw $FFFE ; $0107: pitch
 db $01 ; $0109: arpegio
 db $F4 ; $010A: dataColumn_0 (non hard), vol=$D
 dw $FFFD ; $010B: pitch
 db $F4 ; $010D: arpegio
 db $EC ; $010E: dataColumn_0 (non hard), vol=$B
 dw $FFFE ; $010F: pitch
 db $02 ; $0111: arpegio
 db $F0 ; $0112: dataColumn_0 (non hard), vol=$C
 dw $FFFE ; $0113: pitch
 db $F2 ; $0115: arpegio
 db $B4 ; $0116: dataColumn_0 (non hard), vol=$D
 dw $FFFF ; $0117: pitch
 db $F0 ; $0119: dataColumn_0 (non hard), vol=$C
 dw $FFFD ; $011A: pitch
 db $FA ; $011C: arpegio
 db $0D ; $011D: dataColumn_0 (hard)
 dw instrument12loopBerzerkMusicId ; $011E: [$00FE] loop
instrument13BerzerkMusicId:
 db $02 ; $0120: speed
 db $00 ; $0121: retrig
 db $34 ; $0122: dataColumn_0 (non hard), vol=$D
 db $70 ; $0123: dataColumn_0 (non hard), vol=$C
 db $06 ; $0124: arpegio
 db $6C ; $0125: dataColumn_0 (non hard), vol=$B
 db $0A ; $0126: arpegio
instrument13loopBerzerkMusicId:
 db $2C ; $0127: dataColumn_0 (non hard), vol=$B
 db $6C ; $0128: dataColumn_0 (non hard), vol=$B
 db $06 ; $0129: arpegio
 db $6C ; $012A: dataColumn_0 (non hard), vol=$B
 db $0A ; $012B: arpegio
 db $0D ; $012C: dataColumn_0 (hard)
 dw instrument13loopBerzerkMusicId ; $012D: [$0127] loop
instrument14BerzerkMusicId:
 db $02 ; $012F: speed
 db $00 ; $0130: retrig
 db $34 ; $0131: dataColumn_0 (non hard), vol=$D
 db $70 ; $0132: dataColumn_0 (non hard), vol=$C
 db $03 ; $0133: arpegio
 db $70 ; $0134: dataColumn_0 (non hard), vol=$C
 db $0A ; $0135: arpegio
instrument14loopBerzerkMusicId:
 db $2C ; $0136: dataColumn_0 (non hard), vol=$B
 db $6C ; $0137: dataColumn_0 (non hard), vol=$B
 db $03 ; $0138: arpegio
 db $70 ; $0139: dataColumn_0 (non hard), vol=$C
 db $0A ; $013A: arpegio
 db $0D ; $013B: dataColumn_0 (hard)
 dw instrument14loopBerzerkMusicId ; $013C: [$0136] loop
instrument15BerzerkMusicId:
 db $02 ; $013E: speed
 db $00 ; $013F: retrig
 db $74 ; $0140: dataColumn_0 (non hard), vol=$D
 db $02 ; $0141: arpegio
 db $70 ; $0142: dataColumn_0 (non hard), vol=$C
 db $07 ; $0143: arpegio
 db $2C ; $0144: dataColumn_0 (non hard), vol=$B
instrument15loopBerzerkMusicId:
 db $6C ; $0145: dataColumn_0 (non hard), vol=$B
 db $02 ; $0146: arpegio
 db $6C ; $0147: dataColumn_0 (non hard), vol=$B
 db $07 ; $0148: arpegio
 db $2C ; $0149: dataColumn_0 (non hard), vol=$B
 db $0D ; $014A: dataColumn_0 (hard)
 dw instrument15loopBerzerkMusicId ; $014B: [$0145] loop
instrument16BerzerkMusicId:
 db $02 ; $014D: speed
 db $00 ; $014E: retrig
 db $34 ; $014F: dataColumn_0 (non hard), vol=$D
 db $70 ; $0150: dataColumn_0 (non hard), vol=$C
 db $03 ; $0151: arpegio
 db $6C ; $0152: dataColumn_0 (non hard), vol=$B
 db $08 ; $0153: arpegio
instrument16loopBerzerkMusicId:
 db $2C ; $0154: dataColumn_0 (non hard), vol=$B
 db $6C ; $0155: dataColumn_0 (non hard), vol=$B
 db $03 ; $0156: arpegio
 db $6C ; $0157: dataColumn_0 (non hard), vol=$B
 db $08 ; $0158: arpegio
 db $0D ; $0159: dataColumn_0 (hard)
 dw instrument16loopBerzerkMusicId ; $015A: [$0154] loop
; start of linker definition
linkerBerzerkMusicId:
 db $08 ; $015C: first height
 db $00 ; $015D: transposition1
 db $00 ; $015E: transposition2
 db $00 ; $015F: transposition3
 dw specialtrackDef0BerzerkMusicId ; $0160: [$0405] specialTrack
pattern0DefinitionBerzerkMusicId:
 db $00 ; $0162: pattern 0 state
 dw trackDef0BerzerkMusicId ; $0163: [$04D4] pattern 0, track 1
 dw trackDef1BerzerkMusicId ; $0165: [$04F5] pattern 0, track 2
 dw trackDef2BerzerkMusicId ; $0167: [$0513] pattern 0, track 3
pattern1DefinitionBerzerkMusicId:
 db $00 ; $0169: pattern 1 state
 dw trackDef3BerzerkMusicId ; $016A: [$0525] pattern 1, track 1
 dw trackDef3BerzerkMusicId ; $016C: [$0525] pattern 1, track 2
 dw trackDef2BerzerkMusicId ; $016E: [$0513] pattern 1, track 3
pattern2DefinitionBerzerkMusicId:
 db $00 ; $0170: pattern 2 state
 dw trackDef4BerzerkMusicId ; $0171: [$0545] pattern 2, track 1
 dw trackDef4BerzerkMusicId ; $0173: [$0545] pattern 2, track 2
 dw trackDef2BerzerkMusicId ; $0175: [$0513] pattern 2, track 3
pattern3DefinitionBerzerkMusicId:
 db $00 ; $0177: pattern 3 state
 dw trackDef5BerzerkMusicId ; $0178: [$0728] pattern 3, track 1
 dw trackDef5BerzerkMusicId ; $017A: [$0728] pattern 3, track 2
 dw trackDef2BerzerkMusicId ; $017C: [$0513] pattern 3, track 3
pattern4DefinitionBerzerkMusicId:
 db $00 ; $017E: pattern 4 state
 dw trackDef5BerzerkMusicId ; $017F: [$0728] pattern 4, track 1
 dw trackDef5BerzerkMusicId ; $0181: [$0728] pattern 4, track 2
 dw trackDef2BerzerkMusicId ; $0183: [$0513] pattern 4, track 3
pattern5DefinitionBerzerkMusicId:
 db $00 ; $0185: pattern 5 state
 dw trackDef5BerzerkMusicId ; $0186: [$0728] pattern 5, track 1
 dw trackDef5BerzerkMusicId ; $0188: [$0728] pattern 5, track 2
 dw trackDef2BerzerkMusicId ; $018A: [$0513] pattern 5, track 3
pattern6DefinitionBerzerkMusicId:
 db $00 ; $018C: pattern 6 state
 dw trackDef6BerzerkMusicId ; $018D: [$057F] pattern 6, track 1
 dw trackDef6BerzerkMusicId ; $018F: [$057F] pattern 6, track 2
 dw trackDef2BerzerkMusicId ; $0191: [$0513] pattern 6, track 3
pattern7DefinitionBerzerkMusicId:
 db $00 ; $0193: pattern 7 state
 dw trackDef7BerzerkMusicId ; $0194: [$059F] pattern 7, track 1
 dw trackDef7BerzerkMusicId ; $0196: [$059F] pattern 7, track 2
 dw trackDef2BerzerkMusicId ; $0198: [$0513] pattern 7, track 3
pattern8DefinitionBerzerkMusicId:
 db $00 ; $019A: pattern 8 state
 dw trackDef8BerzerkMusicId ; $019B: [$040C] pattern 8, track 1
 dw trackDef9BerzerkMusicId ; $019D: [$043C] pattern 8, track 2
 dw trackDef10BerzerkMusicId ; $019F: [$0452] pattern 8, track 3
pattern9DefinitionBerzerkMusicId:
 db $00 ; $01A1: pattern 9 state
 dw trackDef8BerzerkMusicId ; $01A2: [$040C] pattern 9, track 1
 dw trackDef9BerzerkMusicId ; $01A4: [$043C] pattern 9, track 2
 dw trackDef10BerzerkMusicId ; $01A6: [$0452] pattern 9, track 3
pattern10DefinitionBerzerkMusicId:
 db $00 ; $01A8: pattern 10 state
 dw trackDef8BerzerkMusicId ; $01A9: [$040C] pattern 10, track 1
 dw trackDef9BerzerkMusicId ; $01AB: [$043C] pattern 10, track 2
 dw trackDef10BerzerkMusicId ; $01AD: [$0452] pattern 10, track 3
pattern11DefinitionBerzerkMusicId:
 db $00 ; $01AF: pattern 11 state
 dw trackDef8BerzerkMusicId ; $01B0: [$040C] pattern 11, track 1
 dw trackDef9BerzerkMusicId ; $01B2: [$043C] pattern 11, track 2
 dw trackDef10BerzerkMusicId ; $01B4: [$0452] pattern 11, track 3
pattern12DefinitionBerzerkMusicId:
 db $00 ; $01B6: pattern 12 state
 dw trackDef14BerzerkMusicId ; $01B7: [$0414] pattern 12, track 1
 dw trackDef9BerzerkMusicId ; $01B9: [$043C] pattern 12, track 2
 dw trackDef16BerzerkMusicId ; $01BB: [$046C] pattern 12, track 3
pattern13DefinitionBerzerkMusicId:
 db $00 ; $01BD: pattern 13 state
 dw trackDef14BerzerkMusicId ; $01BE: [$0414] pattern 13, track 1
 dw trackDef9BerzerkMusicId ; $01C0: [$043C] pattern 13, track 2
 dw trackDef16BerzerkMusicId ; $01C2: [$046C] pattern 13, track 3
pattern14DefinitionBerzerkMusicId:
 db $00 ; $01C4: pattern 14 state
 dw trackDef14BerzerkMusicId ; $01C5: [$0414] pattern 14, track 1
 dw trackDef9BerzerkMusicId ; $01C7: [$043C] pattern 14, track 2
 dw trackDef16BerzerkMusicId ; $01C9: [$046C] pattern 14, track 3
pattern15DefinitionBerzerkMusicId:
 db $00 ; $01CB: pattern 15 state
 dw trackDef14BerzerkMusicId ; $01CC: [$0414] pattern 15, track 1
 dw trackDef9BerzerkMusicId ; $01CE: [$043C] pattern 15, track 2
 dw trackDef16BerzerkMusicId ; $01D0: [$046C] pattern 15, track 3
pattern16DefinitionBerzerkMusicId:
 db $00 ; $01D2: pattern 16 state
 dw trackDef20BerzerkMusicId ; $01D3: [$041C] pattern 16, track 1
 dw trackDef9BerzerkMusicId ; $01D5: [$043C] pattern 16, track 2
 dw trackDef22BerzerkMusicId ; $01D7: [$0486] pattern 16, track 3
pattern17DefinitionBerzerkMusicId:
 db $00 ; $01D9: pattern 17 state
 dw trackDef20BerzerkMusicId ; $01DA: [$041C] pattern 17, track 1
 dw trackDef9BerzerkMusicId ; $01DC: [$043C] pattern 17, track 2
 dw trackDef22BerzerkMusicId ; $01DE: [$0486] pattern 17, track 3
pattern18DefinitionBerzerkMusicId:
 db $00 ; $01E0: pattern 18 state
 dw trackDef24BerzerkMusicId ; $01E1: [$0424] pattern 18, track 1
 dw trackDef9BerzerkMusicId ; $01E3: [$043C] pattern 18, track 2
 dw trackDef26BerzerkMusicId ; $01E5: [$04A0] pattern 18, track 3
pattern19DefinitionBerzerkMusicId:
 db $00 ; $01E7: pattern 19 state
 dw trackDef24BerzerkMusicId ; $01E8: [$0424] pattern 19, track 1
 dw trackDef9BerzerkMusicId ; $01EA: [$043C] pattern 19, track 2
 dw trackDef26BerzerkMusicId ; $01EC: [$04A0] pattern 19, track 3
pattern20DefinitionBerzerkMusicId:
 db $00 ; $01EE: pattern 20 state
 dw trackDef28BerzerkMusicId ; $01EF: [$042C] pattern 20, track 1
 dw trackDef9BerzerkMusicId ; $01F1: [$043C] pattern 20, track 2
 dw trackDef30BerzerkMusicId ; $01F3: [$04BA] pattern 20, track 3
pattern21DefinitionBerzerkMusicId:
 db $00 ; $01F5: pattern 21 state
 dw trackDef28BerzerkMusicId ; $01F6: [$042C] pattern 21, track 1
 dw trackDef9BerzerkMusicId ; $01F8: [$043C] pattern 21, track 2
 dw trackDef30BerzerkMusicId ; $01FA: [$04BA] pattern 21, track 3
pattern22DefinitionBerzerkMusicId:
 db $00 ; $01FC: pattern 22 state
 dw trackDef32BerzerkMusicId ; $01FD: [$0434] pattern 22, track 1
 dw trackDef33BerzerkMusicId ; $01FF: [$0447] pattern 22, track 2
 dw trackDef30BerzerkMusicId ; $0201: [$04BA] pattern 22, track 3
pattern23DefinitionBerzerkMusicId:
 db $00 ; $0203: pattern 23 state
 dw trackDef32BerzerkMusicId ; $0204: [$0434] pattern 23, track 1
 dw trackDef33BerzerkMusicId ; $0206: [$0447] pattern 23, track 2
 dw trackDef30BerzerkMusicId ; $0208: [$04BA] pattern 23, track 3
pattern24DefinitionBerzerkMusicId:
 db $00 ; $020A: pattern 24 state
 dw trackDef8BerzerkMusicId ; $020B: [$040C] pattern 24, track 1
 dw trackDef9BerzerkMusicId ; $020D: [$043C] pattern 24, track 2
 dw trackDef10BerzerkMusicId ; $020F: [$0452] pattern 24, track 3
pattern25DefinitionBerzerkMusicId:
 db $00 ; $0211: pattern 25 state
 dw trackDef8BerzerkMusicId ; $0212: [$040C] pattern 25, track 1
 dw trackDef9BerzerkMusicId ; $0214: [$043C] pattern 25, track 2
 dw trackDef10BerzerkMusicId ; $0216: [$0452] pattern 25, track 3
pattern26DefinitionBerzerkMusicId:
 db $00 ; $0218: pattern 26 state
 dw trackDef8BerzerkMusicId ; $0219: [$040C] pattern 26, track 1
 dw trackDef9BerzerkMusicId ; $021B: [$043C] pattern 26, track 2
 dw trackDef10BerzerkMusicId ; $021D: [$0452] pattern 26, track 3
pattern27DefinitionBerzerkMusicId:
 db $00 ; $021F: pattern 27 state
 dw trackDef8BerzerkMusicId ; $0220: [$040C] pattern 27, track 1
 dw trackDef9BerzerkMusicId ; $0222: [$043C] pattern 27, track 2
 dw trackDef10BerzerkMusicId ; $0224: [$0452] pattern 27, track 3
pattern28DefinitionBerzerkMusicId:
 db $00 ; $0226: pattern 28 state
 dw trackDef14BerzerkMusicId ; $0227: [$0414] pattern 28, track 1
 dw trackDef9BerzerkMusicId ; $0229: [$043C] pattern 28, track 2
 dw trackDef16BerzerkMusicId ; $022B: [$046C] pattern 28, track 3
pattern29DefinitionBerzerkMusicId:
 db $00 ; $022D: pattern 29 state
 dw trackDef14BerzerkMusicId ; $022E: [$0414] pattern 29, track 1
 dw trackDef9BerzerkMusicId ; $0230: [$043C] pattern 29, track 2
 dw trackDef16BerzerkMusicId ; $0232: [$046C] pattern 29, track 3
pattern30DefinitionBerzerkMusicId:
 db $00 ; $0234: pattern 30 state
 dw trackDef14BerzerkMusicId ; $0235: [$0414] pattern 30, track 1
 dw trackDef9BerzerkMusicId ; $0237: [$043C] pattern 30, track 2
 dw trackDef16BerzerkMusicId ; $0239: [$046C] pattern 30, track 3
pattern31DefinitionBerzerkMusicId:
 db $00 ; $023B: pattern 31 state
 dw trackDef14BerzerkMusicId ; $023C: [$0414] pattern 31, track 1
 dw trackDef9BerzerkMusicId ; $023E: [$043C] pattern 31, track 2
 dw trackDef16BerzerkMusicId ; $0240: [$046C] pattern 31, track 3
pattern32DefinitionBerzerkMusicId:
 db $00 ; $0242: pattern 32 state
 dw trackDef20BerzerkMusicId ; $0243: [$041C] pattern 32, track 1
 dw trackDef9BerzerkMusicId ; $0245: [$043C] pattern 32, track 2
 dw trackDef22BerzerkMusicId ; $0247: [$0486] pattern 32, track 3
pattern33DefinitionBerzerkMusicId:
 db $00 ; $0249: pattern 33 state
 dw trackDef20BerzerkMusicId ; $024A: [$041C] pattern 33, track 1
 dw trackDef9BerzerkMusicId ; $024C: [$043C] pattern 33, track 2
 dw trackDef22BerzerkMusicId ; $024E: [$0486] pattern 33, track 3
pattern34DefinitionBerzerkMusicId:
 db $00 ; $0250: pattern 34 state
 dw trackDef24BerzerkMusicId ; $0251: [$0424] pattern 34, track 1
 dw trackDef9BerzerkMusicId ; $0253: [$043C] pattern 34, track 2
 dw trackDef26BerzerkMusicId ; $0255: [$04A0] pattern 34, track 3
pattern35DefinitionBerzerkMusicId:
 db $00 ; $0257: pattern 35 state
 dw trackDef24BerzerkMusicId ; $0258: [$0424] pattern 35, track 1
 dw trackDef9BerzerkMusicId ; $025A: [$043C] pattern 35, track 2
 dw trackDef26BerzerkMusicId ; $025C: [$04A0] pattern 35, track 3
pattern36DefinitionBerzerkMusicId:
 db $00 ; $025E: pattern 36 state
 dw trackDef28BerzerkMusicId ; $025F: [$042C] pattern 36, track 1
 dw trackDef9BerzerkMusicId ; $0261: [$043C] pattern 36, track 2
 dw trackDef30BerzerkMusicId ; $0263: [$04BA] pattern 36, track 3
pattern37DefinitionBerzerkMusicId:
 db $00 ; $0265: pattern 37 state
 dw trackDef28BerzerkMusicId ; $0266: [$042C] pattern 37, track 1
 dw trackDef9BerzerkMusicId ; $0268: [$043C] pattern 37, track 2
 dw trackDef30BerzerkMusicId ; $026A: [$04BA] pattern 37, track 3
pattern38DefinitionBerzerkMusicId:
 db $00 ; $026C: pattern 38 state
 dw trackDef32BerzerkMusicId ; $026D: [$0434] pattern 38, track 1
 dw trackDef33BerzerkMusicId ; $026F: [$0447] pattern 38, track 2
 dw trackDef30BerzerkMusicId ; $0271: [$04BA] pattern 38, track 3
pattern39DefinitionBerzerkMusicId:
 db $00 ; $0273: pattern 39 state
 dw trackDef32BerzerkMusicId ; $0274: [$0434] pattern 39, track 1
 dw trackDef33BerzerkMusicId ; $0276: [$0447] pattern 39, track 2
 dw trackDef30BerzerkMusicId ; $0278: [$04BA] pattern 39, track 3
pattern40DefinitionBerzerkMusicId:
 db $00 ; $027A: pattern 40 state
 dw trackDef51BerzerkMusicId ; $027B: [$0622] pattern 40, track 1
 dw trackDef52BerzerkMusicId ; $027D: [$05BF] pattern 40, track 2
 dw trackDef10BerzerkMusicId ; $027F: [$0452] pattern 40, track 3
pattern41DefinitionBerzerkMusicId:
 db $00 ; $0281: pattern 41 state
 dw trackDef53BerzerkMusicId ; $0282: [$063C] pattern 41, track 1
 dw trackDef52BerzerkMusicId ; $0284: [$05BF] pattern 41, track 2
 dw trackDef10BerzerkMusicId ; $0286: [$0452] pattern 41, track 3
pattern42DefinitionBerzerkMusicId:
 db $00 ; $0288: pattern 42 state
 dw trackDef55BerzerkMusicId ; $0289: [$0674] pattern 42, track 1
 dw trackDef52BerzerkMusicId ; $028B: [$05BF] pattern 42, track 2
 dw trackDef10BerzerkMusicId ; $028D: [$0452] pattern 42, track 3
pattern43DefinitionBerzerkMusicId:
 db $00 ; $028F: pattern 43 state
 dw trackDef55BerzerkMusicId ; $0290: [$0674] pattern 43, track 1
 dw trackDef52BerzerkMusicId ; $0292: [$05BF] pattern 43, track 2
 dw trackDef10BerzerkMusicId ; $0294: [$0452] pattern 43, track 3
pattern44DefinitionBerzerkMusicId:
 db $00 ; $0296: pattern 44 state
 dw trackDef55BerzerkMusicId ; $0297: [$0674] pattern 44, track 1
 dw trackDef52BerzerkMusicId ; $0299: [$05BF] pattern 44, track 2
 dw trackDef16BerzerkMusicId ; $029B: [$046C] pattern 44, track 3
pattern45DefinitionBerzerkMusicId:
 db $00 ; $029D: pattern 45 state
 dw trackDef55BerzerkMusicId ; $029E: [$0674] pattern 45, track 1
 dw trackDef52BerzerkMusicId ; $02A0: [$05BF] pattern 45, track 2
 dw trackDef16BerzerkMusicId ; $02A2: [$046C] pattern 45, track 3
pattern46DefinitionBerzerkMusicId:
 db $00 ; $02A4: pattern 46 state
 dw trackDef55BerzerkMusicId ; $02A5: [$0674] pattern 46, track 1
 dw trackDef52BerzerkMusicId ; $02A7: [$05BF] pattern 46, track 2
 dw trackDef16BerzerkMusicId ; $02A9: [$046C] pattern 46, track 3
pattern47DefinitionBerzerkMusicId:
 db $00 ; $02AB: pattern 47 state
 dw trackDef55BerzerkMusicId ; $02AC: [$0674] pattern 47, track 1
 dw trackDef52BerzerkMusicId ; $02AE: [$05BF] pattern 47, track 2
 dw trackDef16BerzerkMusicId ; $02B0: [$046C] pattern 47, track 3
pattern48DefinitionBerzerkMusicId:
 db $00 ; $02B2: pattern 48 state
 dw trackDef55BerzerkMusicId ; $02B3: [$0674] pattern 48, track 1
 dw trackDef52BerzerkMusicId ; $02B5: [$05BF] pattern 48, track 2
 dw trackDef22BerzerkMusicId ; $02B7: [$0486] pattern 48, track 3
pattern49DefinitionBerzerkMusicId:
 db $00 ; $02B9: pattern 49 state
 dw trackDef55BerzerkMusicId ; $02BA: [$0674] pattern 49, track 1
 dw trackDef52BerzerkMusicId ; $02BC: [$05BF] pattern 49, track 2
 dw trackDef22BerzerkMusicId ; $02BE: [$0486] pattern 49, track 3
pattern50DefinitionBerzerkMusicId:
 db $00 ; $02C0: pattern 50 state
 dw trackDef55BerzerkMusicId ; $02C1: [$0674] pattern 50, track 1
 dw trackDef52BerzerkMusicId ; $02C3: [$05BF] pattern 50, track 2
 dw trackDef26BerzerkMusicId ; $02C5: [$04A0] pattern 50, track 3
pattern51DefinitionBerzerkMusicId:
 db $00 ; $02C7: pattern 51 state
 dw trackDef55BerzerkMusicId ; $02C8: [$0674] pattern 51, track 1
 dw trackDef52BerzerkMusicId ; $02CA: [$05BF] pattern 51, track 2
 dw trackDef26BerzerkMusicId ; $02CC: [$04A0] pattern 51, track 3
pattern52DefinitionBerzerkMusicId:
 db $00 ; $02CE: pattern 52 state
 dw trackDef66BerzerkMusicId ; $02CF: [$0654] pattern 52, track 1
 dw trackDef52BerzerkMusicId ; $02D1: [$05BF] pattern 52, track 2
 dw trackDef30BerzerkMusicId ; $02D3: [$04BA] pattern 52, track 3
pattern53DefinitionBerzerkMusicId:
 db $00 ; $02D5: pattern 53 state
 dw trackDef68BerzerkMusicId ; $02D6: [$06CA] pattern 53, track 1
 dw trackDef52BerzerkMusicId ; $02D8: [$05BF] pattern 53, track 2
 dw trackDef30BerzerkMusicId ; $02DA: [$04BA] pattern 53, track 3
pattern54DefinitionBerzerkMusicId:
 db $00 ; $02DC: pattern 54 state
 dw trackDef70BerzerkMusicId ; $02DD: [$068A] pattern 54, track 1
 dw trackDef52BerzerkMusicId ; $02DF: [$05BF] pattern 54, track 2
 dw trackDef30BerzerkMusicId ; $02E1: [$04BA] pattern 54, track 3
pattern55DefinitionBerzerkMusicId:
 db $00 ; $02E3: pattern 55 state
 dw trackDef72BerzerkMusicId ; $02E4: [$06AA] pattern 55, track 1
 dw trackDef52BerzerkMusicId ; $02E6: [$05BF] pattern 55, track 2
 dw trackDef30BerzerkMusicId ; $02E8: [$04BA] pattern 55, track 3
pattern56DefinitionBerzerkMusicId:
 db $00 ; $02EA: pattern 56 state
 dw trackDef74BerzerkMusicId ; $02EB: [$05D1] pattern 56, track 1
 dw trackDef52BerzerkMusicId ; $02ED: [$05BF] pattern 56, track 2
 dw trackDef10BerzerkMusicId ; $02EF: [$0452] pattern 56, track 3
pattern57DefinitionBerzerkMusicId:
 db $00 ; $02F1: pattern 57 state
 dw trackDef76BerzerkMusicId ; $02F2: [$05E4] pattern 57, track 1
 dw trackDef52BerzerkMusicId ; $02F4: [$05BF] pattern 57, track 2
 dw trackDef10BerzerkMusicId ; $02F6: [$0452] pattern 57, track 3
pattern58DefinitionBerzerkMusicId:
 db $00 ; $02F8: pattern 58 state
 dw trackDef78BerzerkMusicId ; $02F9: [$077B] pattern 58, track 1
 dw trackDef52BerzerkMusicId ; $02FB: [$05BF] pattern 58, track 2
 dw trackDef10BerzerkMusicId ; $02FD: [$0452] pattern 58, track 3
pattern59DefinitionBerzerkMusicId:
 db $00 ; $02FF: pattern 59 state
 dw trackDef80BerzerkMusicId ; $0300: [$0407] pattern 59, track 1
 dw trackDef52BerzerkMusicId ; $0302: [$05BF] pattern 59, track 2
 dw trackDef10BerzerkMusicId ; $0304: [$0452] pattern 59, track 3
pattern60DefinitionBerzerkMusicId:
 db $00 ; $0306: pattern 60 state
 dw trackDef82BerzerkMusicId ; $0307: [$061A] pattern 60, track 1
 dw trackDef52BerzerkMusicId ; $0309: [$05BF] pattern 60, track 2
 dw trackDef16BerzerkMusicId ; $030B: [$046C] pattern 60, track 3
pattern61DefinitionBerzerkMusicId:
 db $00 ; $030D: pattern 61 state
 dw trackDef76BerzerkMusicId ; $030E: [$05E4] pattern 61, track 1
 dw trackDef52BerzerkMusicId ; $0310: [$05BF] pattern 61, track 2
 dw trackDef16BerzerkMusicId ; $0312: [$046C] pattern 61, track 3
pattern62DefinitionBerzerkMusicId:
 db $00 ; $0314: pattern 62 state
 dw trackDef78BerzerkMusicId ; $0315: [$077B] pattern 62, track 1
 dw trackDef52BerzerkMusicId ; $0317: [$05BF] pattern 62, track 2
 dw trackDef16BerzerkMusicId ; $0319: [$046C] pattern 62, track 3
pattern63DefinitionBerzerkMusicId:
 db $00 ; $031B: pattern 63 state
 dw trackDef80BerzerkMusicId ; $031C: [$0407] pattern 63, track 1
 dw trackDef52BerzerkMusicId ; $031E: [$05BF] pattern 63, track 2
 dw trackDef16BerzerkMusicId ; $0320: [$046C] pattern 63, track 3
pattern64DefinitionBerzerkMusicId:
 db $00 ; $0322: pattern 64 state
 dw trackDef87BerzerkMusicId ; $0323: [$06EA] pattern 64, track 1
 dw trackDef52BerzerkMusicId ; $0325: [$05BF] pattern 64, track 2
 dw trackDef22BerzerkMusicId ; $0327: [$0486] pattern 64, track 3
pattern65DefinitionBerzerkMusicId:
 db $00 ; $0329: pattern 65 state
 dw trackDef76BerzerkMusicId ; $032A: [$05E4] pattern 65, track 1
 dw trackDef52BerzerkMusicId ; $032C: [$05BF] pattern 65, track 2
 dw trackDef22BerzerkMusicId ; $032E: [$0486] pattern 65, track 3
pattern66DefinitionBerzerkMusicId:
 db $00 ; $0330: pattern 66 state
 dw trackDef90BerzerkMusicId ; $0331: [$06F0] pattern 66, track 1
 dw trackDef52BerzerkMusicId ; $0333: [$05BF] pattern 66, track 2
 dw trackDef26BerzerkMusicId ; $0335: [$04A0] pattern 66, track 3
pattern67DefinitionBerzerkMusicId:
 db $00 ; $0337: pattern 67 state
 dw trackDef76BerzerkMusicId ; $0338: [$05E4] pattern 67, track 1
 dw trackDef52BerzerkMusicId ; $033A: [$05BF] pattern 67, track 2
 dw trackDef26BerzerkMusicId ; $033C: [$04A0] pattern 67, track 3
pattern68DefinitionBerzerkMusicId:
 db $00 ; $033E: pattern 68 state
 dw trackDef93BerzerkMusicId ; $033F: [$06F6] pattern 68, track 1
 dw trackDef94BerzerkMusicId ; $0341: [$0702] pattern 68, track 2
 dw trackDef30BerzerkMusicId ; $0343: [$04BA] pattern 68, track 3
pattern69DefinitionBerzerkMusicId:
 db $00 ; $0345: pattern 69 state
 dw trackDef76BerzerkMusicId ; $0346: [$05E4] pattern 69, track 1
 dw trackDef94BerzerkMusicId ; $0348: [$0702] pattern 69, track 2
 dw trackDef30BerzerkMusicId ; $034A: [$04BA] pattern 69, track 3
pattern70DefinitionBerzerkMusicId:
 db $00 ; $034C: pattern 70 state
 dw trackDef96BerzerkMusicId ; $034D: [$06FC] pattern 70, track 1
 dw trackDef94BerzerkMusicId ; $034F: [$0702] pattern 70, track 2
 dw trackDef30BerzerkMusicId ; $0351: [$04BA] pattern 70, track 3
pattern71DefinitionBerzerkMusicId:
 db $00 ; $0353: pattern 71 state
 dw trackDef76BerzerkMusicId ; $0354: [$05E4] pattern 71, track 1
 dw trackDef94BerzerkMusicId ; $0356: [$0702] pattern 71, track 2
 dw trackDef30BerzerkMusicId ; $0358: [$04BA] pattern 71, track 3
pattern72DefinitionBerzerkMusicId:
 db $00 ; $035A: pattern 72 state
 dw trackDef99BerzerkMusicId ; $035B: [$0714] pattern 72, track 1
 dw trackDef52BerzerkMusicId ; $035D: [$05BF] pattern 72, track 2
 dw trackDef10BerzerkMusicId ; $035F: [$0452] pattern 72, track 3
pattern73DefinitionBerzerkMusicId:
 db $00 ; $0361: pattern 73 state
 dw trackDef76BerzerkMusicId ; $0362: [$05E4] pattern 73, track 1
 dw trackDef52BerzerkMusicId ; $0364: [$05BF] pattern 73, track 2
 dw trackDef10BerzerkMusicId ; $0366: [$0452] pattern 73, track 3
pattern74DefinitionBerzerkMusicId:
 db $00 ; $0368: pattern 74 state
 dw trackDef78BerzerkMusicId ; $0369: [$077B] pattern 74, track 1
 dw trackDef52BerzerkMusicId ; $036B: [$05BF] pattern 74, track 2
 dw trackDef10BerzerkMusicId ; $036D: [$0452] pattern 74, track 3
pattern75DefinitionBerzerkMusicId:
 db $00 ; $036F: pattern 75 state
 dw trackDef80BerzerkMusicId ; $0370: [$0407] pattern 75, track 1
 dw trackDef52BerzerkMusicId ; $0372: [$05BF] pattern 75, track 2
 dw trackDef10BerzerkMusicId ; $0374: [$0452] pattern 75, track 3
pattern76DefinitionBerzerkMusicId:
 db $00 ; $0376: pattern 76 state
 dw trackDef82BerzerkMusicId ; $0377: [$061A] pattern 76, track 1
 dw trackDef52BerzerkMusicId ; $0379: [$05BF] pattern 76, track 2
 dw trackDef16BerzerkMusicId ; $037B: [$046C] pattern 76, track 3
pattern77DefinitionBerzerkMusicId:
 db $00 ; $037D: pattern 77 state
 dw trackDef76BerzerkMusicId ; $037E: [$05E4] pattern 77, track 1
 dw trackDef52BerzerkMusicId ; $0380: [$05BF] pattern 77, track 2
 dw trackDef16BerzerkMusicId ; $0382: [$046C] pattern 77, track 3
pattern78DefinitionBerzerkMusicId:
 db $00 ; $0384: pattern 78 state
 dw trackDef78BerzerkMusicId ; $0385: [$077B] pattern 78, track 1
 dw trackDef52BerzerkMusicId ; $0387: [$05BF] pattern 78, track 2
 dw trackDef16BerzerkMusicId ; $0389: [$046C] pattern 78, track 3
pattern79DefinitionBerzerkMusicId:
 db $00 ; $038B: pattern 79 state
 dw trackDef80BerzerkMusicId ; $038C: [$0407] pattern 79, track 1
 dw trackDef52BerzerkMusicId ; $038E: [$05BF] pattern 79, track 2
 dw trackDef16BerzerkMusicId ; $0390: [$046C] pattern 79, track 3
pattern80DefinitionBerzerkMusicId:
 db $00 ; $0392: pattern 80 state
 dw trackDef87BerzerkMusicId ; $0393: [$06EA] pattern 80, track 1
 dw trackDef52BerzerkMusicId ; $0395: [$05BF] pattern 80, track 2
 dw trackDef22BerzerkMusicId ; $0397: [$0486] pattern 80, track 3
pattern81DefinitionBerzerkMusicId:
 db $00 ; $0399: pattern 81 state
 dw trackDef76BerzerkMusicId ; $039A: [$05E4] pattern 81, track 1
 dw trackDef52BerzerkMusicId ; $039C: [$05BF] pattern 81, track 2
 dw trackDef22BerzerkMusicId ; $039E: [$0486] pattern 81, track 3
pattern82DefinitionBerzerkMusicId:
 db $00 ; $03A0: pattern 82 state
 dw trackDef90BerzerkMusicId ; $03A1: [$06F0] pattern 82, track 1
 dw trackDef52BerzerkMusicId ; $03A3: [$05BF] pattern 82, track 2
 dw trackDef26BerzerkMusicId ; $03A5: [$04A0] pattern 82, track 3
pattern83DefinitionBerzerkMusicId:
 db $00 ; $03A7: pattern 83 state
 dw trackDef76BerzerkMusicId ; $03A8: [$05E4] pattern 83, track 1
 dw trackDef52BerzerkMusicId ; $03AA: [$05BF] pattern 83, track 2
 dw trackDef26BerzerkMusicId ; $03AC: [$04A0] pattern 83, track 3
pattern84DefinitionBerzerkMusicId:
 db $00 ; $03AE: pattern 84 state
 dw trackDef93BerzerkMusicId ; $03AF: [$06F6] pattern 84, track 1
 dw trackDef94BerzerkMusicId ; $03B1: [$0702] pattern 84, track 2
 dw trackDef30BerzerkMusicId ; $03B3: [$04BA] pattern 84, track 3
pattern85DefinitionBerzerkMusicId:
 db $00 ; $03B5: pattern 85 state
 dw trackDef76BerzerkMusicId ; $03B6: [$05E4] pattern 85, track 1
 dw trackDef94BerzerkMusicId ; $03B8: [$0702] pattern 85, track 2
 dw trackDef30BerzerkMusicId ; $03BA: [$04BA] pattern 85, track 3
pattern86DefinitionBerzerkMusicId:
 db $00 ; $03BC: pattern 86 state
 dw trackDef96BerzerkMusicId ; $03BD: [$06FC] pattern 86, track 1
 dw trackDef94BerzerkMusicId ; $03BF: [$0702] pattern 86, track 2
 dw trackDef30BerzerkMusicId ; $03C1: [$04BA] pattern 86, track 3
pattern87DefinitionBerzerkMusicId:
 db $00 ; $03C3: pattern 87 state
 dw trackDef76BerzerkMusicId ; $03C4: [$05E4] pattern 87, track 1
 dw trackDef94BerzerkMusicId ; $03C6: [$0702] pattern 87, track 2
 dw trackDef30BerzerkMusicId ; $03C8: [$04BA] pattern 87, track 3
pattern88DefinitionBerzerkMusicId:
 db $00 ; $03CA: pattern 88 state
 dw trackDef116BerzerkMusicId ; $03CB: [$071A] pattern 88, track 1
 dw trackDef80BerzerkMusicId ; $03CD: [$0407] pattern 88, track 2
 dw trackDef117BerzerkMusicId ; $03CF: [$05EE] pattern 88, track 3
pattern89DefinitionBerzerkMusicId:
 db $00 ; $03D1: pattern 89 state
 dw trackDef118BerzerkMusicId ; $03D2: [$0748] pattern 89, track 1
 dw trackDef80BerzerkMusicId ; $03D4: [$0407] pattern 89, track 2
 dw trackDef119BerzerkMusicId ; $03D6: [$0565] pattern 89, track 3
pattern90DefinitionBerzerkMusicId:
 db $00 ; $03D8: pattern 90 state
 dw trackDef80BerzerkMusicId ; $03D9: [$0407] pattern 90, track 1
 dw trackDef80BerzerkMusicId ; $03DB: [$0407] pattern 90, track 2
 dw trackDef120BerzerkMusicId ; $03DD: [$0602] pattern 90, track 3
pattern91DefinitionBerzerkMusicId:
 db $00 ; $03DF: pattern 91 state
 dw trackDef80BerzerkMusicId ; $03E0: [$0407] pattern 91, track 1
 dw trackDef80BerzerkMusicId ; $03E2: [$0407] pattern 91, track 2
 dw trackDef121BerzerkMusicId ; $03E4: [$0757] pattern 91, track 3
pattern92DefinitionBerzerkMusicId:
 db $00 ; $03E6: pattern 92 state
 dw trackDef80BerzerkMusicId ; $03E7: [$0407] pattern 92, track 1
 dw trackDef80BerzerkMusicId ; $03E9: [$0407] pattern 92, track 2
 dw trackDef117BerzerkMusicId ; $03EB: [$05EE] pattern 92, track 3
pattern93DefinitionBerzerkMusicId:
 db $00 ; $03ED: pattern 93 state
 dw trackDef80BerzerkMusicId ; $03EE: [$0407] pattern 93, track 1
 dw trackDef80BerzerkMusicId ; $03F0: [$0407] pattern 93, track 2
 dw trackDef119BerzerkMusicId ; $03F2: [$0565] pattern 93, track 3
pattern94DefinitionBerzerkMusicId:
 db $00 ; $03F4: pattern 94 state
 dw trackDef80BerzerkMusicId ; $03F5: [$0407] pattern 94, track 1
 dw trackDef80BerzerkMusicId ; $03F7: [$0407] pattern 94, track 2
 dw trackDef120BerzerkMusicId ; $03F9: [$0602] pattern 94, track 3
pattern95DefinitionBerzerkMusicId:
 db $00 ; $03FB: pattern 95 state
 dw trackDef80BerzerkMusicId ; $03FC: [$0407] pattern 95, track 1
 dw trackDef80BerzerkMusicId ; $03FE: [$0407] pattern 95, track 2
 dw trackDef122BerzerkMusicId ; $0400: [$0767] pattern 95, track 3
pattern96DefinitionBerzerkMusicId:
 db $01 ; $0402: pattern 96 state
 dw pattern0DefinitionBerzerkMusicId ; $0403: [$0162] song restart address
specialtrackDef0BerzerkMusicId:
 db $1D ; $0405: data, speed 7
 db $00 ; $0406: wait 128
trackDef80BerzerkMusicId:
 db $42 ; $0407: normal track data
 db $80 ; $0408: vol off, pitch, no note, no instrument
 dw $0000 ; $0409: pitch
 db $00 ; $040B: track end signature found
trackDef8BerzerkMusicId:
 db $92 ; $040C: normal track data
 db $E1 ; $040D: vol = $F (inverted), no pitch, no note, no instrument
 dw $0000 ; $040E: pitch
 db $01 ; $0410: instrument
 db $06 ; $0411: normal track data,  wait 2
 db $6F ; $0412: full optimization, no escape: F#4
 db $00 ; $0413: track end signature found
trackDef14BerzerkMusicId:
 db $8E ; $0414: normal track data
 db $E0 ; $0415: vol off, pitch, note, instrument
 dw $0000 ; $0416: pitch
 db $01 ; $0418: instrument
 db $06 ; $0419: normal track data,  wait 2
 db $6F ; $041A: full optimization, no escape: F#4
 db $00 ; $041B: track end signature found
trackDef20BerzerkMusicId:
 db $8C ; $041C: normal track data
 db $E0 ; $041D: vol off, pitch, note, instrument
 dw $0000 ; $041E: pitch
 db $01 ; $0420: instrument
 db $06 ; $0421: normal track data,  wait 2
 db $6F ; $0422: full optimization, no escape: F#4
 db $00 ; $0423: track end signature found
trackDef24BerzerkMusicId:
 db $84 ; $0424: normal track data
 db $E0 ; $0425: vol off, pitch, note, instrument
 dw $0000 ; $0426: pitch
 db $01 ; $0428: instrument
 db $06 ; $0429: normal track data,  wait 2
 db $6F ; $042A: full optimization, no escape: F#4
 db $00 ; $042B: track end signature found
trackDef28BerzerkMusicId:
 db $88 ; $042C: normal track data
 db $E0 ; $042D: vol off, pitch, note, instrument
 dw $0000 ; $042E: pitch
 db $01 ; $0430: instrument
 db $06 ; $0431: normal track data,  wait 2
 db $6F ; $0432: full optimization, no escape: F#4
 db $00 ; $0433: track end signature found
trackDef32BerzerkMusicId:
 db $88 ; $0434: normal track data
 db $E0 ; $0435: vol off, pitch, note, instrument
 dw $0000 ; $0436: pitch
 db $01 ; $0438: instrument
 db $06 ; $0439: normal track data,  wait 2
 db $6F ; $043A: full optimization, no escape: F#4
 db $00 ; $043B: track end signature found
trackDef9BerzerkMusicId:
 db $42 ; $043C: normal track data
 db $80 ; $043D: vol off, pitch, no note, no instrument
 dw $0000 ; $043E: pitch
 db $02 ; $0440: normal track data,  wait 0
 db $AA ; $0441: normal track data
 db $61 ; $0442: vol = $F (inverted), no pitch, no note, no instrument
 db $01 ; $0443: instrument
 db $06 ; $0444: normal track data,  wait 2
 db $79 ; $0445: full optimization, no escape: B4
 db $00 ; $0446: track end signature found
trackDef33BerzerkMusicId:
 db $42 ; $0447: normal track data
 db $80 ; $0448: vol off, pitch, no note, no instrument
 dw $0000 ; $0449: pitch
 db $02 ; $044B: normal track data,  wait 0
 db $A8 ; $044C: normal track data
 db $60 ; $044D: vol off, no pitch, note, instrument
 db $01 ; $044E: instrument
 db $06 ; $044F: normal track data,  wait 2
 db $79 ; $0450: full optimization, no escape: B4
 db $00 ; $0451: track end signature found
trackDef10BerzerkMusicId:
 db $64 ; $0452: normal track data
 db $E0 ; $0453: vol off, pitch, note, instrument
 dw $0000 ; $0454: pitch
 db $02 ; $0456: instrument
 db $72 ; $0457: normal track data
 db $60 ; $0458: vol off, no pitch, note, instrument
 db $03 ; $0459: instrument
 db $7A ; $045A: normal track data
 db $60 ; $045B: vol off, no pitch, note, instrument
 db $04 ; $045C: instrument
 db $72 ; $045D: normal track data
 db $60 ; $045E: vol off, no pitch, note, instrument
 db $05 ; $045F: instrument
 db $8E ; $0460: normal track data
 db $60 ; $0461: vol off, no pitch, note, instrument
 db $06 ; $0462: instrument
 db $72 ; $0463: normal track data
 db $60 ; $0464: vol off, no pitch, note, instrument
 db $03 ; $0465: instrument
 db $7A ; $0466: normal track data
 db $60 ; $0467: vol off, no pitch, note, instrument
 db $04 ; $0468: instrument
 db $72 ; $0469: normal track data
 db $60 ; $046A: vol off, no pitch, note, instrument
 db $05 ; $046B: instrument
trackDef16BerzerkMusicId:
 db $64 ; $046C: normal track data
 db $E0 ; $046D: vol off, pitch, note, instrument
 dw $0000 ; $046E: pitch
 db $02 ; $0470: instrument
 db $72 ; $0471: normal track data
 db $60 ; $0472: vol off, no pitch, note, instrument
 db $03 ; $0473: instrument
 db $76 ; $0474: normal track data
 db $60 ; $0475: vol off, no pitch, note, instrument
 db $04 ; $0476: instrument
 db $72 ; $0477: normal track data
 db $60 ; $0478: vol off, no pitch, note, instrument
 db $05 ; $0479: instrument
 db $8E ; $047A: normal track data
 db $60 ; $047B: vol off, no pitch, note, instrument
 db $06 ; $047C: instrument
 db $72 ; $047D: normal track data
 db $60 ; $047E: vol off, no pitch, note, instrument
 db $03 ; $047F: instrument
 db $76 ; $0480: normal track data
 db $60 ; $0481: vol off, no pitch, note, instrument
 db $04 ; $0482: instrument
 db $72 ; $0483: normal track data
 db $60 ; $0484: vol off, no pitch, note, instrument
 db $05 ; $0485: instrument
trackDef22BerzerkMusicId:
 db $64 ; $0486: normal track data
 db $E0 ; $0487: vol off, pitch, note, instrument
 dw $0000 ; $0488: pitch
 db $02 ; $048A: instrument
 db $72 ; $048B: normal track data
 db $60 ; $048C: vol off, no pitch, note, instrument
 db $03 ; $048D: instrument
 db $74 ; $048E: normal track data
 db $60 ; $048F: vol off, no pitch, note, instrument
 db $04 ; $0490: instrument
 db $72 ; $0491: normal track data
 db $60 ; $0492: vol off, no pitch, note, instrument
 db $05 ; $0493: instrument
 db $8E ; $0494: normal track data
 db $60 ; $0495: vol off, no pitch, note, instrument
 db $06 ; $0496: instrument
 db $72 ; $0497: normal track data
 db $60 ; $0498: vol off, no pitch, note, instrument
 db $03 ; $0499: instrument
 db $74 ; $049A: normal track data
 db $60 ; $049B: vol off, no pitch, note, instrument
 db $04 ; $049C: instrument
 db $72 ; $049D: normal track data
 db $60 ; $049E: vol off, no pitch, note, instrument
 db $05 ; $049F: instrument
trackDef26BerzerkMusicId:
 db $64 ; $04A0: normal track data
 db $E0 ; $04A1: vol off, pitch, note, instrument
 dw $0000 ; $04A2: pitch
 db $02 ; $04A4: instrument
 db $72 ; $04A5: normal track data
 db $60 ; $04A6: vol off, no pitch, note, instrument
 db $03 ; $04A7: instrument
 db $6C ; $04A8: normal track data
 db $60 ; $04A9: vol off, no pitch, note, instrument
 db $04 ; $04AA: instrument
 db $72 ; $04AB: normal track data
 db $60 ; $04AC: vol off, no pitch, note, instrument
 db $05 ; $04AD: instrument
 db $8E ; $04AE: normal track data
 db $60 ; $04AF: vol off, no pitch, note, instrument
 db $06 ; $04B0: instrument
 db $72 ; $04B1: normal track data
 db $60 ; $04B2: vol off, no pitch, note, instrument
 db $03 ; $04B3: instrument
 db $6C ; $04B4: normal track data
 db $60 ; $04B5: vol off, no pitch, note, instrument
 db $04 ; $04B6: instrument
 db $72 ; $04B7: normal track data
 db $60 ; $04B8: vol off, no pitch, note, instrument
 db $05 ; $04B9: instrument
trackDef30BerzerkMusicId:
 db $64 ; $04BA: normal track data
 db $E0 ; $04BB: vol off, pitch, note, instrument
 dw $0000 ; $04BC: pitch
 db $02 ; $04BE: instrument
 db $72 ; $04BF: normal track data
 db $60 ; $04C0: vol off, no pitch, note, instrument
 db $03 ; $04C1: instrument
 db $70 ; $04C2: normal track data
 db $60 ; $04C3: vol off, no pitch, note, instrument
 db $04 ; $04C4: instrument
 db $72 ; $04C5: normal track data
 db $60 ; $04C6: vol off, no pitch, note, instrument
 db $05 ; $04C7: instrument
 db $8E ; $04C8: normal track data
 db $60 ; $04C9: vol off, no pitch, note, instrument
 db $06 ; $04CA: instrument
 db $72 ; $04CB: normal track data
 db $60 ; $04CC: vol off, no pitch, note, instrument
 db $03 ; $04CD: instrument
 db $70 ; $04CE: normal track data
 db $60 ; $04CF: vol off, no pitch, note, instrument
 db $04 ; $04D0: instrument
 db $72 ; $04D1: normal track data
 db $60 ; $04D2: vol off, no pitch, note, instrument
 db $05 ; $04D3: instrument
trackDef0BerzerkMusicId:
 db $78 ; $04D4: normal track data,  note: D#2
 db $EF ; $04D5: vol = $8 (inverted), no pitch, no note, no instrument
 dw $FFFD ; $04D6: pitch
 db $07 ; $04D8: instrument
 db $42 ; $04D9: normal track data
 db $80 ; $04DA: vol off, pitch, no note, no instrument
 dw $0000 ; $04DB: pitch
 db $42 ; $04DD: normal track data
 db $80 ; $04DE: vol off, pitch, no note, no instrument
 dw $FFFD ; $04DF: pitch
 db $42 ; $04E1: normal track data,  note: C0
 db $8D ; $04E2: vol = $9 (inverted), no pitch, no note, no instrument
 dw $0000 ; $04E3: pitch
 db $42 ; $04E5: normal track data
 db $80 ; $04E6: vol off, pitch, no note, no instrument
 dw $FFFC ; $04E7: pitch
 db $42 ; $04E9: normal track data
 db $80 ; $04EA: vol off, pitch, no note, no instrument
 dw $0000 ; $04EB: pitch
 db $42 ; $04ED: normal track data
 db $8B ; $04EE: vol = $A (inverted), no pitch, no note, no instrument
 dw $FFFD ; $04EF: pitch
 db $42 ; $04F1: normal track data
 db $80 ; $04F2: vol off, pitch, no note, no instrument
 dw $0000 ; $04F3: pitch
trackDef1BerzerkMusicId:
 db $78 ; $04F5: normal track data,  note: D#2
 db $EF ; $04F6: vol = $8 (inverted), no pitch, no note, no instrument
 dw $0000 ; $04F7: pitch
 db $07 ; $04F9: instrument
 db $02 ; $04FA: normal track data,  wait 0
 db $42 ; $04FB: normal track data
 db $80 ; $04FC: vol off, pitch, no note, no instrument
 dw $FFFD ; $04FD: pitch
 db $42 ; $04FF: normal track data,  note: C0
 db $8D ; $0500: vol = $9 (inverted), no pitch, no note, no instrument
 dw $0000 ; $0501: pitch
 db $42 ; $0503: normal track data
 db $80 ; $0504: vol off, pitch, no note, no instrument
 dw $FFFC ; $0505: pitch
 db $42 ; $0507: normal track data
 db $80 ; $0508: vol off, pitch, no note, no instrument
 dw $0000 ; $0509: pitch
 db $42 ; $050B: normal track data
 db $8B ; $050C: vol = $A (inverted), no pitch, no note, no instrument
 dw $FFFD ; $050D: pitch
 db $42 ; $050F: normal track data
 db $80 ; $0510: vol off, pitch, no note, no instrument
 dw $0000 ; $0511: pitch
trackDef2BerzerkMusicId:
 db $72 ; $0513: normal track data
 db $E0 ; $0514: vol off, pitch, note, instrument
 dw $0000 ; $0515: pitch
 db $03 ; $0517: instrument
 db $33 ; $0518: full optimization, no escape: C2
 db $72 ; $0519: normal track data
 db $60 ; $051A: vol off, no pitch, note, instrument
 db $05 ; $051B: instrument
 db $33 ; $051C: full optimization, no escape: C2
 db $72 ; $051D: normal track data
 db $60 ; $051E: vol off, no pitch, note, instrument
 db $03 ; $051F: instrument
 db $72 ; $0520: normal track data
 db $60 ; $0521: vol off, no pitch, note, instrument
 db $05 ; $0522: instrument
 db $33 ; $0523: full optimization, no escape: C2
 db $33 ; $0524: full optimization, no escape: C2
trackDef3BerzerkMusicId:
 db $42 ; $0525: normal track data
 db $89 ; $0526: vol = $B (inverted), no pitch, no note, no instrument
 dw $FFFC ; $0527: pitch
 db $42 ; $0529: normal track data
 db $80 ; $052A: vol off, pitch, no note, no instrument
 dw $0000 ; $052B: pitch
 db $42 ; $052D: normal track data
 db $80 ; $052E: vol off, pitch, no note, no instrument
 dw $FFFD ; $052F: pitch
 db $42 ; $0531: normal track data
 db $80 ; $0532: vol off, pitch, no note, no instrument
 dw $0000 ; $0533: pitch
 db $42 ; $0535: normal track data,  note: C0
 db $87 ; $0536: vol = $C (inverted), no pitch, no note, no instrument
 dw $FFFC ; $0537: pitch
 db $42 ; $0539: normal track data
 db $80 ; $053A: vol off, pitch, no note, no instrument
 dw $0000 ; $053B: pitch
 db $42 ; $053D: normal track data
 db $80 ; $053E: vol off, pitch, no note, no instrument
 dw $FFFD ; $053F: pitch
 db $42 ; $0541: normal track data,  note: C0
 db $85 ; $0542: vol = $D (inverted), no pitch, no note, no instrument
 dw $0000 ; $0543: pitch
trackDef4BerzerkMusicId:
 db $42 ; $0545: normal track data
 db $80 ; $0546: vol off, pitch, no note, no instrument
 dw $FFFC ; $0547: pitch
 db $42 ; $0549: normal track data
 db $83 ; $054A: vol = $E (inverted), no pitch, no note, no instrument
 dw $0000 ; $054B: pitch
 db $42 ; $054D: normal track data
 db $80 ; $054E: vol off, pitch, no note, no instrument
 dw $FFFD ; $054F: pitch
 db $42 ; $0551: normal track data
 db $80 ; $0552: vol off, pitch, no note, no instrument
 dw $0000 ; $0553: pitch
 db $42 ; $0555: normal track data
 db $80 ; $0556: vol off, pitch, no note, no instrument
 dw $FFFC ; $0557: pitch
 db $42 ; $0559: normal track data
 db $80 ; $055A: vol off, pitch, no note, no instrument
 dw $0000 ; $055B: pitch
 db $42 ; $055D: normal track data
 db $80 ; $055E: vol off, pitch, no note, no instrument
 dw $FFFD ; $055F: pitch
 db $42 ; $0561: normal track data
 db $80 ; $0562: vol off, pitch, no note, no instrument
 dw $0000 ; $0563: pitch
trackDef119BerzerkMusicId:
 db $64 ; $0565: normal track data
 db $E0 ; $0566: vol off, pitch, note, instrument
 dw $0000 ; $0567: pitch
 db $02 ; $0569: instrument
 db $72 ; $056A: normal track data
 db $60 ; $056B: vol off, no pitch, note, instrument
 db $03 ; $056C: instrument
 db $72 ; $056D: normal track data
 db $60 ; $056E: vol off, no pitch, note, instrument
 db $05 ; $056F: instrument
 db $64 ; $0570: normal track data
 db $60 ; $0571: vol off, no pitch, note, instrument
 db $02 ; $0572: instrument
 db $8E ; $0573: normal track data
 db $60 ; $0574: vol off, no pitch, note, instrument
 db $06 ; $0575: instrument
 db $72 ; $0576: normal track data
 db $60 ; $0577: vol off, no pitch, note, instrument
 db $03 ; $0578: instrument
 db $8E ; $0579: normal track data
 db $60 ; $057A: vol off, no pitch, note, instrument
 db $06 ; $057B: instrument
 db $72 ; $057C: normal track data
 db $60 ; $057D: vol off, no pitch, note, instrument
 db $05 ; $057E: instrument
trackDef6BerzerkMusicId:
 db $42 ; $057F: normal track data
 db $80 ; $0580: vol off, pitch, no note, no instrument
 dw $FFFB ; $0581: pitch
 db $42 ; $0583: normal track data
 db $80 ; $0584: vol off, pitch, no note, no instrument
 dw $0000 ; $0585: pitch
 db $42 ; $0587: normal track data,  note: C0
 db $85 ; $0588: vol = $D (inverted), no pitch, no note, no instrument
 dw $FFFC ; $0589: pitch
 db $42 ; $058B: normal track data
 db $80 ; $058C: vol off, pitch, no note, no instrument
 dw $0000 ; $058D: pitch
 db $42 ; $058F: normal track data
 db $80 ; $0590: vol off, pitch, no note, no instrument
 dw $FFFB ; $0591: pitch
 db $42 ; $0593: normal track data,  note: C0
 db $87 ; $0594: vol = $C (inverted), no pitch, no note, no instrument
 dw $0000 ; $0595: pitch
 db $42 ; $0597: normal track data
 db $80 ; $0598: vol off, pitch, no note, no instrument
 dw $FFFC ; $0599: pitch
 db $42 ; $059B: normal track data
 db $80 ; $059C: vol off, pitch, no note, no instrument
 dw $0000 ; $059D: pitch
trackDef7BerzerkMusicId:
 db $42 ; $059F: normal track data
 db $89 ; $05A0: vol = $B (inverted), no pitch, no note, no instrument
 dw $FFFB ; $05A1: pitch
 db $42 ; $05A3: normal track data
 db $80 ; $05A4: vol off, pitch, no note, no instrument
 dw $0000 ; $05A5: pitch
 db $42 ; $05A7: normal track data
 db $8B ; $05A8: vol = $A (inverted), no pitch, no note, no instrument
 dw $FFFC ; $05A9: pitch
 db $42 ; $05AB: normal track data
 db $80 ; $05AC: vol off, pitch, no note, no instrument
 dw $0000 ; $05AD: pitch
 db $42 ; $05AF: normal track data
 db $80 ; $05B0: vol off, pitch, no note, no instrument
 dw $FFFB ; $05B1: pitch
 db $42 ; $05B3: normal track data,  note: C0
 db $8D ; $05B4: vol = $9 (inverted), no pitch, no note, no instrument
 dw $0000 ; $05B5: pitch
 db $42 ; $05B7: normal track data
 db $80 ; $05B8: vol off, pitch, no note, no instrument
 dw $FFFC ; $05B9: pitch
 db $42 ; $05BB: normal track data
 db $80 ; $05BC: vol off, pitch, no note, no instrument
 dw $0000 ; $05BD: pitch
trackDef52BerzerkMusicId:
 db $AA ; $05BF: normal track data
 db $E0 ; $05C0: vol off, pitch, note, instrument
 dw $0000 ; $05C1: pitch
 db $08 ; $05C3: instrument
 db $42 ; $05C4: normal track data
 db $00 ; $05C5: vol off, no pitch, no note, no instrument
 db $C2 ; $05C6: normal track data
 db $60 ; $05C7: vol off, no pitch, note, instrument
 db $09 ; $05C8: instrument
 db $42 ; $05C9: normal track data
 db $00 ; $05CA: vol off, no pitch, no note, no instrument
 db $A6 ; $05CB: normal track data
 db $60 ; $05CC: vol off, no pitch, note, instrument
 db $08 ; $05CD: instrument
 db $02 ; $05CE: normal track data,  wait 0
 db $6B ; $05CF: full optimization, no escape: E4
 db $00 ; $05D0: track end signature found
trackDef74BerzerkMusicId:
 db $AA ; $05D1: normal track data
 db $EB ; $05D2: vol = $A (inverted), no pitch, no note, no instrument
 dw $0000 ; $05D3: pitch
 db $0A ; $05D5: instrument
 db $42 ; $05D6: normal track data
 db $09 ; $05D7: vol = $B (inverted), no pitch, no note, no instrument
 db $42 ; $05D8: normal track data,  note: C0
 db $07 ; $05D9: vol = $C (inverted), no pitch, no note, no instrument
 db $42 ; $05DA: normal track data,  note: C0
 db $05 ; $05DB: vol = $D (inverted), no pitch, no note, no instrument
 db $42 ; $05DC: normal track data
 db $00 ; $05DD: vol off, no pitch, no note, no instrument
 db $42 ; $05DE: normal track data
 db $03 ; $05DF: vol = $E (inverted), no pitch, no note, no instrument
 db $42 ; $05E0: normal track data
 db $00 ; $05E1: vol off, no pitch, no note, no instrument
 db $42 ; $05E2: normal track data
 db $01 ; $05E3: vol = $F (inverted), no pitch, no note, no instrument
trackDef76BerzerkMusicId:
 db $42 ; $05E4: normal track data
 db $80 ; $05E5: vol off, pitch, no note, no instrument
 dw $0000 ; $05E6: pitch
 db $02 ; $05E8: normal track data,  wait 0
 db $42 ; $05E9: normal track data
 db $03 ; $05EA: vol = $E (inverted), no pitch, no note, no instrument
 db $08 ; $05EB: normal track data,  wait 3
 db $42 ; $05EC: normal track data,  note: C0
 db $05 ; $05ED: vol = $D (inverted), no pitch, no note, no instrument
trackDef117BerzerkMusicId:
 db $64 ; $05EE: normal track data
 db $E0 ; $05EF: vol off, pitch, note, instrument
 dw $0000 ; $05F0: pitch
 db $02 ; $05F2: instrument
 db $25 ; $05F3: full optimization, no escape: F1
 db $72 ; $05F4: normal track data
 db $60 ; $05F5: vol off, no pitch, note, instrument
 db $05 ; $05F6: instrument
 db $33 ; $05F7: full optimization, no escape: C2
 db $8E ; $05F8: normal track data
 db $60 ; $05F9: vol off, no pitch, note, instrument
 db $06 ; $05FA: instrument
 db $72 ; $05FB: normal track data
 db $60 ; $05FC: vol off, no pitch, note, instrument
 db $03 ; $05FD: instrument
 db $72 ; $05FE: normal track data
 db $60 ; $05FF: vol off, no pitch, note, instrument
 db $05 ; $0600: instrument
 db $33 ; $0601: full optimization, no escape: C2
trackDef120BerzerkMusicId:
 db $64 ; $0602: normal track data
 db $E0 ; $0603: vol off, pitch, note, instrument
 dw $0000 ; $0604: pitch
 db $02 ; $0606: instrument
 db $72 ; $0607: normal track data
 db $60 ; $0608: vol off, no pitch, note, instrument
 db $03 ; $0609: instrument
 db $64 ; $060A: normal track data
 db $60 ; $060B: vol off, no pitch, note, instrument
 db $02 ; $060C: instrument
 db $72 ; $060D: normal track data
 db $60 ; $060E: vol off, no pitch, note, instrument
 db $05 ; $060F: instrument
 db $8E ; $0610: normal track data
 db $60 ; $0611: vol off, no pitch, note, instrument
 db $06 ; $0612: instrument
 db $72 ; $0613: normal track data
 db $60 ; $0614: vol off, no pitch, note, instrument
 db $03 ; $0615: instrument
 db $72 ; $0616: normal track data
 db $60 ; $0617: vol off, no pitch, note, instrument
 db $05 ; $0618: instrument
 db $33 ; $0619: full optimization, no escape: C2
trackDef82BerzerkMusicId:
 db $A6 ; $061A: normal track data
 db $E1 ; $061B: vol = $F (inverted), no pitch, no note, no instrument
 dw $0000 ; $061C: pitch
 db $0B ; $061E: instrument
 db $42 ; $061F: normal track data
 db $00 ; $0620: vol off, no pitch, no note, no instrument
 db $00 ; $0621: track end signature found
trackDef51BerzerkMusicId:
 db $F6 ; $0622: normal track data
 db $EB ; $0623: vol = $A (inverted), no pitch, no note, no instrument
 dw $0000 ; $0624: pitch
 db $0C ; $0626: instrument
 db $42 ; $0627: normal track data
 db $00 ; $0628: vol off, no pitch, no note, no instrument
 db $42 ; $0629: normal track data
 db $80 ; $062A: vol off, pitch, no note, no instrument
 dw $0001 ; $062B: pitch
 db $42 ; $062D: normal track data
 db $80 ; $062E: vol off, pitch, no note, no instrument
 dw $0000 ; $062F: pitch
 db $42 ; $0631: normal track data
 db $09 ; $0632: vol = $B (inverted), no pitch, no note, no instrument
 db $02 ; $0633: normal track data,  wait 0
 db $42 ; $0634: normal track data
 db $80 ; $0635: vol off, pitch, no note, no instrument
 dw $0001 ; $0636: pitch
 db $42 ; $0638: normal track data
 db $80 ; $0639: vol off, pitch, no note, no instrument
 dw $0000 ; $063A: pitch
trackDef53BerzerkMusicId:
 db $42 ; $063C: normal track data,  note: C0
 db $87 ; $063D: vol = $C (inverted), no pitch, no note, no instrument
 dw $0000 ; $063E: pitch
 db $02 ; $0640: normal track data,  wait 0
 db $42 ; $0641: normal track data
 db $80 ; $0642: vol off, pitch, no note, no instrument
 dw $0001 ; $0643: pitch
 db $42 ; $0645: normal track data
 db $80 ; $0646: vol off, pitch, no note, no instrument
 dw $0000 ; $0647: pitch
 db $42 ; $0649: normal track data,  note: C0
 db $05 ; $064A: vol = $D (inverted), no pitch, no note, no instrument
 db $02 ; $064B: normal track data,  wait 0
 db $42 ; $064C: normal track data
 db $80 ; $064D: vol off, pitch, no note, no instrument
 dw $0001 ; $064E: pitch
 db $42 ; $0650: normal track data
 db $80 ; $0651: vol off, pitch, no note, no instrument
 dw $0000 ; $0652: pitch
trackDef66BerzerkMusicId:
 db $42 ; $0654: normal track data
 db $80 ; $0655: vol off, pitch, no note, no instrument
 dw $FFFE ; $0656: pitch
 db $42 ; $0658: normal track data
 db $80 ; $0659: vol off, pitch, no note, no instrument
 dw $0000 ; $065A: pitch
 db $42 ; $065C: normal track data
 db $80 ; $065D: vol off, pitch, no note, no instrument
 dw $FFFE ; $065E: pitch
 db $42 ; $0660: normal track data
 db $80 ; $0661: vol off, pitch, no note, no instrument
 dw $0000 ; $0662: pitch
 db $42 ; $0664: normal track data
 db $80 ; $0665: vol off, pitch, no note, no instrument
 dw $FFFE ; $0666: pitch
 db $42 ; $0668: normal track data
 db $80 ; $0669: vol off, pitch, no note, no instrument
 dw $0000 ; $066A: pitch
 db $42 ; $066C: normal track data
 db $80 ; $066D: vol off, pitch, no note, no instrument
 dw $FFFE ; $066E: pitch
 db $42 ; $0670: normal track data
 db $80 ; $0671: vol off, pitch, no note, no instrument
 dw $0000 ; $0672: pitch
trackDef55BerzerkMusicId:
 db $42 ; $0674: normal track data
 db $80 ; $0675: vol off, pitch, no note, no instrument
 dw $0000 ; $0676: pitch
 db $02 ; $0678: normal track data,  wait 0
 db $42 ; $0679: normal track data
 db $80 ; $067A: vol off, pitch, no note, no instrument
 dw $0001 ; $067B: pitch
 db $42 ; $067D: normal track data
 db $80 ; $067E: vol off, pitch, no note, no instrument
 dw $0000 ; $067F: pitch
 db $04 ; $0681: normal track data,  wait 1
 db $42 ; $0682: normal track data
 db $80 ; $0683: vol off, pitch, no note, no instrument
 dw $0001 ; $0684: pitch
 db $42 ; $0686: normal track data
 db $80 ; $0687: vol off, pitch, no note, no instrument
 dw $0000 ; $0688: pitch
trackDef70BerzerkMusicId:
 db $42 ; $068A: normal track data
 db $89 ; $068B: vol = $B (inverted), no pitch, no note, no instrument
 dw $FFFE ; $068C: pitch
 db $42 ; $068E: normal track data
 db $80 ; $068F: vol off, pitch, no note, no instrument
 dw $0000 ; $0690: pitch
 db $42 ; $0692: normal track data
 db $80 ; $0693: vol off, pitch, no note, no instrument
 dw $FFFE ; $0694: pitch
 db $42 ; $0696: normal track data
 db $80 ; $0697: vol off, pitch, no note, no instrument
 dw $0000 ; $0698: pitch
 db $42 ; $069A: normal track data
 db $80 ; $069B: vol off, pitch, no note, no instrument
 dw $FFFE ; $069C: pitch
 db $42 ; $069E: normal track data
 db $80 ; $069F: vol off, pitch, no note, no instrument
 dw $0000 ; $06A0: pitch
 db $42 ; $06A2: normal track data
 db $80 ; $06A3: vol off, pitch, no note, no instrument
 dw $FFFE ; $06A4: pitch
 db $42 ; $06A6: normal track data
 db $80 ; $06A7: vol off, pitch, no note, no instrument
 dw $0000 ; $06A8: pitch
trackDef72BerzerkMusicId:
 db $42 ; $06AA: normal track data
 db $8B ; $06AB: vol = $A (inverted), no pitch, no note, no instrument
 dw $FFFE ; $06AC: pitch
 db $42 ; $06AE: normal track data
 db $80 ; $06AF: vol off, pitch, no note, no instrument
 dw $0000 ; $06B0: pitch
 db $42 ; $06B2: normal track data
 db $80 ; $06B3: vol off, pitch, no note, no instrument
 dw $FFFE ; $06B4: pitch
 db $42 ; $06B6: normal track data
 db $80 ; $06B7: vol off, pitch, no note, no instrument
 dw $0000 ; $06B8: pitch
 db $42 ; $06BA: normal track data
 db $80 ; $06BB: vol off, pitch, no note, no instrument
 dw $FFFE ; $06BC: pitch
 db $42 ; $06BE: normal track data
 db $80 ; $06BF: vol off, pitch, no note, no instrument
 dw $0000 ; $06C0: pitch
 db $42 ; $06C2: normal track data
 db $80 ; $06C3: vol off, pitch, no note, no instrument
 dw $FFFE ; $06C4: pitch
 db $42 ; $06C6: normal track data
 db $80 ; $06C7: vol off, pitch, no note, no instrument
 dw $0000 ; $06C8: pitch
trackDef68BerzerkMusicId:
 db $42 ; $06CA: normal track data,  note: C0
 db $87 ; $06CB: vol = $C (inverted), no pitch, no note, no instrument
 dw $FFFE ; $06CC: pitch
 db $42 ; $06CE: normal track data
 db $80 ; $06CF: vol off, pitch, no note, no instrument
 dw $0000 ; $06D0: pitch
 db $42 ; $06D2: normal track data
 db $80 ; $06D3: vol off, pitch, no note, no instrument
 dw $FFFE ; $06D4: pitch
 db $42 ; $06D6: normal track data
 db $80 ; $06D7: vol off, pitch, no note, no instrument
 dw $0000 ; $06D8: pitch
 db $42 ; $06DA: normal track data
 db $80 ; $06DB: vol off, pitch, no note, no instrument
 dw $FFFE ; $06DC: pitch
 db $42 ; $06DE: normal track data
 db $80 ; $06DF: vol off, pitch, no note, no instrument
 dw $0000 ; $06E0: pitch
 db $42 ; $06E2: normal track data
 db $80 ; $06E3: vol off, pitch, no note, no instrument
 dw $FFFE ; $06E4: pitch
 db $42 ; $06E6: normal track data
 db $80 ; $06E7: vol off, pitch, no note, no instrument
 dw $0000 ; $06E8: pitch
trackDef87BerzerkMusicId:
 db $A4 ; $06EA: normal track data
 db $E1 ; $06EB: vol = $F (inverted), no pitch, no note, no instrument
 dw $0000 ; $06EC: pitch
 db $0D ; $06EE: instrument
 db $00 ; $06EF: track end signature found
trackDef90BerzerkMusicId:
 db $A4 ; $06F0: normal track data
 db $E1 ; $06F1: vol = $F (inverted), no pitch, no note, no instrument
 dw $0000 ; $06F2: pitch
 db $0E ; $06F4: instrument
 db $00 ; $06F5: track end signature found
trackDef93BerzerkMusicId:
 db $AA ; $06F6: normal track data
 db $E1 ; $06F7: vol = $F (inverted), no pitch, no note, no instrument
 dw $0000 ; $06F8: pitch
 db $0F ; $06FA: instrument
 db $00 ; $06FB: track end signature found
trackDef96BerzerkMusicId:
 db $A8 ; $06FC: normal track data
 db $E1 ; $06FD: vol = $F (inverted), no pitch, no note, no instrument
 dw $0000 ; $06FE: pitch
 db $10 ; $0700: instrument
 db $00 ; $0701: track end signature found
trackDef94BerzerkMusicId:
 db $A0 ; $0702: normal track data
 db $E0 ; $0703: vol off, pitch, note, instrument
 dw $0000 ; $0704: pitch
 db $08 ; $0706: instrument
 db $42 ; $0707: normal track data
 db $00 ; $0708: vol off, no pitch, no note, no instrument
 db $B8 ; $0709: normal track data
 db $60 ; $070A: vol off, no pitch, note, instrument
 db $09 ; $070B: instrument
 db $42 ; $070C: normal track data
 db $00 ; $070D: vol off, no pitch, no note, no instrument
 db $9C ; $070E: normal track data
 db $60 ; $070F: vol off, no pitch, note, instrument
 db $08 ; $0710: instrument
 db $02 ; $0711: normal track data,  wait 0
 db $61 ; $0712: full optimization, no escape: B3
 db $00 ; $0713: track end signature found
trackDef99BerzerkMusicId:
 db $AA ; $0714: normal track data
 db $E1 ; $0715: vol = $F (inverted), no pitch, no note, no instrument
 dw $0000 ; $0716: pitch
 db $0A ; $0718: instrument
 db $00 ; $0719: track end signature found
trackDef116BerzerkMusicId:
 db $42 ; $071A: normal track data,  note: C0
 db $87 ; $071B: vol = $C (inverted), no pitch, no note, no instrument
 dw $0000 ; $071C: pitch
 db $02 ; $071E: normal track data,  wait 0
 db $42 ; $071F: normal track data
 db $09 ; $0720: vol = $B (inverted), no pitch, no note, no instrument
 db $02 ; $0721: normal track data,  wait 0
 db $42 ; $0722: normal track data
 db $0B ; $0723: vol = $A (inverted), no pitch, no note, no instrument
 db $02 ; $0724: normal track data,  wait 0
 db $42 ; $0725: normal track data,  note: C0
 db $0D ; $0726: vol = $9 (inverted), no pitch, no note, no instrument
 db $00 ; $0727: track end signature found
trackDef5BerzerkMusicId:
 db $42 ; $0728: normal track data
 db $80 ; $0729: vol off, pitch, no note, no instrument
 dw $FFFC ; $072A: pitch
 db $42 ; $072C: normal track data
 db $80 ; $072D: vol off, pitch, no note, no instrument
 dw $0000 ; $072E: pitch
 db $42 ; $0730: normal track data
 db $80 ; $0731: vol off, pitch, no note, no instrument
 dw $FFFD ; $0732: pitch
 db $42 ; $0734: normal track data
 db $80 ; $0735: vol off, pitch, no note, no instrument
 dw $0000 ; $0736: pitch
 db $42 ; $0738: normal track data
 db $80 ; $0739: vol off, pitch, no note, no instrument
 dw $FFFC ; $073A: pitch
 db $42 ; $073C: normal track data
 db $80 ; $073D: vol off, pitch, no note, no instrument
 dw $0000 ; $073E: pitch
 db $42 ; $0740: normal track data
 db $80 ; $0741: vol off, pitch, no note, no instrument
 dw $FFFD ; $0742: pitch
 db $42 ; $0744: normal track data
 db $80 ; $0745: vol off, pitch, no note, no instrument
 dw $0000 ; $0746: pitch
trackDef118BerzerkMusicId:
 db $42 ; $0748: normal track data,  note: C0
 db $8F ; $0749: vol = $8 (inverted), no pitch, no note, no instrument
 dw $0000 ; $074A: pitch
 db $02 ; $074C: normal track data,  wait 0
 db $42 ; $074D: normal track data
 db $11 ; $074E: vol = $7 (inverted), no pitch, no note, no instrument
 db $02 ; $074F: normal track data,  wait 0
 db $42 ; $0750: normal track data
 db $13 ; $0751: vol = $6 (inverted), no pitch, no note, no instrument
 db $02 ; $0752: normal track data,  wait 0
 db $42 ; $0753: normal track data,  note: C0
 db $15 ; $0754: vol = $5 (inverted), no pitch, no note, no instrument
 db $42 ; $0755: normal track data,  note: C0
 db $1F ; $0756: vol = $0 (inverted), no pitch, no note, no instrument
trackDef121BerzerkMusicId:
 db $64 ; $0757: normal track data
 db $E0 ; $0758: vol off, pitch, note, instrument
 dw $0000 ; $0759: pitch
 db $02 ; $075B: instrument
 db $25 ; $075C: full optimization, no escape: F1
 db $25 ; $075D: full optimization, no escape: F1
 db $25 ; $075E: full optimization, no escape: F1
 db $8E ; $075F: normal track data
 db $60 ; $0760: vol off, no pitch, note, instrument
 db $06 ; $0761: instrument
 db $4F ; $0762: full optimization, no escape: D3
 db $4F ; $0763: full optimization, no escape: D3
 db $72 ; $0764: normal track data
 db $60 ; $0765: vol off, no pitch, note, instrument
 db $05 ; $0766: instrument
trackDef122BerzerkMusicId:
 db $64 ; $0767: normal track data
 db $E0 ; $0768: vol off, pitch, note, instrument
 dw $0000 ; $0769: pitch
 db $02 ; $076B: instrument
 db $25 ; $076C: full optimization, no escape: F1
 db $25 ; $076D: full optimization, no escape: F1
 db $72 ; $076E: normal track data
 db $60 ; $076F: vol off, no pitch, note, instrument
 db $05 ; $0770: instrument
 db $8E ; $0771: normal track data
 db $60 ; $0772: vol off, no pitch, note, instrument
 db $06 ; $0773: instrument
 db $72 ; $0774: normal track data
 db $60 ; $0775: vol off, no pitch, note, instrument
 db $03 ; $0776: instrument
 db $72 ; $0777: normal track data
 db $60 ; $0778: vol off, no pitch, note, instrument
 db $05 ; $0779: instrument
 db $33 ; $077A: full optimization, no escape: C2
trackDef78BerzerkMusicId:
 db $42 ; $077B: normal track data
 db $80 ; $077C: vol off, pitch, no note, no instrument
 dw $0000 ; $077D: pitch
 db $0C ; $077F: normal track data,  wait 5
 db $42 ; $0780: normal track data,  note: C0
 db $07 ; $0781: vol = $C (inverted), no pitch, no note, no instrument


 DB " *** MUSIC DONE BY VTK - THANK YOU! *** " 