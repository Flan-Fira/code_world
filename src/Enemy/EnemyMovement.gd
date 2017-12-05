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
	grid = get_parent()
	type = grid.ENEMY
	set_process(global.enemyTurn)
	

func _process(delta):
	direction = Vector2()
	var move = randi() % 4+1
	if move == 1:
		direction.x=1
	if move == 2:
		direction.x=-1
	if move == 3:
		direction.y=1
	if move == 4:
		direction.y= -1
	if not moving and direction != Vector2():
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
			global.enemyTurn = false
			global.playerTurn = true
			moving = false
		if abs(velocity.y) > distance_to_target.y:
			velocity.y = distance_to_target.y * target_direction.y
			global.enemyTurn = false
			global.playerTurn = true
			moving = false
		move(velocity)