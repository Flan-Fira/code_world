extends Label

func _ready():
	update_arrows()
	pass

#Changes text of label to new number of arrows
func update_arrows():
	if global.amountOfArrow >= 0:
		set_text("x" + str(global.amountOfArrow))