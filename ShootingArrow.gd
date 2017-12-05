extends KinematicBody2D
var direction = Vector2()
var velocity = Vector2()
var moving_speed = 200
var speed = 0
var moving = false
var grid
var type
var target_space = Vector2()
var target_direction = Vector2()

func _ready():
	grid = get_parent()
	type = grid.ARROW
	set_process(false)
	
func _process(delta):
	if global.reachEnd:
		queue_free()
		global.reachEnd = false
	direction = global.arrowDirection

	
	if not moving and direction != Vector2():
		target_direction = direction
		if grid.is_cell_vacant(get_pos(), target_direction):
			target_space = grid.update_bullet_pos(self)
			moving = true
	elif moving:
		speed = moving_speed
		velocity = speed * target_direction * delta
		var pos = get_pos()
		var distance_to_target = Vector2(abs(target_space.x - pos.x), abs(target_space.y - pos.y))
		if abs(velocity.x) > distance_to_target.x:
			velocity.x = distance_to_target.x * target_direction.x
			moving = false
		if abs(velocity.y) > distance_to_target.y:
			velocity.y = distance_to_target.y * target_direction.y
			moving = false
		move(velocity)


