extends KinematicBody2D

#onready var Bullet = preload("res://bullet.tscn")
var speed = 0
var moving_speed = 100
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
func _ready():
	grid = get_parent()
	type = grid.ENEMY
	set_process(global.enemyTurn)

func _process(delta):
#	body = get_node("Area2D").get_overlapping_bodies()
#	var player = get_node("/root/World/MapControl/Player")
#	if body.size() != 0:
#		for area in body:
#			if global.moveEnemy:
#				if (area.get_global_pos().x < self.get_global_pos().x):
#					direction.x = -1
#				elif (area.get_global_pos().x > self.get_global_pos().x):
#					direction.x = 1
#				if (area.get_global_pos().y < self.get_global_pos().y):
#					direction.y = -1
#				elif (area.get_global_pos().y > self.get_global_pos().y):
#					direction.y = 1
	if global.enemyTurn:
		var move = randi() % 4+1
		if move == 1:
			direction.x=1
		if move == 2:
			direction.x=-1
		if move ==3:
			direction.y=1
		if move == 4:
			direction.y= -1
	
	#var bullet = Bullet.instance()
	#get_parent().add_child(bullet)
	#bullet.set_pos(get_node("Position2D").get_global_pos())
	
		if not moving and direction != Vector2():
			target_direction = direction
			if grid.is_cell_vacant(get_pos(), target_direction):
				target_space = grid.update_enemy_pos(self)
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