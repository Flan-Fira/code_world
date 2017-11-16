extends TileMap


var tile_size = get_cell_size()
var half_tile_size = tile_size/2

enum ENTITY_TYPES {PLAYER, ENEMY}
var grid_size = Vector2(16, 9)
var grid = []
var positions = []
onready var red = preload("res://Red.tscn")
onready var arrow = preload("res://Arrow.tscn")

func _ready():
	randomize()
	for x in range(grid_size.x):
		grid.append([])
		for y in range(grid_size.y):
			grid[x].append(null)
	
	var player = get_node("Player")
	var beginning_pos = update_child_pos(player)
	player.set_pos(beginning_pos)
	
	var item1 = arrow.instance()
	item1.set_pos(map_to_world(Vector2(4,4)) + half_tile_size)
	add_child(item1)
	
	for n in range(5):
		var grid_pos = Vector2(randi() % int(grid_size.x), randi() % int(grid_size.y))
		if grid_pos.x > 0 and grid_pos.x < grid_size.x and grid_pos.y > 0 and grid_pos.y < grid_size.y-1:
			if not grid_pos in positions:
				if grid_pos != beginning_pos:
					positions.append(grid_pos)
		else:
			n = n - 1
		
	for pos in positions:
		var new_obstacle = red.instance()
		new_obstacle.set_pos(map_to_world(pos) + half_tile_size)
		grid[pos.x][pos.y] = new_obstacle.get_name()
		add_child(new_obstacle)
	####	
		
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
	
