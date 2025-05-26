extends Node3D


func _on_smoke_particles_finished() -> void:
	$Timer.start()


func _on_timer_timeout() -> void:
	queue_free()
