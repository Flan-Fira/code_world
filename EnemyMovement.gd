extends KinematicBody2D
var velocity = Vector2()

var direction = Vector2()
var position = Vector2()
var Speed = 1
var grid
var type
var target_space = Vector2()
var target_direction = Vector2()


func _ready():
	randomize()
	grid = get_parent()
	type = grid.ENEMY
	set_fixed_process(true)
	if global.bombAll:
		queue_free()
	pass

func _fixed_process(delta):
	if not global.enemies_moving:
		var randiDirection = randi() % 5 + 1
		if randiDirection == 1:
			direction.y = -1
			position = get_pos()
		elif randiDirection == 2:
			direction.y = 1
			position = get_pos()
		elif randiDirection == 3:
			direction.x = -1
			position = get_pos()
		elif randiDirection == 4:
			direction.x = 1
			position = get_pos()
			
			
	if not global.enemies_moving and direction != Vector2():
		target_direction = direction
		if grid.is_cell_vacant(get_pos(), target_direction):
			target_space = grid.update_child_pos(self)
			global.enemies_moving = true
	elif global.enemies_moving:
		velocity = Speed * target_direction * delta
		var pos = get_pos()
		var distance_to_target = Vector2(abs(target_space.x - pos.x), abs(target_space.y - pos.y))
		if abs(velocity.x) > distance_to_target.x:
			velocity.x = distance_to_target.x * target_direction.x
			global.enemies_moving = false
		if abs(velocity.y) > distance_to_target.y:
			velocity.y = distance_to_target.y * target_direction.y
			global.enemies_moving = false
		move(velocity)

