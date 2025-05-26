extends Label

var lines = []
const MAX_LINES = 5
const DELET_LINE_AFTER = 3.0

var delete_timer : Timer

func _ready() -> void:
	delete_timer = Timer.new()
	add_child(delete_timer)
	delete_timer.wait_time = DELET_LINE_AFTER
	delete_timer.timeout.connect(delete_line)
	update_display()

func on_pickup(pickup : PickUp):
	if pickup.pick_up_type == PickUp.PICKUP_TYPES.HEALTH:
		add_line("Picked up %s health" % pickup.pick_up_amount)
		return
	var weapon_name = PickUp.WEAPONS.keys()[pickup.weapon_type].capitalize()
	if pickup.pick_up_type == PickUp.PICKUP_TYPES.WEAPON:
		add_line("Picked up %s " % weapon_name)
	if pickup.pick_up_type == PickUp.PICKUP_TYPES.AMMO:
		add_line("Picked up %s %s ammo" % [pickup.pick_up_amount,weapon_name] )
	
func add_line(line_text : String):
	delete_timer.start()
	lines.push_back(line_text)
	if lines.size() > MAX_LINES:
		lines.pop_front()
	update_display()
	
func delete_line():
	lines.pop_front()
	update_display()
	
func update_display():
	var s = ""
	for line in lines:
		s += line + "\n"
	text = s
