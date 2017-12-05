extends TileMap

var width = 11; var height = 11; var num_grass = 300; var density = 4; var minlength = 2; var maxlength = 4 #density cannot equal 1
var grid = []; var dir = {0:Vector2(0,-1),1:Vector2(-1,0),2:Vector2(1,0),3:Vector2(0,1)}
var curr = Vector2(); var step = Vector2();

# Room type is [Top, Bottom, Left, Right]; 0 = no door, 1 = door
var room_type = [1,1,1,1]

func _ready():
	random_room()
	self.set_pos(Vector2(0,0))
	for i in range(0,width):
		grid.append([])
		for j in range(0,height):
			grid[i].append(-2)
			
	for i in range(0,width):
		for j in range(0,height):
			if grid[i][j] == -2: set_cell(i,j,1) #random tile: 
			if i == 0 or j == 0 or i == width-1 or j == height-1:
				grid[i][j] = -1
				set_cell(i,j,0) #set border
	
	for i in range(0,width):  #set door
		for j in range(0,height):
			for x in [((width/2)-1), (width/2), ((width/2)+1)]: #3 middle spots of row for top and bottom rows
				# Controls Spawning of the Top door
				if (room_type [0] == 1):
					set_cellv(Vector2 ( x, 0),2) #set black tile
				# Controls Spawning of the Bottom door
				if (room_type [1] == 1):
					set_cellv(Vector2 ( x, height - 1),2)
					
			for y in [((height/2)-1), (height/2), ((height/2)+1)]:
				# Controls Spawning of the Left door
				if (room_type [2] == 1):
					set_cellv(Vector2 ( 0, y),2) #set black tile
				# Controls Spawning of the Right door
				if (room_type [3] == 1):
					set_cellv(Vector2 ( width-1, y),2)
		
	generate_map(minlength, maxlength, density, num_grass)
	return room_type
	pass

#Sets the tiles inside of the box
func set_inside(curr,dirv,len):
	for i in range(1,len,1):
		if grid[curr.x][curr.y] == -1: return -1
		set_cell(curr.x,curr.y,1) # set inside
		grid[curr.x][curr.y] = -1
		curr = curr + dirv

#Creates random tiles
func rand_coord_tile(density):
	step = Vector2(density + rand_range(0,width/density),density + rand_range(0,width/density))
	return step
	
#Checks the size of the map
func calculation_map(minlength, maxlength, density):
	randomize()
	rand_coord_tile(density)
	if grid[step.x][step.y] == -1: return -1
	var dirr = [0,1,2,3]
	dirr = dirr[randi()%dirr.size()]
	var dirv = dir[dirr]
	var len = rand_range(minlength, maxlength)
	len = len + density + 1
	set_inside(step, dirv, len)

#Creates map
func generate_map(minlength, maxlength, density, num_grass):
	for count in range(1,num_grass,1):
		calculation_map(minlength, maxlength, density)

func random_door():
	# Godot doesn't let you choose randomly between 0 and 1; instead use a random number from 1 to 10 and check if it's even or odd
	randomize()
	var rand = randi() % 10 + 1
	return rand % 2

func random_room():
	var check = global.check_room_global_map()
	
	if check == null:

		room_type[0] = random_door()
		room_type[1] = random_door()
		room_type[2] = random_door()
		room_type[3] = random_door()
		
		if global.last_door == null:
			# First room will always have doors on all sides
			room_type[0] = 1
			room_type[1] = 1
			room_type[2] = 1
			room_type[3] = 1
		
		# Checks if the room should have 
		var check_oneway = global.check_room_oneway_doors()
		for x in range (check_oneway.size()):
			if check_oneway[x] == 1 or check_oneway[x] == 0:
				room_type[x] = check_oneway[x]
		
		# Ensures that there won't be any doors leading out of the global map.
		if global.locationY == 0:
			room_type[0] = 0
		if global.locationY == 4:
			room_type[1] = 0
		if global.locationX == 0:
			room_type[2] = 0
		if global.locationX == 4:
			room_type[3] = 0
			
		global.room_counter = global.room_counter + 1
		global.last_room = room_type
		global.add_room_global_map()
	else:
		room_type = check
		global.last_room = room_type