extends TileMap
var tile_size = get_cell_size()
var half_tile_size = tile_size/2

enum ENTITY_TYPES {PLAYER, ENEMY}
var grid_size = Vector2(11, 11)
var grid = []
var positions = []
var randiX
var randiY
var finding = true

var playerX
var playerY

var arrowX
var arrowY
var bombX
var bombY
var stairX
var stairY

onready var TDoor = preload("res://TopDoor.tscn")
onready var BDoor = preload("res://BotDoor.tscn")
onready var LDoor = preload("res://LeftDoor.tscn")
onready var RDoor = preload("res://RightDoor.tscn")
onready var red = preload("res://Red.tscn")
onready var Arrow = preload("res://Arrow.tscn")
onready var Player = preload("res://Player.tscn")
onready var Bomb = preload("res://Bomb.tscn")
onready var Map = preload("res://createMap.tscn")
onready var Health = preload("res://Health.tscn")
onready var Item_UI = preload("res://Item_UI.tscn")
onready var Stair = preload("res://Stair.tscn")

func _ready():
	# Will create a global map at the start of a 25 room by 25 room grid
	if (global.global_map == null):
		global.create_global_map()
	
	# Moves the location of the character on the global map
	global.move_global_map()
	
	var createmap = Map.instance()

	add_child(createmap)
	
	var hp = Health.instance()
	var item_ui = Item_UI.instance()
	add_child(hp)
	add_child(item_ui)
	
	randomize()
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
	_setPlayer()
	_setItems()
	_setDoors()
#	_setEnemies()
	
#func _setEnemies():
	#for n in range(5):
	#	var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
	#	if grid_pos.x > 0 and grid_pos.x < grid_size.x and grid_pos.y > 0 and grid_pos.y < grid_size.y-1:
	#		if not grid_pos in positions:
	#			if grid_pos != player.get_pos():
	#				positions.append(grid_pos)
	#	else:
	#		n = n - 1
	#	
	#for pos in positions:
	#	var new_obstacle = red.instance()
	#	new_obstacle.set_pos(map_to_world(pos) + half_tile_size)
	#	grid[pos.x][pos.y] = new_obstacle.get_name()
	#	add_child(new_obstacle)
	####	
		
		
func _setPlayer():
	
	if (global.last_door != null):
		print ("Last door: " + global.last_door)
	
	if global.last_door == null:
		randomize()
		playerX = random()
		playerY = random()
	elif global.last_door.casecmp_to("TopDoor") == 0:
		playerX = 5
		playerY = 9
	elif global.last_door.casecmp_to("BotDoor") == 0:
		playerX = 5
		playerY = 1
	elif global.last_door.casecmp_to("LeftDoor") == 0:
		playerX = 9
		playerY = 5
	elif global.last_door.casecmp_to("RightDoor") == 0:
		playerX = 1
		playerY = 5
	

	var player = Player.instance()
	player.set_pos(map_to_world(Vector2(playerX, playerY)) + half_tile_size)
	add_child(player)
	var player_pos = Vector2(playerX, playerY)
	positions.append(player_pos)


func _setItems():
	
	while (true):
		random_X_Y()
		arrowX = randiX
		arrowY = randiY
		
		random_X_Y()
		bombX = randiX
		bombY = randiY
		
		random_X_Y()
		stairX = randiX
		stairY = randiX
		if (arrowX != bombX != stairX && arrowY != bombY != stairY):
			break
	
	var arrow = Arrow.instance()
	arrow.set_pos(map_to_world(Vector2(arrowX,arrowY)) + half_tile_size)
	add_child(arrow)
	
	var bomb = Bomb.instance()
	bomb.set_pos(map_to_world(Vector2(bombX,bombY)) + half_tile_size)
	add_child(bomb)

	_setStairs()


func _setStairs():
	if (global.room_counter > 3 + global.score):
		randomize()
		var c = randi() % (3 + global.score + 1)
		print (c)
		if (c == 1):
			var stair = Stair.instance()
			stair.set_pos(map_to_world(Vector2(random(),random())) + half_tile_size)
			add_child(stair)
	pass

func _setDoors():
	###LEFT door
	var doorL = LDoor.instance()
	doorL.set_pos(map_to_world(Vector2(0,5)) + half_tile_size)
	add_child(doorL)
	###TOP door
	var doorT = TDoor.instance()
	doorT.set_pos(map_to_world(Vector2(5,0)) + half_tile_size)
	add_child(doorT)
	###BOTTOM door
	var doorB = BDoor.instance()
	doorB.set_pos(map_to_world(Vector2(5,10)) + half_tile_size)
	add_child(doorB)
	###RIGHT door
	var doorR = RDoor.instance()
	doorR.set_pos(map_to_world(Vector2(10,5)) + half_tile_size)
	add_child(doorR)
	
func random():
	return randi() % 9+1
	
func random_X_Y():
	randiX = random()
	randiY = random()
	pass

	
func is_cell_vacant(pos, direction):
	var grid_pos = world_to_map(pos) + direction
	if grid_pos.x < grid_size.x and grid_pos.x >= 0:
		if grid_pos.y < grid_size.y and grid_pos.y >= 0:
			return true if grid[grid_pos.x][grid_pos.y] == null else false
	return false
	
func update_child_pos(child_node):
	var grid_pos = world_to_map(child_node.get_pos())
	print(grid_pos)
	grid[grid_pos.x][grid_pos.y] = null
	
	var new_grid_pos = grid_pos + child_node.direction
	grid[new_grid_pos.x][new_grid_pos.y] = child_node.type
	
	var target_pos = map_to_world(new_grid_pos) + half_tile_size
	return target_pos
	pass
	
