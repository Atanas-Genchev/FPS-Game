extends Control
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var restart_button: Button = $Panel/RestartButton
@onready var quit_button: Button = $Panel/QuitButton
@onready var main_menu_button: Button = $Panel/MainMenuButton
@export var main_menu : PackedScene

func _ready() -> void:
	restart_button.button_up.connect(restart_level)
	quit_button.button_up.connect(quit_game)
	main_menu_button.button_up.connect(main_menu_)
	hide()
func show_death_screen():
	show()
	animation_player.play("FadeIn")
	await animation_player.animation_finished
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func main_menu_() -> void:
	get_tree().change_scene_to_packed(main_menu)
	
func restart_level():
	get_tree().call_group("instanced", "queue_free")
	get_tree().reload_current_scene()

func quit_game():
	get_tree().quit()
