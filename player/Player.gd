extends KinematicBody2D

onready var sprite: = $Sprite

const FLOOR_NORMAL: = Vector2.UP
export var speed: = Vector2(400.0, 900.0)
export var gravity: = 2000.0  
var _velocity : = Vector2.ZERO

func _physics_process(delta: float) -> void:
	var is_jump_interrupted: = Input.is_action_just_released("jump") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	manage_animations()
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		-1.0 if Input.is_action_just_pressed("jump") and is_on_floor() else 1.0
	)

func manage_animations():
#	ADMINISTRAR LAS ANIMACIONES PARA SANCHEZITO
#	puto el que lo lea

	if is_on_floor():
		if _velocity.x != 0:
			sprite.play("walking")
		else:
			sprite.play("default")
	else:
		if _velocity.y > 0:
			sprite.play("jump")
		elif _velocity.y < 0:
			sprite.play("fall")
	
	
	if _velocity.x < 0:
		sprite.flip_h = 1
	elif _velocity.x > 0:
		sprite.flip_h = 0
	
func play_animation(anim: String):
	if sprite.playing != anim:
		sprite.play(anim)

func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2,
		is_jump_interrupted: bool
	) -> Vector2:
	var out: = linear_velocity
	out.x = speed.x * direction.x
	out.y += gravity * get_physics_process_delta_time()
	if direction.y == -1.0:
		out.y = speed.y * direction.y
	if is_jump_interrupted:
		out.y = 0.0
	return out
