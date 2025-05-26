extends Node3D

@onready var character_mover : CharacterMover = get_parent()
@onready var steps: AudioStreamPlayer = $Steps

@export var step_after_dist = 3.0
@onready var last_pos = global_position
var dist_travelled_since_last_step = 0.0

func _physics_process(delta: float) -> void:
	if !character_mover.character_body.is_on_floor():
		dist_travelled_since_last_step = 0.0
	
	dist_travelled_since_last_step += global_position.distance_to(last_pos)
	if dist_travelled_since_last_step >= step_after_dist:
		dist_travelled_since_last_step = 0.0
		steps.play()
	
	last_pos = global_position
