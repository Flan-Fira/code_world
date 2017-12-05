extends Area2D

func _ready():
	connect("body_enter", self, "_enter_scene")

func _enter_scene(body):
	if(body.get_name() == "Player"):
		global.health += 1
		get_parent().get_node("Node2D/Health Panel").update_health()

		
		print(global.health)
		queue_free()