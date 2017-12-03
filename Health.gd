extends Panel

var hp = global.health
var empty = Rect2(0,0,64,64)
var full = Rect2(64,0,64,64)

func _ready():
	
	# Updates health UI whenever it is called
	update_health()
	
	pass

# HP becomes full
func turn_full(node):
	get_node(node).set_region_rect(full)
	pass
	
# HP becomes empty
func turn_empty(node):
	get_node(node).set_region_rect(empty)
	pass
	
func update_health():
	if hp == 3:
		turn_full("Health 3")
		turn_full("Health 2")
		turn_full("Health 1")
	elif hp == 2:
		turn_empty("Health 3")
		turn_full("Health 2")
		turn_full("Health 1")
	elif hp == 1:
		turn_empty("Health 3")
		turn_empty("Health 2")
		turn_full("Health 1")
	elif hp == 0:
		turn_empty("Health 3")
		turn_empty("Health 2")
		turn_empty("Health 1")
	else:
		turn_full("Health 3")
		turn_empty("Health 2")
		turn_full("Health 1")
		
		
		
		
		
		
		
		
		
		
		