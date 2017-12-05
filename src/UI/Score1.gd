extends Label

func _ready():
	update_score()
	pass

#Updates text of score to global score count
func update_score():
	if global.score >= 0:
		set_text(str(global.score))