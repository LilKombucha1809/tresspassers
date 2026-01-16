extends Area2D

func _ready() -> void:
	$shield_sprite.play("idle")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		monitoring = false
		Game_Events.player_shield.emit()
		$shield_sprite.play("gone")
		await $shield_sprite.animation_finished
		queue_free()
