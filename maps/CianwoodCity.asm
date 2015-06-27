CianwoodCity_MapScriptHeader:
	; trigger count
	db 2

	; triggers
	dw .Trigger1, $0000
	dw .Trigger2, $0000

	; callback count
	db 1

	; callbacks
	dbw 5, .FlyPointAndSuicune

.Trigger1
	end

.Trigger2
	end

.FlyPointAndSuicune
	setflag ENGINE_FLYPOINT_CIANWOOD
	setevent $07aa
	checkevent $0333
	iffalse UnknownScript_0x1a001d
	disappear $c
UnknownScript_0x1a001d:
	return

UnknownScript_0x1a001e:
	spriteface $0, UP
	showemote $0, $0, 15
	pause 15
	playsound SFX_WARP_FROM
	applymovement $d, MovementData_0x1a00da
	spriteface $0, DOWN
	pause 15
	playsound SFX_WARP_FROM
	applymovement $d, MovementData_0x1a00e0
	disappear $d
	pause 10
	dotrigger $0
	clearevent EVENT_SAW_SUICUNE_ON_ROUTE_42
	domaptrigger GROUP_ROUTE_42, MAP_ROUTE_42, $1
	checkevent $0333
	iftrue UnknownScript_0x1a0083
	setevent $0333
	playmusic MUSIC_MYSTICALMAN_ENCOUNTER
	appear $c
	applymovement $c, MovementData_0x1a00e7
	loadfont
	writetext UnknownText_0x1a0433
	closetext
	loadmovesprites
	winlosstext UnknownText_0x1a05a1, $0000
	setlasttalked $c
	loadtrainer MYSTICALMAN, EUSINE
	startbattle
	reloadmapmusic
	returnafterbattle
	playmusic MUSIC_MYSTICALMAN_ENCOUNTER
	loadfont
	writetext UnknownText_0x1a05c3
	closetext
	loadmovesprites
	applymovement $c, MovementData_0x1a00ec
	disappear $c
	pause 20
	special Functionc48f
	playmapmusic
	pause 10
UnknownScript_0x1a0083:
	end

PokefanFScript_0x1a0084:
	faceplayer
	loadfont
	checkevent EVENT_GOT_HM02_FLY
	iftrue UnknownScript_0x1a00ad
	writetext UnknownText_0x1a00f1
	keeptextopen
	checkevent EVENT_BEAT_CHUCK
	iftrue UnknownScript_0x1a009c
	writetext UnknownText_0x1a0163
	closetext
	loadmovesprites
	end

UnknownScript_0x1a009c:
	writetext UnknownText_0x1a01e3
	keeptextopen
	verbosegiveitem HM_02, 1
	iffalse UnknownScript_0x1a00b1
	setevent EVENT_GOT_HM02_FLY
	writetext UnknownText_0x1a021d
	keeptextopen
UnknownScript_0x1a00ad:
	writetext UnknownText_0x1a0277
	closetext
UnknownScript_0x1a00b1:
	loadmovesprites
	end

StandingYoungsterScript_0x1a00b3:
	jumptextfaceplayer UnknownText_0x1a02df

PokefanMScript_0x1a00b6:
	jumptextfaceplayer UnknownText_0x1a0319

LassScript_0x1a00b9:
	jumptextfaceplayer UnknownText_0x1a0394

UnknownScript_0x1a00bc:
	jumptextfaceplayer UnknownText_0x1a03cc

CianwoodCitySign:
	jumptext CianwoodCitySignText

CianwoodGymSign:
	jumptext CianwoodGymSignText

CianwoodPharmacySign:
	jumptext CianwoodPharmacySignText

CianwoodPhotoStudioSign:
	jumptext CianwoodPhotoStudioSignText

CianwoodPokeSeerSign:
	jumptext CianwoodPokeSeerSignText

CianwoodPokeCenterSign:
	jumpstd pokecentersign

CianwoodCityRock:
	jumpstd smashrock

MapCianwoodCitySignpostItem6:
	dw $00b2
	db REVIVE

