extends Area3D
@onready var weapon_manager: Node3D = %WeaponManager
@onready var health_manager: Node3D = %HealthManager
@onready var pick_up_info: Label = %PickUpInfo

@onready var ammo_sounds = {
	PickUp.WEAPONS.PISTOL: $PickUpMakarovAmmo,
	PickUp.WEAPONS.SHOTGUN: $PickUpSGAmmo,
	PickUp.WEAPONS.SMG: $PickUpSmgAmmo
}

func _ready() -> void:
	area_entered.connect(on_area_entered)

func on_area_entered(pick_up : Area3D):
	var delete_on_pickup = true
	if pick_up is PickUp:
		match pick_up.pick_up_type:
			PickUp.PICKUP_TYPES.HEALTH:
				if health_manager.cur_health < health_manager.max_health and health_manager.cur_health > 0:
					health_manager.heal(pick_up.pick_up_amount)
					$PickUpHealth.play()
				else:
					delete_on_pickup = false
			PickUp.PICKUP_TYPES.WEAPON:
				var weapon : Weapon = weapon_manager.get_weapon_from_pickup_type(pick_up.weapon_type)
				weapon_manager.enable_weapon(weapon)
				weapon.add_ammo(pick_up.pick_up_amount)
				ammo_sounds[pick_up.weapon_type].play()
			PickUp.PICKUP_TYPES.AMMO:
				var weapon : Weapon = weapon_manager.get_weapon_from_pickup_type(pick_up.weapon_type)
				weapon.add_ammo(pick_up.pick_up_amount)
				ammo_sounds[pick_up.weapon_type].play()
	if delete_on_pickup:
		pick_up_info.on_pickup(pick_up)
		pick_up.pickup()
