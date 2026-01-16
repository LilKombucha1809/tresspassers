extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		get_tree().change_scene_to_file("res://level_1.tscn")
		Game_Events.enter_first_level.emit()
		Game_Events.hit_door_kun.emit()