MapCianwoodCitySignpostItem7:
	dw $00b3
	db MAX_ETHER

MovementData_0x1a00da:
	db $39 ; movement
	fast_jump_step_down
	fast_jump_step_down
	fast_jump_step_right
	db $38 ; movement
	step_end

MovementData_0x1a00e0:
	db $39 ; movement
	fast_jump_step_right
	fast_jump_step_up
	fast_jump_step_right
	fast_jump_step_right
	db $38 ; movement
	step_end

MovementData_0x1a00e7:
	step_up
	step_up
	step_up
	step_up
	step_end

MovementData_0x1a00ec:
	step_down
	step_down
	step_down
	step_down
	step_end

UnknownText_0x1a00f1:
	text "You crossed the"
	line "sea to get here?"

	para "That must have"
	line "been hard."

	para "It would be much"
	line "easier if your"

	para "#MON knew how"
	line "to FLY…"
	done

UnknownText_0x1a0163:
	text "But you can't use"
	line "FLY without this"
	cont "city's GYM BADGE."

	para "If you beat the"
	line "GYM LEADER here,"
	cont "come see me."

	para "I'll have a nice"
	line "gift for you."
	done

UnknownText_0x1a01e3:
	text "That's CIANWOOD's"
	line "GYM BADGE!"

	para "Then you should"
	line "take this HM."
	done

UnknownText_0x1a021d:
	text "Teach FLY to your"
	line "#MON."

	para "You will be able"
	line "to FLY instantly"

	para "to anywhere you "
	line "have visited."
	done

UnknownText_0x1a0277:
	text "My husband lost to"
	line "you, so he needs"
	cont "to train harder."

	para "That's good, since"
	line "he was getting a"
	cont "little chubby."
	done

UnknownText_0x1a02df:
	text "If you use FLY,"
	line "you can get back"

	para "to OLIVINE in-"
	line "stantly."
	done

UnknownText_0x1a0319:
	text "Boulders to the"
	line "north of town can"
	cont "be crushed."

	para "They may be hiding"
	line "something."

	para "Your #MON could"
	line "use ROCK SMASH to"
	cont "break them."
	done

UnknownText_0x1a0394:
	text "CHUCK, the GYM"
	line "LEADER, spars with"

	para "his fighting #-"
	line "MON."
	done

; possibly unused
UnknownText_0x1a03cc:
	text "There are several"
	line "islands between"
	cont "here and OLIVINE."

	para "A mythical sea"
	line "creature supposed-"
	cont "ly lives there."
	done

UnknownText_0x1a0433:
	text "EUSINE: Yo,"
	line $52, "."

	para "Wasn't that"
	line "SUICUNE just now?"

	para "I only caught a"
	line "quick glimpse, but"

	para "I thought I saw"
	line "SUICUNE running on"
	cont "the waves."

	para "SUICUNE is beau-"
	line "tiful and grand."

	para "And it races"
	line "through towns and"

	para "roads at simply"
	line "awesome speeds."

	para "It's wonderful…"

	para "I want to see"
	line "SUICUNE up close…"

	para "I've decided."

	para "I'll battle you as"
	line "a trainer to earn"
	cont "SUICUNE's respect!"

	para "Come on, ", $52, "."
	line "Let's battle now!"
	done

UnknownText_0x1a05a1:
	text "I hate to admit"
	line "it, but you win."
	done

UnknownText_0x1a05c3:
	text "You're amazing,"
	line $52, "!"

	para "No wonder #MON"
	line "gravitate to you."

	para "I get it now."

	para "I'm going to keep"
	line "searching for"
	cont "SUICUNE."

	para "I'm sure we'll see"
	line "each other again."

	para "See you around!"
	done

CianwoodCitySignText:
	text "CIANWOOD CITY"

	para "A Port Surrounded"
	line "by Rough Seas"
	done

CianwoodGymSignText:
	text "CIANWOOD CITY"
	line "#MON GYM"

	para "LEADER: CHUCK"

	para "His Roaring Fists"
	line "Do the Talking"
	done

