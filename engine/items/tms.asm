; tests if mon [wcf91] can learn move [wMoveNum]
CanLearnTM: ; 1373e (4:773e)
	ld a, [wcf91]
	ld [wd0b5], a
	call GetMonHeader
	ld hl, W_MONHLEARNSET
	push hl
	ld a, [wMoveNum]
	ld b, a
	ld c, $0
	ld hl, TechnicalMachines
.findTMloop
	ld a, [hli]
	cp b
	jr z, .TMfoundLoop
	inc c
	jr .findTMloop
.TMfoundLoop
	pop hl
	ld b, CHECK_FLAG
	predef_jump FlagActionPredef

; converts TM/HM number in wd11e into move number
; HMs start at 51
TMToMove: ; 13763 (4:7763)
	ld a, [wd11e]
	dec a
	ld hl, TechnicalMachines
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wd11e], a
	ret

INCLUDE "data/tms.asm"


; tests if mon [wcf91] can learn move [wMoveNum]
CanLearnTutor:
	ld a, [wcf91]
	ld [wd0b5], a
	call GetMonHeader
	ld hl, W_MONHMOVES
	push hl
	ld a, [wMoveNum]
	ld b, a
	ld c, $0
	ld hl, MoveTutorMoves
.findTutorLoop
	ld a, [hli]
	cp b
	jr z, .TutorFoundLoop
	inc c
	jr .findTutorLoop
.TutorFoundLoop
	pop hl
	ld b, CHECK_FLAG
	predef FlagActionPredef
	ld a, c
	ld [wTempMoveID], a ; bc is not preserved when called from another bank
	ret

; converts Move Tutor number in wd11e into move number
TutorToMove:
	ld a, [wd11e]
	dec a
	ld hl, MoveTutorMoves
	ld b, $0
	ld c, a
	add hl, bc
	ld a, [hl]
	ld [wd11e], a
	ret

INCLUDE "data/move_tutors.asm"
