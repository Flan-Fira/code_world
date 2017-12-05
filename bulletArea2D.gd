extends Area2D

func _ready():
	connect("body_enter", self, "_enter_scene")
	pass
func _enter_scene(body):
	if(body.get_name() == "Player"):
		queue_free()
		global.die = true
