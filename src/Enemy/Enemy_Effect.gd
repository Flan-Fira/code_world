extends Area2D

func _ready():
	connect("body_enter", self, "_enter_scene")

func _enter_scene(body):
	
	#check if the body interacting with the enemy is the Player
	if(body.get_name() == "Player"):
		#lose a health/heart
		global.health -= 1
		#update the panel
		get_parent().get_parent().get_node("Node2D/Health Panel").update_health()
		#enemy is then deleted
		queue_free()
