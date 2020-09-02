	object_const_def
	const OAKSLAB_OAK
	const OAKSLAB_SCIENTIST1
	const OAKSLAB_SCIENTIST2
;	const OAKSLAB_SCIENTIST3
	const OAKSLAB_STARTERBALL
	const OAKSLAB_RED 

OaksLab_MapScripts:
	def_scene_scripts
	scene_script .DummyScene0 ; SCENE_OAKSLAB_NOTHING
	scene_script .DummyScene1 ; SCENE_OAKSLAB_CANT_LEAVE
	scene_script .DummyScene2 ; SCENE_OAKSLAB_RIVAL_BATTLE_1
	scene_script .DummyScene3 ; SCENE_OAKSLAB_GET_POKEDEX

	def_callbacks
	
.DummyScene0:
.DummyScene1:
.DummyScene2:
.DummyScene3:
    end


.DummyScene:
	end

OaksLab_OakScript:
	faceplayer
	checkevent EVENT_TOOK_EEVEE
	iftrue .GotEevee
	opentext
	writetext OaksLab_OakText1
	promptbutton
	special NameRival
	writetext OaksLab_OakText2
	waitbutton
	closetext
	applymovement OAKSLAB_OAK, OaksLab_OakLeavesMovement_1 ;oak leaves
	disappear OAKSLAB_OAK 
	setscene SCENE_OAKSLAB_CANT_LEAVE
	setevent EVENT_OAK_GONE_FROM_LAB
	end
	

.GotEevee:
	opentext
	writetext OaksLab_OakText7
	waitbutton
	closetext
	end
	
OaksLab_OakText7:
	text "<PLAYER>…"
	
	para "I was going to"
	line "give you a pick"
	cont "from another set"
	cont "of #MON later."
	
	para "I wanted <RIVAL>"
	line "to have that"
	cont "Eevee, but I guess"
	cont "it's fine if you"
	cont "want it."
	
	para "Take good care"
	line "of that Eevee!"
	done

OaksLabTryToLeaveScriptL:
OaksLabTryToLeaveScriptR:
	checkevent EVENT_TOOK_EEVEE
	iftrue .OaksLabRivalBattle
	opentext
	writetext OaksLab_TryToLeaveText
	waitbutton
	closetext
	applymovement PLAYER, OaksLab_TryToLeaveMovement_1
	end
	
.OaksLabRivalBattle:
	checkevent EVENT_BEAT_RED_OAKSLAB
	iftrue .DoNothing
	showemote EMOTE_SHOCK, PLAYER, 15
	pause 15
	turnobject PLAYER, UP
	opentext 
	writetext OaksLab_LetsCheckOutOurPokemonText
	waitbutton
	closetext
	applymovement OAKSLAB_RED, OaksLab_RedPreparesForBattleMovement_1
	;battle red
	winlosstext RivalOaksLabWinText, RivalOaksLabLossText
	setlasttalked CHERRYGROVECITY_SILVER
	loadtrainer RIVAL1, RIVAL1_1_TOTODILE
	loadvar VAR_BATTLETYPE, BATTLETYPE_CANLOSE
	startbattle
	dontrestartmapmusic
	reloadmap
	iftrue .AfterVictorious
	sjump .AfterYourDefeat
	
.DoNothing:
	end
	
;   setflag ENGINE_POKEDEX	
	
	
.AfterVictorious:
	playmusic MUSIC_RIVAL_AFTER
	opentext
	writetext OaksLab_RivalText_AfterBattle
	waitbutton
	closetext
	sjump .FinishRival

.AfterYourDefeat:
	playmusic MUSIC_RIVAL_AFTER
	opentext
	writetext OaksLab_RivalText_AfterBattle
	waitbutton
	closetext
.FinishRival:
	applymovement OAKSLAB_RED, OaksLab_RedLeavesMovement
	disappear OAKSLAB_RED 
	setscene SCENE_OAKSLAB_RIVAL_BATTLE_1
	special HealParty
	playmapmusic
	end
	
RivalOaksLabWinText:
	text "<PLAYER>: Heh! Am"
	line "I great or what?"
	done

