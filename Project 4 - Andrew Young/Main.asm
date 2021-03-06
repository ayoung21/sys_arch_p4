; 10 SYS (2304)

*=$0801

        BYTE    $0E, $08, $0A, $00, $9E, $20, $28,  $32, $33, $30, $34, $29, $00, $00, $00


*=$0900
FRONT_EYE_PIXELS=$2E80
LEFT_EYE_PIXLES=FRONT_EYE_PIXELS+64
RIGHT_EYE_PIXLES=LEFT_EYE_PIXLES+64
PROGRAM_START
        JSR SETUP_INTERRUPT
        JSR LOAD_FRONT_EYE_DATA
        JSR LOAD_LEFT_EYE_DATA
        JSR LOAD_RIGHT_EYE_DATA
        JSR SET_FRONT_EYE_POINTER

        LDA #1
        JSR SET_SPRITE_COLOR

        LDA #45
        JSR SET_X_LOCATION

        LDA #60
        JSR SET_Y_LOCATION

        JSR SHOW_SPRITES
PROGRAM_END
        rts

COUNTER BYTE 00       
; SUB-ROUTINES

; Sets up interrupt
SETUP_INTERRUPT
        SEI 
        LDA #<ANIMATION_ROUTINE
        STA $0314
        LDA #>ANIMATION_ROUTINE
        STA $0315
        CLI
        RTS

; sets front eye pointer
SET_FRONT_EYE_POINTER
        LDA #FRONT_EYE_PIXELS/64
        STA $07F8
        RTS

; show sprites
SHOW_SPRITES
        LDA #$0001
        STA $D015
        RTS

; animation routine
ANIMATION_ROUTINE
        LDA COUNTER
        ADC #1
        STA COUNTER
        CMP #0
        BEQ LOOK_LEFT
        CMP #64
        BEQ LOOK_STRAIGHT
        CMP #128
        BEQ LOOK_RIGHT
        CMP #192
        BEQ LOOK_STRAIGHT
        JMP JUMP_TO_HANDLER

; jumps to handler
JUMP_TO_HANDLER
        JMP $EA31

; have the eye look straight
LOOK_STRAIGHT
        LDA #FRONT_EYE_PIXELS/64
        STA $07F8
        JMP $EA31

; have the eye look right
LOOK_RIGHT
        LDA #$3A00/64
        STA $07F8
        JMP $EA31

; have the eye look left
LOOK_LEFT
        LDA #LEFT_EYE_PIXLES/64
        STA $07F8
        JMP $EA31

; loads front eye data
LOAD_FRONT_EYE_DATA
        LDX #63
sprite_loop
        LDA EYE_FRONT_DATA,X
        STA FRONT_EYE_PIXELS,X
        DEX
        BPL sprite_loop
        RTS

; loads left eye data
LOAD_LEFT_EYE_DATA
        LDX #63
sprite_loop_left
        LDA EYE_LEFT_DATA,X
        STA LEFT_EYE_PIXLES,X
        DEX
        BPL sprite_loop_left
        RTS

; loads right eye data
LOAD_RIGHT_EYE_DATA
        LDX #63
sprite_loop_right
        LDA EYE_RIGHT_DATA,X
        STA $3A00,X
        DEX
        BPL sprite_loop_right
        RTS

; sets the x location
SET_X_LOCATION
        STA $D000       ; X position sprite #0 set on 44
        LDA $D000       ; load X-MSB
        ORA #%00000001  ; set extra bit for sprite #5
        STA $D010       ; write X-MSB register
        RTS

; sets the y location
SET_Y_LOCATION
        STA $D001
        RTS

; sets the sprite color to whatever is passed in
SET_SPRITE_COLOR
        STA $D027
        RTS

; eye front data
EYE_FRONT_DATA
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

; left eye data
EYE_LEFT_DATA
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

; right eye data
EYE_RIGHT_DATA
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

