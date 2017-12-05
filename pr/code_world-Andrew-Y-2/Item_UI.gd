extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

onready var arrow_label = get_node("Panel/FireBall Label")
onready var score_label = get_node("Panel/Score Number")

var asdfjkl = 3


func update_arrow_UI():
	arrow_label.set_text(global.FireBall)
	pass
	
func update_score_UI():
	score_label.set_tex(global.score)
	pass