RivalOaksLabLossText:
	text "<PLAYER>: No! I"
	line "picked the wrong"
	cont "#MON!"
	done

OaksLab_RivalText_AfterBattle:
	text "<PLAYER>: Okay!"
	line "I'll make my"
	cont "#MON fight to"
	cont "toughen it up!"
	
	para "<RIVAL>! Gramps!"
	line "Smell ya later!"
	done

OaksLab_RedLeavesMovement:
	step RIGHT
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end
	
OaksLab_LetsCheckOutOurPokemonText:
	text "Wait! I know!"
	
	para "<RIVAL>, let's"
	line "check out our new"
	cont "#MON!"
	
	para "Come on, I'll"
	line "take you on!"
	done
	
OaksLab_RedPreparesForBattleMovement_1:
	step DOWN
	step DOWN
	step DOWN
	step_end
	
OaksLab_OakLeavesMovement_1:
	step DOWN
	step DOWN
	step DOWN
	step DOWN
	step_end
	
OaksLab_TryToLeaveMovement_1:
	step UP
	step_end
	
OaksLab_TryToLeaveText:
	text "Gramps said he'd"
	line "be right back."
	
	para "Let's not be too"
	line "impatient…"
	done
	
OaksLab_RedScript:
	faceplayer
	opentext
	writetext OaksLab_RedText1
	waitbutton
	closetext
	end
	
OaksLab_RedText1:
	text "… …"
	line "… …"
	done
	
Oak:
	faceplayer
	opentext
	checkevent EVENT_OPENED_MT_SILVER
	iftrue .CheckPokedex
	checkevent EVENT_TALKED_TO_OAK_IN_KANTO
	iftrue .CheckBadges
	writetext OakWelcomeKantoText
	promptbutton
	setevent EVENT_TALKED_TO_OAK_IN_KANTO
.CheckBadges:
	readvar VAR_BADGES
	ifequal NUM_BADGES, .OpenMtSilver
	ifequal NUM_JOHTO_BADGES, .Complain
	sjump .AhGood




.CheckPokedex:
	writetext OakLabDexCheckText
	waitbutton
	special ProfOaksPCBoot
	writetext OakLabGoodbyeText
	waitbutton
	closetext
	end

.OpenMtSilver:
	writetext OakOpenMtSilverText
	promptbutton
	setevent EVENT_OPENED_MT_SILVER
	sjump .CheckPokedex

.Complain:
	writetext OakNoKantoBadgesText
	promptbutton
	sjump .CheckPokedex

.AhGood:
	writetext OakYesKantoBadgesText
	promptbutton
	sjump .CheckPokedex

OaksAssistant1Script:
	jumptextfaceplayer OaksAssistant1Text

OaksAssistant2Script:
	jumptextfaceplayer OaksAssistant2Text

OaksAssistant3Script:
	jumptextfaceplayer OaksAssistant3Text

OaksLabBookshelf:
	jumpstd DifficultBookshelfScript

OaksLabPoster1:
	jumptext OaksLabPoster1Text

OaksLabPoster2:
	jumptext OaksLabPoster2Text

OaksLabTrashcan:
	jumptext OaksLabTrashcanText

