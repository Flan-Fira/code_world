extends Area2D

func _ready():
	connect("body_enter", self, "_enter_scene")

func _enter_scene(body):
	if(body.get_name() == "Player"):
		global.score += 1
		print("Score: " + str(global.score))
		get_parent().get_node("UI/Panel/Score Number").update_score()
		global.create_new_level()
		
		get_tree().change_scene("res://src/MapControl/World.tscn")