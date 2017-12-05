extends KinematicBody2D

var direction = Vector2()
var velocity = Vector2()
var speed = 0
var moving_speed = 400
var moving = false
var grid
var type
var target_space = Vector2()
var target_direction = Vector2()
var entity

func set_entity(ent):
	entity = ent

func _ready():
	
	#a way to connect to the parent fucntion and variable
	grid = get_parent()
	type = grid.PLAYER
	set_process(global.playerTurn)
	
func _process(delta):
	direction = Vector2()
	if not moving and global.playerTurn:
		global.interpreter.run()
		
		####Moving the player in a direction
		if (global.interpreter.is_button_pressed(Interpreter.up)):
			direction.y = -1
			global.arrowDirection = direction
		elif (global.interpreter.is_button_pressed(Interpreter.down)):
			direction.y = 1
			global.arrowDirection = direction
		if (global.interpreter.is_button_pressed(Interpreter.left)):
			direction.x = -1
			global.arrowDirection = direction
		elif (global.interpreter.is_button_pressed(Interpreter.right)):
			direction.x = 1
			global.arrowDirection = direction
		
		#renaming the direction for better understanding
		target_direction = direction
		
		#check if the next space can be move
		if grid.can_move_ent(entity, target_direction):
			
			#aquire the free space to move to
			target_space = grid.update_child_pos(self)
		moving = true
	elif moving:
		speed = moving_speed
		
		#velocity is the speed and the direction of movement
		velocity = speed * target_direction * delta
		
		#get the position that the player is currently located on the map
		var pos = get_pos()
		
		#check if the space wanting to move is not the space that is being stand on
		var distance_to_target = Vector2(abs(target_space.x - pos.x), abs(target_space.y - pos.y))
		if abs(velocity.x) > distance_to_target.x:
			velocity.x = distance_to_target.x * target_direction.x
			
			#reset turn to enemy
			global.enemyTurn = true
			global.playerTurn = false
			moving = false
		if abs(velocity.y) > distance_to_target.y:
			velocity.y = distance_to_target.y * target_direction.y
			global.enemyTurn = true
			global.playerTurn = false
			moving = false
		
		#move the player
		move(velocity)