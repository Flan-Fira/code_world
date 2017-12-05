extends Area2D

func _ready():
	connect("body_enter", self, "_enter_scene")

func _enter_scene(body):
	
	if(body.get_name() == "Player"):
		global.last_door = self.get_name()
		global.noEnemy = false
		get_tree().change_scene("res://World.tscn")