extends Node2D

var flySprite: = preload("res://assets/sprites/hook/hook_0.png")
var hookedSprite: = preload("res://assets/sprites/hook/hook_2.png")

onready var line: = $Line
onready var headSprite: = $Head/Sprite
var direction: = Vector2.ZERO
var tip: = Vector2.ZERO

const SPEED = 50

var flying: = false
var hooked: = false

func shoot(dir: Vector2) -> void:
	print("Shooting!")
	direction = dir.normalized()
	flying = true
	tip = self.global_position

func release() -> void:
	headSprite.texture = flySprite
	flying = false
	hooked = false

func _process(delta: float) -> void:
	self.visible = flying or hooked
	if not self.visible:
		return
	var tip_loc: = to_local(tip)
	line.rotation = self.position.angle_to_point(tip_loc) - deg2rad(90)
	$Head.rotation = self.position.angle_to_point(tip_loc) - deg2rad(90)
	line.position = tip_loc
	line.region_rect.size.y = tip_loc.distance_to(self.position)
	
	if flying:
		headSprite.texture = flySprite
	else:
		headSprite.texture = hookedSprite


func _physics_process(delta: float) -> void:
	$Head.global_position = tip
	if flying:
		if $Head.move_and_collide(direction * SPEED):
			print("Hooked!")
			hooked = true
			flying = false
	tip = $Head.global_position

