extends Area2D

func _ready() -> void:
	$lava.play("lava")
	
func _process(delta: float) -> void:
	position.y -= 50 * delta

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Game_Events.hit_lava.emit()
