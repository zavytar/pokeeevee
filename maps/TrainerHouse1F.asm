	object_const_def
	const TRAINERHOUSE1F_RECEPTIONIST
	const TRAINERHOUSE1F_COOLTRAINER_M
	const TRAINERHOUSE1F_COOLTRAINER_F
	const TRAINERHOUSE1F_YOUNGSTER
	const TRAINERHOUSE1F_GENTLEMAN

TrainerHouse1F_MapScripts:
	def_scene_scripts

	def_callbacks

TrainerHouse1FReceptionistScript:
	jumptextfaceplayer TrainerHouse1FReceptionistText

TrainerHouse1FCooltrainerMScript:
	jumptextfaceplayer TrainerHouse1FCooltrainerMText

TrainerHouse1FCooltrainerFScript:
	jumptextfaceplayer TrainerHouse1FCooltrainerFText

TrainerHouse1FYoungsterScript:
	jumptextfaceplayer TrainerHouse1FYoungsterText

TrainerHouse1FGentlemanScript:
	jumptextfaceplayer TrainerHouse1FGentlemanText

TrainerHouseBlackBoard:
	jumptext TrainerHouseBlackBoardText

TrainerHouseIllegibleBook:
	jumptext TrainerHouseIllegibleText

TrainerHouse1FReceptionistText:
	text "Welcome to the"
	line "#MON ACADEMY!"

	para "Are you a new"
	line "student?"
	done

TrainerHouse1FCooltrainerMText:
	text "Whew!"
	
	para "I'm trying to"
	line "memorize my notes."
	done

TrainerHouse1FCooltrainerFText:
	text "I would love to"
	line "see how well a"

	para "trainer from JOHTO"
	line "battles."
	done

TrainerHouse1FYoungsterText:
	text "I'm here to learn"
	line "all there is to"
	cont "#MON battles!"

	para "Then, I'll become"
	line "a #MON CHAMP!"
	done

TrainerHouse1FGentlemanText:
	text "Whew… I'm taking a"
	line "rest from #MON"
	cont "battles."
	done

TrainerHouseBlackBoardText:
	text "Status conditions"
	line "are listed in the"
	cont "board."
	done

TrainerHouseIllegibleText:
	text "…What's this?"

	para "These appear to"
	line "be notes."

	para "It's barely"
	line "legible…"
	done

TrainerHouse1F_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4,  9, VIRIDIAN_CITY, 3
	warp_event  5,  9, VIRIDIAN_CITY, 3
;	warp_event  9, -3, TRAINER_HOUSE_B1F, 1

	def_coord_events

	def_bg_events
	bg_event  3,  0, BGEVENT_READ, TrainerHouseBlackBoard
	bg_event  4,  0, BGEVENT_READ, TrainerHouseBlackBoard
	bg_event  5,  4, BGEVENT_READ, TrainerHouseIllegibleBook

	def_object_events
	object_event  3,  7, SPRITE_RECEPTIONIST, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, PAL_NPC_GREEN, OBJECTTYPE_SCRIPT, 0, TrainerHouse1FReceptionistScript, -1
	object_event  5,  5, SPRITE_COOLTRAINER_M, SPRITEMOVEDATA_STANDING_UP, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TrainerHouse1FCooltrainerMScript, -1
	object_event  8,  6, SPRITE_COOLTRAINER_F, SPRITEMOVEDATA_STANDING_DOWN, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TrainerHouse1FCooltrainerFScript, -1
	object_event  1,  5, SPRITE_YOUNGSTER, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 2, 0, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, TrainerHouse1FYoungsterScript, -1
	object_event  5,  1, SPRITE_GENTLEMAN, SPRITEMOVEDATA_STANDING_RIGHT, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, TrainerHouse1FGentlemanScript, -1
