extends AudioStreamPlayer2D

func _notification(what):
	if what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_IN:
		print("Sounds on")
		set_stream_paused(false)
	elif what == MainLoop.NOTIFICATION_APPLICATION_FOCUS_OUT:
		print("Sounds off")
		set_stream_paused(true)
