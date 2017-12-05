extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _create_board():
	var matrix = []
	
	var height = 9
	var width = 9
	
	for x in range(height):
	    matrix.append([])
	    for y in range(width):
	        matrix[x].append(0)
	
	return matrix
	pass

func _random():
	var matrix = []
	
	var height = 7
	var width = 6
	
	for x in range(height):
	    matrix.append([])
	    for y in range(width):
	        matrix[x].append(0)
	
	for x in range(height):
		
		matrix[x][0] = "Room " + str(x)
		
		randomize()
		matrix[x][1] = (randi() % 15)
		
		if x == 0:
			matrix[x][1] = 0

		if matrix[x][1] == 0:
			matrix[x][1] = "UDLR"
			matrix[x][2] = 1
			matrix[x][3] = 1
			matrix[x][4] = 1
			matrix[x][5] = 1
			
		elif matrix[x][1] == 1:
			matrix[x][1] = "U"
			matrix[x][2] = 1
			matrix[x][3] = "x" 
			matrix[x][4] = "x"
			matrix[x][5] = "x"
			
		elif matrix[x][1] == 2:
			matrix[x][1] = "D"
			matrix[x][2] = "x"
			matrix[x][3] = 1
			matrix[x][4] = "x"
			matrix[x][5] = "x"
			
		elif matrix[x][1] == 3:
			matrix[x][1] = "L"
			matrix[x][2] = "x"
			matrix[x][3] = "x"
			matrix[x][4] = 1
			matrix[x][5] = "x"
			
		elif matrix[x][1] == 4:
			matrix[x][1] = "R"
			matrix[x][2] = "x"
			matrix[x][3] = "x"
			matrix[x][4] = "x"
			matrix[x][5] = 1
			
		elif matrix[x][1] == 5:
			matrix[x][1] = "UD"
			matrix[x][2] = 1
			matrix[x][3] = 1
			matrix[x][4] = "x"
			matrix[x][5] = "x"
			
		elif matrix[x][1] == 6:
			matrix[x][1] = "LR"
			matrix[x][2] = "x"
			matrix[x][3] = "x"
			matrix[x][4] = 1
			matrix[x][5] = 1
			
		elif matrix[x][1] == 7:
			matrix[x][1] = "UL"
			matrix[x][2] = 1
			matrix[x][3] = "x"
			matrix[x][4] = 1
			matrix[x][5] = "x"
			
		elif matrix[x][1] == 8:
			matrix[x][1] = "UR"
			matrix[x][2] = 1
			matrix[x][3] = "x"
			matrix[x][4] = "x"
			matrix[x][5] = 1
			
		elif matrix[x][1] == 9:
			matrix[x][1] = "DL"
			matrix[x][2] = "x"
			matrix[x][3] = 1
			matrix[x][4] = 1
			matrix[x][5] = "x"
			
		elif matrix[x][1] == 10:
			matrix[x][1] = "DR"
			matrix[x][2] = "x"
			matrix[x][3] = 1
			matrix[x][4] = "x"
			matrix[x][5] = 1
			
		elif matrix[x][1] == 11:
			matrix[x][1] = "DLR"
			matrix[x][2] = "x"
			matrix[x][3] = 1
			matrix[x][4] = 1
			matrix[x][5] = 1
			
		elif matrix[x][1] == 12:
			matrix[x][1] = "UDL"
			matrix[x][2] = 1
			matrix[x][3] = 1
			matrix[x][4] = 1
			matrix[x][5] = "x"
			
		elif matrix[x][1] == 13:
			matrix[x][1] = "ULR"
			matrix[x][2] = 1
			matrix[x][3] = "x"
			matrix[x][4] = 1
			matrix[x][5] = 1
			
		elif matrix[x][1] == 14:
			matrix[x][1] = "UDR"
			matrix[x][2] = 1
			matrix[x][3] = 1
			matrix[x][4] = "x"
			matrix[x][5] = 1
			
	
	return matrix
	
	pass
	
	

func _random_direction(array):

	randomize()
	
	if str(array[2]).casecmp_to("1") == 0:
		tmp = tmp + "U"
	if str(array[3]).casecmp_to("1") == 0:
		tmp = tmp + "D"
	if str(array[4]).casecmp_to("1") == 0:
		tmp = tmp + "L"
	if str(array[5]).casecmp_to("1") == 0:
		tmp = tmp + "R"
	
	var direction

	if tmp.casecmp_to ("U") == 0 || tmp.casecmp_to ("D") == 0 || tmp.casecmp_to ("L") == 0 || tmp.casecmp_to ("R") == 0:
		direction = 0
	elif tmp.casecmp_to ("UD") == 0 || tmp.casecmp_to ("LR") == 0 || tmp.casecmp_to ("UL") == 0 || tmp.casecmp_to ("UR") == 0 || tmp.casecmp_to ("DL") == 0 || tmp.casecmp_to ("DR") == 0 :
		direction = (randi() % 2)
	elif tmp.casecmp_to ("ULD") == 0 || tmp.casecmp_to ("UDR") == 0 || tmp.casecmp_to ("ULR") == 0 || tmp.casecmp_to ("DLR") == 0:
		direction = (randi() % 3)
	elif tmp.casecmp_to ("UDLR") == 0:
		direction = (randi() % 4)

	var directionD = tmp[direction]
	return directionD
	pass


func _match(matrix, board):
	var room_num = matrix.size()
	var i = 1000
	board[5][5] = "ULDR"
	for x in range (room_num):
		if x == 0:
			continue
		direction = _random_direction(matrix[x])
		
		if direction.casecmp_to("U"):
			while (i < x):
				i = 0
				if matrix[i][3].casecmpt_to("1") == 0:
					var asdfasdf = asdfasdf


	pass


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	_create_board()
	#var matrix = _random()
	#print(matrix)
	var test = [["Room 0", "UDLR", 1, 1, 1, 1], ["Room 1", "UL", 1, "x", 1, "x"], ["Room 2", "U", 1, "x", "x", "x"]]
	_match(test)


	
	
	
	pass


