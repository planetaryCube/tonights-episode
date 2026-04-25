#define NO_MAXVOTES_CAP -1

#define AUTOTRANSFER_SUBSYSTEM_DEF(X) GLOBAL_REAL(SS##X, /datum/controller/subsystem/autotransfer/##X);\
/datum/controller/subsystem/autotransfer/##X/New(){\
	NEW_SS_GLOBAL(SS##X);\
	PreInit();\
}\
/datum/controller/subsystem/autotransfer/##X/fire() {..() /*just so it shows up on the profiler*/} \
/datum/controller/subsystem/autotransfer/##X

AUTOTRANSFER_SUBSYSTEM_DEF(storyteller_vote)
	name = "Automatic Storyteller Vote"

/datum/controller/subsystem/autotransfer/storyteller_vote/Initialize()
	if(!CONFIG_GET(flag/autostoryteller)) //Autotransfer voting disabled.
		can_fire = FALSE
		return SS_INIT_NO_NEED

	var/init_vote = CONFIG_GET(number/vote_autostoryteller_initial)
	starttime = REALTIMEOFDAY
	targettime = starttime + init_vote
	voteinterval = CONFIG_GET(number/vote_autostoryteller_interval)
	maxvotes = CONFIG_GET(number/vote_autostoryteller_maximum)
	return SS_INIT_SUCCESS

/datum/controller/subsystem/autotransfer/storyteller_vote/fire()
	if(REALTIMEOFDAY < targettime || !SSticker.current_state == GAME_STATE_PLAYING)
		return
	if(!isnull(SSvote.current_vote))
		return
	if(maxvotes == NO_MAXVOTES_CAP || maxvotes > curvotes)
		SSvote.initiate_vote(/datum/vote/storyteller, "automatic storyteller vote", forced = TRUE)
		targettime = targettime + voteinterval
		curvotes++

/datum/controller/subsystem/autotransfer/storyteller_vote/new_shift(real_round_start_time)
	var/init_vote = CONFIG_GET(number/vote_autostoryteller_initial) // Check if an admin has manually set an override in the pre-game lobby
	starttime = real_round_start_time
	targettime = starttime + init_vote
	log_game("Auto storyteller vote enabled, first vote in [DisplayTimeText(targettime - starttime)]")
	message_admins("Auto storyteller vote enabled, first vote in [DisplayTimeText(targettime - starttime)]")

#undef NO_MAXVOTES_CAP
