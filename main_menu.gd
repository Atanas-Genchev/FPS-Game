extends Control

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func _on_level_1_pressed() -> void:
	get_tree().change_scene_to_file("res://level_1.tscn")


func _on_level_2_pressed() -> void:
	get_tree().change_scene_to_file("res://level_2.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
