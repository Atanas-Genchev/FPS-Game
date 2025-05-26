extends Area3D
class_name PickUp

enum PICKUP_TYPES {HEALTH, WEAPON, AMMO}
enum WEAPONS {PISTOL, SHOTGUN, SMG}
@export var pick_up_type = PICKUP_TYPES.HEALTH
@export var weapon_type = WEAPONS.PISTOL
@export var pick_up_amount = 16

func pickup():
	queue_free()
