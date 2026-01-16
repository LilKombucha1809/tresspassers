extends Node

@onready var player = $level_1

func _ready() -> void:
	get_tree().root.child_entered_tree.connect(_on_scene_changed)
	var tes_music = load("res://level_1.mp3")
	play_music(tes_music)

func _on_scene_changed(node):
	await get_tree().process_frame
	
	var current_scene = get_tree().current_scene
	
	if current_scene and ("level_music" in current_scene):
		var music = current_scene.level_music
		if music != null:
			play_music(music)
			
func play_music(music: AudioStream):
	if music == null:
		return
	
	if player.stream == music and player.playing:
		return
	
	player.stream = music
	player.play()
	
func stop_music():
	player.stop()
	
