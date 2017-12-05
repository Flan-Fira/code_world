extends Label

func _ready():
	
	update_arrows()
	
	pass

func update_arrows():
	if global.amountOfArrow >= 0:
		set_text("x" + str(global.amountOfArrow))