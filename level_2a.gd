extends Node2D

var bullet_scene = preload("res://spikes.tscn")

func spawn_spike():
	var new_bullet = bullet_scene.instantiate()
	
	var random_x = randf_range(0,100)
	
	new_bullet.position = Vector2(500, 800) 
	
	add_child(new_bullet)


func _on_ec_body_entered(body: Node2D) -> void:
	pass # Replace with function body.
