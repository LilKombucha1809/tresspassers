extends Area2D

func _ready() -> void:
	$double_jump.play("idle")
	
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		monitoring = false
		Game_Events.player_double_jump.emit()
		$double_jump.play("gone")
		await $double_jump.animation_finished
		queue_free()
