#isometric
extends Node2D

var width = 11; var height = 11; var num_grass = 300; var density = 2; var minlength = 2; var maxlength = 4
var grid = []; var dir = {0:Vector2(0,-1),1:Vector2(-1,0),2:Vector2(1,0),3:Vector2(0,1)}
var curr = Vector2(); var step = Vector2(); var rock = 0
var river_bed = []; var river_dir = [Vector2(1,0),Vector2(-1,0),Vector2(0,1)]

func _ready():
	self.set_pos(Vector2(800,256))
	for i in range(0,width):
		grid.append([])
		for j in range(0,height):
			grid[i].append(-2)
	for i in range(0,width):
		for j in range(0,height,1):
			if grid[i][j] == -2: get_node("TileMap").set_cell(i,j,0) #random tile: pine
			if i == 0 or j == 0 or i == width-1 or j == height-1:
				grid[i][j] = -1
				get_node("TileMap").set_cell(i,j,3) # set border
		#river_bed.append(Vector2(i,0))
	generate_map(minlength, maxlength, density, num_grass)
	#generate_river_bed()
	pass
	
func grass_rock(curr,dirv,len):
	for i in range(1,len,1):
		if grid[curr.x][curr.y] == -1: return -1
		get_node("TileMap").set_cell(curr.x,curr.y,1) # set inside
		#rock = rock + 1
		#if dirv.x == -1 and dirv.y == 0 and rock > 10: get_node("TileMap").set_cell(curr.x,curr.y,1); rock = 0
		grid[curr.x][curr.y] = -1
		curr = curr + dirv

func rand_coord_tile(density):
	step = Vector2(density + rand_range(0,width/density),density + rand_range(0,width/density))
	return step
	
func calculation_map(minlength, maxlength, density):
	randomize()
	rand_coord_tile(density)
	if grid[step.x][step.y] == -1: return -1
	var dirr = [0,1,2,3]
	dirr = dirr[randi()%dirr.size()]
	var dirv = dir[dirr]
	var len = rand_range(minlength, maxlength)
	len = len + density + 1
	grass_rock(step, dirv, len)

func generate_map(minlength, maxlength, density, num_grass):
	for count in range(1,num_grass,1):
		calculation_map(minlength, maxlength, density)

#func generate_river_bed():
	#randomize()
	#river_bed = river_bed[randi()%river_bed.size()]
	#while river_bed.y <= height-1:
		#river_bed.x = min(river_bed.x,width-2); river_bed.x = max(river_bed.x, 2)
		#if grid[river_bed.x][river_bed.y] == -3: river_bed.y = min(river_bed.y + 1,height-1)
		#get_node("TileMap").set_cell(river_bed.x,river_bed.y,2)
		#grid[river_bed.x][river_bed.y] = -3
		#var river = river_dir[randi()%river_dir.size()]
		#river_bed = river_bed + river