extends Label

func _process(_delta: float) -> void:
	text = "Time: " + str(snapped(GlobalTimer.time_elapsed, 0.01))
