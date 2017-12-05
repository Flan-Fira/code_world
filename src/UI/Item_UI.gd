extends Node2D

onready var arrow_label = get_node("Panel/Arrow Label")
onready var score_label = get_node("Panel/Score Number")

#Changes text of label to new number of arrows
func update_arrow_UI():
	arrow_label.set_text(global.amountOfArrow)
	pass
	
#Changes text of label to new count score
func update_score_UI():
	score_label.set_tex(global.score)
	pass

