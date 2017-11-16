extends KinematicBody2D

var direction = Vector2()
var velocity = Vector2()
var speed = 0
var moving_speed = 200
var grid
var type
var target_space = Vector2()
var target_direction = Vector2()

func _ready():
	grid = get_parent()
	type = grid.PLAYER
	set_fixed_process(true)

func _fixed_process(delta):
	direction = Vector2()
	if (Input.is_action_pressed("ui_up")):
		direction.y = -1
	elif (Input.is_action_pressed("ui_down")):
		direction.y = 1
	if (Input.is_action_pressed("ui_left")):
		direction.x = -1
	elif (Input.is_action_pressed("ui_right")):
		direction.x = 1
	
	#if global.amountOfArrow != 0:
	#	if (Input.is_action_pressed("ui_accept")):
	#		grid.shooting()
	
	if not global.moving and direction != Vector2():
		target_direction = direction
		if grid.is_cell_vacant(get_pos(), target_direction):
			target_space = grid.update_child_pos(self)
			global.moving = true
	elif global.moving:
		speed = moving_speed
		velocity = speed * target_direction * delta
		var pos = get_pos()
		var distance_to_target = Vector2(abs(target_space.x - pos.x), abs(target_space.y - pos.y))
		if abs(velocity.x) > distance_to_target.x:
			velocity.x = distance_to_target.x * target_direction.x
			global.moving = false
		if abs(velocity.y) > distance_to_target.y:
			velocity.y = distance_to_target.y * target_direction.y
			global.moving = false
		move(velocity)
