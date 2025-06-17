extends Node3D

var enemy_count : int = 0
@onready var enemies = $Enemies
@onready var timer: Timer = $Timer
@onready var level_end: AudioStreamPlayer = $LevelEnd
@export var next_scene : PackedScene

func _ready() -> void:
	enemy_count = enemies.get_child_count()
	print(enemy_count)
	for child in enemies.get_children():
		child.connect("dead", decrease_enemy_count)

func decrease_enemy_count() -> void:
	if enemy_count <= 1:
		level_end.play()
		timer.start()
	enemy_count -= 1
		
func change_level() -> void:
	get_tree().change_scene_to_packed(next_scene)

func _on_timer_timeout() -> void:
	change_level()
