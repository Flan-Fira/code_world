extends Node2D
 
var item_ui

var arrow_label


func _ready():
	connect("body_enter", self, "_enter_scene")
	
func _enter_scene(body):
	if(body.get_name() == "Player"):
		arrow_label = get_node("Arrow Label")
		global.amountOfArrow = global.amountOfArrow + 10
		queue_free()