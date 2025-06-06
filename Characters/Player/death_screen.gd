extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var restart_button: Button = $Panel/RestartButton
@onready var quit_button: Button = $Panel/QuitButton


func _ready() -> void:
	restart_button.button_up.connect(restart_level)
	quit_button.button_up.connect(quit_game)
	hide()
func show_death_screen():
	show()
	animation_player.play("FadeIn")
	await animation_player.animation_finished
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func restart_level():
	get_tree().call_group("instanced", "queue_free")
	get_tree().reload_current_scene()

func quit_game():
	get_tree().quit()
