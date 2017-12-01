extends TileMap
var tile_size = get_cell_size()
var half_tile_size = tile_size/2
var interpeter
enum ENTITY_TYPES {PLAYER, ENEMY}
var grid_size = Vector2(11, 11)
var grid = []
var positions = []
var randiX
var randiY
var finding = true
onready var TBDoor = preload("res://TopBotDoor.tscn")
onready var LRDoor = preload("res://LeftRightDoor.tscn")
onready var red = preload("res://Red.tscn")
onready var Arrow = preload("res://Arrow.tscn")
onready var Player = preload("res://Player.tscn")
onready var Bomb = preload("res://Bomb.tscn")

func _ready():
	interpreter = Interpreter.new()
	randomize()
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
	_setPlayer()
	_setItems()
	_setDoors()
	_setEnemies()
	
func _setEnemies():
	var enemy = red.instance()
	enemy.set_pos(map_to_world(Vector2(5,6)) + half_tile_size)
	add_child(enemy)
	
func _setPlayer():
	randiX = random()
	randiY = random()
	var player = Player.instance()
	player.set_pos(map_to_world(Vector2(randiX, randiY)) + half_tile_size)
	add_child(player)
	var player_pos = Vector2(randiX, randiY)
	positions.append(player_pos)
	
func _setItems():
	var arrow = Arrow.instance()
	arrow.set_pos(map_to_world(Vector2(4,4)) + half_tile_size)
	add_child(arrow)
	var bomb = Bomb.instance()
	bomb.set_pos(map_to_world(Vector2(3,4)) + half_tile_size)
	add_child(bomb)
	var arrow = Arrow.instance()
	arrow.set_pos(map_to_world(Vector2(5,4)) + half_tile_size)
	add_child(arrow)
func _setDoors():
	###LEFT door
	var door1 = LRDoor.instance()
	door1.set_pos(map_to_world(Vector2(0,5)) + half_tile_size)
	add_child(door1)
	###TOP door
	var door5 = TBDoor.instance()
	door5.set_pos(map_to_world(Vector2(5,0)) + half_tile_size)
	add_child(door5)
	###BOTTOM door
	var door8 = TBDoor.instance()
	door8.set_pos(map_to_world(Vector2(5,10)) + half_tile_size)
	add_child(door8)
	###RIGHT door
	var door11 = LRDoor.instance()
	door11.set_pos(map_to_world(Vector2(10,5)) + half_tile_size)
	add_child(door11)
	
func random():
	return randi() % 9+1
	
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
	
