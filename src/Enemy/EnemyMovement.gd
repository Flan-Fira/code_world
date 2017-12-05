extends KinematicBody2D
var speed = 0
var moving_speed = 400
var enemy = self
var direction = Vector2()
var grid
var type
var velocity = Vector2()
var moving = false
var target_space = Vector2()
var target_direction = Vector2()
var body
var time
var entity

func set_entity(ent):
	entity = ent

func _ready():
	
	#access to parent function
	grid = get_parent()
	type = grid.ENEMY
	set_process(global.enemyTurn)
	

func _process(delta):
	direction = Vector2()
	
	#random movement of enemy by the used of random generator
	var move = randi() % 4+1
	if move == 1:
		direction.x=1
	if move == 2:
		direction.x=-1
	if move == 3:
		direction.y=1
	if move == 4:
		direction.y= -1
	
	#station the enemy first, to find the next space to move to
	if not moving and direction != Vector2():
		target_direction = direction
		
		#check if the space is open to relocate the enemy
		if grid.can_move_ent(entity, target_direction):
			
			#aquire a space to move to
			target_space = grid.update_child_pos(self)
			moving = true
	elif moving:
		speed = moving_speed
		velocity = speed * target_direction * delta
		var pos = get_pos()
		var distance_to_target = Vector2(abs(target_space.x - pos.x), abs(target_space.y - pos.y))
		if abs(velocity.x) > distance_to_target.x:
			velocity.x = distance_to_target.x * target_direction.x
			
			#change to player turn
			global.enemyTurn = false
			global.playerTurn = true
			moving = false
		if abs(velocity.y) > distance_to_target.y:
			velocity.y = distance_to_target.y * target_direction.y
			global.enemyTurn = false
			global.playerTurn = true
			moving = false
		move(velocity)