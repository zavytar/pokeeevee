	object_const_def
	const BLUESHOUSE_DAISY

BluesHouse_MapScripts:
	def_scene_scripts
	scene_script .IntroScene
	scene_script .DummyScene0
	
	def_callbacks

.IntroScene:
	playmusic MUSIC_MOM
	turnobject PLAYER, RIGHT
	turnobject BLUESHOUSE_DAISY, LEFT
	opentext
	writetext DaisyIntroText_1
	promptbutton
	;give pokegear
	getstring STRING_BUFFER_4, BluesHouse_PokegearName
	scall BluesHouse_ReceiveItemStd
	setflag ENGINE_POKEGEAR
	setflag ENGINE_PHONE_CARD
	addcellnum PHONE_MOM
	setscene SCENE_BLUESHOUSE_SPAWN
	writetext DaisyIntroText_2
	promptbutton
	special SetDayOfWeek
.SetDayOfWeek:
	writetext BluesHouse_IsItDSTText
	yesorno
	iffalse .WrongDay
	special InitialSetDSTFlag
	yesorno
	iffalse .SetDayOfWeek
	sjump .DayOfWeekDone

.WrongDay:
	special InitialClearDSTFlag
	yesorno
	iffalse .SetDayOfWeek
.DayOfWeekDone:
	writetext BluesHouse_ComeHomeForDSTText
	waitbutton
	closetext
	special RestartMapMusic
	turnobject BLUESHOUSE_DAISY, RIGHT
	setevent EVENT_RED_GONE_FROM_LAB
	end
	
.DummyScene0:
	end

DaisyScript:
	faceplayer
	opentext
	readvar VAR_HOUR
	ifequal 15, .ThreePM
	writetext DaisyHelloText
	waitbutton
	closetext
	end

.ThreePM:
	checkflag ENGINE_DAISYS_GROOMING
	iftrue .AlreadyGroomedMon
	writetext DaisyOfferGroomingText
	yesorno
	iffalse .Refused
	writetext DaisyWhichMonText
	waitbutton
	special DaisysGrooming
	ifequal $0, .Refused
	ifequal $1, .CantGroomEgg
	setflag ENGINE_DAISYS_GROOMING
	writetext DaisyAlrightText
	waitbutton
	closetext
	special FadeOutPalettes
	playmusic MUSIC_HEAL
	pause 60
	special FadeInPalettes
	special RestartMapMusic
	opentext
	writetext GroomedMonLooksContentText
	special PlayCurMonCry
	promptbutton
	writetext DaisyAllDoneText
	waitbutton
	closetext
	end

.AlreadyGroomedMon:
	writetext DaisyAlreadyGroomedText
	waitbutton
	closetext
	end

.Refused:
	writetext DaisyRefusedText
	waitbutton
	closetext
	end

.CantGroomEgg:
	writetext DaisyCantGroomEggText
	waitbutton
	closetext
	end

DaisyIntroText_1:
	text "Finally, <PLAYER>!"
	
	para "Your #MON"
	line "journey is about"
	cont "to begin!"
	
	para "Now, before you"
	line "head to Grampa's"
	cont "lab, don't forget"
	cont "to take this!"
	done
	
DaisyIntroText_2:	
	text "There, your very"
	line "own #GEAR!"
	
	para "..."
	
	para "It seems the day"
	line "of the week"
	cont "isn't set yet."
	done
	
BluesHouse_IsItDSTText:
	text "Is it Daylight"
	line "Saving Time now?"
	done

BluesHouse_ComeHomeForDSTText:
	text "Come home to"
	line "adjust your clock"

	para "for Daylight"
	line "Saving Time."
	
	para "By the way, this"
	line "#GEAR also has"
	cont "a PHONE. It's so"
	cont "easy to use and"
	cont "convenient!"
	
	para "Don't forget to"
	line "call home every"
	cont "once in a while!"
	done
	
BluesHouse_PokegearName:
	db "#GEAR@"

BluesHouse_ReceiveItemStd:
	jumpstd ReceiveItemScript
	end


DaisyHelloText:
	text "DAISY: Hi! My kid"
	line "brother is the GYM"

	para "LEADER in VIRIDIAN"
	line "CITY."

	para "But he goes out"
	line "of town so often,"

	para "it causes problems"
	line "for the trainers."
	done

DaisyOfferGroomingText:
	text "DAISY: Hi! Good"
	line "timing. I'm about"
	cont "to have some tea."

	para "Would you like to"
	line "join me?"

	para "Oh, your #MON"
	line "are a bit dirty."

	para "Would you like me"
	line "to groom one?"
	done

DaisyWhichMonText:
	text "DAISY: Which one"
	line "should I groom?"
	done

DaisyAlrightText:
	text "DAISY: OK, I'll"
	line "get it looking"
	cont "nice in no time."
	done

GroomedMonLooksContentText:
	text_ram wStringBuffer3
	text " looks"
	line "content."
	done

DaisyAllDoneText:
	text "DAISY: There you"
	line "go! All done."

	para "See? Doesn't it"
	line "look nice?"

	para "It's such a cute"
	line "#MON."
	done

DaisyAlreadyGroomedText:
	text "DAISY: I always"
	line "have tea around"

	para "this time. Come"
	line "join me."
	done

DaisyRefusedText:
	text "DAISY: You don't"
	line "want to have one"

	para "groomed? OK, we'll"
	line "just have tea."
	done

DaisyCantGroomEggText:
	text "DAISY: Oh, sorry."
	line "I honestly can't"
	cont "groom an EGG."
	done

BluesHouse_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  6, 12, OAKS_LAB, 3

	def_coord_events

	def_bg_events

	def_object_events
	object_event  2,  9, SPRITE_DAISY, SPRITEMOVEDATA_SPINRANDOM_SLOW, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, DaisyScript, -1
