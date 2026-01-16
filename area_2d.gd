extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://game_end.tscn")
		GlobalTimer.stop_timer()
		Game_Events.hit_door_kun_end.emit()