OaksLabPC:
	opentext
	writetext OaksLabPCText
	waitbutton
	closetext
	showemote EMOTE_SHOCK, PLAYER, 15
	pause 15
	moveobject OAKSLAB_OAK, 4, 6
	moveobject OAKSLAB_RED, 4, 7
	applymovement PLAYER, OaksLab_OakComesBackMovement_1 ;player gets into position
	appear OAKSLAB_OAK
	applymovement OAKSLAB_OAK, OaksLab_OakComesBackMovement_2 ;oak comes back
	turnobject OAKSLAB_OAK, DOWN
	appear OAKSLAB_RED
	applymovement OAKSLAB_RED, OaksLab_OakComesBackMovement_2 ;red appears
	turnobject PLAYER, UP
	opentext
	writetext OaksLab_FedUpWithWaiting
	waitbutton
	writetext OaksLab_OakText3 ;Blue? Ah, that's right, I told you to wait. Offers Red 1st pick
	waitbutton 
	writetext OaksLab_NoFairGramps
	waitbutton
	writetext OaksLab_BePatient
	waitbutton
	closetext
	applymovement OAKSLAB_RED, OaksLab_RedGetsStarterMovement_1  ;red walks up to ball
	turnobject OAKSLAB_RED, UP
	pause 15
	showemote EMOTE_SHOCK, PLAYER, 15
	pause 15
	applymovement PLAYER, OaksLab_RedGetsStarterMovement_1 ;player walks up to Red
	pause 5
	playsound SFX_TACKLE
	showemote EMOTE_SHOCK, OAKSLAB_RED, 15
	pause 15
	applymovement OAKSLAB_RED, OaksLab_RedPushedMovement_1 ;Red is pushed
	applymovement PLAYER, OaksLab_PlayerSnatchesEeveeMovement_1 ;Player walks up to ball
	opentext
	writetext OaksLab_IWantThisOne
	waitbutton
	closetext 
	disappear OAKSLAB_STARTERBALL 
	setevent EVENT_TOOK_EEVEE
	opentext
	writetext OaksLab_PlayerSnatchedEeveeText
	waitbutton
	givepoke EEVEE, 5
	closetext
	showemote EMOTE_SHOCK, OAKSLAB_OAK, 15
	pause 15
	opentext
	writetext OaksLab_OakText4 ;Oak scolds Player 
	waitbutton
	closetext
	applymovement OAKSLAB_RED, OaksLab_RedGetsStarterMovement_2 ;Red walks up to oak
	opentext
	writetext OaksLab_OakText5 ;gives Red the Pokémon he caught earlier (Pika)
	waitbutton
	writetext OaksLab_OakGivesPikachuText ;RED got PIKACHU!
	waitbutton
	writetext OaksLab_OakText6 ;If a wild Pokemon appears...
	waitbutton
	closetext
	clearevent EVENT_OAK_GONE_FROM_LAB
	clearevent EVENT_RED_GONE_FROM_LAB
	end
	
OaksLab_OakComesBackMovement_1:
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step_end
	
OaksLab_OakComesBackMovement_2:
	step UP
	step UP
	step UP
	step UP
	step_end
	
OaksLab_FedUpWithWaiting:
	text "Gramps! I'm fed"
	line "up with waiting!"
	done
	
OaksLab_OakText3:
	text "<PLAYER>?"
	line "Ah, that's right!"
	
	para "I told you to wait"
	line "here while I went"
	cont "to find <RIVAL>."
	
	para "Anyway, now that"
	line "you're both here,"
	cont "we can finally"
	cont "begin!"
	
	para "Do you two see"
	line "that ball on"
	cont "the table?"
	
	para "It's called a #"
	line "BALL. It holds a"
	cont "#MON inside."
	
	para "<RIVAL>, you"
	line "can have it!"
	cont "Go on, take it!"
	done
	
OaksLab_NoFairGramps:
	text "Hey! Gramps!"
	line "What about me?"
	done
	
OaksLab_BePatient:
	text "Be patient,"
	line "<PLAYER>,"
	cont "you'll get your"
	cont "#MON next!"
	done
	
OaksLab_RedGetsStarterMovement_1:
	step DOWN
	step RIGHT
	step RIGHT
	step RIGHT
	step_end
	
	
OaksLab_RedPushedMovement_1:
	step RIGHT
	step RIGHT
	step_end

OaksLab_PlayerSnatchedEeveeText:
	text "<PLAYER> snatched"
	line "the #MON!"
	done

OaksLab_PlayerSnatchesEeveeMovement_1:
	step RIGHT
	turn_head UP
	step_end

OaksLab_RedGetsStarterMovement_2:
	step DOWN
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step LEFT
	step UP
	step UP
	step_end
	
OaksLab_IWantThisOne:
	text "No way! <RIVAL>,"
	line "I want this"
	cont "#MON! I was"
	cont "here first!"
	done
	
