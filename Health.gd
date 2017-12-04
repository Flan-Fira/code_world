extends Panel

var empty = Rect2(0,0,64,64)
var full = Rect2(64,0,64,64)

func _ready():
	
	update_health()
	
	pass

func turn_full(node):
	print("full")
	get_node(node).set_region_rect(full)
	pass
	
func turn_empty(node):
	print("empty")
	get_node(node).set_region_rect(empty)
	pass
	
func update_health():
	if global.health == 3:
		turn_full("Health 3")
		turn_full("Health 2")
		turn_full("Health 1")
	elif global.health == 2:
		turn_empty("Health 3")
		turn_full("Health 2")
		turn_full("Health 1")
	elif global.health == 1:
		turn_empty("Health 3")
		turn_empty("Health 2")
		turn_full("Health 1")
	elif global.health == 0:
		turn_empty("Health 3")
		turn_empty("Health 2")
		turn_empty("Health 1")
	else:
		turn_full("Health 3")
		turn_empty("Health 2")
		turn_full("Health 1")
		
		
		
		
		
		
		
		
		
		
		