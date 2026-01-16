extends Label

func _ready() -> void:
  
	var final_time = GlobalTimer.time_elapsed
  
	var minutes = int(final_time / 60)
	var seconds = int(final_time) % 60
	var milliseconds = int((final_time - int(final_time)) * 100)
	
	text = "%02d:%02d.%02d" % [minutes, seconds, milliseconds]