OaksLab_OakText1:
	text "Hello there,"
	line "<PLAYER>! You're"
	cont "right on time!"
	
	para "Today's the day"
	line "you finally get"
	cont "your very own"
	cont "#MON!"
	
	para "… …"
	
	para "It appears your"
	line "friend isn't here."
	cont "What was his"
	cont "name now?"
	done
	
OaksLab_OakText2:
	text "Ah, I remember"
	line "now! His name"
	cont "is <RIVAL>!"
	
	para "Anyway, he hasn't"
	line "shown up yet."
	
	para "He can't have"
	line "gone off too far"
	cont "without #MON."
	
	para "I'll go find him,"
	line "<PLAYER>. Wait"
	cont "here, I'll be"
	cont "right back."
	done	
	
OaksLab_OakText4:
	text "<PLAYER>! What"
	line "are you doing?"
	
	para "… …"
	line "… …"
	
	para "I was going to"
	line "give you another"
	cont "#MON later…"
	
	para "Uh… Okay. That"
	line "#MON is yours."
	para "You were here"
	line "on time after all…"
	
	para "<RIVAL>, come"
	line "over here."
	done
	
OaksLab_OakText5:
	text "This is the"
	line "#MON I caught"
	cont "earlier."
	
	para "You can have"
	line "it instead. Be"
	cont "careful, though."
	
	para "I caught it in"
	line "the wild and it's"
	cont "not tame yet."
	done
	
OaksLab_OakGivesPikachuText:
	text "<RIVAL> got a"
	line "PIKACHU!"
	done
	
OaksLab_OakText6:
	text "Now you two can"
	line "go on to the"
	cont "next town."
	para "If a wild #MON"
	line "appears, your"
	cont "#MON can fight"
	cont "against it!"
	done
	
StarterBallScript:
	opentext
	writetext OaksLab_StarterBallText_1
	waitbutton
	closetext
	end
	

	
OaksLab_StarterBallText_1:
	text "It's a #BALL"
	line "with a #MON"
	cont "inside."
	
	para "Heh, I bet that's"
	line "the one Gramps'"
	cont "been saving"
	cont "for me!"
	done

OakWelcomeKantoText:
	text "OAK: Ah, <PLAY_G>!"
	line "It's good of you"

	para "to come all this"
	line "way to KANTO."

	para "What do you think"
	line "of the trainers"

	para "out here?"
	line "Pretty tough, huh?"
	done

OakLabDexCheckText:
	text "How is your #-"
	line "DEX coming?"

	para "Let's see…"
	done

OakLabGoodbyeText:
	text "If you're in the"
	line "area, I hope you"
	cont "come visit again."
	done

OakOpenMtSilverText:
	text "OAK: Wow! That's"
	line "excellent!"

	para "You collected the"
	line "BADGES of GYMS in"
	cont "KANTO. Well done!"

	para "I was right in my"
	line "assessment of you."

	para "Tell you what,"
	line "<PLAY_G>. I'll make"

	para "arrangements so"
	line "that you can go to"
	cont "MT.SILVER."

	para "MT.SILVER is a big"
	line "mountain that is"

	para "home to many wild"
	line "#MON."

	para "It's too dangerous"
	line "for your average"

	para "trainer, so it's"
	line "off limits. But"

	para "we can make an"
	line "exception in your"
	cont "case, <PLAY_G>."

	para "Go up to INDIGO"
	line "PLATEAU. You can"

	para "reach MT.SILVER"
	line "from there."
	done

OakNoKantoBadgesText:
	text "OAK: Hmm? You're"
	line "not collecting"
	cont "KANTO GYM BADGES?"

	para "The GYM LEADERS in"
	line "KANTO are as tough"

	para "as any you battled"
	line "in JOHTO."

	para "I recommend that"
	line "you challenge"
	cont "them."
	done

OakYesKantoBadgesText:
	text "OAK: Ah, you're"
	line "collecting KANTO"
	cont "GYM BADGES."

	para "I imagine that"
	line "it's hard, but the"

	para "experience is sure"
	line "to help you."

	para "Come see me when"
	line "you get them all."

	para "I'll have a gift"
	line "for you."

	para "Keep trying hard,"
	line "<PLAY_G>!"
	done

