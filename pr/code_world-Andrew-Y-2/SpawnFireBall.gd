extends Area2D

onready var Item_UI = preload("res://Item_UI.tscn")

func _ready():
	connect("body_enter", self, "_enter_scene")

func _enter_scene(body):
	if(body.get_name() == "Player"):
		global.throwFire += 1 
#		get_parent().get_parent().get_node("UI/Panel/FireBall").update_fireball()
		print(global.throwFire)
		queue_free()
		