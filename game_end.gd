extends CanvasLayer



func _on_restart_pressed() -> void:
	Game_Events.start_the_clock.emit()
	get_tree().change_scene_to_file("res://tute.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