OaksAssistant1Text:
	text "The PROF's #MON"
	line "TALK radio program"

	para "isn't aired here"
	line "in KANTO."

	para "It's a shame--I'd"
	line "like to hear it."
	done

OaksAssistant2Text:
	text "Thanks to your"
	line "work on the #-"
	cont "DEX, the PROF's"

	para "research is coming"
	line "along great."
	done

OaksAssistant3Text:
	text "Don't tell anyone,"
	line "but PROF.OAK'S"

	para "#MON TALK isn't"
	line "a live broadcast."
	done

OaksLabPoster1Text:
	text "Press START to"
	line "open the MENU."
	done

OaksLabPoster2Text:
	text "The SAVE option is"
	line "on the MENU."

	para "Use it in a timely"
	line "manner."
	done

OaksLabTrashcanText:
	text "There's nothing in"
	line "here…"
	done

OaksLabPCText:
	text "There's an e-mail"
	line "message on the PC."

	para "…"

	para "Calling all"
	line "#MON trainers!"
	
	para "The elite trainers"
	line "of #MON LEAGUE"
	cont "are ready to take"
	cont "on all comers!"

	para "Bring your best"
	line "#MON and see"
	cont "how you rate as a"
	cont "trainer!"

	para "#MON LEAGUE HQ"
	line "INDIGO PLATEAU"

	para "PS: PROF. OAK,"
	line "please visit us!"
	
	para "…"
	done

OaksLab_MapEvents:
	db 0, 0 ; filler

	def_warp_events
	warp_event  4, 11, PALLET_TOWN, 2
	warp_event  5, 11, PALLET_TOWN, 2
	warp_event  9, 10, BLUES_HOUSE, 1

	def_coord_events
	coord_event  4,  7, SCENE_OAKSLAB_CANT_LEAVE, OaksLabTryToLeaveScriptL
	coord_event  5,  7, SCENE_OAKSLAB_CANT_LEAVE, OaksLabTryToLeaveScriptR


	def_bg_events
	bg_event  6,  1, BGEVENT_READ, OaksLabBookshelf
	bg_event  7,  1, BGEVENT_READ, OaksLabBookshelf
	bg_event  8,  1, BGEVENT_READ, OaksLabBookshelf
	bg_event  9,  1, BGEVENT_READ, OaksLabBookshelf
	bg_event  0,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  1,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  2,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  3,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  6,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  7,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  8,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  9,  7, BGEVENT_READ, OaksLabBookshelf
	bg_event  4,  0, BGEVENT_READ, OaksLabPoster1
	bg_event  5,  0, BGEVENT_READ, OaksLabPoster2
	bg_event  9,  3, BGEVENT_READ, OaksLabTrashcan
	bg_event  0,  1, BGEVENT_READ, OaksLabPC

	def_object_events
	object_event  4,  2, SPRITE_OAK, SPRITEMOVEDATA_STANDING_DOWN, 0, 0, -1, -1, 0, OBJECTTYPE_SCRIPT, 0, OaksLab_OakScript, EVENT_OAK_GONE_FROM_LAB
	object_event  1,  8, SPRITE_SCIENTIST, SPRITEMOVEDATA_WALK_LEFT_RIGHT, 1, 0, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OaksAssistant1Script, -1
	object_event  7,  9, SPRITE_SCIENTIST, SPRITEMOVEDATA_WALK_UP_DOWN, 0, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OaksAssistant2Script, -1
;	object_event  1,  4, SPRITE_SCIENTIST, SPRITEMOVEDATA_WANDER, 1, 1, -1, -1, PAL_NPC_BLUE, OBJECTTYPE_SCRIPT, 0, OaksAssistant3Script, -1
	object_event  7,  3, SPRITE_POKE_BALL, SPRITEMOVEDATA_STILL, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, StarterBallScript, -1
	object_event  0,  0, SPRITE_SILVER, SPRITEMOVEDATA_SPINRANDOM_SLOW, 1, 1, -1, -1, PAL_NPC_RED, OBJECTTYPE_SCRIPT, 0, OaksLab_RedScript, EVENT_RED_GONE_FROM_LAB
	
