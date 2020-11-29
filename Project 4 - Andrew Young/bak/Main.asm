; 10 SYS (2304)

*=$0801

        BYTE    $0E, $08, $0A, $00, $9E, $20, $28,  $32, $33, $30, $34, $29, $00, $00, $00


*=$0900
FRONT_EYE_PIXELS=$2E80
LEFT_EYE_PIXLES=FRONT_EYE_PIXELS+64
RIGHT_EYE_PIXLES=LEFT_EYE_PIXLES+64
PROGRAM_START
        JSR LOAD_FRONT_EYE_DATA

        LDA #1
        JSR SET_SPRITE_COLOR

        LDA #44
        JSR SET_X_LOCATION

        LDA #60
        JSR SET_Y_LOCATION

        ;; DELETE
        JSR LOAD_LEFT_EYE_DATA
        LDA #LEFT_EYE_PIXLES/64
        STA $07F9

        JSR LOAD_RIGHT_EYE_DATA
        LDA #RIGHT_EYE_PIXLES/64
        STA $07FA
        ;; END OF DELETE

        ; set sprite pointers
        LDA #FRONT_EYE_PIXELS/64
        STA $07F8

        ; show sprites
        LDA #$0001
        STA $D015

; SUB-ROUTINES
LOAD_FRONT_EYE_DATA
        LDX #63
sprite_loop
        LDA EYE_FRONT_DATA,X
        STA $2E80,X
        DEX
        BNE sprite_loop
        RTS
; DELEETE
LOAD_LEFT_EYE_DATA
        LDX #63
sprite_loop_left
        LDA EYE_LEFT_DATA,X
        STA $2E80,X
        DEX
        BNE sprite_loop_left
        RTS

LOAD_RIGHT_EYE_DATA
        LDX #63
sprite_loop_right
        LDA EYE_RIGHT_DATA,X
        STA $2E80,X
        DEX
        BNE sprite_loop_right
        RTS
; end of delete

SET_X_LOCATION
        STA $D000       ; X position sprite #0 set on 44
        LDA $D010       ; load X-MSB
        ORA #%00000001  ; set extra bit for sprite #5
        STA $D010       ; write X-MSB register
        RTS
SET_Y_LOCATION
        STA $D001
        RTS
SET_SPRITE_COLOR
        STA $D027
        RTS

PROGRAM_END
        rts
        



EYE_FRONT_DATA
; eye_front
 BYTE $00,$7E,$00
 BYTE $03,$81,$C0
 BYTE $0C,$7E,$30
 BYTE $13,$FF,$C8
 BYTE $2F,$FF,$F4
 BYTE $2F,$FF,$F4
 BYTE $5F,$FF,$FA
 BYTE $5F,$C3,$FA
 BYTE $5F,$81,$FA
 BYTE $BF,$00,$FD
 BYTE $BF,$00,$FD
 BYTE $BF,$00,$FD
 BYTE $5F,$81,$FA
 BYTE $5F,$C3,$FA
 BYTE $5F,$FF,$FA
 BYTE $2F,$FF,$F4
 BYTE $2F,$FF,$F4
 BYTE $13,$FF,$C8
 BYTE $0C,$7E,$30
 BYTE $03,$81,$C0
 BYTE $00,$7E,$00
 BYTE $00

EYE_LEFT_DATA
; eye_left
 BYTE $00,$7E,$00
 BYTE $03,$81,$C0
 BYTE $0C,$7E,$30
 BYTE $13,$FF,$C8
 BYTE $2F,$FF,$F4
 BYTE $2F,$FF,$F4
 BYTE $5F,$FF,$FA
 BYTE $5C,$7F,$FA
 BYTE $58,$3F,$FA
 BYTE $B8,$3F,$FD
 BYTE $B8,$3F,$FD
 BYTE $B8,$3F,$FD
 BYTE $58,$3F,$FA
 BYTE $5C,$7F,$FA
 BYTE $5F,$FF,$FA
 BYTE $2F,$FF,$F4
 BYTE $2F,$FF,$F4
 BYTE $13,$FF,$C8
 BYTE $0C,$7E,$30
 BYTE $03,$81,$C0
 BYTE $00,$7E,$00
 BYTE $00

EYE_RIGHT_DATA
; eye right
 BYTE $00,$7E,$00
 BYTE $03,$81,$C0
 BYTE $0C,$7E,$30
 BYTE $13,$FF,$C8
 BYTE $2F,$FF,$F4
 BYTE $2F,$FF,$F4
 BYTE $5F,$FF,$FA
 BYTE $5F,$FE,$3A
 BYTE $5F,$FC,$1A
 BYTE $BF,$FC,$1D
 BYTE $BF,$FC,$1D
 BYTE $BF,$FC,$1D
 BYTE $5F,$FC,$1A
 BYTE $5F,$FE,$3A
 BYTE $5F,$FF,$FA
 BYTE $2F,$FF,$F4
 BYTE $2F,$FF,$F4
 BYTE $13,$FF,$C8
 BYTE $0C,$7E,$30
 BYTE $03,$81,$C0
 BYTE $00,$7E,$00
 BYTE $00

