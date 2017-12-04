extends Node2D
var current_scene = null
var amountOfArrow = 0
var bombAll =  false
var enemies_moving = true

var title_screen = 0

# Character values

var health = 3
var score = 0

# Position values

# The amount of different rooms the player has gone through in each level.
var room_counter = 1
# The last door the player has gone through.
var last_door = null
# The last room type the player has gone through
var last_room = [1,1,1,1]
# Starting location on global map
var locationX = 13
var locationY = 13

# Map that encompasses the whole level
var global_map
var global_map_dimensions = 5

# Creates a new global map / level
func create_global_map():
	if (global_map == null):
		print ("creating map")
		global_map = []
		for x in range(25):
			global_map.append([])
			for y in range(25):
				global_map[x].append(0)
				
	global_map[locationX][locationY] = [1,1,1,1]

# Creates a new level, resting all global position values while leaving the character values alone
func create_new_level():
	global_map = null
	room_counter = 1
	room_counter = 1
	last_door = null
	last_room = [1,1,1,1]
	locationX = 13
	locationY = 13

# Tracks the characters position in the global map.
func move_global_map():
	if (global_map == null):
		print("No map found")
		pass
		
	if (last_door == null):
		pass
	elif (last_door.casecmp_to("TopDoor") == 0):
		locationY = locationY - 1
	elif (last_door.casecmp_to("BotDoor") == 0):
		locationY = locationY + 1
	elif (last_door.casecmp_to("LeftDoor") == 0):
		locationX = locationX - 1
	elif (last_door.casecmp_to("RightDoor") == 0):
		locationX = locationX + 1
	
	print ("x: " + str(locationX) + " y: " + str(locationY))
	pass
	

	

# Checks if the room alread exists on the global map.
func check_room_global_map():
	if global_map[locationX][locationY] == 0:
		print ("New room found")
		return null
	else:
		print ("Old room found")
		return global_map[locationX][locationY]

func check_oneway_door(x,y):
	if global_map[x][y] == 0:
		return [5,5,5,5]
	else:
		return global_map[x][y]

func check_room_oneway_doors():
	# Checks the up door
	var up = (check_oneway_door(locationX, locationY - 1))[1]
	var down = (check_oneway_door(locationX, locationY + 1))[0]
	var left = (check_oneway_door(locationX - 1, locationY))[3]
	var right = (check_oneway_door(locationX + 1, locationY))[2]
	
	var oneway_check = [up,down,left,right]
	return oneway_check


# Adds the current room to the global map.
func add_room_global_map():
	global_map[locationX][locationY] = last_room
	

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child( root.get_child_count() -1 )
	
	if (title_screen == 0):
		get_tree().change_scene("res://Title.tscn")
	else:
		get_tree().change_scene("res://MapControl.tscn")


func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)
	
func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene( current_scene )
	