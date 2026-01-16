extends Node

var time_elapsed: float = 0.0
var timer_active: bool = true

func _ready() -> void:
	Game_Events.start_the_clock.connect(reset_timer)
	Game_Events.hit_door_kun_end.connect(stop_timer)
	
func _process(delta: float) -> void:
	if timer_active:
		time_elapsed += delta

func stop_timer():
	timer_active = false
func reset_timer():
	time_elapsed = 0.0
