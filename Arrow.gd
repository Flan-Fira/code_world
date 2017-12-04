extends Area2D
onready var Item_UI = preload("res://Item_UI.tscn")

func _ready():
	connect("body_enter", self, "_enter_scene")

func _enter_scene(body):
	if(body.get_name() == "Player"):
		global.amountOfArrow += 1 
		get_parent().get_node("UI/Panel/Arrow/Arrows").update_arrows()
		print(global.amountOfArrow)
		queue_free()
		
