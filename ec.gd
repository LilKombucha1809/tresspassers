extends Area2D

@export var delay_seconds: float = 0.5
var history: Array = []
var total_time: float = 0.0

@onready var player = $"../Player"

func _physics_process(delta: float) -> void:
		total_time += delta
		
		history.append({
			"pos": player.global_position,
			"time": total_time,
			"scale_x": player.get_node("mc").scale.x,
			"anim": player.get_node("mc").animation
		})
		
		while history.size() > 0 and (total_time - history[0]["time"]) >= delay_seconds:
			var data = history.pop_front()
			global_position = data["pos"]
			
			$AnimatedSprite2D.scale.x = data["scale_x"]
			if $AnimatedSprite2D.animation != data["anim"]:
				$AnimatedSprite2D.play(data["anim"])

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		Game_Events.hit_lava.emit()
