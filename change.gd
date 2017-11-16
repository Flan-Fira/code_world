extends Area2D

func _ready():
	connect("body_enter", self, "_enter_scene")

func _enter_scene(body):
	if(body.get_name() == "Player"):
		global.moving = false
		get_tree().change_scene("res://Panel.tscn")