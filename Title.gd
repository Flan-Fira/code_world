extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
func _on_button_pressed():
	get_tree().change_scene("res://MapControl.tscn")


func _ready():
	get_node("Button").connect("pressed",self,"_on_button_pressed")
	pass
