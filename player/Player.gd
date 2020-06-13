extends KinematicBody2D

var H: = 144
var T: = 0.15
var g: = (2*H) / (T * T)
var xspeed: = 160

var vel : = Vector2.ZERO


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _physics_process(delta: float) -> void:
	vel.y += g
	vel.x = (Input.get_action_strength("left") - Input.get_action_strength("right")) * xspeed
	move_and_slide(vel * delta, Vector2.UP)
