extends Area2D

var speed = 200
var moving = false
var direction = Vector2()
var grid
var type
var target_space = Vector2()
var target_direction = Vector2()
var velocity = Vector2()
func _ready():
	grid = get_parent()
	type = grid.FIREBALL
	set_process(true)
	pass

func _process(delta):
	if global.fireEnd:
		queue_free()
		global.resetFire = true
	direction = global.fireDirection
	
	if not moving and direction != Vector2():
		target_direction = direction
		if grid.is_cell_vacant(get_pos(), target_direction):
			target_space = grid.update_item_pos(self)
			moving = true
	elif moving:
		velocity = speed * target_direction * delta
		var pos = get_pos()
		var distance_to_target = Vector2(abs(target_space.x - pos.x), abs(target_space.y - pos.y))
		if abs(velocity.x) > distance_to_target.x:
			velocity.x = distance_to_target.x * target_direction.x
			moving = false
		if abs(velocity.y) > distance_to_target.y:
			velocity.y = distance_to_target.y * target_direction.y
			moving = false
		set_pos(get_pos() +velocity)
