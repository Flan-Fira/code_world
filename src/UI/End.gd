extends Sprite

# Game over menu, contains credits and an option to retry the game.

func _on_button_pressed():
	global.reset_game()
	get_tree().change_scene("res://src/MapControl/MapControl.tscn")

func _ready():
	get_node("Button").connect("pressed",self,"_on_button_pressed")
	pass