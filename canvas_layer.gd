extends CanvasLayer

var time = GlobalTimer.time_elapsed
 
func _physics_process(delta):
	time = float(time) + delta
	update_ui()
	
func update_ui():
	var formatted_time = str(time)
	var decimal_index = formatted_time.find(".")
	
	if decimal_index > 0:
		formatted_time = formatted_time.left(decimal_index + 3)
	
	GlobalTimer.time_elapsed = formatted_time

	$Label.text = formatted_time
