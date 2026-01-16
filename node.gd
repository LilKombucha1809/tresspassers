extends Node


func _ready() -> void:
	Game_Events.start_game.connect(play_first_track)
	Game_Events.enter_first_level.connect(play_second_track)
	
func play_first_track():
	pass
	
func play_second_track():
	$menus.stop()
	$level_1.play()
