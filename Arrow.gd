extends Area2D
func _ready():
	connect("body_enter", self, "_enter_scene")

func _enter_scene(body):
	if(body.get_name() == "Player"):
		global.amountOfArrow = 10
		print("hi")
		queue_free()