/datum/controller/subsystem/gamemode/proc/cap_storyteller_thresholds()
	var/datum/storyteller_data/tracks/track_data = storyteller.track_data
	event_track_points[EVENT_TRACK_MUNDANE] = min(event_track_points[EVENT_TRACK_MUNDANE], track_data.threshold_mundane)
	event_track_points[EVENT_TRACK_MODERATE] = min(event_track_points[EVENT_TRACK_MODERATE], track_data.threshold_mundane)
	event_track_points[EVENT_TRACK_MAJOR] = min(event_track_points[EVENT_TRACK_MAJOR], track_data.threshold_major)
	event_track_points[EVENT_TRACK_CREWSET] = min(event_track_points[EVENT_TRACK_CREWSET], track_data.threshold_crewset)
	event_track_points[EVENT_TRACK_GHOSTSET] = min(event_track_points[EVENT_TRACK_GHOSTSET], track_data.threshold_ghostset)
