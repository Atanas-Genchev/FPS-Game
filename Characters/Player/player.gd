extends CharacterBody3D

@onready var camera_3d = $Camera3D 
@onready var character_mover = $CharacterMover
@onready var health_manager = $HealthManager
@onready var weapon_manager = $Camera3D/WeaponManager
@onready var death_screen: Control = $PlayerUI/DeathScreen
@onready var flash_light: SpotLight3D = $Camera3D/FlashLight

@export var mouse_sensitivity_h = 0.15
@export var mouse_sensitivity_v = 0.15
var mouse_delta := Vector2.ZERO
const HOTKEYS = {
	KEY_1: 0,
	KEY_2: 1,
	KEY_3: 2,
}

var dead = false


func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	health_manager.died.connect(kill)

func _input(event):
	if dead:
		return
	if event is InputEventMouseMotion:
		rotation_degrees.y -= event.relative.x * mouse_sensitivity_h
		camera_3d.rotation_degrees.x -= event.relative.y * mouse_sensitivity_v
		camera_3d.rotation_degrees.x = clamp(camera_3d.rotation_degrees.x, -90, 90)
		
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			weapon_manager.switch_to_previous_weapon()
		if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			weapon_manager.switch_to_next_weapon()
	if event is InputEventKey and event.pressed and event.keycode in HOTKEYS:
		weapon_manager.switch_to_weapon_slot(HOTKEYS[event.keycode], false)

func _process(delta):	
	
	if dead:
		return
	if Input.is_action_just_pressed("flash_light"):
		flash_light.visible = !flash_light.visible
		
	
	var input_dir = Input.get_vector("move_left", "move_right", "move_forwards", "move_backwards")
	var move_dir = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if input_dir.x != 0 :
		rotate_head(input_dir.x * -3, $Camera3D)
		rotate_head(input_dir.x * -3, %WeaponManager)
	else:
		rotate_head(0, $Camera3D)
		rotate_head(0, %WeaponManager)
	
	character_mover.set_move_dir(move_dir)
	
	weapon_manager.attack(Input.is_action_just_pressed("attack"), Input.is_action_pressed("attack"))

func rotate_head(value : float, object : Node3D) -> void:
	object.rotation.z = lerp_angle(object.rotation.z, deg_to_rad(value), 0.02)

func kill():
	dead = true
	character_mover.set_move_dir(Vector3.ZERO)
	death_screen.show_death_screen()
	
func hurt(damage_data: DamageData):
	health_manager.hurt(damage_data)