CianwoodPharmacySignText:
	text "500 Years of"
	line "Tradition"

	para "CIANWOOD CITY"
	line "PHARMACY"

	para "We Await Your"
	line "Medicinal Queries"
	done

CianwoodPhotoStudioSignText:
	text "CIANWOOD CITY"
	line "PHOTO STUDIO"

	para "Take a Snapshot as"
	line "a Keepsake!"
	done

CianwoodPokeSeerSignText:
	text "THE # SEER"
	line "AHEAD"
	done

CianwoodCity_MapEventHeader:
	; filler
	db 0, 0

	; warps
	db 7
	warp_def $29, $11, 1, GROUP_MANIAS_HOUSE, MAP_MANIAS_HOUSE
	warp_def $2b, $8, 1, GROUP_CIANWOOD_GYM, MAP_CIANWOOD_GYM
	warp_def $2b, $17, 1, GROUP_CIANWOOD_POKECENTER_1F, MAP_CIANWOOD_POKECENTER_1F
	warp_def $2f, $f, 1, GROUP_CIANWOOD_PHARMACY, MAP_CIANWOOD_PHARMACY
	warp_def $1f, $9, 1, GROUP_CIANWOOD_CITY_PHOTO_STUDIO, MAP_CIANWOOD_CITY_PHOTO_STUDIO
	warp_def $25, $f, 1, GROUP_CIANWOOD_LUGIA_SPEECH_HOUSE, MAP_CIANWOOD_LUGIA_SPEECH_HOUSE
	warp_def $11, $5, 1, GROUP_POKE_SEERS_HOUSE, MAP_POKE_SEERS_HOUSE

	; xy triggers
	db 1
	xy_trigger 1, $10, $b, $0, UnknownScript_0x1a001e, $0, $0

	; signposts
	db 8
	signpost 34, 20, $0, CianwoodCitySign
	signpost 45, 7, $0, CianwoodGymSign
	signpost 43, 24, $0, CianwoodPokeCenterSign
	signpost 47, 19, $0, CianwoodPharmacySign
	signpost 32, 8, $0, CianwoodPhotoStudioSign
	signpost 24, 8, $0, CianwoodPokeSeerSign
	signpost 19, 4, $7, MapCianwoodCitySignpostItem6
	signpost 29, 5, $7, MapCianwoodCitySignpostItem7

	; people-events
	db 12
	person_event SPRITE_STANDING_YOUNGSTER, 41, 25, $3, $0, 255, 255, $a0, 0, StandingYoungsterScript_0x1a00b3, $ffff
	person_event SPRITE_POKEFAN_M, 37, 21, $5, $1, 255, 255, $0, 0, PokefanMScript_0x1a00b6, $ffff
	person_event SPRITE_LASS, 46, 18, $4, $20, 255, 255, $0, 0, LassScript_0x1a00b9, $ffff
	person_event SPRITE_ROCK, 20, 12, $18, $0, 255, 255, $0, 0, CianwoodCityRock, $ffff
	person_event SPRITE_ROCK, 21, 13, $18, $0, 255, 255, $0, 0, CianwoodCityRock, $ffff
	person_event SPRITE_ROCK, 29, 8, $18, $0, 255, 255, $0, 0, CianwoodCityRock, $ffff
	person_event SPRITE_ROCK, 33, 9, $18, $0, 255, 255, $0, 0, CianwoodCityRock, $ffff
	person_event SPRITE_ROCK, 31, 14, $18, $0, 255, 255, $0, 0, CianwoodCityRock, $ffff
	person_event SPRITE_ROCK, 23, 8, $18, $0, 255, 255, $0, 0, CianwoodCityRock, $ffff
	person_event SPRITE_POKEFAN_F, 50, 14, $5, $1, 255, 255, $0, 0, PokefanFScript_0x1a0084, $ffff
	person_event SPRITE_SUPER_NERD, 25, 15, $7, $0, 255, 255, $90, 0, ObjectEvent, $07ad
	person_event SPRITE_SUICUNE, 18, 14, $1, $0, 255, 255, $90, 0, ObjectEvent, $07ae
