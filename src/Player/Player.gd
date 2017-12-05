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
	grid = get_parent()
	type = grid.PLAYER
	set_process(global.playerTurn)
	
func _process(delta):
	direction = Vector2()
	if not moving and global.playerTurn:
		global.interpreter.run()
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
		target_direction = direction
		if grid.can_move_ent(entity, target_direction):
			target_space = grid.update_child_pos(self)
		moving = true
	elif moving:
		speed = moving_speed
		velocity = speed * target_direction * delta
		var pos = get_pos()
		var distance_to_target = Vector2(abs(target_space.x - pos.x), abs(target_space.y - pos.y))
		if abs(velocity.x) > distance_to_target.x:
			velocity.x = distance_to_target.x * target_direction.x
			global.enemyTurn = true
			global.playerTurn = false
			moving = false
		if abs(velocity.y) > distance_to_target.y:
			velocity.y = distance_to_target.y * target_direction.y
			global.enemyTurn = true
			global.playerTurn = false
			moving = false
		move(velocity)