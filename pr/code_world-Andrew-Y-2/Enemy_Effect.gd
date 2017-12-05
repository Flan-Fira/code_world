extends Area2D
onready var Health = preload("res://Health.tscn")

func _ready():
	connect("body_enter", self, "_enter_scene")
	set_process(true)

func _process(delta):
	if global.bombAll:
		global.noEnemy = true
		global.bombAll = false
		queue_free()

func _enter_scene(body):
	if(body.get_name() == "Player"):
		global.health -= 1
		get_parent().get_parent().get_node("Node2D/Health Panel").update_health()
		global.noEnemy = true
		queue_free()
	if(body.get_name() == "fireball"):
		queue_free()
		
