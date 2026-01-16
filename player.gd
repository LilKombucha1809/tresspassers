extends CharacterBody2D

@export var speed: float = 200
@export var jump_horizontal_speed = 500
var max_jumps = 0
var jump_count = 0
var shield = false
var is_dead = false
var respawning = true

@onready var wall = $wall_ray

@export var jump_height: float = 70
@export var time_ascent: float = 0.3
@export var time_descent: float = 0.2

@onready var animatedsprite2d = $AnimatedSprite2D
@onready var jump_speed: float =  -1.0 * (2 * jump_height / time_ascent)
@onready var gravity_ascent: float =  -1.0 * (- 2 * jump_height / time_ascent / time_ascent)
@onready var gravity_descent: float =  -1.0 * (- 2 * jump_height / time_descent / time_descent)
@onready var coyote_timer = $coyote_timer
@onready var double_jump_timer = $double_jump_timer
@onready var shield_timer = $shield_timer
@onready var iframe_timer = $iframe_timer

func _ready() -> void:
	Game_Events.hit_lava.connect(hit_lava)
	Game_Events.player_double_jump.connect(double_jump_recieved)
	Game_Events.player_shield.connect(player_shield_recieved)
	Game_Events.hit_spike.connect(hit_lava)
	play_respawn_animation()
	
func hit_lava():
	if !shield_timer.is_stopped():
		velocity.y = jump_speed
		$shield_bubble.play("pop")
		await $shield_bubble.animation_finished
		$shield_bubble.hide()
		shield_timer.stop()
		iframe_timer.start()
	elif !iframe_timer.is_stopped():
		velocity.y = jump_speed
	else:
		is_dead = true
		velocity.y = jump_speed
		$mc.play("die")
		var current_treee = get_tree()
		await $mc.animation_finished
		if current_treee:
			current_treee.reload_current_scene()

func play_respawn_animation():
	respawning = true
	respawning = false
	
func double_jump_recieved():
	double_jump_timer.start()
	$jump_meter.show()
	$jump_meter.stop()
	$jump_meter.play("jump_meter")
	max_jumps = 1

func player_shield_recieved():
	shield_timer.start()
	$shield_bubble.show()
	$shield_meter.show()
	$shield_bubble.stop()
	$shield_meter.stop()
	$shield_meter.play("shield_meter")
	$shield_bubble.play("idle")
	
func mc_animation():
	if velocity.x == 0:
		$mc.play("idle")
	else:
		$mc.play("run")

func _physics_process(delta: float) -> void:
	
	if is_dead or respawning:
		if is_dead:
			velocity.y += gravity() * delta
			move_and_slide()
		return

	velocity.y += gravity() * delta
	
	var target_speed = get_input_velocity() * speed
	velocity.x = move_toward(velocity.x, target_speed, 30.0)
	
	mc_animation()
	
	if shield_timer.is_stopped():
		$shield_bubble.hide()
		$shield_meter.hide()

	jump()
	
	if double_jump_timer.is_stopped():
		$jump_meter.hide()
		max_jumps = 0

	if is_on_floor():
		jump_count = 0
	
	var was_on_floor = is_on_floor()
	move_and_slide()
	if was_on_floor and !is_on_floor():
		coyote_timer.start()
	
	
	if Input.is_action_pressed("restart"):
		Game_Events.start_the_clock.emit()
		get_tree().change_scene_to_file("res://tute.tscn")
	
func get_input_velocity() -> float:
	if is_dead or respawning:
		return 0.0
		
	if Input.is_action_pressed("left"):
		$mc.scale.x = 1.0
		wall.scale.x = -1.0
		return -1.0
	elif Input.is_action_pressed("right"):
		$mc.scale.x = -1.0
		wall.scale.x = 1.0
		return 1.0
	else:
		return 0
	
func jump():
	if Input.is_action_just_pressed("ui_accept"):
		if is_on_floor() or !coyote_timer.is_stopped() or (jump_count < max_jumps):
			velocity.y = jump_speed
			jump_count += 1
		elif wall.is_colliding():
			var wall_normal = get_wall_normal()
			velocity.y = jump_speed*1.2
			velocity.x = wall_normal.x * jump_horizontal_speed
			jump_count = 0
	
func gravity() -> float:
	return gravity_ascent if velocity.y <= 0 else gravity_descent
	


func _on_doorkun_body_entered(body: Node2D) -> void:
	pass
