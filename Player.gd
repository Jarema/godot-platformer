extends KinematicBody2D

var motion = Vector2()
var jumpCount = 0
var jump_frames = 0
var hp = 100

const x_velocity = 250
const jump_height = -300
const acceleration = 18
const UP = Vector2(0,-1)

func _ready():
	$animations.play("idle")

func gravity():
	motion.y += acceleration

func _physics_process(delta):
	gravity()
	if Input.is_action_pressed("ui_right"):
		motion.x = x_velocity
		$animations.flip_h = false
		$ledge_cast.global_rotation = 0
		$ceiling_cast.global_rotation = 0
		if motion.y == acceleration:
			$animations.play("run_right")
	elif Input.is_action_pressed("ui_left"):
		motion.x = x_velocity * -1
		$animations.flip_h = true
		$ledge_cast.global_rotation = 180
		$ceiling_cast.global_rotation = 180
		if motion.y == acceleration:
			$animations.play("run_left")
	else:
		motion.x = 0
	if Input.is_action_pressed("ui_up"):
		# for checking max jump height
		jump_frames += (1 * delta)
		# double jump
		if jumpCount < 2 && jump_frames < 0.28:
			$animations.play("jump")
			motion.y = jump_height
	if is_on_floor():
		jumpCount = 0
	if Input.is_action_just_released("ui_up"):
		jumpCount += 1
	if Input.is_action_just_pressed("ui_up"):
		jump_frames = 0
	if motion.y > acceleration:
		$animations.play("falling")
	if motion.x == 0 && motion.y == acceleration:
		$animations.play("idle")
	if $ledge_cast.is_colliding() && !$ceiling_cast.is_colliding() && !Input.is_action_just_pressed("ui_up"):
		jumpCount = 0
		motion.y = 0
		$animations.play("grab")
	motion = move_and_slide(motion, UP)	

func receive_damage(amount):
	hp = hp - amount
	if hp <= 0:
		queue_free()
		get_tree().reload_current_scene()
