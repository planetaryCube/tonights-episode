/// Length of time before the first autostoryteller vote is called (deciseconds, default 2 hours)
/// Set to 0 to disable the subsystem altogether.
/datum/config_entry/number/vote_autostoryteller_initial
	config_entry_value = 72000
	min_val = 0

///length of time to wait before subsequent autostoryteller votes (deciseconds, default 30 minutes)
/datum/config_entry/number/vote_autostoryteller_interval
	config_entry_value = 18000
	min_val = 0

/// maximum extensions until the round autoends.
/// Set to 0 to force automatic crew storyteller after the 'vote_autostoryteller_initial' elapsed.
/// Set to -1 to disable the maximum extensions cap.
/datum/config_entry/number/vote_autostoryteller_maximum
	config_entry_value = 4
	min_val = -1

/// Determines if the autostoryteller system runs or not.
/datum/config_entry/flag/autostoryteller


/// Determines if the storyteller vote can be started by anyone or not.
/datum/config_entry/flag/allow_vote_storyteller
