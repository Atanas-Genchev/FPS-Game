extends Control
@onready var heal: ColorRect = $Heal
@onready var hurt: ColorRect = $Hurt
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var health_manager: Node3D = %HealthManager

func _ready() -> void:
	health_manager.healed.connect(on_heal)
	health_manager.damaged.connect(on_hurt)

func on_hurt():
	animation_player.play("flash")
	hurt.show()
	heal.hide()
	

func on_heal():
	animation_player.play("flash")
	heal.show()
	hurt.hide()
