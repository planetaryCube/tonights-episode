// A point is added every second, adjust new track threshold overrides accordingly

/// Storyteller track data, for easy overriding of tracks without having to copypaste
/// thresholds - Used to show how many points the track has to collect before it triggers, lower means faster
/datum/storyteller_data/tracks
	var/threshold_mundane = 45
	var/threshold_moderate = 75
	var/threshold_major = 300
	var/threshold_crewset = 600
	var/threshold_ghostset = 300
