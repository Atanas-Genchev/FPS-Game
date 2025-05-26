extends Node3D

@onready var player : CharacterBody3D = $"../../.."

@export var sway_left : Vector3
@export var sway_right : Vector3
@export var sway_up : Vector3
@export var sway_down : Vector3
@export var sway_normal : Vector3

var mouse_movement_y : float
var mouse_movement_x : float
var sway_threshold : float = 5.0
var sway_lerp : float = 0.5

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_movement_y = -event.relative.x
		mouse_movement_x = event.relative.y
	
func _physics_process(delta: float) -> void:
	if mouse_movement_y != null:
		if mouse_movement_y > sway_threshold:
			rotation = rotation.lerp(sway_left, sway_lerp * delta)
		elif mouse_movement_y < -sway_threshold:
			rotation = rotation.lerp(sway_right, sway_lerp * delta)
		
		if mouse_movement_x > sway_threshold:
			rotation = rotation.lerp(sway_up, sway_lerp * delta)
		elif mouse_movement_x < -sway_threshold:
			rotation = rotation.lerp(sway_down, sway_lerp * delta)
		else:
			rotation = rotation.lerp(sway_normal, sway_lerp * delta)
