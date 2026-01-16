extends Area2D

func _physics_process(delta: float) -> void:
	position.y -= 150 * delta

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player": 
		get_tree().reload_current_scene()
	
	if body is TileMapLayer:
		queue_free()
