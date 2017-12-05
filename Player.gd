extends KinematicBody2D

onready var fireball = preload("res://fireball.tscn")
var direction = Vector2()
var velocity = Vector2()
var speed = 0
var moving_speed = 200
var moving = false
var grid
var type
var target_space = Vector2()
var target_direction = Vector2()

func _ready():
	grid = get_parent()
	type = grid.PLAYER
	set_process(global.playerTurn)
	
func _process(delta):
	direction = Vector2()
	if (Input.is_action_pressed("ui_up")):
		direction.y = -1
		if global.resetFire:
			global.fireDirection = direction
	elif (Input.is_action_pressed("ui_down")):
		direction.y = 1
		if global.resetFire:
			global.fireDirection = direction
	elif (Input.is_action_pressed("ui_left")):
		direction.x = -1
		if global.resetFire:
			global.fireDirection = direction
	elif (Input.is_action_pressed("ui_right")):
		direction.x = 1
		if global.resetFire:
			global.fireDirection = direction
		
	if global.throwFire > 0:
		if Input.is_action_pressed("ui_accept"):
			var fire = fireball.instance()
			get_parent().add_child(fire)
			fire.set_pos(get_node("Position2D").get_global_pos())
			global.resetFire = false
			global.throwFire= global.throwFire - 1
		
	if not moving and direction != Vector2():
		target_direction = direction
		if grid.is_cell_vacant(get_pos(), target_direction):
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